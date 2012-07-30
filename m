From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: New build warnings
Date: Mon, 30 Jul 2012 18:40:43 +0100
Message-ID: <20120730174043.GO4468@opensource.wolfsonmicro.com>
References: <20120730164444.GO6802@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from opensource.wolfsonmicro.com ([80.75.67.52]:60246 "EHLO
	opensource.wolfsonmicro.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754603Ab2G3Rko (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Mon, 30 Jul 2012 13:40:44 -0400
Content-Disposition: inline
In-Reply-To: <20120730164444.GO6802@n2100.arm.linux.org.uk>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: linux-omap@vger.kernel.org, Liam Girdwood <lrg@ti.com>, Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@pengutronix.de>

On Mon, Jul 30, 2012 at 05:44:44PM +0100, Russell King - ARM Linux wrote:

> -#define TWLRES_OF_MATCH(comp, label) TWL_OF_MATCH(comp, TWLRES, label)
> -       TWLRES_OF_MATCH("ti,twl6030-clk32kg", CLK32KG),

> but completely forgets that this:

> TWL6030_FIXED_RESOURCE(CLK32KG, 0x8C, 0);

> defines a structure that it was using.  (Welcome to why macros are horrid
> when they hide the names of stuff they create.)

I actually have the fix in a separate patch which completely removes
the "regulator" but wasn't happy about pushing the patch for 3.6 since I
can't test (I don't think anyone's ever actually used those and
obviously they should be using the clk API now).
