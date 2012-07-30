From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: New build warnings
Date: Mon, 30 Jul 2012 19:06:23 +0100
Message-ID: <20120730180623.GJ7405@n2100.arm.linux.org.uk>
References: <20120730164444.GO6802@n2100.arm.linux.org.uk> <20120730174043.GO4468@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([78.32.30.218]:52015 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751793Ab2G3SG2 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 30 Jul 2012 14:06:28 -0400
Content-Disposition: inline
In-Reply-To: <20120730174043.GO4468@opensource.wolfsonmicro.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: linux-omap@vger.kernel.org, Liam Girdwood <lrg@ti.com>, Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@pengutronix.de>

On Mon, Jul 30, 2012 at 06:40:43PM +0100, Mark Brown wrote:
> On Mon, Jul 30, 2012 at 05:44:44PM +0100, Russell King - ARM Linux wrote:
> 
> > -#define TWLRES_OF_MATCH(comp, label) TWL_OF_MATCH(comp, TWLRES, label)
> > -       TWLRES_OF_MATCH("ti,twl6030-clk32kg", CLK32KG),
> 
> > but completely forgets that this:
> 
> > TWL6030_FIXED_RESOURCE(CLK32KG, 0x8C, 0);
> 
> > defines a structure that it was using.  (Welcome to why macros are horrid
> > when they hide the names of stuff they create.)
> 
> I actually have the fix in a separate patch which completely removes
> the "regulator" but wasn't happy about pushing the patch for 3.6 since I
> can't test (I don't think anyone's ever actually used those and
> obviously they should be using the clk API now).

If the structure is unused, the fix is to delete the
"TWL6030_FIXED_RESOURCE(CLK32KG, 0x8C, 0);" line because nothing is using
that (if it was, we wouldn't end up with the warning).
