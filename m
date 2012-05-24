From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: Re: [PATCH] omap2+: add drm device
Date: Thu, 24 May 2012 15:10:16 +0300
Message-ID: <1337861416.12304.4.camel@deskari>
References: <1337803690-30116-1-git-send-email-andy.gross@ti.com>
	 <1337839294.2764.7.camel@lappyti>
	 <CAO8GWq=rGLw3nx_r3+AO6xZNSDVyftpUXwWnbfevga4x2QUxfA@mail.gmail.com>
	 <1337843144.2909.17.camel@deskari>
	 <CAF6AEGtQqn3jpDMRDeCrDA8p_EEAG5=NhRh8uhmfs6haboAE5g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg="pgp-sha1"; protocol="application/pgp-signature";
	boundary="=-c0ibVkZBTharnCmaYf60"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog135.obsmtp.com ([74.125.149.84]:39366 "EHLO
	na3sys009aog135.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756525Ab2EXMK0 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Thu, 24 May 2012 08:10:26 -0400
Received: by lagy4 with SMTP id y4so5815433lag.15
        for <linux-omap@vger.kernel.org>; Thu, 24 May 2012 05:10:23 -0700 (PDT)
In-Reply-To: <CAF6AEGtQqn3jpDMRDeCrDA8p_EEAG5=NhRh8uhmfs6haboAE5g@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Rob Clark <rob.clark@linaro.org>
Cc: greg@kroah.com, linux-omap@vger.kernel.org, dri-devel@lists.freedesktop.org


--=-c0ibVkZBTharnCmaYf60
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, 2012-05-24 at 02:35 -0600, Rob Clark wrote:
> On Thu, May 24, 2012 at 1:05 AM, Tomi Valkeinen <tomi.valkeinen@ti.com> w=
rote:
> > On Thu, 2012-05-24 at 00:27 -0600, Clark, Rob wrote:
> >> On Thu, May 24, 2012 at 12:01 AM, Tomi Valkeinen <tomi.valkeinen@ti.co=
m> wrote:
> >> > Hi,
> >> >
> >> > On Wed, 2012-05-23 at 15:08 -0500, Andy Gross wrote:
> >> >> Register OMAP DRM/KMS platform device.  DMM is split into a
> >> >> separate device using hwmod.
> >> >>
> >> >> Signed-off-by: Andy Gross <andy.gross@ti.com>
> >> >
> >> > <snip>
> >> >
> >> >> +static int __init omap_init_drm(void)
> >> >> +{
> >> >> +     struct omap_hwmod *oh =3D NULL;
> >> >> +     struct platform_device *pdev;
> >> >> +
> >> >> +     /* lookup and populate the DMM information, if present - OMAP=
4+ */
> >> >> +     oh =3D omap_hwmod_lookup("dmm");
> >> >> +
> >> >> +     if (oh) {
> >> >> +             pdev =3D omap_device_build(oh->name, -1, oh, NULL, 0,=
 NULL, 0,
> >> >> +                                     false);
> >> >> +             WARN(IS_ERR(pdev), "Could not build omap_device for %=
s\n",
> >> >> +                     oh->name);
> >> >> +     }
> >> >> +
> >> >> +     return platform_device_register(&omap_drm_device);
> >> >> +
> >> >> +}
> >> >
> >> > I still don't like fixing the tiler to drm. I would like to have bas=
ic
> >> > tiler support in omapfb also, but with this approach I'll need to
> >> > duplicate the code. And even if we disregard omapfb, wouldn't it be
> >> > architecturally better to have the tiler as a separate independent
> >> > library/driver?
> >>
> >> Not easily, at least not if we want to manage to use tiler/dmm in a
> >> more dynamic way, or to enable some additional features which are
> >> still on the roadmap (like reprogramming dmm synchronized w/ scanout,
> >> or some things which are coming if future hw generations).  We need
> >> one place to keep track of which buffers are potentially evictable to
> >> make room for mapping a new buffer.  And if you look at the tricks
> >> that go on with mmap'ing tiled buffers to userspace, you *really*
> >> don't want to duplicate that in N different drivers.
> >
> > So why can't all that code be in a tiler library/driver?
>=20
> Possibly the placement stuff could be in a library..  the
> mmap/faulting stuff I think would be harder to split.  With it split
> out in a separate lib, it becomes logistically a bit more of a
> headache to change APIs, etc.  Basically it just makes more work and
> is unnecessary.

Unnecessary for you, but maybe not for those who want to use omapfb.

> >> Fortunately with dmabuf there is not really a need for N different
> >> drivers to need to use tiler/dmm directly.  The dmabuf mechanism
> >> provides what they need to import GEM buffers from omapdrm.  That may
> >> not really help omapfb because fbdev doesn't have a concept of
> >> importing buffers.  But OTOH this is unnecessary, because drm provides
> >> an fbdev interface for legacy apps.  The best thing I'd recommend is,
> >> if you miss some features of omapfb in the drm fbdev implementation,
> >> is to send some patches to add this missing features.
> >
> > Well, at least currently omapfb and omapdrm work quite differently, if
> > I've understood right. Can we make a full omapfb layer on top of
> > omapdrm? With multiple framebuffers mapped to one or more overlays,
> > support for all the ioctls, etc?
>=20
> Well, there is still room to add your own fb_ioctl() fxn, so I guess
> in principle it should be possible to add whatever custom ioctls are
> required.
>=20
> Typically you have a single fbdev device for a single drm device,
> although I suppose nothing prevents creating more.  I'd probably want
> to encourage users more towards using KMS directly for multi-display
> cases because you have a lot more options/flexibility that way.

Sure, but we can't force people to use omapdrm instead of omapfb. And
omapfb is not going to disappear. So obviously we should recommend using
omapdrm, but on the other hand, I don't see any problem in adding new
features to omapfb if they are easily implemented (using, for example, a
separate tiler driver).

> > I guess we'd still need to have omapfb driver to keep the module
> > parameters and behavior the same. Can omapdrm be used from inside the
> > kernel by another driver?
>=20
> Hmm, I'm not quite sure what you have in mind, but it sounds a bit
> hacky..  I'd guess if you need 100% backwards compatibility even down
> to kernel cmdline / module params, then you probably want to use
> omapfb.  But there isn't really need to add new features to omapfb in
> that case.

I was thinking of making omapfb use omapdrm, instead of omapdss. I mean,
not planning to do that, just wondering if that would be possible.

> Off the top of my head, I guess that 80-90% compatibility would
> probably be reasonable to add to omapdrm's fbdev..  and that the last
> 10-20% would be too hacky/invasive to justify adding to omapdrm.

I think it should be 99.9% - 100% or nothing. If it's only 80-90%
compatible, then it's not compatible =3D).

 Tomi


--=-c0ibVkZBTharnCmaYf60
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAABAgAGBQJPviUoAAoJEPo9qoy8lh71J5sP/j8mZptzyfVXIqYoygLaL65p
rf0YAivW/xdoEIP57b0cXNNN/28ts1iZ4Or9rsMNhTnJE1ZAkeYXlbxA3TORaG2J
AAVQ4POInLUh0ihqu067tE3W7UamrdkDVAazFQJgKkab8Mw4yjCtsml2cqPGP+me
S5JBjomCpPuEcFOiKef47qE9x7PRKgXrOZHLVmNImrMC4mnxHDHMeOzeV/4DYTAm
roFPSqHkuRS7+wAPF93cbq2yPfMyAqK17onzyUlrsGHmyo4blPTBwYuSy7Rdk/sx
immGJmc5KhhQU1MlSTAxKbx0SvNjQzpL4hG7Lzb5eswcbw1x0WzRfDoOF8/Cy67U
yMVeZfWLXrFY5MxvicjMYZxEl2V9n51bkYJycV6yDIBkbQ/9ciHRccxuuswk8t7H
5O/g1BcVpyLskxJbXpPJkFF87yhErFcfXzrxA0UAnuRzyXRF0ggz1E5D/ktF3PCC
VeMySkAUutW3+vSYIu5jzs4MeP4/tv5CuPnoIHqZP64w0xvY93/V7YGQbu6QKdPs
fECbmSWzL9Om3BMTLTsU/JrpuMkATXII8eil+bQplHQpnzk5pxPtzYGpx7vx9FxA
raGeTYAKWi7LlWtk9L3yvC1F1GaqWDqyL3cIbhUHvPi+Yhqoja1FIFdp86KALlD/
Gk+2ZkkgiWJfbSxMCifo
=6Hzn
-----END PGP SIGNATURE-----

--=-c0ibVkZBTharnCmaYf60--

