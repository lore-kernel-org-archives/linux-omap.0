From: Rick Ball <rball@AESAustin.com>
Subject: Bug in omap3evm.c?
Date: Mon, 10 May 2010 23:08:59 +0000
Message-ID: <4B8557E2E5753944B2BB2E52F7C2A30C02C6DA1A@MAIL.AES.local>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail.ascendant-es.com ([209.12.206.138]:29612 "EHLO
	mail.aesasutin.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S932819Ab0EJXJD convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 10 May 2010 19:09:03 -0400
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

I think I've found a small problem in the board-omap3evm.c file under arch/arm/mach-omap2 (support for the TI/Mistral OMAP35x EVM board).

What I noticed is that the declaration for the array gpio_leds is initialized with one element (at line 380):

static struct gpio_led gpio_leds[] = {
        {
                .name                   = "omap3evm::ledb",
                /* normally not visible (board underside) */
                .default_trigger        = "default-on",
                .gpio                   = -EINVAL,      /* gets replaced */
                .active_low             = true,
        },
};
 
But then down at line 430 element 2 is set:

        /* TWL4030_GPIO_MAX + 1 == ledB (out, active low LED) */
        gpio_leds[2].gpio = gpio + TWL4030_GPIO_MAX + 1;

How did the array end up with 3 elements so that 2 would be a valid index?  It looks to me like it wouldn't flag an error, but would corrupt memory.  I'd submit a patch, but I'm not sure what this code was attempting to do...

Rick Ball
