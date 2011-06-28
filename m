From: "Cousson, Benoit" <b-cousson@ti.com>
Subject: Re: [PATCH v3 8/8] OMAP2+: hwmod: Follow the recommended PRCM module
 enable sequence
Date: Wed, 29 Jun 2011 00:23:43 +0200
Message-ID: <4E0A546F.5010607@ti.com>
References: <1309191103-8817-1-git-send-email-b-cousson@ti.com>	<1309191103-8817-9-git-send-email-b-cousson@ti.com> <87iprq4xx2.fsf@ti.com> <4E09D19E.2020409@ti.com> <4E0A4FB4.70404@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:43966 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751149Ab1F1WXt (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 28 Jun 2011 18:23:49 -0400
In-Reply-To: <4E0A4FB4.70404@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Nayak, Rajendra" <rnayak@ti.com>
Cc: "Hilman, Kevin" <khilman@ti.com>, "paul@pwsan.com" <paul@pwsan.com>, "Shilimkar, Santosh" <santosh.shilimkar@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "toddpoynor@google.com" <toddpoynor@google.com>

On 6/29/2011 12:03 AM, Nayak, Rajendra wrote:
> On 6/28/2011 6:05 AM, Cousson, Benoit wrote:
>> Hi Kevin,
>>
>> On 6/28/2011 2:11 AM, Hilman, Kevin wrote:
>>> Benoit Cousson<b-cousson@ti.com>    writes:
>>>
>>>> From: Rajendra Nayak<rnayak@ti.com>
>>>>
>>>> On OMAP4, the PRCM recommended sequence for enabling
>>>> a module after power-on-reset is:
>>>> -1- Force clkdm to SW_WKUP
>>>> -2- Enabling the clocks
>>>> -3- Configure desired module mode to "enable" or "auto"
>>>> -4- Wait for the desired module idle status to be FUNC
>>>> -5- Program clkdm in HW_AUTO(if supported)
>>>>
>>>> This sequence applies to all older OMAPs' as well,
>>>> however since they use autodeps, it makes sure that
>>>> no clkdm is in IDLE, and hence not requiring a force
>>>> SW_WKUP when a module is being enabled.
>>>>
>>>> OMAP4 does not need to support autodeps, because
>>>> of the dyanamic dependency feature, wherein
>>>> the HW takes care of waking up a clockdomain from
>>>> idle and hence the module, whenever an interconnect
>>>> access happens to the given module.
>>>>
>>>> Implementing the sequence for OMAP4 requires
>>>> the clockdomain handling that is currently done in
>>>> clock framework to be done as part of hwmod framework
>>>> since the step -4- above to "Wait for the desired
>>>> module idle status to be FUNC" is done as part of
>>>> hwmod framework.
>>>>
>>>> Signed-off-by: Rajendra Nayak<rnayak@ti.com>
>>>> [b-cousson@ti.com: Adapt it to the new clkdm hwmod attribute and API]
>>>> Signed-off-by: Benoit Cousson<b-cousson@ti.com>
>>>> Cc: Paul Walmsley<paul@pwsan.com>
>>>
>>> [...]
>>>
>>>> diff --git a/arch/arm/mach-omap2/omap_hwmod.c b/arch/arm/mach-omap2/omap_hwmod.c
>>>> index 3eef106..3538805 100644
>>>> --- a/arch/arm/mach-omap2/omap_hwmod.c
>>>> +++ b/arch/arm/mach-omap2/omap_hwmod.c
>>>> @@ -1360,6 +1360,7 @@ static int _reset(struct omap_hwmod *oh)
>>>>     static int _enable(struct omap_hwmod *oh)
>>>>     {
>>>>      int r;
>>>> +   int hwsup = 0;
>>>>
>>>>      if (oh->_state != _HWMOD_STATE_INITIALIZED&&
>>>>      oh->_state != _HWMOD_STATE_IDLE&&
>>>> @@ -1378,6 +1379,19 @@ static int _enable(struct omap_hwmod *oh)
>>>>              omap_hwmod_mux(oh->mux, _HWMOD_STATE_ENABLED);
>>>>
>>>>      _add_initiator_dep(oh, mpu_oh);
>>>> +
>>>> +   /*
>>>> +    * A clockdomain must be in SW_SUP before enabling completely the
>>>> +    * module. The clockdomain can be set in HW_AUTO only when the module
>>>> +    * become ready.
>>>> +    */
>>>> +   hwsup = clkdm_allows_idle(oh->clkdm);
>>>> +   r = clkdm_hwmod_enable(oh->clkdm, oh);
>>>> +   if (r) {
>>>> +           WARN(1, "omap_hwmod: %s: could not enable clockdomain %s: %d\n",
>>>> +                oh->name, oh->clkdm->name, r);
>>>> +           return r;
>>>> +   }
>>>
>>> If oh->clkdm == NULL (as it is on OMAP3 since the hwmod data has no
>>> clkdms yet), this hangs trying to dereference oh->clkdm->name.
>>>
>>> Simple fix below, but probably better is to not call any of these
>>> functions if oh->clkdm == NULL, otherwise this is very noisy on OMAP3
>>> since that WARN is printed for every hwmod.
>>
>> I can as well prevent the clkdm_hwmod_enable function to return any errors in case of omap2&   omap3...
>
> Is'nt it best to do this..
>
> if (oh->clkdm)
>          hwsup = clkdm_allows_idle(oh->clkdm);
>          r = clkdm_hwmod_enable(oh->clkdm, oh);
>          ...
>
> My original patch infact had this check :-)

Yep, I remember :-) I removed them because for my point of view that 
attribute is mandatory for every hwmod entries and thus we should not 
have to check for it.
I preferred to hide that inside clkdm_hwmod_enable... but I'm not that 
sure it should be there now :-)

Benoit
