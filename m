From: "Avinash.H.M." <avinashhm@ti.com>
Subject: Re: [PATCH v4] OMAP2/3: hwmod: fix the i2c-reset timeout during
 bootup
Date: Tue, 31 May 2011 00:56:45 +0530
Message-ID: <20110530192645.GB4959@avinash-laptop>
References: <1305906384-22061-1-git-send-email-avinashhm@ti.com>
 <1306737490.2117.24.camel@deskari>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog107.obsmtp.com ([74.125.149.197]:37693 "EHLO
	na3sys009aog107.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750783Ab1E3T05 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Mon, 30 May 2011 15:26:57 -0400
Received: by mail-px0-f169.google.com with SMTP id 9so2379373pxi.0
        for <linux-omap@vger.kernel.org>; Mon, 30 May 2011 12:26:56 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1306737490.2117.24.camel@deskari>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Rajendra Nayak <rnayak@ti.com>, Paul Walmsley <paul@pwsan.com>, Benoit Cousson <b-cousson@ti.com>, Kevin Hilman <khilman@ti.com>

On Mon, May 30, 2011 at 09:38:10AM +0300, Tomi Valkeinen wrote:
> On Fri, 2011-05-20 at 21:16 +0530, Avinash.H.M wrote:
> > The sequence of _ocp_softreset doesn't work for i2c. The i2c module has a
> > special sequence to reset the module. The sequence is
> >  - Disable the I2C.
> >  - Write to SOFTRESET bit.
> >  - Enable the I2C.
> >  - Poll on the RESETDONE bit.
> > The sequence is implemented as a function and the i2c_class is updated with
> > the correct 'reset' pointer.  omap_hwmod_softreset function is implemented
> > which triggers the softreset by writing into sysconfig register. On following
> > this sequence, i2c module resets properly and timeouts are not seen.
> > 
> > Cc: Rajendra Nayak <rnayak@ti.com>
> > Cc: Paul Walmsley <paul@pwsan.com>
> > Cc: Benoit Cousson <b-cousson@ti.com>
> > Cc: Kevin Hilman <khilman@ti.com>
> > Signed-off-by: Avinash.H.M <avinashhm@ti.com>
> > ---
> 
> <snip>
> 
> > diff --git a/arch/arm/plat-omap/include/plat/i2c.h b/arch/arm/plat-omap/include/plat/i2c.h
> > index 878d632..3ffb94e 100644
> > --- a/arch/arm/plat-omap/include/plat/i2c.h
> > +++ b/arch/arm/plat-omap/include/plat/i2c.h
> > @@ -23,6 +23,8 @@
> >  
> >  #include <linux/i2c.h>
> >  
> > +#include <plat/omap_hwmod.h>
> > +
> >  #if defined(CONFIG_I2C_OMAP) || defined(CONFIG_I2C_OMAP_MODULE)
> >  extern int omap_register_i2c_bus(int bus_id, u32 clkrate,
> >  				 struct i2c_board_info const *info,
> > @@ -52,4 +54,6 @@ struct omap_i2c_dev_attr {
> >  void __init omap1_i2c_mux_pins(int bus_id);
> >  void __init omap2_i2c_mux_pins(int bus_id);
> >  
> > +int omap_i2c_reset(struct omap_hwmod *oh);
> > +
> 
> It's not necessary to include omap_hwmod.h, just declare
> 
> struct omap_hwmod;

Hi Tomi ,

I agree to the comment, since it is a header file (i2c.h), no need to
include hwmod.h.  

I ll drop the file inclusion.  Thanks for reviewing.

B R ,

- Avinash


> 
>  Tomi
> 
> 
