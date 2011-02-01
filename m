From: Rajendra Nayak <rnayak@ti.com>
Subject: RE: [PATCH] OMAP: hwmod: Do not expect an entry in clkdev to add
 alias for opt_clks
Date: Tue, 1 Feb 2011 10:53:19 +0530
Message-ID: <997a6c2b061aee29cd2d0c755d4ad80c@mail.gmail.com>
References: <1296213475-23460-1-git-send-email-rnayak@ti.com> <alpine.DEB.2.00.1101311606030.16671@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog113.obsmtp.com ([74.125.149.209]:47657 "EHLO
	na3sys009aog113.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750936Ab1BAFXY (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 1 Feb 2011 00:23:24 -0500
Received: by mail-fx0-f48.google.com with SMTP id 2so7227606fxm.7
        for <linux-omap@vger.kernel.org>; Mon, 31 Jan 2011 21:23:21 -0800 (PST)
In-Reply-To: <alpine.DEB.2.00.1101311606030.16671@utopia.booyaka.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>
Cc: linux-omap@vger.kernel.org

Hi Paul,

> -----Original Message-----
> From: Paul Walmsley [mailto:paul@pwsan.com]
> Sent: Tuesday, February 01, 2011 4:39 AM
> To: Rajendra Nayak
> Cc: linux-omap@vger.kernel.org
> Subject: Re: [PATCH] OMAP: hwmod: Do not expect an entry in clkdev to
add alias for opt_clks
>
> Hi Rajendra
>
> one brief comment below.  Also, when you post an updated version, could
> you cc the linux-arm-kernel mailing list?  That way I won't have to do
> it...

Sure, I will. Sorry I missed it again. Will make sure I have
linux-arm-kernel
Cc'ed for all my patches hence forth.
Have a few comments below.

>
> On Fri, 28 Jan 2011, Rajendra Nayak wrote:
>
> > The _add_optional_clock_alias function expects an entry
> > already existing in the clkdev table in the form of
> > <dev-id=NULL, con-id=role> which might not be the case
> > always.
> >
> > Instead, just check if an entry already exists in clkdev
> > in the <dev-id=dev_name, con-id=role> form, else go ahead
> > and add one.
> >
> > Remove any assumption of an entry already existing in clkdev
> > table in any form.
> >
> > Signed-off-by: Rajendra Nayak <rnayak@ti.com>
> > Reported-by: Sumit Semwal <sumit.semwal@ti.com>
> > ---
> >  arch/arm/plat-omap/omap_device.c |   25 +++++++++++++++++++------
> >  1 files changed, 19 insertions(+), 6 deletions(-)
> >
> > diff --git a/arch/arm/plat-omap/omap_device.c
b/arch/arm/plat-omap/omap_device.c
> > index 57adb27..80d4f35 100644
> > --- a/arch/arm/plat-omap/omap_device.c
> > +++ b/arch/arm/plat-omap/omap_device.c
> > @@ -83,9 +83,11 @@
> >  #include <linux/err.h>
> >  #include <linux/io.h>
> >  #include <linux/clk.h>
> > +#include <linux/clkdev.h>
> >
> >  #include <plat/omap_device.h>
> >  #include <plat/omap_hwmod.h>
> > +#include <plat/clock.h>
> >
> >  /* These parameters are passed to _omap_device_{de,}activate() */
> >  #define USE_WAKEUP_LAT			0
> > @@ -244,7 +246,7 @@ static inline struct omap_device
*_find_by_pdev(struct platform_device *pdev)
> >   *
> >   * For every optional clock present per hwmod per omap_device, this
function
> >   * adds an entry in the clocks list of the form <dev-id=dev_name,
con-id=role>
> > - * if an entry is already present in it with the form <dev-id=NULL,
con-id=role>
> > + * if it does not exist already.
> >   *
> >   * The function is called from inside omap_device_build_ss(), after
> >   * omap_device_register.
> > @@ -258,21 +260,32 @@ static void _add_optional_clock_alias(struct
omap_device *od,
> >  				      struct omap_hwmod *oh)
> >  {
> >  	int i;
> > +	struct clk_lookup *l;
> > +	struct omap_hwmod_opt_clk *oc;

This was a stray change. Will fix in the updated version.

> >
> >  	for (i = 0; i < oh->opt_clks_cnt; i++) {
> > -		struct omap_hwmod_opt_clk *oc;
> > -		int r;
> > +		struct clk *r;
> >
> >  		oc = &oh->opt_clks[i];
> >
> >  		if (!oc->_clk)
> >  			continue;
> >
> > -		r = clk_add_alias(oc->role, dev_name(&od->pdev.dev),
> > -				  (char *)oc->clk, &od->pdev.dev);
> > -		if (r)
> > +		r = clk_get_sys(dev_name(&od->pdev.dev), oc->role);
> > +		if (!IS_ERR(r))
> > +			continue; /* clkdev entry exists */
> > +
> > +		r = omap_clk_get_by_name((char *)oc->clk);
> > +		if (IS_ERR(r)) {
> >  			pr_err("omap_device: %s: clk_add_alias for %s
failed\n",
> >  			       dev_name(&od->pdev.dev), oc->role);
> > +			continue;
> > +		}
> > +
> > +		l = clkdev_alloc(r, oc->role, dev_name(&od->pdev.dev));
> > +		if (!l)
> > +			return;
>
> Please add a pr_err() in this case, similar to the above one; that way
> in the unlikely event that this fails, there will be some sign of what
is
> happening...  other than that, it looks good to me

Ok, will add the pr_err().
One other thing I was thinking of is if the function name
_add_optional_clock_alias need to be changed to something like
_add_optional_clock_clkdev since we are adding a new clkdev entry,
if it does not exist, and no longer adding an 'alias' for an existing
entry.

Also, the adding of an entry in clkdev is today done for
optional clocks alone. Is there any reason why we should not do
this at runtime for all main clks and interface clks also.
That way we get rid of all dependencies with the static clkdev
table, and we might infact not need one if all entries are added
runtime.

Regards,
Rajendra

>
>
> > +		clkdev_add(l);
> >  	}
> >  }
> >
> > --
> > 1.7.0.4
> >
> > --
> > To unsubscribe from this list: send the line "unsubscribe linux-omap"
in
> > the body of a message to majordomo@vger.kernel.org
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
> >
>
>
> - Paul
