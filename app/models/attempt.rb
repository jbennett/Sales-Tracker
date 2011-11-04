class Attempt < ActiveRecord::Base
  belongs_to :campaign
  belongs_to :company
  
  def campaign_name
    campaign.title if campaign
  end
  
  def campaign_name=(name)
    self.campaign = Campaign.find_by_title(name) unless name.blank?
  end
  
  def company_name
    company.fullname if company
  end
  
  def company_name=(name)
    self.company = Company.find_by_title(name) unless name.blank?
  end
  
end
