From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [PATCH] OMAP3 ROM Random Number Generator support
Date: Thu, 28 Mar 2013 09:52:28 +0000
Message-ID: <20130328095228.GT30923@n2100.arm.linux.org.uk>
References: <201302281905.48546@pali> <20130327210918.GP10155@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([78.32.30.218]:46869 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756149Ab3C1Jwy (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 28 Mar 2013 05:52:54 -0400
Content-Disposition: inline
In-Reply-To: <20130327210918.GP10155@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Pali =?iso-8859-1?Q?Roh=E1r?= <pali.rohar@gmail.com>, Juha Yrjola <juha.yrjola@solidboot.com>, Matt Mackall <mpm@selenic.com>, Herbert Xu <herbert@gondor.apana.org.au>, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org

On Wed, Mar 27, 2013 at 02:09:18PM -0700, Tony Lindgren wrote:
> > +	setup_timer(&idle_timer, omap3_rom_idle_rng, 0);
> > +	rng_clk = clk_get_sys("omap_rng", "ick");

Why is this using clk_get_sys when it should be using clk_get() with the
platform device?
