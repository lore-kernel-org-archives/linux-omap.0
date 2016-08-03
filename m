From: Andreas Kemnade <andreas@kemnade.info>
Subject: Re: [PATCH] musb: omap2430: do not assume balanced
 enable()/disable()
Date: Wed, 3 Aug 2016 16:54:36 +0200
Message-ID: <20160803165436.007842fc@aktux>
References: <1469814151-2571-1-git-send-email-andreas@kemnade.info>
	<20160802103334.GC28140@atomide.com>
	<20160802170101.12bdad52@aktux>
	<20160803063015.GE28140@atomide.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/awDbYkDT5oy+3SIUrYVVwoJ"; protocol="application/pgp-signature"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20160803063015.GE28140@atomide.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Bin Liu <b-liu@ti.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-usb@vger.kernel.org, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, letux-kernel@openphoenux.org
List-Id: linux-omap@vger.kernel.org

--Sig_/awDbYkDT5oy+3SIUrYVVwoJ
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Tue, 2 Aug 2016 23:30:16 -0700
Tony Lindgren <tony@atomide.com> wrote:

> * Andreas Kemnade <andreas@kemnade.info> [160802 08:14]:
> > On Tue, 2 Aug 2016 03:33:34 -0700
> > Tony Lindgren <tony@atomide.com> wrote:
> >=20
> > > * Andreas Kemnade <andreas@kemnade.info> [160729 11:14]:
> > > > The code assumes that omap2430_musb_enable() and
> > > > omap2430_musb_disable() is called in a balanced way. The
> > > > That fact is broken by the fact that musb_init_controller()
> > > > calls musb_platform_disable() to switch from unknown state to
> > > > off state.
> > >=20
> > > OK, some spelling issues with the above paragraph though :)
> > >=20
> > > > That means that phy_power_off() is called first so that
> > > > phy->power_count gets -1 and the phy is not enabled on
> > > > phy_power_on(). In the probably common case of using the
> > > > phy_twl4030, that prevents also charging the battery and so
> > > > makes further kernel debugging hard.
> > >=20
> > > Is this with v4.7 kernel? Also, care to describe how you hit this
> > > and on which hardware? Just wondering..
> >=20
> > I got this error on the Openphoenux GTA04 phone. It has a DM3730
> > SoC and a TPS65950 companion. Severe charging problems were already
> > observed with the 4.4rc1. I do not know if that already was exactly
> > *this* problem. I have debugged and patched the v4.7 kernel.
>=20
> OK thanks for the info.
>=20
> > How I hit the problem: Just boot an that device and try to charge
> > via usb.
>=20
> OK so it's the twl4030 charger then I guess.
>=20
yes, besides from causing usb gadget problems, it has side effect
towards the twl4030 charger.

> > Should I resubmit the patch with an extended commit message?
>=20
> Well yeah it might be worth describing that it's the twl4030
> charger that otherwise does not work properly.
>=20
Ok, will resend a better commit message.

Regards,
Andreas Kemnade

--Sig_/awDbYkDT5oy+3SIUrYVVwoJ
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJXogWsAAoJEInxNTv1CwY0ZBQP/RKakSqmL15HeY2nTJzFK0F3
cNj7wvUYUGecb74YS6LX5zU4ctYEvVda2jvGRtp3E9TCqbxT8x5YULKpW2S18LGr
pTNqQphP+WfI0Nlz5bVdTxPrIwMOMFXnj2j2J/8a5rGPrTkswAAcJjp+svHVTCYr
/SaV/WuXltY/t8lHjAiFOadaxGSQ+0R0yeLXrGQfu7iQw93vXEvUmXzqTbxwT7+d
D0FHl17xVNBH/OjSeeOWlRg+7YYw3aQD/7zHw8ha3y00zXVEb/mooC8NRm78R+1N
BlGo6cPa3npcX/boG5iWVXYUWJT4NTxjjfx4a9ZQi5MbGJjud+h4KNTUIn8RcVHn
HRRwKVXCJXjNOtmNS4FdHOMIef49qZKencSM3pLjSwtlNo2ALigXx9jhmecruFY5
Oac64KrTN17E+xDr4lU63vi2HH2tSHuLZjmsvv7I/JIKJuZe/rDcOEka1JciAlxq
Z58gnKs/PiY7aMFM0JxZsV/C8daj8ySPEZVzGExEghncGIwRytSWgmf8TwtgHSUu
cHov/fQixfe/0RDNgOS7MhtBosdUQCCHOXXEzuO0jVgzKMzyEJjdxPrC2BY5CU9T
SpeWlL0YZwveC3s5VxI6EO32VGsxPgsmnBnnGE3DOxgUyYNr7xdjkuQxnN7EkscA
ks8AJ3aDAEdDAM/H6iIi
=+bWc
-----END PGP SIGNATURE-----

--Sig_/awDbYkDT5oy+3SIUrYVVwoJ--
