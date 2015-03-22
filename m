From: NeilBrown <neilb@suse.de>
Subject: Re: [PATCH 13/15] twl4030_charger: add ac/mode to match usb/mode
Date: Mon, 23 Mar 2015 10:13:19 +1100
Message-ID: <20150323101319.642c6638@notabene.brown>
References: <20150224043341.4243.23291.stgit@notabene.brown>
	<20150224043352.4243.8071.stgit@notabene.brown>
	<CANOLnOOJhz3JSevuz7T+XZDquEvJ-UiVM4KVHxxa4mSqb-yTpg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 boundary="Sig_/PyAArOqmcTvmjIePPcf_o9t"; protocol="application/pgp-signature"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:58454 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751907AbbCVXNP (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Sun, 22 Mar 2015 19:13:15 -0400
In-Reply-To: <CANOLnOOJhz3JSevuz7T+XZDquEvJ-UiVM4KVHxxa4mSqb-yTpg@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Grazvydas Ignotas <notasas@gmail.com>
Cc: Samuel Ortiz <sameo@linux.intel.com>, Tony Lindgren <tony@atomide.com>, Lee Jones <lee.jones@linaro.org>, Sebastian Reichel <sre@kernel.org>, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, David Woodhouse <dwmw2@infradead.org>, GTA04 owners <gta04-owner@goldelico.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, linux-pm@vger.kernel.org

--Sig_/PyAArOqmcTvmjIePPcf_o9t
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Fri, 6 Mar 2015 23:59:04 +0200 Grazvydas Ignotas <notasas@gmail.com> wro=
te:

> On Tue, Feb 24, 2015 at 6:33 AM, NeilBrown <neilb@suse.de> wrote:
> > This allows AC charging to be turned off, much like usb charging.
> >
> > "continuous" (aka "linear") mode maps to the CVENAC (constant voltage)
> > feature of the twl4030.
>=20
> Are you sure? Before your patches CVENAC was set at all times and and
> charger still worked in automatic mode.
>=20
> >
> > Signed-off-by: NeilBrown <neilb@suse.de>
> > ---
> >  drivers/power/twl4030_charger.c |   40 +++++++++++++++++++++++++++++--=
--------
> >  1 file changed, 30 insertions(+), 10 deletions(-)
> >
> > diff --git a/drivers/power/twl4030_charger.c b/drivers/power/twl4030_ch=
arger.c
> > index 6c53f0b601a4..e5a0225ea87e 100644
> > --- a/drivers/power/twl4030_charger.c
> > +++ b/drivers/power/twl4030_charger.c
> > @@ -112,7 +112,7 @@ struct twl4030_bci {
> >         int                     ichg_eoc, ichg_lo, ichg_hi;
> >         int                     usb_cur, ac_cur;
> >         bool                    ac_is_active;
> > -       int                     usb_mode; /* charging mode requested */
> > +       int                     usb_mode, ac_mode; /* charging mode req=
uested */
> >  #define        CHARGE_OFF      0
> >  #define        CHARGE_AUTO     1
> >  #define        CHARGE_LINEAR   2
> > @@ -449,12 +449,18 @@ static int twl4030_charger_enable_usb(struct twl4=
030_bci *bci, bool enable)
> >  /*
> >   * Enable/Disable AC Charge funtionality.
> >   */
> > -static int twl4030_charger_enable_ac(bool enable)
> > +static int twl4030_charger_enable_ac(struct twl4030_bci *bci, bool ena=
ble)
> >  {
> >         int ret;
> >
> > -       if (enable)
> > -               ret =3D twl4030_clear_set_boot_bci(0, TWL4030_BCIAUTOAC=
);
> > +       if (bci->ac_mode =3D=3D CHARGE_OFF)
> > +               enable =3D false;
> > +
> > +       if (enable && bci->ac_mode =3D=3D CHARGE_LINEAR)
> > +               ret =3D twl4030_clear_set_boot_bci(0, (TWL4030_CVENAC |
> > +                                                    TWL4030_BCIAUTOAC)=
);
> > +       else if (enable)
> > +               ret =3D twl4030_clear_set_boot_bci(TWL4030_CVENAC, TWL4=
030_BCIAUTOAC);
> >         else
> >                 ret =3D twl4030_clear_set_boot_bci(TWL4030_BCIAUTOAC, 0=
);
>=20
> CVENAC is required to be set for operation on AC without battery
> (which works fine on most pandora boards). After this patch, when
> booted without battery,  the board will reset before there is a chance
> to set the linear mode by userspace, because this is called on
> probe...
>=20

Yes, it looks like I misunderstood CVENAC a bit - thanks.

I've removed 'continuous' mode for AC and no longer clear or set that bit.

Thanks,
NeilBrown

--Sig_/PyAArOqmcTvmjIePPcf_o9t
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIVAwUBVQ9MkDnsnt1WYoG5AQIklA//YFoMBf1xlxWoHcb+Tun1Jxiz9zaJgGzR
6XvqH4ESTMYkOy14omPiyWQpsgnbWxWpezhhoWVXpaAThFuJyMO3SkiL1Ve7OJDy
aOsbLNUVKHdWsO0Hb5VHdxr7J+YoEokRbsYtAlu5KNhiiLGDDdHgGrIE6LZ5hSqH
Quou86ABDQ//FfB1g91JNefR+81p+paK9RfQTr3lxbRQ4Us2Mn5aNIsdbBogTuGH
B6q8WScIit4TUGS6cx+KzR8t6BiMger7LXI5uNm+01YA4QLrqcEOCRwBmJPReFOR
ce2ugIg5+POmi44WDNN1aTft1q2w5f0qKYU2BWs86ZdK8sxTVc0SGhirswO2haO2
jZyQR3+OanHE7KKDLl9NW73Lav7HbzeMV//vavRy2W+kAn/Zbdno5DdElzuhRaLo
vP1oN8Atsw7COuGoi2Le8Qm14OLHb0Z9iCbcUIarcIpxBcoPJ6/HHM4f6EWM44jo
hgD3GoM6xgj5vcFpW3QlaReaLSd/SwbXNXjws9g2AoJ6wvovoQAOzmJJ6ZoEWR5D
ZRx5PkHP7XlSET9K4XOIgvZ2PTHNezGP3WilXJ2WPtgSd5bXCwS5yPWSUOPpIjfz
5/OOo72Bz/Jl8lex/W86x6a5OmBFznJCA8CoOWsDHCsf7Umc6ocQN6e8/Mz68dBQ
clTdw0T3IHg=
=QP5i
-----END PGP SIGNATURE-----

--Sig_/PyAArOqmcTvmjIePPcf_o9t--
