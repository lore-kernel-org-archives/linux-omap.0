From: Tero Kristo <t-kristo@ti.com>
Subject: Re: [PATCH] regulator: twl6030: add support for vdd1, vdd2 and
 vdd3 regulators
Date: Fri, 24 Feb 2012 16:42:12 +0200
Message-ID: <1330094532.4102.555.camel@sokoban>
References: <1329995109-4795-1-git-send-email-t-kristo@ti.com>
	 <20120223153422.GF4553@opensource.wolfsonmicro.com>
	 <1330076289.4102.517.camel@sokoban>
	 <20120224114940.GB5450@opensource.wolfsonmicro.com>
	 <1330089398.4102.539.camel@sokoban>
	 <20120224132408.GF5450@opensource.wolfsonmicro.com>
	 <1330091765.4102.547.camel@sokoban>
	 <20120224140109.GG5450@opensource.wolfsonmicro.com>
	 <1330093512.4102.552.camel@sokoban>
	 <20120224143415.GL5450@opensource.wolfsonmicro.com>
Reply-To: <t-kristo@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:44190 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755439Ab2BXOmU (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 24 Feb 2012 09:42:20 -0500
In-Reply-To: <20120224143415.GL5450@opensource.wolfsonmicro.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Liam Girdwood <lrg@ti.com>, Samuel Ortiz <sameo@linux.intel.com>, Kevin Hilman <khilman@ti.com>

On Fri, 2012-02-24 at 14:34 +0000, Mark Brown wrote:
> On Fri, Feb 24, 2012 at 04:25:12PM +0200, Tero Kristo wrote:
> 
> > Still, setting selector in this case does nothing, as it is immediately
> > overwritten by the regulator core by -1. This looks like a perfectly
> > acceptable way to implement a regulator, as everything checks for the
> > presence of list_voltage anyway.
> 
> Ah, so it is - we're fixing things up in the core.  I'd forgotten we did
> that.

So, no need to add list_voltage to this, I just fix the return values
for the get / set and send the new version, am I right?

-Tero

