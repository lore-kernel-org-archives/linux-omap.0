From: Tero Kristo <t-kristo@ti.com>
Subject: Re: [PATCH] regulator: twl6030: add support for vdd1, vdd2 and
 vdd3 regulators
Date: Fri, 24 Feb 2012 17:04:44 +0200
Message-ID: <1330095884.4102.564.camel@sokoban>
References: <20120223153422.GF4553@opensource.wolfsonmicro.com>
	 <1330076289.4102.517.camel@sokoban>
	 <20120224114940.GB5450@opensource.wolfsonmicro.com>
	 <1330089398.4102.539.camel@sokoban>
	 <20120224132408.GF5450@opensource.wolfsonmicro.com>
	 <1330091765.4102.547.camel@sokoban>
	 <20120224140109.GG5450@opensource.wolfsonmicro.com>
	 <1330093512.4102.552.camel@sokoban>
	 <20120224143415.GL5450@opensource.wolfsonmicro.com>
	 <1330094532.4102.555.camel@sokoban>
	 <20120224145027.GN5450@opensource.wolfsonmicro.com>
Reply-To: <t-kristo@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:46641 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754533Ab2BXPFK (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 24 Feb 2012 10:05:10 -0500
In-Reply-To: <20120224145027.GN5450@opensource.wolfsonmicro.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Liam Girdwood <lrg@ti.com>, Samuel Ortiz <sameo@linux.intel.com>, Kevin Hilman <khilman@ti.com>

On Fri, 2012-02-24 at 14:50 +0000, Mark Brown wrote:
> On Fri, Feb 24, 2012 at 04:42:12PM +0200, Tero Kristo wrote:
> > On Fri, 2012-02-24 at 14:34 +0000, Mark Brown wrote:
> 
> > > Ah, so it is - we're fixing things up in the core.  I'd forgotten we did
> > > that.
> 
> > So, no need to add list_voltage to this, I just fix the return values
> > for the get / set and send the new version, am I right?
> 
> I guess.  Though actually given that there's no interaction with the
> chip itself at all I'm not sure I understand why this is part of the
> twl6030 driver rather than being a separate driver for whatever
> implements the operations - it's not like the case with the other
> regulators where there was some functionality implemented through the
> twl6030 driver beyond straight passthrough.

Well, there are still some registers within twl6030 that could be
accessed through the control channel, it is just that the voltage
registers are no longer visible through this. We have the CFG_GRP,
CFG_TRANS, CFG_STATE and CFG_STEP registers visible here, even though we
are not accessing them right now.

-Tero


