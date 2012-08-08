From: Matthias Kaehlcke <matthias@kaehlcke.net>
Subject: Re: [PATCH] backlight: Add TPS65217 WLED driver
Date: Wed, 8 Aug 2012 22:29:17 +0200
Message-ID: <20120808202917.GC30282@darwin>
References: <20120731194838.GJ4701@darwin>
 <331ABD5ECB02734CA317220B2BBEABC13EA0D18A@DBDE01.ent.ti.com>
 <20120807204305.GA30282@darwin>
 <331ABD5ECB02734CA317220B2BBEABC13EA0E4D1@DBDE01.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from relay3-d.mail.gandi.net ([217.70.183.195]:51995 "EHLO
	relay3-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759221Ab2HHUaJ (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 8 Aug 2012 16:30:09 -0400
Content-Disposition: inline
In-Reply-To: <331ABD5ECB02734CA317220B2BBEABC13EA0E4D1@DBDE01.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "AnilKumar, Chimata" <anilkumar@ti.com>
Cc: Richard Purdie <rpurdie@rpsys.net>, Samuel Ortiz <sameo@linux.intel.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

Hi AnilKumar,

El Wed, Aug 08, 2012 at 09:25:29AM +0000 AnilKumar, Chimata ha dit:

> Cross check with mfd/master also.

ok

> > > > +			if (!of_property_read_u32(np, "fdim", &val)) {
> > > > +				if (val == 100) {
> > > > +					pdata->bl_pdata->fdim = TPS65217_BL_FDIM_100HZ;
> > > > +				} else if (val == 200) {
> > > > +					pdata->bl_pdata->fdim = TPS65217_BL_FDIM_200HZ;
> > > > +				} else if (val == 500) {
> > > > +					pdata->bl_pdata->fdim = TPS65217_BL_FDIM_500HZ;
> > > > +				} else if (val == 1000) {
> > > > +					pdata->bl_pdata->fdim = TPS65217_BL_FDIM_1000HZ;
> > > > +				} else {
> > > > +					dev_err(&client->dev, "invalid value for backlight dimming frequency in the device tree\n");
> > > > +					return NULL;
> > > > +				}
> > > > +			} else {
> > > > +				pdata->bl_pdata->fdim = TPS65217_BL_FDIM_200HZ;
> > > > +			}
> > > > +		}
> > > > +	}
> > > 
> > > Same here.
> > 
> > not exactly, the value specified in the device tree for the dimming
> > frequency will be a frequency, not a value corresponding to the enum,
> > so a range check + assignment isn't enough. if you'd like to see a
> > similar handling an option would be to set TPS65217_BL_FDIM_100HZ to
> > 100, TPS..._200HZ to 200, ..., and do:
> > 
> > switch (val) {
> >   case TPS65217_BL_FDIM_100HZ:
> >   case TPS65217_BL_FDIM_200HZ:
> >   ...
> >     pdata->bl_pdata->fdim	= val;
> >     break;
> > 
> >   default:
> >     /* error handling */
> > }
> > 
> 
> This looks better.

taking a closer look i noticed that unfortunately it won't work that
way, as the constants TPS65217_BL_FDIM_*HZ are the values which are
written to the WLEDCTRL1 registers

so the outcome will be:

switch (val) {
  case 100:
    pdata->bl_pdata->fdim	= TPS65217_BL_FDIM_100HZ;
    break;

	case 200:

  ...

	default:
    /* error handling */
}

or the initial solution, which is slightly shorter, but i
think you prefer the switch construct

regards

-- 
Matthias Kaehlcke
Embedded Linux Developer
Amsterdam

   Programming is not just an act of telling a computer what to do:
  it is also an act of telling other programmers what you wished the
   computer to do. Both are important, and the latter deserves care
                          (Andrew Morton)
                                                                 .''`.
    using free software / Debian GNU/Linux | http://debian.org  : :'  :
                                                                `. `'`
gpg --keyserver pgp.mit.edu --recv-keys 47D8E5D4                  `-
