From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [PATCH 5/17] ARM: OMAP2: Change 24xx to use new register access
Date: Mon, 7 Apr 2008 17:48:56 +0100
Message-ID: <20080407164856.GG5306@flint.arm.linux.org.uk>
References: <1205848935-12078-1-git-send-email-tony@atomide.com> <1205848935-12078-2-git-send-email-tony@atomide.com> <1205848935-12078-3-git-send-email-tony@atomide.com> <1205848935-12078-4-git-send-email-tony@atomide.com> <1205848935-12078-5-git-send-email-tony@atomide.com> <1205848935-12078-6-git-send-email-tony@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([78.32.30.218]:60634 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750960AbYDGQtG (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 7 Apr 2008 12:49:06 -0400
Content-Disposition: inline
In-Reply-To: <1205848935-12078-6-git-send-email-tony@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: linux-arm-kernel@lists.arm.linux.org.uk, linux-omap@vger.kernel.org

On Tue, Mar 18, 2008 at 04:02:03PM +0200, Tony Lindgren wrote:
> From: Paul Walmsley <paul@pwsan.com>
> 
> This patch changes 24xx to use new register access, except for clock
> framework. Clock framework register access will get updates in the
> next patch.

Hmm...

> @@ -187,13 +189,40 @@ static inline void __init apollon_init_smc91x(void)
>  {
>  	unsigned long base;
>  
> +	unsigned int rate;
> +	struct clk *l3ck;
> +	int eth_cs;
> +
> +	l3ck = clk_get(NULL, "core_l3_ck");
> +	if (IS_ERR(l3ck))
> +		rate = 100000000;
> +	else
> +		rate = clk_get_rate(l3ck);

Now read:

/**
 * clk_get_rate - obtain the current clock rate (in Hz) for a clock source.
 *                This is only valid once the clock source has been enabled.
 * @clk: clock source
 */
unsigned long clk_get_rate(struct clk *clk);

And now tell me what's wrong with the above code.

> +	int eth_cs;
> +	unsigned long cs_mem_base;
> +	unsigned int muxed, rate;
> +	struct clk *l3ck;
> +
> +	eth_cs	= H4_SMC91X_CS;
> +
> +	l3ck = clk_get(NULL, "core_l3_ck");
> +	if (IS_ERR(l3ck))
> +		rate = 100000000;
> +	else
> +		rate = clk_get_rate(l3ck);

Ditto.
