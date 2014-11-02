--[[ 
	ShinyLoot, by Tyranadin (US - Moon Guard)
]]

local ShinyLoot,sl = ...;

local GetItemInfo = GetItemInfo;
local GetNumQuestChoices = GetNumQuestChoices;
local GetQuestItemLink = GetQuestItemLink;
local select = select;

sl.frame = CreateFrame("Frame");
sl.frame:SetScript("OnEvent",function(self,event,...)
	if QuestFrameRewardPanel:IsShown() then
		sl.reward();
	end
end);
sl.frame:RegisterEvent("QUEST_COMPLETE");
sl.frame:RegisterEvent("QUEST_ITEM_UPDATE");
sl.frame:RegisterEvent("GET_ITEM_INFO_RECEIVED");

function sl.reward()
	local index
	local gold = 0

	for i=1, GetNumQuestChoices() do
		local link = GetQuestItemLink("choice", i)
		if ( link == nil ) then
			return
		else
			local g = select(11, GetItemInfo(link))
			if g > gold then
				gold = g
				index = i
			end
		end

	end

	if (index != nil) then
		QuestInfoItem_OnClick(_G["QuestInfoRewardsFrameQuestInfoItem"..index]);
	end
end