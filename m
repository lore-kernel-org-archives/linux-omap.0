From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [PATCH 2/4] TI816X: clock: Add clock data
Date: Sat, 16 Jul 2011 02:05:40 -0600 (MDT)
Message-ID: <alpine.DEB.2.00.1107160201410.25013@utopia.booyaka.com>
References: <1301070006-8363-1-git-send-email-hemantp@ti.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:38726 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751084Ab1GPIFm (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sat, 16 Jul 2011 04:05:42 -0400
In-Reply-To: <1301070006-8363-1-git-send-email-hemantp@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Hemant Pedanekar <hemantp@ti.com>
Cc: linux-omap@vger.kernel.org, tony@atomide.com, linux-arm-kernel@lists.infradead.org, khilman@ti.com


Spot-checking this...

On Fri, 25 Mar 2011, Hemant Pedanekar wrote:

> +static struct clk uart1_fck = {
> +	.name		= "uart1_fck",
> +	.parent		= &sysclk10_ck,
> +	.ops		= &clkops_omap2_dflt,
> +	.enable_reg	= TI816X_CM_ALWON_UART_0_CLKCTRL,
> +	.enable_bit	= TI816X_MODULEMODE_SWCTRL,
> +	.clkdm_name	= "alwon_l3_slow_clkdm",
> +	.recalc		= &followparent_recalc,
> +};

Is this really in the alwon_l3_slow_clkdm clockdomain?  Looking at SPRS680 
section 5.2 "L4 Interconnect", these UARTs seem to be in some L4 
clockdomain?


- Paul
