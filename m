From: Tero Kristo <t-kristo@ti.com>
Subject: Re: [PATCH] regulator: twl6030: add support for vdd1, vdd2 and
 vdd3 regulators
Date: Fri, 24 Feb 2012 11:38:09 +0200
Message-ID: <1330076289.4102.517.camel@sokoban>
References: <1329995109-4795-1-git-send-email-t-kristo@ti.com>
	 <20120223153422.GF4553@opensource.wolfsonmicro.com>
Reply-To: <t-kristo@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:59390 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756164Ab2BXJiS (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 24 Feb 2012 04:38:18 -0500
In-Reply-To: <20120223153422.GF4553@opensource.wolfsonmicro.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Liam Girdwood <lrg@ti.com>, Samuel Ortiz <sameo@linux.intel.com>, Kevin Hilman <khilman@ti.com>

On Thu, 2012-02-23 at 15:34 +0000, Mark Brown wrote:
> On Thu, Feb 23, 2012 at 01:05:09PM +0200, Tero Kristo wrote:
> 
> > +static int twl6030coresmps_set_voltage(struct regulator_dev *rdev, int min_uV,
> > +	int max_uV, unsigned *selector)
> > +{
> > +	struct twlreg_info *info = rdev_get_drvdata(rdev);
> > +
> > +	if (info->set_voltage)
> > +		return info->set_voltage(info->data, min_uV);
> > +
> > +	return 0;
> > +}
> 
> This should be returning an error if it failed to set the voltage.

Yea, I can change the return to -ENODEV for this and get_voltage.

> Since you're using min_uV as the "register value" you probably ought to
> be returning that as the selector too and supplying a list_voltage()
> which just passes the selector back in case something tries to use it
> and gets confused.

I was thinking at some point about adding a list_voltage for these
regulators, however I dropped that idea, because the regulators can
support a range of voltages (from min to max) with some stepping value.
But... if you propose that the list_voltage would just return the
current voltage back, wouldn't that also potentially confuse the user
more, as it can only see the single voltage and nothing else, maybe
making it to think that the regulator can only support one voltage
level?

> 
> > +static int twl6030coresmps_get_voltage(struct regulator_dev *rdev)
> > +{
> > +	struct twlreg_info *info = rdev_get_drvdata(rdev);
> > +
> > +	if (info->get_voltage)
> > +		return info->get_voltage(info->data);
> > +
> > +	return 0;
> 
> Similarly here.

I'll change that also.

-Tero

