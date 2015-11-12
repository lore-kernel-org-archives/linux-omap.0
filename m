From: Neil Armstrong <narmstrong@baylibre.com>
Subject: Re: [PATCH 1/4] arm: omap2+: add missing HWMOD_NO_IDLEST in 81xx
 hwmod data
Date: Thu, 12 Nov 2015 15:15:49 +0100
Message-ID: <56449F15.10508@baylibre.com>
References: <5628A9F2.3010801@baylibre.com>
 <20151024012112.GA3078@atomide.com>
 <CAA3gFWs8-3pqiZR8vYLDWdXwWjUcd9UK23W3dODGTT+FY55E7g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAA3gFWs8-3pqiZR8vYLDWdXwWjUcd9UK23W3dODGTT+FY55E7g@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Paul Walmsley <paul@pwsan.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, Brian Hutchinson <b.hutchman@gmail.com>, Frode Isaksen <fisaksen@baylibre.com>
List-Id: linux-omap@vger.kernel.org

On 10/24/2015 12:09 PM, Neil Armstrong wrote:
> Hi,
> 
> 2015-10-24 3:21 GMT+02:00 Tony Lindgren <tony@atomide.com>:
>>
>> Hi,
>>
>> * Neil Armstrong <narmstrong@baylibre.com> [151022 02:19]:
>>> Add missing HWMOD_NO_IDLEST hwmod flag for entries no
>>> having omap4 clkctrl values.
>>
>> Have you checked this is the case both in dm814x and dm816x TRM?
>> Also the documentation may not be complete FYI, might be also
>> worth checking the legacy TI kernel tree to be sure.
>>
>> Regards,
>>
>> Tony
>>
>>> Cc: Brian Hutchinson <b.hutchman@gmail.com>
>>> Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
>>> ---
>>>  arch/arm/mach-omap2/omap_hwmod_81xx_data.c | 3 +++
>>>  1 file changed, 3 insertions(+)
>>>
>>> diff --git a/arch/arm/mach-omap2/omap_hwmod_81xx_data.c b/arch/arm/mach-omap2/omap_hwmod_81xx_data.c
>>> index b1288f5..6256052 100644
>>> --- a/arch/arm/mach-omap2/omap_hwmod_81xx_data.c
>>> +++ b/arch/arm/mach-omap2/omap_hwmod_81xx_data.c
>>> @@ -144,6 +144,7 @@ static struct omap_hwmod dm81xx_l4_ls_hwmod = {
>>>       .name           = "l4_ls",
>>>       .clkdm_name     = "alwon_l3s_clkdm",
>>>       .class          = &l4_hwmod_class,
>>> +     .flags          = HWMOD_NO_IDLEST,
>>>  };
> In DM814x TRM, the CM_ALWON_L3_SLOW_CLKSTCTRL does not have IDLEST field.
> Same in DM816x TRM.
> 
>>>
>>>  /*
>>> @@ -155,6 +156,7 @@ static struct omap_hwmod dm81xx_l4_hs_hwmod = {
>>>       .name           = "l4_hs",
>>>       .clkdm_name     = "alwon_l3_med_clkdm",
>>>       .class          = &l4_hwmod_class,
>>> +     .flags          = HWMOD_NO_IDLEST,
>>>  };
> In DM814x TRM, the CM_ALWON_L3_MED_CLKSTCTRL does not have IDLEST field.
> Same in DM816x TRM.
> 
>>>
>>>  /* L3 slow -> L4 ls peripheral interface running at 125MHz */
>>> @@ -850,6 +852,7 @@ static struct omap_hwmod dm816x_emac0_hwmod = {
>>>       .name           = "emac0",
>>>       .clkdm_name     = "alwon_ethernet_clkdm",
>>>       .class          = &dm816x_emac_hwmod_class,
>>> +     .flags          = HWMOD_NO_IDLEST,
>>>  };
> In this particular case, the IDLEST is handled in the MDIO hwmod.
> 
>>>
>>>  static struct omap_hwmod_ocp_if dm81xx_l4_hs__emac0 = {
>>> --
>>> 1.9.1
> 
> I'll check the TI tree to be sure...
> 
> Regards,
> Neil
> 
Tony,

In TI's tree, there is no L3_MED hwmod but the L3_SLOW hwmod has NO_IDLEST flag.

Is there any other issue about this patchset ?

Neil
