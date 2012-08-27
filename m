From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH v3 1/4] arm/dts: regulator: Add tps65910 device tree data
Date: Mon, 27 Aug 2012 09:51:38 -0700
Message-ID: <20120827165137.GL4339@opensource.wolfsonmicro.com>
References: <1345547850-29761-1-git-send-email-anilkumar@ti.com>
 <1345547850-29761-2-git-send-email-anilkumar@ti.com>
 <5033ADC5.4030002@wwwdotorg.org>
 <20120821163805.GW7995@opensource.wolfsonmicro.com>
 <5033CDDB.808@wwwdotorg.org>
 <20120821180847.GC7995@opensource.wolfsonmicro.com>
 <20120824201634.GZ11011@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from opensource.wolfsonmicro.com ([80.75.67.52]:46597 "EHLO
	opensource.wolfsonmicro.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752432Ab2H0Qvk (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Mon, 27 Aug 2012 12:51:40 -0400
Content-Disposition: inline
In-Reply-To: <20120824201634.GZ11011@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Stephen Warren <swarren@wwwdotorg.org>, AnilKumar Ch <anilkumar@ti.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

On Fri, Aug 24, 2012 at 01:16:34PM -0700, Tony Lindgren wrote:
> * Mark Brown <broonie@opensource.wolfsonmicro.com> [120821 11:09]:

> > The board shouldn't have to define the regulators, the regulator driver
> > really ought to be able to figure out that they're there by itself if
> > there's no configuration based purely on knowing which chip is there.
> > From that point of view it's OK for the chip .dtsi to have them (though
> > ideally the driver wouldn't *need* that either) which was what was
> > happening here.

> So I assume no changes needed here then?

Seems that way.
