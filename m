From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH RESEND] usb: otg: OMAP4: Fix the omap4430_phy_set_clk
 function
Date: Mon, 2 Jul 2012 01:08:26 -0700
Message-ID: <20120702080825.GC1122@atomide.com>
References: <1339522581-8124-1-git-send-email-ruslan.bilovol@ti.com>
 <20120620133115.GL12766@atomide.com>
 <CAEa47NrLyKS-HDgruoSWAh-ZT_jtZs3Bd3C8xNtiqfOH3DejLQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-ewr.mailhop.org ([204.13.248.71]:52285 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752364Ab2GBII2 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 2 Jul 2012 04:08:28 -0400
Content-Disposition: inline
In-Reply-To: <CAEa47NrLyKS-HDgruoSWAh-ZT_jtZs3Bd3C8xNtiqfOH3DejLQ@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Ruslan Bilovol <ruslan.bilovol@ti.com>
Cc: linux-usb@vger.kernel.org, linux-omap@vger.kernel.org, balbi@ti.com

* Ruslan Bilovol <ruslan.bilovol@ti.com> [120629 14:55]:
> On Wed, Jun 20, 2012 at 4:31 PM, Tony Lindgren <tony@atomide.com> wro=
te:
> >
> > * Ruslan Bilovol <ruslan.bilovol@ti.com> [120612 10:42]:
> > > If the clocks are enabled and we want to enable them again
> > > omap4430_phy_set_clk disables them.
> > >
> > > Fix this - so now if we try to enable already enabled clocks
> > > it works correctly.
> >
> > Sounds like Felipe is on vacation. Trying to figure out if this
> > is something for the fixes branch:
> >
> > What happens if this not fixed, do you get some error?
>=20
> The function is designed for simple clocks on-off:
> if zero "on" parameter is passed - switch the clocks off,
> if non-zero "on" parameter passed - switch the clocks on.
>=20
> But due to error in implementation, it works wrong if called twice or=
 more
> times with non-zero "on" parameter.
>=20
> For example, assuming that clocks are disabled:
>     omap4430_phy_set_clk(dev, 1);   <=3D=3D=3D enables clocks
>     omap4430_phy_set_clk(dev, 1);   <=3D=3D=3D suddenly disables cloc=
ks,
> when we expect enabling.
>     omap4430_phy_set_clk(dev, 1);   <=3D=3D=3D enables clocks again
>=20
> It seems impact of this wrong behavior is not observed on current cod=
e
> base, but we see
> crashes caused by access to non-clocked registers when heavy use this=
 function
> in the charger detection or after implementing otg EYE improvement.

Yes thanks for explaining. Can you please update the commit message a b=
it
with the explanation above?
=20
> > Was this caused by some recent commit?
>=20
> No, we have this wrong behavior since the omap_phy_internal.c file
> creation (c33fad0c37)

OK. It's probably safest to wait for Felipe to take a look at this
patch then and queue it for v3.6 -rc cycle.

Regards,

Tony

> > > Signed-off-by: Ruslan Bilovol <ruslan.bilovol@ti.com>
> > > ---
> > > =C2=A0arch/arm/mach-omap2/omap_phy_internal.c | =C2=A0 =C2=A02 +-
> > > =C2=A01 files changed, 1 insertions(+), 1 deletions(-)
> > >
> > > diff --git a/arch/arm/mach-omap2/omap_phy_internal.c
> > > b/arch/arm/mach-omap2/omap_phy_internal.c
> > > index 4c90477..0196683 100644
> > > --- a/arch/arm/mach-omap2/omap_phy_internal.c
> > > +++ b/arch/arm/mach-omap2/omap_phy_internal.c
> > > @@ -97,7 +97,7 @@ int omap4430_phy_set_clk(struct device *dev, in=
t on)
> > > =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 clk_enable(clk48=
m);
> > > =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 clk_enable(clk32=
k);
> > > =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 state =3D 1;
> > > - =C2=A0 =C2=A0 } else if (state) {
> > > + =C2=A0 =C2=A0 } else if (!on && state) {
> > > =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 /* Disable the p=
hy clocks */
> > > =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 clk_disable(phyc=
lk);
> > > =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 clk_disable(clk4=
8m);
> > > --
> > > 1.7.1
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
