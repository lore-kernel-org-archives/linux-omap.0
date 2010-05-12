From: Ranjith Lohithakshan <ranjithl@ti.com>
Subject: Re: Bug in omap3evm.c?
Date: Wed, 12 May 2010 19:34:00 +0530
Message-ID: <4BEAB550.9000502@ti.com>
References: <4B8557E2E5753944B2BB2E52F7C2A30C02C6DA1A@MAIL.AES.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:41629 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754511Ab0ELOEM (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 12 May 2010 10:04:12 -0400
In-Reply-To: <4B8557E2E5753944B2BB2E52F7C2A30C02C6DA1A@MAIL.AES.local>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Rick Ball <rball@AESAustin.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>



On Tue, 11-May-10 4:38 AM +0530, Rick Ball wrote:
> I think I've found a small problem in the board-omap3evm.c file under arch/arm/mach-omap2 (support for the TI/Mistral OMAP35x EVM board).
> 
> What I noticed is that the declaration for the array gpio_leds is initialized with one element (at line 380):
> 
> static struct gpio_led gpio_leds[] = {
>         {
>                 .name                   = "omap3evm::ledb",
>                 /* normally not visible (board underside) */
>                 .default_trigger        = "default-on",
>                 .gpio                   = -EINVAL,      /* gets replaced */
>                 .active_low             = true,
>         },
> };
>  
> But then down at line 430 element 2 is set:
> 
>         /* TWL4030_GPIO_MAX + 1 == ledB (out, active low LED) */
>         gpio_leds[2].gpio = gpio + TWL4030_GPIO_MAX + 1;
> 
> How did the array end up with 3 elements so that 2 would be a valid index?  It looks to me like it wouldn't flag an error, but would corrupt memory.  I'd submit a patch, but I'm not sure what this code was attempting to do...

This appears to be like a bug. Possibly there would have been some
entries earlier which got removed, but the indexing done in the code
never got updated.

 - Ranjith
