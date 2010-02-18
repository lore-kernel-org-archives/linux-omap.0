From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 1/2] twl6030: regulator: Fix vsel calculations in
 set/get voltage apis
Date: Thu, 18 Feb 2010 09:48:14 +0000
Message-ID: <20100218094814.GD3315@rakim.wolfsonmicro.main>
References: <1266420255-4307-1-git-send-email-rnayak@ti.com>
 <20100217161509.GA13324@rakim.wolfsonmicro.main>
 <5A47E75E594F054BAF48C5E4FC4B92AB03215B1039@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from opensource.wolfsonmicro.com ([80.75.67.52]:43958 "EHLO
	opensource2.wolfsonmicro.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1754903Ab0BRJsQ (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Thu, 18 Feb 2010 04:48:16 -0500
Content-Disposition: inline
In-Reply-To: <5A47E75E594F054BAF48C5E4FC4B92AB03215B1039@dbde02.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Nayak, Rajendra" <rnayak@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, Liam Girdwood <lrg@slimlogic.co.uk>, Samuel Ortiz <sameo@linux.intel.com>

On Thu, Feb 18, 2010 at 12:02:49PM +0530, Nayak, Rajendra wrote:

> > This looks wrong - this code is inside a loop over vsel->voltage
> > mappings, if that mapping is wrong and needs to be ignored (which is
> > what this code is doing) then we shouldn't be looking at it at all.

> Not sure if I understood your comment completely, but here's how I think
> it will work.

> The for loop runs through all the valid voltages supported by the regulator
> and and when it finds the first in-range value programs the VOLTAGE register.
> For twl4030 the VOLTAGE register can be programmed with just the index
> of the table since the mapping was something like

> 1800mV = 0x0
> 2800mV = 0x1
> 2900mV = 0x2
> 3000mV = 0x3

> Now for twl6030 I just have added an additional vsel calulation part after
> the in-range value is found, since using the table index directly as vsel
> would not work.

Right, but this means that the code is looking at one table of values to
find a voltage it likes and then picking the actual selector from
another set of values.  This means that depending on the actual
differences it may either pick a value which isn't valid for the TWL6030
or omit values which the TWL6030 can actually support.  Either way from
a code inspection point of view the code doesn't look good due to the
mismatch between the two sets of selectors.

The TWL6030 case should be doing something more like other regulator
drivers with straightforward mappings between selector and voltage (most
of them) and not using the TWL4030 value table.
