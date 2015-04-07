From: Igor Grinberg <grinberg@compulab.co.il>
Subject: Re: [rtc-linux] [PATCH] rtc: OMAP: Add external 32k clock feature
Date: Tue, 07 Apr 2015 10:06:52 +0300
Message-ID: <5523820C.2010709@compulab.co.il>
References: <1425375722-13412-1-git-send-email-j-keerthy@ti.com> <20150324155916.cfd1b7ab442271466160283f@linux-foundation.org> <55234F25.5060708@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from softlayer.compulab.co.il ([50.23.254.55]:54809 "EHLO
	compulab.co.il" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751528AbbDGHG4 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 7 Apr 2015 03:06:56 -0400
In-Reply-To: <55234F25.5060708@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Keerthy <a0393675@ti.com>, Andrew Morton <akpm@linux-foundation.org>, rtc-linux@googlegroups.com
Cc: Keerthy <j-keerthy@ti.com>, a.zummo@towertech.it, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org

Hi,

On 04/07/15 06:29, Keerthy wrote:
> Hi Andrew,
> 
> Apologies for replying late.
> 
> On Wednesday 25 March 2015 04:29 AM, Andrew Morton wrote:
>> On Tue, 3 Mar 2015 15:12:02 +0530 Keerthy <j-keerthy@ti.com> wrote:
>>
>>> Add external 32k clock feature. The internal clock will be gated during suspend.
>>> Hence make use of the external 32k clock so that rtc is functional accross
>>> suspend/resume.
>>>
>>> ...
>>>
>>> @@ -446,6 +449,7 @@ static const struct omap_rtc_device_type omap_rtc_default_type = {
>>>
>>>   static const struct omap_rtc_device_type omap_rtc_am3352_type = {
>>>       .has_32kclk_en    = true,
>>> +    .has_osc_ext_32k = true,
>>>       .has_kicker    = true,
>>>       .has_irqwakeen    = true,
>>>       .has_pmic_mode    = true,
>>> @@ -543,7 +547,16 @@ static int __init omap_rtc_probe(struct platform_device *pdev)
>>>       if (rtc->type->has_32kclk_en) {
>>>           reg = rtc_read(rtc, OMAP_RTC_OSC_REG);
>>>           rtc_writel(rtc, OMAP_RTC_OSC_REG,
>>> -                reg | OMAP_RTC_OSC_32KCLK_EN);
>>> +               reg | OMAP_RTC_OSC_32KCLK_EN);
>>> +    }
>>> +
>>> +    /* Enable External clock as the source */
>>> +
>>> +    if (rtc->type->has_osc_ext_32k) {
>>> +        rtc_writel(rtc, OMAP_RTC_OSC_REG,
>>> +               (OMAP_RTC_OSC_EXT_32K |
>>> +               rtc_read(rtc, OMAP_RTC_OSC_REG)) &
>>> +               (~OMAP_RTC_OSC_OSC32K_GZ));
>>>       }
>>
>> How do we know that all systems have this external clock and that it
>> works OK?
>>
> 
> AM335 and AM43X have the external clock feature which we choose using
> RTC_OSC_REG. I verified it works OK by seeing the RTC seconds ticking
> even after switching the source to the external 32k Clock.

AFAIU, this is related to the external (outside of SoC) oscillator, right?
If so, there is a possibility to not assemble it on the board (at least
on AM335) and use the internal clock source instead.
There are dozens of boards out there that do not have the external
oscillator assembled.

Am I missing something?

-- 
Regards,
Igor.
