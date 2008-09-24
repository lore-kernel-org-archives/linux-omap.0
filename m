From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 1/3] ARM: OMAP: Allocate McBSP devices dynamically, add
	34xx support
Date: Wed, 24 Sep 2008 15:10:01 +0300
Message-ID: <20080924121001.GP5222@atomide.com>
References: <1222249943-19435-1-git-send-email-tony@atomide.com> <1222249943-19435-2-git-send-email-tony@atomide.com> <20080924115838.GB18700@strlen.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-bos.mailhop.org ([63.208.196.178]:58557 "EHLO
	mho-01-bos.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751239AbYIXMK1 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 24 Sep 2008 08:10:27 -0400
Content-Disposition: inline
In-Reply-To: <20080924115838.GB18700@strlen.de>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <ukleinek@strlen.de>
Cc: linux-arm-kernel@lists.arm.linux.org.uk, linux-omap@vger.kernel.org, Chandra Shekhar <x0044955@ti.com>

* Uwe Kleine-K=F6nig <ukleinek@strlen.de> [080924 14:58]:
> Hello,
>=20
> I wonder if this patch should be further split.
>=20
> To my taste this should be at least:
>=20
>  - Allocate McBSP devices dynamically,
>  - add 34xx support

Sure, I think it's a bit hard to read too. Will repost split.

> maybe more, see below.
>=20
> > diff --git a/arch/arm/mach-omap1/mcbsp.c b/arch/arm/mach-omap1/mcbs=
p.c
> > index afb5789..7de7c69 100644
> > --- a/arch/arm/mach-omap1/mcbsp.c
> > +++ b/arch/arm/mach-omap1/mcbsp.c
> > @@ -103,30 +103,6 @@ static inline void omap_mcbsp_clk_init(struct =
mcbsp_internal_clk *mclk)
> >  { }
> >  #endif
> > =20
> > -static int omap1_mcbsp_check(unsigned int id)
> > -{
> > -	/* REVISIT: Check correctly for number of registered McBSPs */
> > -	if (cpu_is_omap730()) {
> > -		if (id > OMAP_MAX_MCBSP_COUNT - 2) {
> > -		       printk(KERN_ERR "OMAP-McBSP: McBSP%d doesn't exist\n",
> > -				id + 1);
> > -		       return -ENODEV;
> > -		}
> > -		return 0;
> > -	}
> > -
> > -	if (cpu_is_omap15xx() || cpu_is_omap16xx()) {
> > -		if (id > OMAP_MAX_MCBSP_COUNT - 1) {
> > -			printk(KERN_ERR "OMAP-McBSP: McBSP%d doesn't exist\n",
> > -				id + 1);
> > -			return -ENODEV;
> > -		}
> > -		return 0;
> > -	}
> > -
> > -	return -ENODEV;
> > -}
> > -
> >  static void omap1_mcbsp_request(unsigned int id)
> >  {
> >  	/*
> > @@ -151,7 +127,6 @@ static void omap1_mcbsp_free(unsigned int id)
> >  }
> > =20
> >  static struct omap_mcbsp_ops omap1_mcbsp_ops =3D {
> > -	.check		=3D omap1_mcbsp_check,
> Why can this function go away?  IMHO it should either go away in a
> separate commit or be extended to be more general to apply for the 34=
xx
> case, too.  (Same for omap2_mcbsp_check.)

It also removes omap2_mcbsp_check. There's now:
#define omap_mcbsp_check_valid_id() (id < omap_mcbsp_count)

> > @@ -185,7 +226,7 @@ static struct omap_mcbsp_platform_data omap34xx=
_mcbsp_pdata[] =3D {
> >  #define OMAP34XX_MCBSP_PDATA_SZ		0
> >  #endif
> > =20
> > -int __init omap2_mcbsp_init(void)
> > +static int __init omap2_mcbsp_init(void)
> >  {
> >  	int i;
> > =20
> OK, this is trivial, but if you ask me, at least note it in the commi=
t
> message.

Will add.

> > @@ -196,9 +237,18 @@ int __init omap2_mcbsp_init(void)
> >  	}
> > =20
> >  	if (cpu_is_omap24xx())
> > +		omap_mcbsp_count =3D OMAP24XX_MCBSP_PDATA_SZ;
> > +	if (cpu_is_omap34xx())
> > +		omap_mcbsp_count =3D OMAP34XX_MCBSP_PDATA_SZ;
> > +
> > +	mcbsp_ptr =3D kzalloc(omap_mcbsp_count * sizeof(struct omap_mcbsp=
 *),
> > +								GFP_KERNEL);
> > +	if (!mcbsp_ptr)
> > +		return -ENOMEM;
> > +
> > +	if (cpu_is_omap24xx())
> >  		omap_mcbsp_register_board_cfg(omap24xx_mcbsp_pdata,
> >  						OMAP24XX_MCBSP_PDATA_SZ);
> > -
> >  	if (cpu_is_omap34xx())
> >  		omap_mcbsp_register_board_cfg(omap34xx_mcbsp_pdata,
> >  						OMAP34XX_MCBSP_PDATA_SZ);
> Hhm, it looks there is already some 34xx support in the file.  Should
> the commit log be more detailed?

Will split into a separate patch.

> (Note, I didn't check the rest of the patch.)

Thanks for looking!

Tony
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
