From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: Re: [PATCH] omap2+: add drm device
Date: Thu, 24 May 2012 18:26:40 +0300
Message-ID: <1337873200.13723.17.camel@deskari>
References: <1337803690-30116-1-git-send-email-andy.gross@ti.com>
	 <1337839294.2764.7.camel@lappyti>
	 <CAO8GWq=rGLw3nx_r3+AO6xZNSDVyftpUXwWnbfevga4x2QUxfA@mail.gmail.com>
	 <1337843144.2909.17.camel@deskari> <1337844098.2909.20.camel@deskari>
	 <CAF6AEGur-mmZDVrE+Y-6tesNCVKp4xKKuS-C7ozTSJ2KQijHdw@mail.gmail.com>
	 <1337861581.12304.7.camel@deskari>
	 <CABT81PhhCaXuHW+x34_Q8izdcW0Ud8dNVSMEr0Zzyt9FAjm5TA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg="pgp-sha1"; protocol="application/pgp-signature";
	boundary="=-ntKe8tcJ8nJWNaiuUZ70"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog118.obsmtp.com ([74.125.149.244]:40628 "EHLO
	na3sys009aog118.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751364Ab2EXP0q (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Thu, 24 May 2012 11:26:46 -0400
Received: by lahj13 with SMTP id j13so10466901lah.39
        for <linux-omap@vger.kernel.org>; Thu, 24 May 2012 08:26:43 -0700 (PDT)
In-Reply-To: <CABT81PhhCaXuHW+x34_Q8izdcW0Ud8dNVSMEr0Zzyt9FAjm5TA@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Gross, Andy" <andy.gross@ti.com>
Cc: Rob Clark <rob.clark@linaro.org>, greg@kroah.com, linux-omap@vger.kernel.org, dri-devel@lists.freedesktop.org


--=-ntKe8tcJ8nJWNaiuUZ70
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, 2012-05-24 at 10:09 -0500, Gross, Andy wrote:
> On Thu, May 24, 2012 at 7:13 AM, Tomi Valkeinen <tomi.valkeinen@ti.com> w=
rote:
> > On Thu, 2012-05-24 at 02:44 -0600, Rob Clark wrote:
> >
> >> but other drivers *can* use tiler, thanks to dmabuf.. I have omap4iss
> >> v4l2 camera working w/ tiler buffers on my pandaboard, for example.
> >>
> >> Maybe fbdev is an exception to the rule because it has no way for
> >> userspace to pass it a buffer to use.  But on the other hand it is a
> >> legacy API so I'm not sure if it is worth loosing too much sleep over
> >> that.
> >
> > I'm not that familiar with dmabuf, but are you saying it's not possible
> > for a kernel driver to request the buffers? They _must_ come from the
> > userspace?
> >
> > Anyway, even if it would be possible, if the tiler is a part of omapdrm
> > we need omapdrm to get and use the tiler buffers. And we can't have
> > omapdrm running when using omapfb, because they both use omapdss.
>=20
> And that is a good point.  The DSS is kind of a sticking point to anyone
> having to enable DRM to get Tiler.  However, omapfb doesn't currently uti=
lize
> DMM/Tiler features.  Can't we defer generalizing until there is a
> requirement for it?

Sure. I just brought it up because it'd be nice and it'd be better
architecturally. However, as I said, I'm not familiar with the related
problems, so I take your word that it's not simple =3D).

 Tomi


--=-ntKe8tcJ8nJWNaiuUZ70
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAABAgAGBQJPvlMwAAoJEPo9qoy8lh71zWMP/R4Q/GkhnK1jLhLy5vM5Iuq+
EwWedc0YtUDWDsbg1Q64X064QIPE8G0a/87kjTGKxD6fRo7gIp3G9qSbxeLUV7aN
IsObzllqp8oPOVNnV4PqcssU6OvSvxI1Hjzdt3l8433lla1FWhZuGrFNGlzHigpB
rq5l7HwJk7GiJAiQtkGIA7dD4DCRUGBQgs+f7s+xLFrIcRa7NlP18Gxu+/FhSRU3
Rd6zcjueK4yXeVRlr+JnYxbCyrT2WOhAhS47nDfPC0gjt7LJiMl/04vMJIkWrIwn
/cWU5VpvRkz+S2cWNyvYPHMNkeOm9/6i9s2RzNWUyukyYbgm3Nu/LXvNRZllKXSc
geTSI9uhVLt7VyhFRUUSJHirqlY7DsPojCra2YE+kNY6zg+OKD3DYhaBAz6fNNgq
qpur4YZx8k4qU6N0pUAfF+LSDnuEZBtc4axW+8ODEkM70ueHG7dbs8XPRdNMoGqn
Y1vLTKMS6dbn21XyXtqQij9pYe1pmbabAkCjqTJEE9MsUKTgAblUFaPSil+yABzQ
Cn8/A6oXQjBkK1So+EWErPQGqaQDfGE0BBbPJ/NGjN473Klx2KMsbIpY06nbGJ8V
zv9V7NWce9BtLYCI6w9O9Ly+w9/GhRUafkVsE7Cokm8weD3+uJ02tKCbOYtxQjN2
8Q0qC6I9e0SDEkrgrLRz
=L3vU
-----END PGP SIGNATURE-----

--=-ntKe8tcJ8nJWNaiuUZ70--

