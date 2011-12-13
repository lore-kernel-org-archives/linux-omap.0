From: Tero Kristo <t-kristo@ti.com>
Subject: Re: [PATCHv7 5/7] mfd: twl-core: pass driver data from pdata to
 add_regulator for VDD1 and VDD2
Date: Tue, 13 Dec 2011 09:19:33 +0200
Message-ID: <1323760773.15292.12.camel@sokoban>
References: <1322492005-27741-1-git-send-email-t-kristo@ti.com>
	 <1322492005-27741-6-git-send-email-t-kristo@ti.com>
	 <20111212180423.GX13952@sortiz-mobl>
Reply-To: <t-kristo@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:58106 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751909Ab1LMHTm (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 13 Dec 2011 02:19:42 -0500
In-Reply-To: <20111212180423.GX13952@sortiz-mobl>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Samuel Ortiz <sameo@linux.intel.com>
Cc: linux-omap@vger.kernel.org, broonie@opensource.wolfsonmicro.com, lrg@ti.com, khilman@ti.com, b-cousson@ti.com, rnayak@ti.com, gg@slimlogic.co.uk

On Mon, 2011-12-12 at 19:04 +0100, Samuel Ortiz wrote:
> Hi Tero,
> 
> 
> On Mon, Nov 28, 2011 at 04:53:23PM +0200, Tero Kristo wrote:
> > This way, we can add custom flags for VDD1 and VDD2 regulators that
> > get passed all the way to regulator init. This is needed for SMPS
> > regulator support to select used controller mode for these regulators
> > (either voltage processor or default.)
> > 
> > Signed-off-by: Tero Kristo <t-kristo@ti.com>
> > Cc: Samuel Ortiz <sameo@linux.intel.com>
> > ---
> >  drivers/mfd/twl-core.c |    6 ++++--
> >  1 files changed, 4 insertions(+), 2 deletions(-)
> > 
> > diff --git a/drivers/mfd/twl-core.c b/drivers/mfd/twl-core.c
> > index 01ecfee..af93fce 100644
> > --- a/drivers/mfd/twl-core.c
> > +++ b/drivers/mfd/twl-core.c
> > @@ -846,12 +846,14 @@ add_children(struct twl4030_platform_data *pdata, unsigned long features)
> >  			return PTR_ERR(child);
> >  
> >  		child = add_regulator(TWL4030_REG_VDD1, pdata->vdd1,
> > -					features);
> > +					features |
> > +					(u32)pdata->vdd1->driver_data);
> That looks hackish to me. Do you have any guarantee that your driver_data and
> your features bitmaps have zero intersections ?

That is somewhat hackish yes. I changed the implementation a bit for v8
(which you should also have in your inbox now, I sent it out on Friday),
I split the driver_data to a struct that contains a couple of function
pointers and the features flag. It is still using a bitwise OR for
setting the flags inside twl-core.c, but the entity that initializes the
driver_data sets the features always at zero, so twl-core is the only
one who sets these. That version of the patch could be changed from
twl-core point of view to just set the features field instead of OR.

v8 of the patch set actually merges the regulator driver and the
twl-core data passing parts together to avoid merge conflicts, so you
should take a look at the twl-core.c / include/linux/i2c/twl.h part of
patch:

[PATCHv8 4/5] twl4030: add support for external voltage get/set

-Tero


