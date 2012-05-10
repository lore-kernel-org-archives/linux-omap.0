From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: Re: omapfb-main.c: check result of simple_strtoul
Date: Thu, 10 May 2012 14:02:29 +0300
Message-ID: <1336647749.5182.36.camel@deskari>
References: <4FAA838A.3040106@yahoo.es> <1336638194.5182.28.camel@deskari>
	 <4FAB9DC1.6000908@yahoo.es>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg="pgp-sha1"; protocol="application/pgp-signature";
	boundary="=-xrHBRgldgEykPZmmWNQt"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog129.obsmtp.com ([74.125.149.142]:44044 "EHLO
	na3sys009aog129.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1757877Ab2EJLCf (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Thu, 10 May 2012 07:02:35 -0400
Received: by lboj14 with SMTP id j14so1322792lbo.35
        for <linux-omap@vger.kernel.org>; Thu, 10 May 2012 04:02:32 -0700 (PDT)
In-Reply-To: <4FAB9DC1.6000908@yahoo.es>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Hein Tibosch <hein_tibosch@yahoo.es>
Cc: linux-omap <linux-omap@vger.kernel.org>


--=-xrHBRgldgEykPZmmWNQt
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, 2012-05-10 at 18:51 +0800, Hein Tibosch wrote:
> On 5/10/2012 4:23 PM, Tomi Valkeinen wrote:
> > On Wed, 2012-05-09 at 22:47 +0800, Hein Tibosch wrote:
> >>   		fbnum =3D simple_strtoul(p, &p, 10);
> >> -		if (p =3D=3D param)
> >> +		if (p =3D=3D start)
> >>
> >> correct?
> > Yes, looks like a correct fix. I'll cook up a patch.
> >
> > How did you encounter the bug? What was the outcome?
> I was reading the source, adding some printk's to get more debugging.
>=20
> It would fail to detect a syntax error like:
>=20
>      "omapfb.vram=3D0:2M,:5M"
>=20

Ok, thanks.

> If I may ask: why aren't "mode" and "modes" filled in:
>=20
>     /sys/devices/platform/omapfb/graphics/fb0 ?
>=20
> Only "modes" will get an entry when a new mode becomes active.

No particular reason, nobody just has implemented it.

> I thought of adding something like this in hdmi.c:
>=20
> +static void omap_to_fbmode (struct fb_videomode *fb_mode, const struct h=
dmi_config *cfg)
> +{

You can't add framebuffer code to omapdss. omapdss is the lowlevel
driver that cannot depend on the fb driver. omapdss is also used by
other display drivers like omapdrm.

 Tomi


--=-xrHBRgldgEykPZmmWNQt
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAABAgAGBQJPq6BFAAoJEPo9qoy8lh71CAkQAKazmgbwgMlDiKeZYOUAFq3y
3ao5qVnZSiak6+bTtg+qmohZGontVQ/M9HMZFGAPZQeH3sCr74SLMqOirSYzO3ie
MqHRb4w9Dc3HQcJJNMwtFHkwgpVO8UxIrb1S1gi/GEBMRrJCosusxGjdjo9Y+6Se
pXWR2EpBVybTP+EUWILvDE5FY5RihUhIRqbA+XgnAFarFePymsy3wgvK14UR7b8x
85+OVxcvHevBnUSFeNo/g8DoOOJ6Aq7sa9HilyySm1i1/+MYNtsVm2Bhqyhdnmy+
k1sPRweLM9v8Ztr7tkdhBpTC1uZbGPOJpV/y2uypJDRbb0r5hDV8E1PivNpMg3wr
k0PiNoeT40gq64NAvnyaSG/QtRa/OBL9zeTYUcyEQ2Q3AsqeoCXdUnv9jviWXy2N
fLqDGV6h6nr8sqXpXrjmOrV8qqQ72yutaDQJJEnAAXLUFraoFxW7MTYAeZyqr61a
oqggWJaYisS8XGm2b7Laah7yYg0K3PFVKpnFG6tnucDZ8y/ESBTfXDLHN7BKDvss
DTQMiLcqXnLdQTc2Bbez6YTkD/6pietrBYZwac1ApDn4OWLbZR+avDxnLxQtQ/Hu
IzkzZN3+xrn5N5vPjxhVkqLvdxc8aYSdnYi7cql++jxfJfSivSp7ljEHKTV6zzxl
595GDTS+4YMvsX1ZEa0J
=jRtq
-----END PGP SIGNATURE-----

--=-xrHBRgldgEykPZmmWNQt--

