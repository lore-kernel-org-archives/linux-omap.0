From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: Re: [PATCH] ASoC: OMAP: HDMI: Prevent DSS module from going idle
 when playing audio
Date: Fri, 16 Dec 2011 10:18:24 +0200
Message-ID: <1324023504.1859.11.camel@deskari>
References: <1324019032-31532-1-git-send-email-ricardo.neri@ti.com>
	 <alpine.DEB.2.00.1112160107380.12660@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg="pgp-sha1"; protocol="application/pgp-signature"; boundary="=-AK1Wk3qM3VOplA0ZoyJK"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog110.obsmtp.com ([74.125.149.203]:58902 "EHLO
	na3sys009aog110.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753389Ab1LPISa (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Fri, 16 Dec 2011 03:18:30 -0500
Received: by lami14 with SMTP id i14so1993174lam.34
        for <linux-omap@vger.kernel.org>; Fri, 16 Dec 2011 00:18:28 -0800 (PST)
In-Reply-To: <alpine.DEB.2.00.1112160107380.12660@utopia.booyaka.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>
Cc: Ricardo Neri <ricardo.neri@ti.com>, b-cousson@ti.com, linux-omap@vger.kernel.org, mythripk@ti.com, s-guiriec@ti.com, lrg@ti.com, peter.ujfalusi@ti.com


--=-AK1Wk3qM3VOplA0ZoyJK
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, 2011-12-16 at 01:14 -0700, Paul Walmsley wrote:
> > @@ -572,12 +573,16 @@ int hdmi_audio_trigger(struct
> snd_pcm_substream *substream, int cmd,
> >       case SNDRV_PCM_TRIGGER_START:
> >       case SNDRV_PCM_TRIGGER_RESUME:
> >       case SNDRV_PCM_TRIGGER_PAUSE_RELEASE:
> > +             omap_hwmod_set_slave_idlemode(ip_data->oh,
> > +                     HWMOD_IDLEMODE_NO);
>=20
> omap_hwmod functions should not be called from device driver code.
> Device=20
> drivers should be completely independent of architecture and=20
> subarchitecture code.  If you need to do something like this, the way
> to=20
> do it is to call an omap_device function through a platform_data
> function=20
> pointer.  You may need to create omap_device and/or omap_hwmod
> functions=20
> to do what you want to do.=20

But with DT we can't use func pointers in platform_data either, right?

 Tomi


--=-AK1Wk3qM3VOplA0ZoyJK
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAABAgAGBQJO6v7QAAoJEPo9qoy8lh719IkP/ibwyF02OtgwfN/M7d9ytWgD
evnuEy1PU2+vFdvq0fqWmX0Cd3/DDeJCVYOpr7WiV635WaTeSPxnm9uL5iQa+V1m
wQLVpTIvG8kir3rLgiHuMKi8hxmSvk0nsCHYPOFLYRoTaQyHTdDEX4vNFBnDv9BZ
s0HHd+F3djaTUqKOWxhuvJ4z6DRQd8Iof783Ff1u7idipURexQEnw7OKYLwOTein
77N1PQp75c4t6pOUCir2E9W5cz3xmfWQSNARNwse+6bOsK6Ma3h+C2121W4w0b4z
U7QhC6RBlPCg6SY5IBRZGM3Blq8hTm/WlSk90Tf5BZ0rsE0p9y1tfQP5aBrgqwLb
H7YySp+LsCzW2jB7a23Zv3bo6RBWYxzFoaY7jXH8sjY4ayWucyWfqiZ3H8QUUTu1
J7uoYANLgchTDuTRkeOMHjGiLW+8Wzg16fI2JS9ORrjIAwzjhMJr9ZS3ItcuaZ7y
ucOZGUogR6jgrACzHFU/tLcxjNUb54vZXR+yyn4ZjSH6bm38gj8OuP2dmSeZ7nDa
JhPqpGaRdEN9tyPkIYyRvafqs9XA4i89fevIr7SdJikRgzk/t46PZFBe3P7LpXV4
yWwOkvJnimpK4/ZNnU3zt3U9bEDHc7Hk/3W1QdhtW+iUQRbkmBWnJTriPq+WB6AD
0W29QKpLhWaU+RB3wmZq
=/wfx
-----END PGP SIGNATURE-----

--=-AK1Wk3qM3VOplA0ZoyJK--

