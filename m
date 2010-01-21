From: Nishanth Menon <nm@ti.com>
Subject: Re: [PATCH] DSPBRIDGE: Fix BUG scheduling while atomic
Date: Thu, 21 Jan 2010 12:03:05 -0600
Message-ID: <4B5896D9.7020403@ti.com>
References: <1264046462-2417-1-git-send-email-deepak.chitriki@ti.com> <27F9C60D11D683428E133F85D2BB4A53042DF3B7BA@dlee03.ent.ti.com> <4B58931A.2090008@ti.com> <27F9C60D11D683428E133F85D2BB4A53042DF3B7E7@dlee03.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:45681 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752722Ab0AUSDM (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 21 Jan 2010 13:03:12 -0500
In-Reply-To: <27F9C60D11D683428E133F85D2BB4A53042DF3B7E7@dlee03.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Ramirez Luna, Omar" <omar.ramirez@ti.com>
Cc: "Chitriki Rudramuni, Deepak" <deepak.chitriki@ti.com>, linux-omap <linux-omap@vger.kernel.org>, "Guzman Lugo, Fernando" <x0095840@ti.com>, Ameya Palande <ameya.palande@nokia.com>, Felipe Contreras <felipe.contreras@nokia.com>, Hiroshi Doyu <hiroshi.doyu@nokia.com>

Ramirez Luna, Omar had written, on 01/21/2010 11:57 AM, the following:
>> From: Menon, Nishanth on Thursday, January 21, 2010 11:47 AM
>>
>> Ramirez Luna, Omar had written, on 01/21/2010 11:43 AM, the following:
>>>> From: Chitriki Rudramuni, Deepak on Wednesday, January 20, 2010 10:01 PM
>>>>
>> [...]
>>
>>>> diff --git a/drivers/dsp/bridge/wmd/tiomap3430_pwr.c b/drivers/dsp/bridge/wmd/tiomap3430_pwr.c
>>>> index 94b399f..54cba9f 100644
>>>> --- a/drivers/dsp/bridge/wmd/tiomap3430_pwr.c
>>>> +++ b/drivers/dsp/bridge/wmd/tiomap3430_pwr.c
>>>> @@ -806,3 +806,34 @@ void DSPClkWakeupEventCtrl(u32 ClkId, bool enable)
>>>> 	break;
>>>> 	}
>>>> }
>>>> +
>>>> +/**
>>>> + * tiomap3430_bump_dsp_opp_level() - bump up the opp if at minimum
>>>> + *
>>>> + * if we need a higher opp index, request for the same
>>>> + */
>>>> +DSP_STATUS tiomap3430_bump_dsp_opp_level(void)
>>>> +{
>>>> +#ifndef CONFIG_BRIDGE_DVFS
>>> Basically if DVFS is defined nothing is done, this was wrong in the original patch (like I
>> mentioned offline).
>>>> +	u32 opplevel;
>>>> +
>>>> +	struct dspbridge_platform_data *pdata =
>>>> +			omap_dspbridge_dev->dev.platform_data;
>>>> +
>>>> +	if (pdata->dsp_get_opp) {
>>>> +		opplevel = (*pdata->dsp_get_opp)();
>>>> +
>>>> +		/*
>>>> +		 * If OPP is at minimum level, increase it before waking
>>>> +		 * up the DSP.
>>>> +		 */
>>>> +		if (opplevel == 1 && pdata->dsp_set_min_opp) {
>>>> +			(*pdata->dsp_set_min_opp)(opp_level + 1);
>>>> +			DBG_Trace(DBG_LEVEL7, "CHNLSM_InterruptDSP: Setting "
>>>> +				"the vdd1 constraint level to %d before "
>>>> +				"waking DSP \n", opp_level + 1);
>>>> +		}
>>>> +	}
>>>> +#endif
>>>> +	return DSP_SOK;
>>>> +}
>>> Since we are reworking all of this can be changed (u32, opplevel == MAGIC_NUM), besides this was
>> specific to 3430.
>> 							^^^^^^^^^^^^^^^
>> opplevel==1 is independent of 3430.. index 1 has to be the lowest right?
> 
> You are right, I meant opplevel == VDD1_OPP or similar.
arrggh... NOoooooo more #ifdefs, I would rather see my patch for min,max 
opps pushed in(after a rework and add a nominal_opp, min_opp params to 
pdata and use it :D) - that way all silicon variances are handled in 
arch/arm/mach-omap2 rather than drivers/dsp/bridge.

> 
> But the entire bumping thing is specific to 3430 IMHO.
> 
if I get your point, you would rather see that this bump up disappear? 
OR is there a reason for saying this 3430 specific? on 3630, there are 
upto 4 OPPs(on the 1Ghz device), OR is this a errata workaround that we 
have here? the original commit is lacking in info about this.


-- 
Regards,
Nishanth Menon
