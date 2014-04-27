From: Pavel Machek <pavel-+ZI9xUNit7I@public.gmane.org>
Subject: Re: [PATCHv3 07/14] HSI: Add common DT binding for HSI client
 devices
Date: Sun, 27 Apr 2014 12:57:55 +0200
Message-ID: <20140427105755.GA12265@amd.pavel.ucw.cz>
References: <1396053110-21639-1-git-send-email-sre@kernel.org>
 <1396053110-21639-8-git-send-email-sre@kernel.org>
 <20140419191612.GG5148@amd.pavel.ucw.cz>
 <20140425182535.GB22721@earth.universe>
 <20140425205926.GA30032@earth.universe>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20140425205926.GA30032-SfvFxonMDyemK9LvCR3Hrw@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Sebastian Reichel <sre-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Cc: Linus Walleij <linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Shubhrajyoti Datta <omaplinuxkernel-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Carlos Chinea <cch.devel-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Kumar Gala <galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Pali =?iso-8859-1?Q?Roh=E1r?= <pali.rohar-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, =?utf-8?B?0JjQstCw0LnQu9C+INCU0LjQvNC40YLRgNC+0LI=?= <freemangordon-uiMcrn6V0Vs@public.gmane.org>, Joni Lapilainen <joni.lapilainen-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Aaro Koskinen <aaro.koskinen-X3B1VOXEql0@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

On Fri 2014-04-25 22:59:27, Sebastian Reichel wrote:
> On Fri, Apr 25, 2014 at 08:25:36PM +0200, Sebastian Reichel wrote:
> > On Sat, Apr 19, 2014 at 09:16:12PM +0200, Pavel Machek wrote:
> > > On Sat 2014-03-29 01:31:43, Sebastian Reichel wrote:
> > > > Implement and document generic DT bindings for HSI clients.
> > > > 
> > > > Signed-off-by: Sebastian Reichel <sre-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
> > > 
> > > Reviewed-by: Pavel Machek <pavel-+ZI9xUNit7I@public.gmane.org>
> > > 
> > > > diff --git a/drivers/hsi/hsi.c b/drivers/hsi/hsi.c
> > > > index 07e1639..5973906 100644
> > > > --- a/drivers/hsi/hsi.c
> > > > +++ b/drivers/hsi/hsi.c
> > > > @@ -26,8 +26,14 @@
> > > >  #include <linux/slab.h>
> > > >  #include <linux/string.h>
> > > >  #include <linux/notifier.h>
> > > > +#include <linux/of.h>
> > > > +#include <linux/of_device.h>
> > > >  #include "hsi_core.h"
> > > 
> > > 
> > > > +	err = hsi_of_property_parse_mode(client, "hsi-mode", &mode);
> > > > +	if (err) {
> > > > +		err = hsi_of_property_parse_mode(client, "hsi-rx-mode",
> > > > +						 &cl->rx_cfg.mode);
> > > > +		if (err)
> > > > +			goto err;
> > > > +
> > > > +		err = hsi_of_property_parse_mode(client, "hsi-tx-mode",
> > > > +						 &cl->tx_cfg.mode);
> > > > +		if (err)
> > > > +			goto err;
> > > 
> > > Will this need some #ifdef CONFIG_OF?
> > 
> > It would only be needed to reduce the amount of kernel code for
> > disabled Device Tree. I don't think its worth it, since there is no
> > platform in the mainline kernel, which uses HSI without DT.
> 
> mh actually it is needed, since there is no stub provided for
> of_modalias_node in non DT mode (there are stubs for all other
> of_* methods used). I will include the ifdef in PATCHv5.

Alternatively, you can make driver depend on DT...

Thanks,
									Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
