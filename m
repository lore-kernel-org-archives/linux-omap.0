From: "Hemanth V" <hemanthv@ti.com>
Subject: Re: [PATCH 1/7] pwm: Add pwm core driver
Date: Tue, 28 Sep 2010 18:23:24 +0530
Message-ID: <040c01cb5f0c$29bcb3b0$LocalHost@wipblrx0099946>
References: <1285670134-18063-1-git-send-email-arun.murthy@stericsson.com> <1285670134-18063-2-git-send-email-arun.murthy@stericsson.com>
Mime-Version: 1.0
Content-Type: text/plain;
	format=flowed;
	charset="iso-8859-1";
	reply-type=original
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:59578 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753131Ab0I1MzK (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 28 Sep 2010 08:55:10 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: lars@metafoo.de, Andrew Morton <akpm@linux-foundation.org>, kernel@pengutronix.de, philipp.zabel@gmail.com, robert.jarzmik@free.fr
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-mips@linux-mips.org, Arun MURTHY <arun.murthy@stericsson.com>, STEricsson_nomadik_linux@list.st.com

----- Original Message ----- 
From: "Arun Murthy" <arun.murthy@stericsson.com>


> The existing pwm based led and backlight driver makes use of the
> pwm(include/linux/pwm.h). So all the board specific pwm drivers will
> be exposing the same set of function name as in include/linux/pwm.h.
> As a result build fails in case of multi soc environments where each soc
> has a pwm device in it.

This seems very specific to ST environment,  looking at the driver list from
( [PATCH 4/7] pwm: Align existing pwm drivers with pwm-core ) it seems
most multi SOC environments might support PWM in either one of the SOC.

arch/arm/plat-mxc/pwm.c
arch/arm/plat-pxa/pwm.c
arch/arm/plat-samsung/pwm.c
arch/mips/jz4740/pwm.c
drivers/mfd/twl6030-pwm.c

Unless people have examples of other SOCs which might use this,
the better approach might be to go for a custom driver rather than changing
the framework.

Thanks
Hemanth 

