From: Andreas Kemnade <andreas@kemnade.info>
Subject: Re: [PATCH] musb: omap2430: do not assume balanced
 enable()/disable()
Date: Tue, 2 Aug 2016 17:01:01 +0200
Message-ID: <20160802170101.12bdad52@aktux>
References: <1469814151-2571-1-git-send-email-andreas@kemnade.info>
	<20160802103334.GC28140@atomide.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/YZ5GJCEi7ubGxfcwk1ig.ot"; protocol="application/pgp-signature"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20160802103334.GC28140@atomide.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Bin Liu <b-liu@ti.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-usb@vger.kernel.org, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, letux-kernel@openphoenux.org
List-Id: linux-omap@vger.kernel.org

--Sig_/YZ5GJCEi7ubGxfcwk1ig.ot
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Tue, 2 Aug 2016 03:33:34 -0700
Tony Lindgren <tony@atomide.com> wrote:

> * Andreas Kemnade <andreas@kemnade.info> [160729 11:14]:
> > The code assumes that omap2430_musb_enable() and
> > omap2430_musb_disable() is called in a balanced way. The
> > That fact is broken by the fact that musb_init_controller() calls
> > musb_platform_disable() to switch from unknown state to off state.
>=20
> OK, some spelling issues with the above paragraph though :)
>=20
> > That means that phy_power_off() is called first so that
> > phy->power_count gets -1 and the phy is not enabled on
> > phy_power_on(). In the probably common case of using the
> > phy_twl4030, that prevents also charging the battery and so makes
> > further kernel debugging hard.
>=20
> Is this with v4.7 kernel? Also, care to describe how you hit this
> and on which hardware? Just wondering..

I got this error on the Openphoenux GTA04 phone. It has a DM3730
SoC and a TPS65950 companion. Severe charging problems were already
observed with the 4.4rc1. I do not know if that already was exactly
*this* problem. I have debugged and patched the v4.7 kernel.
How I hit the problem: Just boot an that device and try to charge
via usb.
Should I resubmit the patch with an extended commit message?

Regards,
Andreas Kemnade

--Sig_/YZ5GJCEi7ubGxfcwk1ig.ot
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJXoLWtAAoJEInxNTv1CwY0Ld4P/1bkvxdYtg+dtb0SclmcA1Do
ORpMymXYB7AVxbf5g6pj4JjwT4FMziLlfekfeS+scSm4i27Sr8qafnfulIGjY15h
B6uzcVmfPQCHmGs0JvOUoSNuO5Fer3OQ+2rM9reDPpONlbmjAUHxpv8m/sAeU3h7
7R3SiHfOqstQuT28lN8yu3akJLKy5AUzBXMOOu13GmGWX7y8PVlXg2HOglZA7aG0
QohUa3nKs794X0dbAUXB/76wu7ZnQ2D0krnxhmOgNQxED7GzfKUY/c456rajpLxv
sOEVWE1kGU1qTe1Cxh5ppGZLraVKsQdyU2gQx9nuQM/LOneNOE6h+3b6PVIs6z2p
wQJqELgHQAfqn8ZnoZyCoEgFMMWuzmH8BD7EEt1QrqqFwymGuX7S2whm85HBWEUr
XwCL2vJNJBXIwIVTLaji3n0snQR9T0k3NrKeNcEfKLCWa5BnYDeyFzbgo2c+mZTy
ZXivDhzuzv3lLvjyjPa3d6ZCiVHAVyw6dmfsWw3JiGizSiCu20sX9jyOctqLeUnY
tXxzYgdEJ1fLmsPK1LFoZHWWy7rgEzdSNofJhuMkqm6WaHJRpXe98LEqC6f/kApm
22ouVcT/+lXGf4fvOf7xmQlNLaPCidfTPhbEMXSAVfthSNSuzbdjTKXxtVEKlyh4
O/1kCkZYs6ruwVgJaMnq
=BJpx
-----END PGP SIGNATURE-----

--Sig_/YZ5GJCEi7ubGxfcwk1ig.ot--
