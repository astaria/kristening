#!/usr/bin/env ruby

class DocumentMaker < Que::Job
  def run(person_id)
    person = Person.find(person_id)
    unless person.delivered_at
      ActiveRecord::Base.transaction do
        person.send_documents
        person.delivered_at = Time.now
        person.save!
      end
    end
  end
end
