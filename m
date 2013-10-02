From: Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>
Subject: Re: [PATCH v7 09/10] usb: dwc3: omap: manage "usb_otg_ss_refclk960m"
 clock
Date: Wed, 2 Oct 2013 08:11:14 -0500
Message-ID: <20131002131113.GM1476@radagast>
References: <1379508542-22389-1-git-send-email-rogerq@ti.com>
 <1379508542-22389-10-git-send-email-rogerq@ti.com>
 <52403E02.4070208@ti.com>
Reply-To: <balbi-l0cyMroinI0@public.gmane.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="VsILLG6PYTzZlkGF"
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <52403E02.4070208-l0cyMroinI0@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Roger Quadros <rogerq-l0cyMroinI0@public.gmane.org>
Cc: balbi-l0cyMroinI0@public.gmane.org, bcousson-rdvid1DuHRBWk0Htik3J/w@public.gmane.org, tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org, george.cherian-l0cyMroinI0@public.gmane.org, kishon-l0cyMroinI0@public.gmane.org, bigeasy-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org, sergei.shtylyov-M4DtvfQ/ZS1MRgGoP+s0PdBPR1lH4CV8@public.gmane.org, thomas.langer-th3ZBGNqt+7QT0dZR+AlfA@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-omap@vger.kernel.org

--VsILLG6PYTzZlkGF
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 23, 2013 at 04:11:30PM +0300, Roger Quadros wrote:
> Hi Felipe,
>=20
> On 09/18/2013 03:49 PM, Roger Quadros wrote:
> > "usb_otg_ss_refclk960m" is an optional functional clock to the
> > UBS_OTG_SS module. So manage it in the driver.
> >=20
>=20
> Just realized that "usb_otg_ss_refclk960m" is in fact functional clock to=
 the=20
> PHY and not USB_OTG_SS module. The name is misleading.
>=20
> So please ignore patch 9 and 10.

ignored. All others are fine, right ?

--=20
balbi

--VsILLG6PYTzZlkGF
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJSTBtvAAoJEIaOsuA1yqRElrEP/RpfWjYvTQ92g8sDYn4vjtX0
kZmQtEI/Vt68K8UHL+o/Yfxo7IrhclNFm4rrjkQCIh2rj15K06N/jlaos/RzXd4D
5S4scBTAcsYdWBVhVS519E1C3lWR2DIMSr86F4xqrzvjt9nWvyWAK6jE9ReJ+ocU
WndBtqP0uqJfH8b+OXTrjiigdRPJ+JPTMKBwZ4rb4qoELVyI+JCnSKS84VTEyTOJ
BLFv2z0grFPGIN2ggUKF2MGVHRJ/yqZ77bS99rJUyiNonxYox3Ahk249skiz2/5x
qSnv0oIClsPHSsF8FvhAkpNvZq+BZKSh+k7qO7ZJFWpq/YwxudLDTV4OWY8IAAuw
b77yHRYE+ieLYg8oGFYrTjhsn0n2GLtbSbyA4MHiOO5UuEmkAM8N3JsZq8kQ9vB8
D1lTQHK6oRCpk1BnoxCf3CmK1AsWLipm8ZJePqNSucuAfE8YMV74s4/F66DnAbDg
iim65zyaL6DxSXmJ0YVuRbp/RuYELJvCqnKuT9rPcjdoV/H5qC7TAy3p4iZhu6o0
5B3LHINu7Gp42AqrPE2b+ll1qpsTDr4Ssp2PAwztuJ5u1WQEH7N41qdhD5jLf/zX
cB9HhIzdbqEReykKYqBAltE0eH4L06kU67eKn2GON4wandqvO4G4xbMaPCoiLZ0H
/zyTdWtPez5UPBhT2OUE
=EXQS
-----END PGP SIGNATURE-----

--VsILLG6PYTzZlkGF--
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
