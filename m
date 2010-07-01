From: "Hemanth V" <hemanthv@ti.com>
Subject: Re: [PATCH 2/2] OMAP4: Add support for PWM LED
Date: Thu, 1 Jul 2010 17:47:05 +0530
Message-ID: <028701cb1917$5313cd60$LocalHost@wipblrx0099946>
References: <17175.10.24.255.18.1277906683.squirrel@dbdmail.itg.ti.com> <20100701103727.GJ2822@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain;
	format=flowed;
	charset="iso-8859-1";
	reply-type=original
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:38975 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751407Ab0GAMRO (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 1 Jul 2010 08:17:14 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: linux-omap@vger.kernel.org

----- Original Message ----- 
From: "Tony Lindgren" <tony@atomide.com>
To: "Hemanth V" <hemanthv@ti.com>
Cc: <linux-omap@vger.kernel.org>
Sent: Thursday, July 01, 2010 4:07 PM
Subject: Re: [PATCH 2/2] OMAP4: Add support for PWM LED


>* Hemanth V <hemanthv@ti.com> [100630 17:12]:
>> From 713727188b99465341767eedaa42004862261211 Mon Sep 17 00:00:00 2001
>> From: Hemanth V <hemanthv@ti.com>
>> Date: Wed, 30 Jun 2010 18:16:33 +0530
>> Subject: [PATCH] OMAP4: Add support for PWM LED
>> 
>> TWL6030 supports PWM (Pulse Width Modulator) which is used
>> to control charging LED. This allows for controlling brightness
>> This patch implements the APIs needed by leds-pwm driver.
> 
> <snip>
> 
>> --- /dev/null
>> +++ b/arch/arm/mach-omap2/twl6030_pwm.c
>> @@ -0,0 +1,168 @@
>> +/*
>> + * twl6030_pwm.c
>> + * Driver for PHOENIX (TWL6030) Pulse Width Modulator
> 
> This should go to somewhere under drivers instead of
> arch/arm/mach-omap2.

Tony, since PWM is specific to each platform, they are typically
under platform folder. Some examples below

 arch/arm/plat-mxc/pwm.c
 arch/arm/plat-pxa/pwm.c
 arch/arm/plat-samsung/pwm.c

