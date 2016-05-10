From: Felipe Balbi <balbi-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH v7 4/5] usb: dwc3: omap: Pass VBUS and ID events transparently
Date: Tue, 10 May 2016 12:55:34 +0300
Message-ID: <87d1oui6eh.fsf@linux.intel.com>
References: <1462873919-20532-1-git-send-email-rogerq@ti.com> <1462873919-20532-5-git-send-email-rogerq@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
	micalg=pgp-sha256; protocol="application/pgp-signature"
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1462873919-20532-5-git-send-email-rogerq-l0cyMroinI0@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org, Joao.Pinto-HKixBCOQz3hWk0Htik3J/w@public.gmane.org, sergei.shtylyov-M4DtvfQ/ZS1MRgGoP+s0PdBPR1lH4CV8@public.gmane.org, peter.chen-KZfg59tc24xl57MIdRCFDg@public.gmane.org, jun.li-KZfg59tc24xl57MIdRCFDg@public.gmane.org, grygorii.strashko-l0cyMroinI0@public.gmane.org, yoshihiro.shimoda.uh-zM6kxYcvzFBBDgjK7y7TUQ@public.gmane.org, nsekhar-l0cyMroinI0@public.gmane.org, b-liu-l0cyMroinI0@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Roger Quadros <rogerq-l0cyMroinI0@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

--=-=-=
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable


Hi,

Roger Quadros <rogerq-l0cyMroinI0@public.gmane.org> writes:
> Don't make any decisions regarding VBUS session based on ID
> status. That is best left to the OTG core.
>
> Pass ID and VBUS events independent of each other so that OTG
> core knows exactly what to do.
>
> This makes dual-role with extcon work with OTG irq on OMAP platforms.
>
> Signed-off-by: Roger Quadros <rogerq-l0cyMroinI0@public.gmane.org>

I have a feeling this will regress OMAP5432 uEVM. Did you test with that
board ?

cheers

=2D-=20
balbi

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJXMbAWAAoJEIaOsuA1yqREMF4P/ApPxdWxGr7ErIIQiHyPgbxB
HJ6I11iC159yEPDFXClR9d1+yOz9jDEk8YY2jeKwo7UYt1k9rj1iI2b74XpJLjF5
xsFFtZYmFo/7Quk5UzhvyJ98jPvSZ1F8jayKLhfllASHj6uPi3NK/PkNLg3KS7A7
SaONyrL4k3cR6K4qRXmLENfKjGtY8to5rT6kTB2PQUlf+yWKTZ+DiDNtcnc2oyc1
v88WD165nrXBCutYcpuSw8qeAN3IwUnr7GaFe4HVGELCTJ7aam63ckxKCA2m6VJr
U1tjcJVGsS4KZZdgW2sOh63e6ILai1rwjEKR7mPaMT6VPQTM3v5CXouUrd8UWXU/
YXwUKTlhCwJ6r78RfY4hE4ONekfoiKKM0dyHXB5aNTBzvOQfnAPaQrwC9l6Uffsj
A5257V7kot400zKVL6FRaZwGc16vrnalZIb7Dqf6GyKQ+lLDVxGVzfH/tkfjjLzu
J8Lh5rVd3XNPjyNPJlTKxMJ4BFOiKyeayNXo0GCkrgnRudGVpW5p1FbJcK8iyH6s
3m5VnRPeS79ipPWEW7zYncHnQZ36y3yaTlavnQUwFWw7UPTxmfY/0ypRb0EZtzgY
oh7Tp7w2jfVKHZS7QouUItStd5Z0M0rJ3l7JPV+kPCnbTnz3/bgCJtcN7N9SR/Mn
ymrlDgMjNj4CSseYX/iu
=TfcA
-----END PGP SIGNATURE-----
--=-=-=--
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
