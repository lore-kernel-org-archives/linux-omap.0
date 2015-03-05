From: NeilBrown <neilb@suse.de>
Subject: Re: [PATCH 04/15] twl4030_charger: use runtime_pm to keep usb phy
 active while charging.
Date: Thu, 5 Mar 2015 16:48:18 +1100
Message-ID: <20150305164818.53d7c318@notabene.brown>
References: <20150224043341.4243.23291.stgit@notabene.brown>
	<20150224043350.4243.51289.stgit@notabene.brown>
	<20150225072443.GG21323@x1>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 boundary="Sig_/v5A2qcLM684RDC9/=wtMc=2"; protocol="application/pgp-signature"
Return-path: <linux-pm-owner@vger.kernel.org>
In-Reply-To: <20150225072443.GG21323@x1>
Sender: linux-pm-owner@vger.kernel.org
To: Lee Jones <lee.jones@linaro.org>
Cc: Samuel Ortiz <sameo@linux.intel.com>, Tony Lindgren <tony@atomide.com>, Sebastian Reichel <sre@kernel.org>, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, David Woodhouse <dwmw2@infradead.org>, GTA04 owners <gta04-owner@goldelico.com>, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

--Sig_/v5A2qcLM684RDC9/=wtMc=2
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Wed, 25 Feb 2015 07:24:43 +0000 Lee Jones <lee.jones@linaro.org> wrote:

> On Tue, 24 Feb 2015, NeilBrown wrote:
>=20
> > The twl4030 usb phy needs to be active while we are using
> > the USB VBUS as a current source for charging.
> > In particular, the usb3v1 regulator must be enabled and the
> > PHY_PWR_PHYPWD bit must be set to keep the phy powered.
> >=20
> > commit ab37813f4093a5f59cb8e083cde277289dc72ed3
> >     twl4030_charger: Allow charger to control the regulator that feeds =
it
> >=20
> > Gave the charger control over the regulator, but didn't resolve
> > the PHY_PWR_PHYPWD issue.
> >=20
> > Now that both of these are controlled by runtime_pm in
> > phy-twl4030-usb, we can simply take a runtime_pm reference to the USB
> > phy whenever the charger wants to use it as a current source.
> >=20
> > So this patch reverts the above commit, and adds the necessary
> > runtime_pm calls.
> >=20
> > Signed-off-by: NeilBrown <neilb@suse.de>
> > ---
> >  drivers/mfd/twl-core.c          |    9 ++++-----
>=20
> Acked-by: Lee Jones <lee.jones@linaro.org>

Thanks.
I guess that clear it to go in though the 'power supply' tree.

NeilBrown

--Sig_/v5A2qcLM684RDC9/=wtMc=2
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIVAwUBVPfuIjnsnt1WYoG5AQJngBAAiGFHO1Pl5+ZlXb7vwO9rymqTd8rKGp1O
SNiCzDn3flKIYADi1D1RFvNF87qOOLHOv/HNa6miQPqunt4nlbKyimF5pX1Z+U+h
dO/hhhZNF7a+RPoR64/1tOacH92x8vuueNUqjLmTCedfekGOqcS4WaDIMEK1Cz1X
sLiK2pIUpugx+0S3Dw+gNdGPdkro4+bbFPstEBcoNP7Grns4qOaQgwROwZa5A89z
mxIqe0nHFdGU5BPcDXUEp7WdVSy6Z4EAJmMKQ7LlzjSW0pvuN1rDItWJVkXnNdCt
98ENJPcGachh2/CMH1W9KdbcPSXz91N9IZSEPn+3XdnCmz5n3OdHiajvd42Hrd0D
V8zK+WcQBnQuWS5yBJVBbCeEOWZSiYl5vqq36sVrqXaiWWhXvvt8GDX6ASy4X5xn
S6PG7T3PcTk3E3NjDMMmzo2gv1TnaqCxwNgUDpYqT2xlNb2WIga0S+cRK9CJTciN
wl62wse4EPa7Gju+FghqlLzGcUF4UwtPXvGW24ECL8qyGgnnatjXaeQwa6+oG2Mc
/Zp5eACoTWLhYJsCkbSNWDy3jWErRNcd+MTOJLnl/tNRsR7jdWOp9RC/II4KNyWb
rjIn3KzWsEI++wVy3YtZinbP8Qt+d/kr5pAV3EPwmkPKCa8oHqgve5kk3p6yjWWz
0atkfBqyPBU=
=h4Or
-----END PGP SIGNATURE-----

--Sig_/v5A2qcLM684RDC9/=wtMc=2--
