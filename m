From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 2/5] [RFC-HACK] ARM: dts: OMAP3: reorder pinmux_gpio1_pins
Date: Thu, 22 May 2014 16:32:48 -0700
Message-ID: <20140522233247.GF29577@atomide.com>
References: <1400799986-20043-1-git-send-email-chf.fritz@googlemail.com>
 <1400799986-20043-3-git-send-email-chf.fritz@googlemail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:43000 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751315AbaEVXcx (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 22 May 2014 19:32:53 -0400
Content-Disposition: inline
In-Reply-To: <1400799986-20043-3-git-send-email-chf.fritz@googlemail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Christoph Fritz <chf.fritz@googlemail.com>
Cc: Grygorii Strashko <grygorii.strashko@ti.com>, Pekon Gupta <pekon@ti.com>, =?utf-8?Q?Beno=C3=AEt?= Cousson <bcousson@baylibre.com>, Daniel Mack <zonque@gmail.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

* Christoph Fritz <chf.fritz@googlemail.com> [140522 16:07]:
> pinctrl-single for omap3_pmx_core2 gets deferred which results in
> some corrupt IRQs so that mmc, spi and dss stop working.
> 
> Diff of bootlog with (good) and without (fail) this patch:
> 
> --- good
> +++ fail
>  cpuidle: using governor ladder
>  cpuidle: using governor menu
>  Reprogramming SDRC clock to 400000000 Hz
> -pinctrl-single 480025a0.pinmux: 46 pins at pa fa0025a0 size 92
>  pinctrl-single 48002030.pinmux: 282 pins at pa fa002030 size 564
>  pinctrl-single 48002a00.pinmux: 46 pins at pa fa002a00 size 92
> +omap_gpio 48310000.gpio: could not find pctldev for node /ocp/pinmux@480025a0/pinmux_gpio1_pins, deferring probe
> +platform 48310000.gpio: Driver omap_gpio requests probe deferral

I believe this issue too gets fixed because of the drivers/Makefile
order if we make them all module_init.

Regards,

Tony
