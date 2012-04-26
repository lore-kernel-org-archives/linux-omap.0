From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [PATCH-V3 3/3] ARM: OMAP3+: clock33xx: Add AM33XX clock tree
 data
Date: Wed, 25 Apr 2012 23:45:21 -0600 (MDT)
Message-ID: <alpine.DEB.2.00.1204252335190.30642@utopia.booyaka.com>
References: <1333458578-23073-1-git-send-email-hvaibhav@ti.com> <1333458578-23073-4-git-send-email-hvaibhav@ti.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:35775 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751363Ab2DZFpW (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 26 Apr 2012 01:45:22 -0400
In-Reply-To: <1333458578-23073-4-git-send-email-hvaibhav@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Vaibhav Hiremath <hvaibhav@ti.com>, Afzal Mohammed <afzal@ti.com>, Vaibhav Bedia <vaibhav.bedia@ti.com>
Cc: linux-omap@vger.kernel.org, tony@atomide.com, khilman@ti.com, rnayak@ti.com, b-cousson@ti.com, linux-arm-kernel@lists.infradead.org

Hi,

> +/*
> + * clkdiv32 is generated from fixed division of 732.4219
> + */
> +static struct clk clkdiv32k_ick = {
> +	.name		= "clkdiv32k_ick",
> +	.clkdm_name	= "clk_24mhz_clkdm",
> +	.rate		= 32768,
> +	.parent		= &clk_24mhz,
> +	.enable_reg	= AM33XX_CM_PER_CLKDIV32K_CLKCTRL,
> +	.enable_bit	= AM33XX_MODULEMODE_SWCTRL,
> +	.ops		= &clkops_omap2_dflt,
> +};

While working on this file, this clock seemed quite perplexing.  Perhaps 
you might be able to answer some questions about it.

- The fractional fixed division seems a little bogus.  Is this actually an 
M,N counter?  A few moments with PARI revealed a likely M,N of 64,46875.  
Could you please confirm that this is the case for this clock?

- This clock structure makes this clock appear to be a fixed-frequency 
clock.  But according to SPRUH73D Figure 8-10 "Peripheral PLL Structure", 
the divider feeding this clock can be switched between an M,N of 64,46875 
and 32,46875 depending on the value of CONTROL_CLK32K_DIVRATIO_CTRL.  So 
shouldn't we implement that?

- This clock is feeding downstream clocks, but it's using the MODULEMODE 
control interface, as if it were a standalone IP block.  Do you know why 
it's using the MODULEMODE control method rather than some optional clock 
control bits, like OMAP4 does?


- Paul
