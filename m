From: Tero Kristo <t-kristo@ti.com>
Subject: Re: [PATCH] regulator: twl6030: add support for vdd1, vdd2 and
 vdd3 regulators
Date: Fri, 24 Feb 2012 15:16:38 +0200
Message-ID: <1330089398.4102.539.camel@sokoban>
References: <1329995109-4795-1-git-send-email-t-kristo@ti.com>
	 <20120223153422.GF4553@opensource.wolfsonmicro.com>
	 <1330076289.4102.517.camel@sokoban>
	 <20120224114940.GB5450@opensource.wolfsonmicro.com>
Reply-To: <t-kristo@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:55914 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754616Ab2BXNQq (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 24 Feb 2012 08:16:46 -0500
In-Reply-To: <20120224114940.GB5450@opensource.wolfsonmicro.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Liam Girdwood <lrg@ti.com>, Samuel Ortiz <sameo@linux.intel.com>, Kevin Hilman <khilman@ti.com>

On Fri, 2012-02-24 at 11:49 +0000, Mark Brown wrote:
> On Fri, Feb 24, 2012 at 11:38:09AM +0200, Tero Kristo wrote:
> > On Thu, 2012-02-23 at 15:34 +0000, Mark Brown wrote:
> 
> > > Since you're using min_uV as the "register value" you probably ought to
> > > be returning that as the selector too and supplying a list_voltage()
> > > which just passes the selector back in case something tries to use it
> > > and gets confused.
> 
> > I was thinking at some point about adding a list_voltage for these
> > regulators, however I dropped that idea, because the regulators can
> > support a range of voltages (from min to max) with some stepping value.
> > But... if you propose that the list_voltage would just return the
> > current voltage back, wouldn't that also potentially confuse the user
> > more, as it can only see the single voltage and nothing else, maybe
> > making it to think that the regulator can only support one voltage
> > level?
> 
> Yes, that'd be completely broken.  You'd need to just return the
> selector back which would tell them that they had voltage control in
> microvolt steps.

I still ain't quite sure how this would work, do you mean adding
something like this:

+static int twl6030smps_list_voltage(struct regulator_dev *rdev,
+                                   unsigned int selector)
+{
+       return selector;
+}

I believe this would fail still. I took a look at a few drivers that use
regulator_list_voltage(), but all of these seem to numerate voltages
based on regulator_count_voltages(), which will return -EINVAL for the
SMPS ones as the num_voltages is zero. Also, even if I defined
num_voltages here, I would be attempting to list_voltage for zero index,
returning zero, but this would be invalid voltage for the cpu obviously
(and is also out of range for the regulator min_voltage, and also
according to docs invalid return value for the function in the first
place.)

-Tero

