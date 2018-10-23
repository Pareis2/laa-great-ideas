class Idea < ApplicationRecord
  belongs_to :user
  validates :title, presence: true
  validates :area_of_interest, presence: true, if: :submitted?
  validates :business_area, presence: true, if: :submitted?
  validates :it_system, presence: true, if: :submitted?
  validates :idea, presence: true, if: :submitted?
  validates :benefits, presence: true, if: :submitted?
  validates :impact, presence: true, if: :submitted?
  validates :involvement, presence: true, if: :submitted?

  def submitted?
    submission_date
  end

  enum benefits: [
    :better_decision_making,
    :improved_reputation,
    :reduced_risk,
    :time_saved,
    :cost,
    :improved_service,
    :staff_engagement_and_moral
  ]

  enum it_system: [
    :cclf,
    :ccms,
    :ccr,
    :cis,
    :cwa,
    :eforms,
    :laa_online_portal,
    :maat,
    :maat_libra,
    :management_information,
    :obiee,
    :pims,
    :tv
  ]

  enum involvement: [
    :i_want_to_be_informed,
    :i_want_to_be_involved,
    :i_want_to_lead_on_this,
    :no_involvement
  ]

  enum business_area: [
    :exceptional_and_complex_cases, 
    :crime, 
    :civil,
    :delivery_cm_other,
    :central_commissioning,
    :public_defender_service,
    :service_development,
    :contract_management,
    :cla,
    :digital,
    :assurance,
    :finance,
    :planning_and_performance,
    :ceo_office,
    :communications,
    :operational_change_and_improvement,
    :engagement_and_inclusion,
    :corporate_centre_correspondence,
    :central_legal
  ]

  enum area_of_interest: [
    :equality_and_diversity,
    :it_development,
    :learning_and_development,
    :my_business_area,
    :my_office,
    :other_business_area,
    :staff_engagement
  ]
end
