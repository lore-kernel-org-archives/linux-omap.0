From: Guenter Roeck <guenter.roeck@ericsson.com>
Subject: Re: [lm-sensors] [PATCH v3] hwmon: twl4030: Driver for twl4030
 madc module
Date: Thu, 6 Jan 2011 13:55:03 -0800
Message-ID: <1294350903.9786.103.camel@groeck-laptop>
References: <1294287457-2438-1-git-send-email-j-keerthy@ti.com>
	 <20110106053328.GA7489@ericsson.com> <20110106120713.GD17184@sirena.org.uk>
	 <20110106150430.GA9053@ericsson.com>
	 <20110106202142.GC8018@opensource.wolfsonmicro.com>
Reply-To: guenter.roeck@ericsson.com
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from imr4.ericy.com ([198.24.6.8]:45587 "EHLO imr4.ericy.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753788Ab1AFVzy (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 6 Jan 2011 16:55:54 -0500
In-Reply-To: <20110106202142.GC8018@opensource.wolfsonmicro.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: Keerthy <j-keerthy@ti.com>, "amit.kucheria@canonical.com" <amit.kucheria@canonical.com>, "sameo@linux.intel.com" <sameo@linux.intel.com>, "mikko.k.ylinen@nokia.com" <mikko.k.ylinen@nokia.com>, "lm-sensors@lm-sensors.org" <lm-sensors@lm-sensors.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "balajitk@ti.com" <balajitk@ti.com>

On Thu, 2011-01-06 at 15:21 -0500, Mark Brown wrote:
> On Thu, Jan 06, 2011 at 07:04:30AM -0800, Guenter Roeck wrote:
> > On Thu, Jan 06, 2011 at 07:07:13AM -0500, Mark Brown wrote:
> 
> > > Why?  It's not like hwmon has an unreasonably large core or similar.
> 
> > Because it creates an unnecessary dependency, and because it is not hwmon's 
> > responsibility to provide infrastructure for other subsystems or drivers.
> 
> hwmon isn't really doing anything, though.  The *driver* is doing
> something but it doesn't really impact the core that much.  Not that I'm
> particularly sold on putting the ADC core in here, but total NACK based
> on that alone seems rather harsh.

Possibly. However, I had suggested the following earlier (to the 1st
version of the patch):

> I commented on this a couple of times below - the driver mixes generic
> ADC reading functions with hwmon functionality. Generic ADC reading
> functionality should be moved into another driver, possibly to mfd.

Obviously that was ignored. Maybe someone is willing to listen this time
around.

I won't let people break modularity just for convenience in a subsystem
I am responsible for. And forcing the hwmon subsystem, and with it a
specific hwmon driver, to exist just because the adc functionality it
provides is needed by some other (most likely unrelated) subsystem /
driver _does_ break modularity. Worse, it is completely unnecessary to
do so. Other twl4030 functionality was extracted into generic code.
twl-core.c, twl4030-codec.c, twl4030-irq.c, twl4030-power.c are all in
mfd. I fail to see the problem with mfd/twl4030-adc.c.

Guenter


