From: Russell King <rmk@arm.linux.org.uk>
Subject: Re: [PATCH 8/8] OMAP1 clock: convert mach-omap1/clock.h to
	mach-omap1/clock_data.c
Date: Thu, 3 Dec 2009 10:27:00 +0000
Message-ID: <20091203102700.GA30423@flint.arm.linux.org.uk>
References: <20091203095830.1203.76290.stgit@localhost.localdomain> <20091203100707.1203.98247.stgit@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([78.32.30.218]:53190 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753552AbZLCK1H (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 3 Dec 2009 05:27:07 -0500
Content-Disposition: inline
In-Reply-To: <20091203100707.1203.98247.stgit@localhost.localdomain>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Nishanth Menon <nm@ti.com>, Felipe Balbi <felipe.balbi@nokia.com>

On Thu, Dec 03, 2009 at 03:07:08AM -0700, Paul Walmsley wrote:
> -static int clk_omap1_dummy_enable(struct clk *clk)
> +int clk_omap1_dummy_enable(struct clk *clk)
>  {
>  	return 0;
>  }
>  
> -static void clk_omap1_dummy_disable(struct clk *clk)
> +void clk_omap1_dummy_disable(struct clk *clk)
>  {
>  }
>  
> -static const struct clkops clkops_dummy = {
> -	.enable = clk_omap1_dummy_enable,
> -	.disable = clk_omap1_dummy_disable,
> -};

I've no idea why you're moving the clkops into these other files - I think
this is going far too far.  Why not just make the clkops structures non-
static?

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:
