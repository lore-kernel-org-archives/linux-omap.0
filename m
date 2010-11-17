From: "Hemanth V" <hemanthv@ti.com>
Subject: Re: [PATCH] Add OMAP Support for Generic PWM Devices using Dual-mode Timers
Date: Wed, 17 Nov 2010 15:28:25 +0530
Message-ID: <8DF942970F1545A68956053912443807@wipblrx0099946>
References: <C9080357.1FE83%marathon96@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
	format=flowed;
	charset="iso-8859-1";
	reply-type=original
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:39858 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752059Ab0KQJ6e (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 17 Nov 2010 04:58:34 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Grant Erickson <marathon96@gmail.com>
Cc: Tony Lindgren <tony@atomide.com>, linux-omap@vger.kernel.org

----- Original Message ----- 
From: "Grant Erickson" <marathon96@gmail.com>
To: "Hemanth V" <hemanthv@ti.com>
Cc: "Tony Lindgren" <tony@atomide.com>; <linux-omap@vger.kernel.org>
Sent: Tuesday, November 16, 2010 11:15 PM
Subject: Re: [PATCH] Add OMAP Support for Generic PWM Devices using 
Dual-mode Timers


>
>>> Boards can register such devices using platform data such as in the
>>> following
>>> example:
>>>
>>> static struct omap2_pwm_platform_config pwm_config = {
>>>     .timer_id           = 10,   // GPT10_PWM_EVT
>>
>> Since only specific GPTs can be configured for PWM, can some check
>> we added in probe function?
>
> Yes, that check is already present in the probe function:
>
>    pwm->dm_timer = omap_dm_timer_request_specific(pdata->timer_id);
>
>    if (pwm->dm_timer == NULL) {
>        status = -ENOENT;
>        goto err_free;
>    }
>

Since only GPT8 to GPT11 can be configured for PWM output on OMAP3,
I was thinking if a suitable check can be added.

Thanks
Hemanth 

