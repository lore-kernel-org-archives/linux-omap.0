From: Rajendra Nayak <rnayak@ti.com>
Subject: Re: [PATCH] OMAP4: clockdomain: Follow recommended enable sequence
Date: Tue, 05 Apr 2011 18:17:29 +0530
Message-ID: <4D9B0F61.8070905@ti.com>
References: <1299245123-23444-1-git-send-email-rnayak@ti.com> <alpine.DEB.2.00.1103081937100.15132@utopia.booyaka.com> <4D775418.6050105@ti.com> <alpine.DEB.2.00.1103100514210.15132@utopia.booyaka.com> <alpine.DEB.2.00.1103100734490.15132@utopia.booyaka.com> <4D7A22F6.5050806@ti.com> <871v2dbo3q.fsf@ti.com> <4D8711A5.6070301@ti.com> <alpine.DEB.2.00.1103281036060.26455@utopia.booyaka.com> <4D91824F.8020702@ti.com> <4D95E681.4070605@ti.com> <4D95F1F8.5060702@ti.com> <alpine.DEB.2.00.1104040021530.8323@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog116.obsmtp.com ([74.125.149.240]:47460 "EHLO
	na3sys009aog116.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753597Ab1DEMru (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 5 Apr 2011 08:47:50 -0400
Received: by gxk26 with SMTP id 26so114014gxk.32
        for <linux-omap@vger.kernel.org>; Tue, 05 Apr 2011 05:47:48 -0700 (PDT)
In-Reply-To: <alpine.DEB.2.00.1104040021530.8323@utopia.booyaka.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>
Cc: Kevin Hilman <khilman@ti.com>, linux-omap@vger.kernel.org, b-cousson@ti.com, santosh.shilimkar@ti.com, linux-arm-kernel@lists.infradead.org

Hi Paul,

On 4/4/2011 12:17 PM, Paul Walmsley wrote:
> On Fri, 1 Apr 2011, Rajendra Nayak wrote:
>
>> On 4/1/2011 8:21 PM, Rajendra Nayak wrote:
>>>>> In omap_hwmod.c:_enable(), what do you think about:
>>>>>
>>>>> 1. saving the current idle mode of the clockdomain,
>>>>>
>>>>> 2. forcing the clockdomain to software-supervised wakeup.
>>>>>
>>>>> 3. enabling clocks and waiting for the module as we currently do, then
>>>>>
>>>>> 4. switching the clockdomain's idle mode back to its original state?
>>>>>
>>>>> Seems like that would be a reasonable approach for the short term, at
>>>>> least for drivers that have been converted to PM runtime.
>>>>
>>>> Ok, I'll try and get some RFC patches in these lines soon.
>>>
>>> I tried some of what you were suggesting here and it seems to
>>> work well, like you said, for the drivers which are converted
>>> to PM runtime.
>>>
>>> Now the issue seems to be, how do we handle the ones which
>>> are *still* using clock framework to enable main clocks and
>>> are yet to be converted to PM runtime.
>>>
>>> One such, MMC, is showing me issues on OMAP4 even at boot
>>> and causes a crash.
>>>
>>> Its a different thing that some of these drivers which use
>>> direct clock calls are working by fluke on OMAP4 since the
>>> clock framework does not even wait for the modules to become
>>> accessible after the clock enable.
>>>
>>> I know the right way seems to be to get all these drivers
>>> converted to PM runtime, but that might take sometime.
>>
>> One way I am able to get this working (atleast MMC)
>> is by preventing the clock domain belonging to MMC module
>> from being programmed into HW_SUP mode.
>
> What programs the OMAP4 clockdomains into hwsup mode in the first place?

This is not yet in mainline, but being done by Santosh's series which
adds OMAP4 low power support in idle and suspend.
http://marc.info/?l=linux-omap&m=130130417927632&w=2

> There's no clkdms_setup() as there is in mach-omap2/pm34xx.c.  I guess
> maybe this code in mach-omap2/pm.c might do it as a side effect:
>
> 	switch (sleep_switch) {
> 	case FORCEWAKEUP_SWITCH:
> 		if (pwrdm->pwrdm_clkdms[0]->flags&  CLKDM_CAN_ENABLE_AUTO)
> 			clkdm_allow_idle(pwrdm->pwrdm_clkdms[0]);
> 		else
> 			clkdm_sleep(pwrdm->pwrdm_clkdms[0]);
> 		break;
>
> If I'm reading this code correctly, it will always force clockdomains that
> support hwsup mode into hwsup mode, even if they've been previously
> programmed to swsup mode.  That's not right.  This function should leave
> the clockdomain's autoidle setting where it was when the function was
> entered.  So this needs to be fixed also.

You are right, the code is buggy, I just posted a short series which
should fix this.
http://marc.info/?l=linux-omap&m=130200752115352&w=2

>
>> Acceptable hack in the interim while we wait for the MMC driver to be
>> using PM runtime?
>
> Ideally this should be overridden in the code, not the data, since this
> hack is needed due to a software problem, not a hardware problem.  The
> clockdomains data should just be a statement of what the hardware
> supports.
>
> But given the above bug and the lack of some clkdms_setup() function for
> OMAP4, I guess the clockdomains data is the least bad choice for right
> now, provided that the patch also:

With Santosh's series which adds the clkdms_setup and my series
to fix the above bug, I should be able to handle this in the code,
rather than hack the clockdomains data.
I will post some patches for that as well.

regards
Rajendra

>
> 1. puts a big comment in that data warning about the problem and
> explaining why
>
> 2. puts a pr_warn() in mach-omap2/pm44xx.c:omap4_pm_init() saying:
> "WARNING: OMAP4 power savings limited since MMC driver not converted to
> PM runtime"
>
>
> - Paul

