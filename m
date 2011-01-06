From: Guenter Roeck <guenter.roeck@ericsson.com>
Subject: Re: [lm-sensors] [PATCH v3] hwmon: twl4030: Driver for twl4030
	madc module
Date: Thu, 6 Jan 2011 07:04:30 -0800
Message-ID: <20110106150430.GA9053@ericsson.com>
References: <1294287457-2438-1-git-send-email-j-keerthy@ti.com>
 <20110106053328.GA7489@ericsson.com>
 <20110106120713.GD17184@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from imr3.ericy.com ([198.24.6.13]:48245 "EHLO imr3.ericy.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752841Ab1AFPFO (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 6 Jan 2011 10:05:14 -0500
Content-Disposition: inline
In-Reply-To: <20110106120713.GD17184@sirena.org.uk>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: Keerthy <j-keerthy@ti.com>, "amit.kucheria@canonical.com" <amit.kucheria@canonical.com>, "sameo@linux.intel.com" <sameo@linux.intel.com>, "mikko.k.ylinen@nokia.com" <mikko.k.ylinen@nokia.com>, "lm-sensors@lm-sensors.org" <lm-sensors@lm-sensors.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "balajitk@ti.com" <balajitk@ti.com>

On Thu, Jan 06, 2011 at 07:07:13AM -0500, Mark Brown wrote:
> On Wed, Jan 05, 2011 at 09:33:28PM -0800, Guenter Roeck wrote:
> 
> > [...]
> > > +EXPORT_SYMBOL_GPL(twl4030_madc_conversion);
> > [...]
> > > +EXPORT_SYMBOL_GPL(twl4030_get_madc_conversion);
> 
> > No symbol export from hwmon drivers. Other parts of the kernel
> > should not depend on HWMON configuration.
> 
> Why?  It's not like hwmon has an unreasonably large core or similar.
> 
Because it creates an unnecessary dependency, and because it is not hwmon's 
responsibility to provide infrastructure for other subsystems or drivers.

> > I would suggest to check if drivers/staging/iio would be a better fit.
> 
> That does have the problem that it's in staging and constantly churning,
> though.  When I've looked at it it seemed like awfully hard work to use
> for devices like this.
> 
> What I've done in some of my drivers is put the ADC core in the MFD core
> (it's used by both hwmon and power supply function drivers, plus any
> board specific stuff people do).

Fine as well. I think I had suggested that earlier already.

Guenter

