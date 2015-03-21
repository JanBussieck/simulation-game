class Event < ActiveRecord::Base

  belongs_to :game
  cattr_reader :types, :types_mapping, :initial_events

  @@types = ["finance", "price", "sales", "storm", "disease"]
  @@types_mapping = {"finance" => "Finanzereignis", "price" => "Preisbewegung", "sales" => "Verkauf", "storm" => "Wetter", "disease" => "Krankheit", "technical" => "Technik"}

  class InitialEvent
    attr_accessor :type, :message
    def initialize(type, message)
      @type = type
      @message = message
    end
  end

  @@initial_events = {
   "finance" => "Wie hoch deine Zinsen sind, wie viel deine Futures wert sind, und wie viel dich deine Versicherung gekostet hat erfährst du hier. ",
   "price" => "Was ist los auf den Weltmärkten, wie haben sich eventuelle Preisschwankung auf den Wert deines Lagerbestands ausgewirkt",
   "sales" => "Wie viel hast du auf den Auktionen verkaufen und zu welchen Preisen, dies hängt vor allem von der Qualität deinses Personals ab",
   "storm" => "Haben die Wetterbedingungen deine Ernte dezimiert oder ein Sturm diese sogar komplett vernichtet?",
   "disease" => "Ist dein Viehbestand von Krankheiten befallen worden, falls du sie geimpft hast bist du vor diesem Risiko geschützt.",
   "technical" => "Hier wird angezeigt ob du deine Traktoren reparieren oder ersetzen musst und welche Kosten dabei auf dich zukommen, du kannst dich vor diesem Risiko schützen indem du diese regelmäßig in Stand hälst."}.reduce([]) do |memo, elem|
    memo << InitialEvent.new(elem[0], elem[1])
   end

  scope :recent, -> { where( period: Game.current_game.period) }

end
