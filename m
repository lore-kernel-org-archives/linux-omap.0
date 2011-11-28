From: Tero Kristo <t-kristo@ti.com>
Subject: Re: [PATCHv7 6/7] regulator: twl: add support for external
 controller
Date: Mon, 28 Nov 2011 17:43:41 +0200
Message-ID: <1322495021.4489.35.camel@sokoban>
References: <1322492005-27741-1-git-send-email-t-kristo@ti.com>
	 <1322492005-27741-7-git-send-email-t-kristo@ti.com>
	 <20111128145824.GB18958@opensource.wolfsonmicro.com>
Reply-To: <t-kristo@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:43166 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751467Ab1K1Pns (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 28 Nov 2011 10:43:48 -0500
In-Reply-To: <20111128145824.GB18958@opensource.wolfsonmicro.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: linux-omap@vger.kernel.org, sameo@linux.intel.com, lrg@ti.com, khilman@ti.com, b-cousson@ti.com, rnayak@ti.com, gg@slimlogic.co.uk

On Mon, 2011-11-28 at 14:58 +0000, Mark Brown wrote:
> On Mon, Nov 28, 2011 at 04:53:24PM +0200, Tero Kristo wrote:
> 
> > +++ b/drivers/regulator/twl-regulator.c
> > @@ -18,6 +18,7 @@
> >  #include <linux/regulator/machine.h>
> >  #include <linux/i2c/twl.h>
> >  
> > +#include <plat/voltage.h>
> 
> You shouldn't be including platform specific headers in generic code.

Hmm, should I pass the function pointers through platform data also?
Currently this does not seem to be too easy seeing we have a limited
number of parameters that can be passed from board and these are already
in use. regulator_init_data->driver_data is already used as a bitmask
passing feature flags around.

I could change driver_data to be a struct pointer and add the func
pointers + feature flags inside it. However it will end up changing more
code around.

> 
> > +	/* voltagedomain, only used for VP controlled smps regulators */
> > +	union {
> > +		const char		*name;
> > +		struct voltagedomain	*ptr;
> > +	} voltdm;
> > +
> 
> This looks pretty icky...  Why are you using a union of a pointer to a
> struct and a name?  How do things know which to use?

Name is only used during probe, after that we always use the ptr. If
name is not defined, ptr ends up as NULL and we use default mode.

I can change this and add func pointers for both get/set voltages and
also separate pointer for the voltagedomain itself, if I am going to
pass all of these via platform data.

> 
> > -	twlreg_write(info, TWL_MODULE_PM_RECEIVER, VREG_VOLTAGE_SMPS_4030,
> > -		vsel);
> > +	if (info->voltdm.ptr)
> > +		voltdm_scale(info->voltdm.ptr, min_uV);
> > +	else {
> 
> 
> Use braces on both branches.

Okay.

-Tero

