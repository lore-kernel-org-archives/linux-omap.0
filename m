From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH/RFC] ARM: OMAP: Initialize MADC clock divider and clock
Date: Wed, 3 Jun 2009 13:28:17 -0700
Message-ID: <20090603202817.GH5026@atomide.com>
References: <5e088bd90905300640sc9837b4x6055c5c262c18a8c@mail.gmail.com> <5e088bd90906031310v6324b157k97d8ba6c71ea5c6f@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-ewr.mailhop.org ([204.13.248.71]:49715 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752458AbZFCU2R (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 3 Jun 2009 16:28:17 -0400
Content-Disposition: inline
In-Reply-To: <5e088bd90906031310v6324b157k97d8ba6c71ea5c6f@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Steve Sakoman <sakoman@gmail.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

* Steve Sakoman <sakoman@gmail.com> [090603 13:10]:
> Tony,
>=20
> I noticed your comment requesting all twl4030 patches be submitted to
> mainline.  I assume this patch falls into that category too?

Yeah, we should try to make all the patches against mainline now.
=20
> Also for those listening in -- no comments on this patch yet!  Does
> that mean it looks good?   ;-)

You should send it to:

$ grep -a7 "MULTIFUNCTION DEVICES" MAINTAINERS
P:      Samuel Ortiz
M:      sameo@linux.intel.com
L:      linux-kernel@vger.kernel.org
T:      git git://git.kernel.org/pub/scm/linux/kernel/git/sameo/mfd-2.6=
=2Egit
S:      Supported
=46:      drivers/mfd/

Tony
=20
> Steve
>=20
> On Sat, May 30, 2009 at 6:40 AM, Steve Sakoman <sakoman@gmail.com> wr=
ote:
> > Though the comment in clocks_init claims to initialize the MADC
> > clocks, it wasn't actually being done. =A0This patch implements min=
imal
> > MADC clock initialization.
> >
> > Compile/run tested on Overo (prior to patch MADC access would alway=
s timeout)
> >
> > diff --git a/drivers/mfd/twl4030-core.c b/drivers/mfd/twl4030-core.=
c
> > index 769b34b..c5ca36d 100644
> > --- a/drivers/mfd/twl4030-core.c
> > +++ b/drivers/mfd/twl4030-core.c
> > @@ -159,6 +159,7 @@
> >
> > =A0/* Few power values */
> > =A0#define R_CFG_BOOT =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 0x05
> > +#define R_GPBR1 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A00x0C
> > =A0#define R_PROTECT_KEY =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A00x0E
> >
> > =A0/* access control values for R_PROTECT_KEY */
> > @@ -166,6 +167,10 @@
> > =A0#define KEY_UNLOCK2 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A00xec
> > =A0#define KEY_LOCK =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 0x0=
0
> >
> > +/* MADC clock values for R_GPBR1 */
> > +#define MADC_HFCLK_EN =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A00x80
> > +#define DEFAULT_MADC_CLK_EN =A0 =A0 =A0 =A0 =A0 =A00x10
> > +
> > =A0/* some fields in R_CFG_BOOT */
> > =A0#define HFCLK_FREQ_19p2_MHZ =A0 =A0 =A0 =A0 =A0 =A0(1 << 0)
> > =A0#define HFCLK_FREQ_26_MHZ =A0 =A0 =A0 =A0 =A0 =A0 =A0(2 << 0)
> > @@ -717,6 +722,11 @@ static void __init clocks_init(struct device *=
dev)
> > =A0 =A0 =A0 =A0ctrl |=3D HIGH_PERF_SQ;
> > =A0 =A0 =A0 =A0e |=3D unprotect_pm_master();
> > =A0 =A0 =A0 =A0/* effect->MADC+USB ck en */
> > +
> > + =A0 =A0 =A0 if (twl_has_madc())
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 e |=3D twl4030_i2c_write_u8(TWL4030_M=
ODULE_INTBR,
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 MADC_=
HFCLK_EN | DEFAULT_MADC_CLK_EN, R_GPBR1);
> > +
> > =A0 =A0 =A0 =A0e |=3D twl4030_i2c_write_u8(TWL4030_MODULE_PM_MASTER=
, ctrl, R_CFG_BOOT);
> > =A0 =A0 =A0 =A0e |=3D protect_pm_master();
> >
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
