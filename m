From: Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>
Subject: Re: [PATCH 1/5 RESEND] ARM: OMAP: USB: HOST TLL platform driver
Date: Tue, 20 Mar 2012 11:59:16 +0200
Message-ID: <20120320095914.GE9157@arwen.pp.htv.fi>
References: <1332139715-1495-1-git-send-email-keshava_mgowda@ti.com>
 <1332139715-1495-2-git-send-email-keshava_mgowda@ti.com>
 <20120319100603.GB20279@arwen.pp.htv.fi>
 <CAP05o4LkWpANqibBXsY-FbCTOsioUq4qPdA8k=Ct4HHGYfL4Ng@mail.gmail.com>
Reply-To: balbi-l0cyMroinI0@public.gmane.org
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="mR8QP4gmHujQHb1c"
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <CAP05o4LkWpANqibBXsY-FbCTOsioUq4qPdA8k=Ct4HHGYfL4Ng-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: "Munegowda, Keshava" <keshava_mgowda-l0cyMroinI0@public.gmane.org>
Cc: balbi-l0cyMroinI0@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, sameo-VuQAYsv1563Yd54FQh9/CA@public.gmane.org, parthab-PpE0FKYn9XJWk0Htik3J/w@public.gmane.org, govindraj.raja-l0cyMroinI0@public.gmane.org, paul-DWxLp4Yu+b8AvxtiuMwx3w@public.gmane.org, b-cousson-l0cyMroinI0@public.gmane.org
List-Id: linux-omap@vger.kernel.org


--mR8QP4gmHujQHb1c
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Tue, Mar 20, 2012 at 03:00:50PM +0530, Munegowda, Keshava wrote:
> >> +MODULE_AUTHOR("Keshava Munegowda <keshava_mgowda-l0cyMroinI0@public.gmane.org>");
> >> +MODULE_ALIAS("platform:" USBHS_DRIVER_NAME);
> >> +MODULE_LICENSE("GPL v2");
> >> +MODULE_DESCRIPTION("usb tll driver for TI OMAP EHCI and OHCI controll=
ers");
> >> +
> >> +static int __init omap_usbtll_drvinit(void)
> >> +{
> >> + =A0 =A0 return platform_driver_probe(&usbtll_omap_driver, usbtll_oma=
p_probe);
> >
> > please don't. Make sure you use platform_driver_register, instead.
>=20
>=20
> Here , omap_usbtll_drvinit is registered through fs_initcall call;
> this is required because, the TLL driver is required to initialized
> before the UHH ( usb host core) driver.

no issues with fs_initcall. The issue is with platform_driver_probe()
only.

--=20
balbi

--mR8QP4gmHujQHb1c
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAEBAgAGBQJPaFTyAAoJEIaOsuA1yqRECd4P/RQPhxbQchieX7pAWfdOBO5x
Zr7TlDOMkXeATzA21Xmeu9MfjZ65QRiL/5Fo4dH7QSqfG7hl7DgRgmuMzPcdZ9pk
Jg5DGWuGF3pjZzS663ZXZ4pZdQO2LmVLh+oNZrU8W0ncC62uxg834J7UmIt/OV1j
Rw5kfYhuqgpaT3o/cUHsZ2IRKLy1c/rAQtalxpIbvD9ONjDQX/RSx/Iuwp1RnnhA
Up+ljal/xI0CzPx043XfHcf9oYMFGirYRTgLgMo20YC8+RSQAlBEsCnv9+6/HSLm
SVsfAP9W4qbCI0PGUPN2Y839xGSgmpiY7BZOWKxljxTH3WDGdKKUXgkeLMUCpR/g
M8mKKxT4j0ZioF0PXobQpwDYA4KFd4ItpGNZ8ncIZkMO8WloW6IRn8FzAi4Ozr7Z
KaZ3yVxT4jw+g86SDWPerNdUcbpfiGDD2WnIjc4dBGbFEcsENE7cP/gBKA5bXtJ9
JMQvspFKVyyiORxM2v6+hmyeeZ0nHoxDiPwa2dcTrBl7/7WEJXVh/wYpgxg4iOg1
YyylgaE/9d737EOInQF1cXSflyr6xVhrDPFIVStsV7DbROkWVt+gTnDYcoIxJOc5
fMqHUjp3tA/T9m3uARoGHY0jerkAZmjGZO/AdeuEbYeOKTkhwMVDaw1OR3ArQ0Ue
RWnvnNlm4ymYru4FYUuv
=YI3O
-----END PGP SIGNATURE-----

--mR8QP4gmHujQHb1c--
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
