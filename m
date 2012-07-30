From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: New build warnings
Date: Mon, 30 Jul 2012 19:40:38 +0100
Message-ID: <20120730184038.GS4468@opensource.wolfsonmicro.com>
References: <20120730164444.GO6802@n2100.arm.linux.org.uk>
 <20120730174043.GO4468@opensource.wolfsonmicro.com>
 <20120730180623.GJ7405@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from opensource.wolfsonmicro.com ([80.75.67.52]:59892 "EHLO
	opensource.wolfsonmicro.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752263Ab2G3Skk (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Mon, 30 Jul 2012 14:40:40 -0400
Content-Disposition: inline
In-Reply-To: <20120730180623.GJ7405@n2100.arm.linux.org.uk>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: linux-omap@vger.kernel.org, Liam Girdwood <lrg@ti.com>, Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@pengutronix.de>

On Mon, Jul 30, 2012 at 07:06:23PM +0100, Russell King - ARM Linux wrote:
> On Mon, Jul 30, 2012 at 06:40:43PM +0100, Mark Brown wrote:

> > I actually have the fix in a separate patch which completely removes
> > the "regulator" but wasn't happy about pushing the patch for 3.6 since I
> > can't test (I don't think anyone's ever actually used those and
> > obviously they should be using the clk API now).

> If the structure is unused, the fix is to delete the
> "TWL6030_FIXED_RESOURCE(CLK32KG, 0x8C, 0);" line because nothing is using
> that (if it was, we wouldn't end up with the warning).

Well, clearly.  I had thought there were implicit references somewhere
but apparently not since it's not in an array or anything.  Oh, well.
