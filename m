From: Felipe Balbi <balbi@ti.com>
Subject: Re: [PATCH] usb: musb: Fix unstable init of OTG_INTERFSEL.
Date: Mon, 25 Nov 2013 11:56:53 -0600
Message-ID: <20131125175642.GQ18046@saruman.home>
References: <1385113069-23008-1-git-send-email-anaumann@ultratronik.de>
Reply-To: <balbi@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="JWOY2/vB4uO4FuME"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:58171 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754433Ab3KYR5b (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 25 Nov 2013 12:57:31 -0500
Content-Disposition: inline
In-Reply-To: <1385113069-23008-1-git-send-email-anaumann@ultratronik.de>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: anaumann@ultratronik.de
Cc: balbi@ti.com, linux-omap@vger.kernel.org

--JWOY2/vB4uO4FuME
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Fri, Nov 22, 2013 at 10:37:49AM +0100, anaumann@ultratronik.de wrote:
> From: Andreas Naumann <anaumann@ultratronik.de>
>=20
> This is a hard to reproduce problem which leads to non-functional USB-OTG=
 port in 0.1%-1% of all boots.
> Tracked it down to commit e25bec160158abe86c276d7d206264afc3646281, which=
 introduces save/restore of OTG_INTERFSEL over suspend.
> Since the resume function is also called early in driver init, it uses a =
non-initialized value (which is 0 and a non-supported setting in DM37xx for=
 INTERFSEL).
> Shortly after the correct value is set. Apparently this works most time, =
but not always.
>=20
> The fix is to initialize the value, BEFORE being written in the resume fu=
nction.
>=20
> Signed-off-by: Andreas Naumann <anaumann@ultratronik.de>

please resend with linux-usb in Cc as well. Also make sure that your
lines (in commit log) aren't over 72 characters.

thanks

--=20
balbi

--JWOY2/vB4uO4FuME
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.15 (GNU/Linux)

iQIcBAEBAgAGBQJSk49lAAoJEIaOsuA1yqREbSEP/3Y+KmxwDWIpjnjQ5SahFdBi
8SRPAMOTa6mWEDpZtkXAR7vHzhaDikyrZop2MkWEReh5Gqs/w4fss3LcMs/Rjcyv
GT7vrFAVo+MWEOkdlAgOmECA6FCKCKverqNwcIuva+fYNqlUtFmiUmCuiod/6iQR
E0ZWQajgrYMlMWKRv67GOFdTToEuvYwb0ivpdgFEheKoA0q+eVWDh1mPNSyX0OUr
lyIrB8nhkghH5Nvz+y91xn+k5syCW0RAtuh9taBaP9RwsQ96fCxRv3FovU1DBAjt
C2H3XAGYhasyPNF1DncN7fPga1UPagnJiT9/E2u1QKUan2xoQsIhD9tJV9WXZ+EV
4kL5tMCs3dFNcR5BmXU41iICPXcT4Ou/J2fd6PBabdyLTdZt5QISM07F+Vf4Xq20
ryoA0hIRQgl9UJEHZ66uxo9h29UyZQLcMsO6rUzYrUWWcA+yk8c7Ey2T6djHKKU2
VO9mVoVwYEGOIC2D6i0WWaoOdT3PvHfc7Q/I5VDklMCjeALmKPIzJeODeyMhJK71
NqgsReDGL9mYxg0q7coZm/nc/OYWMEWL2ZyRMgkJVJw5jdlpbT56ocY0WrDuneah
GPe726vB2gO8E5ai3IFBzqWQYHWZN10bWHk5tPvA3dIrf/jmn4bHH6Pwn1WfLOOt
E/5B8U3ymA9fZiFCTdzV
=t5V8
-----END PGP SIGNATURE-----

--JWOY2/vB4uO4FuME--
