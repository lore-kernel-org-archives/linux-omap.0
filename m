From: Grant Erickson <marathon96@gmail.com>
Subject: Re: [PATCH] Add OMAP Support for Generic PWM Devices using Dual-mode
 Timers
Date: Tue, 16 Nov 2010 09:45:59 -0800
Message-ID: <C9080357.1FE83%marathon96@gmail.com>
References: <DDDB4A81DAFB4611A2BE7C99D7F92684@wipblrx0099946>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-px0-f174.google.com ([209.85.212.174]:52942 "EHLO
	mail-px0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753636Ab0KPRqD (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 16 Nov 2010 12:46:03 -0500
Received: by pxi15 with SMTP id 15so243058pxi.19
        for <linux-omap@vger.kernel.org>; Tue, 16 Nov 2010 09:46:02 -0800 (PST)
In-Reply-To: <DDDB4A81DAFB4611A2BE7C99D7F92684@wipblrx0099946>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Hemanth V <hemanthv@ti.com>
Cc: Tony Lindgren <tony@atomide.com>, linux-omap@vger.kernel.org

On 11/16/10 4:37 AM, Hemanth V wrote:
> ----- Original Message -----
> From: "Grant Erickson" <marathon96@gmail.com>
> Sent: Monday, November 15, 2010 12:58 AM
> 
>> This patch adds support to request and use one or more of the OMAP
>> dual-mode timers as a generic PWM device compatible with other generic
>> PWM drivers such as the PWM backlight or PWM beeper driver.
> 
> Generally PWMs are supported on PMIC chip.  Is this driver intended for use
> when OMAP is used standalone?

Correct. 

>> Boards can register such devices using platform data such as in the
>> following
>> example:
>> 
>> static struct omap2_pwm_platform_config pwm_config = {
>>     .timer_id           = 10,   // GPT10_PWM_EVT
> 
> Since only specific GPTs can be configured for PWM, can some check
> we added in probe function?

Yes, that check is already present in the probe function:

    pwm->dm_timer = omap_dm_timer_request_specific(pdata->timer_id);

    if (pwm->dm_timer == NULL) {
        status = -ENOENT;
        goto err_free;
    }

> Can the above file  be part of mach-omap2, since comment say its
> specifically for OMAP2/3 or will this work on OMAP1 also?

It should work wherever dmtimers are supported. To the extent that dmtimer.c
is in plat-omap/, I located pwm.c there as well.

Thanks for the feedback!

Best,

Grant


