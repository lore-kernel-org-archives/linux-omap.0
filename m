From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: Re: [PATCH] omap2+: add drm device
Date: Thu, 24 May 2012 10:05:44 +0300
Message-ID: <1337843144.2909.17.camel@deskari>
References: <1337803690-30116-1-git-send-email-andy.gross@ti.com>
	 <1337839294.2764.7.camel@lappyti>
	 <CAO8GWq=rGLw3nx_r3+AO6xZNSDVyftpUXwWnbfevga4x2QUxfA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg="pgp-sha1"; protocol="application/pgp-signature";
	boundary="=-Mm6FJscK9swZ5JiGrdjW"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog118.obsmtp.com ([74.125.149.244]:59837 "EHLO
	na3sys009aog118.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750957Ab2EXHFu (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Thu, 24 May 2012 03:05:50 -0400
Received: by lboj14 with SMTP id j14so5486616lbo.7
        for <linux-omap@vger.kernel.org>; Thu, 24 May 2012 00:05:47 -0700 (PDT)
In-Reply-To: <CAO8GWq=rGLw3nx_r3+AO6xZNSDVyftpUXwWnbfevga4x2QUxfA@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Clark, Rob" <rob@ti.com>
Cc: Andy Gross <andy.gross@ti.com>, dri-devel@lists.freedesktop.org, linux-omap@vger.kernel.org, greg@kroah.com


--=-Mm6FJscK9swZ5JiGrdjW
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, 2012-05-24 at 00:27 -0600, Clark, Rob wrote:
> On Thu, May 24, 2012 at 12:01 AM, Tomi Valkeinen <tomi.valkeinen@ti.com> =
wrote:
> > Hi,
> >
> > On Wed, 2012-05-23 at 15:08 -0500, Andy Gross wrote:
> >> Register OMAP DRM/KMS platform device.  DMM is split into a
> >> separate device using hwmod.
> >>
> >> Signed-off-by: Andy Gross <andy.gross@ti.com>
> >
> > <snip>
> >
> >> +static int __init omap_init_drm(void)
> >> +{
> >> +     struct omap_hwmod *oh =3D NULL;
> >> +     struct platform_device *pdev;
> >> +
> >> +     /* lookup and populate the DMM information, if present - OMAP4+ =
*/
> >> +     oh =3D omap_hwmod_lookup("dmm");
> >> +
> >> +     if (oh) {
> >> +             pdev =3D omap_device_build(oh->name, -1, oh, NULL, 0, NU=
LL, 0,
> >> +                                     false);
> >> +             WARN(IS_ERR(pdev), "Could not build omap_device for %s\n=
",
> >> +                     oh->name);
> >> +     }
> >> +
> >> +     return platform_device_register(&omap_drm_device);
> >> +
> >> +}
> >
> > I still don't like fixing the tiler to drm. I would like to have basic
> > tiler support in omapfb also, but with this approach I'll need to
> > duplicate the code. And even if we disregard omapfb, wouldn't it be
> > architecturally better to have the tiler as a separate independent
> > library/driver?
>=20
> Not easily, at least not if we want to manage to use tiler/dmm in a
> more dynamic way, or to enable some additional features which are
> still on the roadmap (like reprogramming dmm synchronized w/ scanout,
> or some things which are coming if future hw generations).  We need
> one place to keep track of which buffers are potentially evictable to
> make room for mapping a new buffer.  And if you look at the tricks
> that go on with mmap'ing tiled buffers to userspace, you *really*
> don't want to duplicate that in N different drivers.

So why can't all that code be in a tiler library/driver?

> Fortunately with dmabuf there is not really a need for N different
> drivers to need to use tiler/dmm directly.  The dmabuf mechanism
> provides what they need to import GEM buffers from omapdrm.  That may
> not really help omapfb because fbdev doesn't have a concept of
> importing buffers.  But OTOH this is unnecessary, because drm provides
> an fbdev interface for legacy apps.  The best thing I'd recommend is,
> if you miss some features of omapfb in the drm fbdev implementation,
> is to send some patches to add this missing features.

Well, at least currently omapfb and omapdrm work quite differently, if
I've understood right. Can we make a full omapfb layer on top of
omapdrm? With multiple framebuffers mapped to one or more overlays,
support for all the ioctls, etc?

I guess we'd still need to have omapfb driver to keep the module
parameters and behavior the same. Can omapdrm be used from inside the
kernel by another driver?

 Tomi


--=-Mm6FJscK9swZ5JiGrdjW
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAABAgAGBQJPvd3IAAoJEPo9qoy8lh71Hg8P/22od+wcixwPJEd4QMbrkfvs
PRG+rQtY4TfWkQALy1GljrIiwAGlloFMdqVBDzlJL1SNuf/LAJy+VOLullGm0LKk
nT10BFBwGbE/rHfJKHwmVZg+y+nL//9n+2pceu1kB/2m06Rd8T+GtfZhoRz++GvI
YpVECbUPPMJBu+kIdW6o5xWl/OjcL8IvNQf78CL2H4WOfADThlRIwpL+b62PAsOh
RW3+9UZdkCep7x4UattMoaUS/IkyyKKEUQb7As7z4EvP3gd8qsGaaQ+1PwuCSQge
ZCcfbykbhrIQ7YUopu30Z0M+q9oyUDsozACVizJnzslaKp+iOzWf3bCcjA88ZbRJ
pdumn/Wkztpo1DOkDu2F2X67o7dw1TthGu/w4D7RJhnJt+rio4+CpTqt5WVH+XkK
tk2tu0XjupWm40rriqYn/aqbJJCkDHHgatpC/9mhw7tHtl4lNq0NHAg93TZRKMOE
PHOa32fgtmBGFtoZ4TeRXSrzj42F2lzFuez+yUuBz4X1yaaGkzXYIJjChIYfcch2
8UTj94GLbGpZQuun65Cf//4p13fs03OnmKdL8Y1J7bRezap9cthJBfa/uDSH82RG
WH4jpp2BeA0pRDTiZy+odBzpN25Zxxhe5UeCIokFN8MXcqBOqapcHb8c72btS9hy
Cifq19pz8qvOfgcPtsjJ
=7VIj
-----END PGP SIGNATURE-----

--=-Mm6FJscK9swZ5JiGrdjW--

