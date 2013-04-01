From: Jan Luebbe <jlu@pengutronix.de>
Subject: Re: [PATCH 1/3] ARM: dts: AM33XX: Add pinmux configuration for CPSW
 to beaglebone
Date: Mon, 1 Apr 2013 12:45:14 +0200
Message-ID: <20130401104514.GA27388@pengutronix.de>
References: <1364196478-16688-1-git-send-email-mugunthanvnm@ti.com>
 <1364196478-16688-2-git-send-email-mugunthanvnm@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:54230 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757560Ab3DAKpS (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 1 Apr 2013 06:45:18 -0400
Content-Disposition: inline
In-Reply-To: <1364196478-16688-2-git-send-email-mugunthanvnm@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Mugunthan V N <mugunthanvnm@ti.com>
Cc: linux-omap@vger.kernel.org, devicetree-discuss@lists.ozlabs.org, b-cousson@ti.com, benoit.cousson@linaro.org, tony@atomide.com

On Mon, Mar 25, 2013 at 12:57:56PM +0530, Mugunthan V N wrote:
>  	am33xx_pinmux: pinmux@44e10800 {
>  		pinctrl-names = "default";
> -		pinctrl-0 = <&user_leds_s0>;
> +		pinctrl-0 = <&user_leds_s0 &cpsw_s0>;

Why do you add &cpsw_s0 to the pinmux node? This should go into the cpsw
node itself, which should work without further code changes since:
https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git/commit/?id=ab78029ecc347
(drivers/pinctrl: grab default handles from device core)

Same for the other patches.

Regards,
Jan
