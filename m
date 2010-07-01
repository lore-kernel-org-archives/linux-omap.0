From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 2/2] OMAP4: Add support for PWM LED
Date: Thu, 1 Jul 2010 13:37:28 +0300
Message-ID: <20100701103727.GJ2822@atomide.com>
References: <17175.10.24.255.18.1277906683.squirrel@dbdmail.itg.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:51039 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752307Ab0GAKhU (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 1 Jul 2010 06:37:20 -0400
Content-Disposition: inline
In-Reply-To: <17175.10.24.255.18.1277906683.squirrel@dbdmail.itg.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Hemanth V <hemanthv@ti.com>
Cc: linux-omap@vger.kernel.org

* Hemanth V <hemanthv@ti.com> [100630 17:12]:
> From 713727188b99465341767eedaa42004862261211 Mon Sep 17 00:00:00 2001
> From: Hemanth V <hemanthv@ti.com>
> Date: Wed, 30 Jun 2010 18:16:33 +0530
> Subject: [PATCH] OMAP4: Add support for PWM LED
> 
> TWL6030 supports PWM (Pulse Width Modulator) which is used
> to control charging LED. This allows for controlling brightness
> This patch implements the APIs needed by leds-pwm driver.

<snip>

> --- /dev/null
> +++ b/arch/arm/mach-omap2/twl6030_pwm.c
> @@ -0,0 +1,168 @@
> +/*
> + * twl6030_pwm.c
> + * Driver for PHOENIX (TWL6030) Pulse Width Modulator

This should go to somewhere under drivers instead of
arch/arm/mach-omap2.

Tony
