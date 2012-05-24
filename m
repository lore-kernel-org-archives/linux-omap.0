From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: Re: [PATCH] omap2+: add drm device
Date: Thu, 24 May 2012 10:21:38 +0300
Message-ID: <1337844098.2909.20.camel@deskari>
References: <1337803690-30116-1-git-send-email-andy.gross@ti.com>
	<1337839294.2764.7.camel@lappyti>
	<CAO8GWq=rGLw3nx_r3+AO6xZNSDVyftpUXwWnbfevga4x2QUxfA@mail.gmail.com>
	<1337843144.2909.17.camel@deskari>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1525384295=="
Return-path: <dri-devel-bounces+sf-dri-devel=m.gmane.org@lists.freedesktop.org>
In-Reply-To: <1337843144.2909.17.camel@deskari>
List-Unsubscribe: <http://lists.freedesktop.org/mailman/options/dri-devel>,
	<mailto:dri-devel-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <http://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <http://lists.freedesktop.org/mailman/listinfo/dri-devel>,
	<mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Sender: dri-devel-bounces+sf-dri-devel=m.gmane.org@lists.freedesktop.org
Errors-To: dri-devel-bounces+sf-dri-devel=m.gmane.org@lists.freedesktop.org
To: "Clark, Rob" <rob@ti.com>
Cc: greg@kroah.com, linux-omap@vger.kernel.org, dri-devel@lists.freedesktop.org
List-Id: linux-omap@vger.kernel.org


--===============1525384295==
Content-Type: multipart/signed; micalg="pgp-sha1"; protocol="application/pgp-signature";
	boundary="=-YSQXdAHo4RQTkKuKyv8l"


--=-YSQXdAHo4RQTkKuKyv8l
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, 2012-05-24 at 10:05 +0300, Tomi Valkeinen wrote:
> On Thu, 2012-05-24 at 00:27 -0600, Clark, Rob wrote:
> > On Thu, May 24, 2012 at 12:01 AM, Tomi Valkeinen <tomi.valkeinen@ti.com=
> wrote:
> > > Hi,
> > >
> > > On Wed, 2012-05-23 at 15:08 -0500, Andy Gross wrote:
> > >> Register OMAP DRM/KMS platform device.  DMM is split into a
> > >> separate device using hwmod.
> > >>
> > >> Signed-off-by: Andy Gross <andy.gross@ti.com>
> > >
> > > <snip>
> > >
> > >> +static int __init omap_init_drm(void)
> > >> +{
> > >> +     struct omap_hwmod *oh =3D NULL;
> > >> +     struct platform_device *pdev;
> > >> +
> > >> +     /* lookup and populate the DMM information, if present - OMAP4=
+ */
> > >> +     oh =3D omap_hwmod_lookup("dmm");
> > >> +
> > >> +     if (oh) {
> > >> +             pdev =3D omap_device_build(oh->name, -1, oh, NULL, 0, =
NULL, 0,
> > >> +                                     false);
> > >> +             WARN(IS_ERR(pdev), "Could not build omap_device for %s=
\n",
> > >> +                     oh->name);
> > >> +     }
> > >> +
> > >> +     return platform_device_register(&omap_drm_device);
> > >> +
> > >> +}
> > >
> > > I still don't like fixing the tiler to drm. I would like to have basi=
c
> > > tiler support in omapfb also, but with this approach I'll need to
> > > duplicate the code. And even if we disregard omapfb, wouldn't it be
> > > architecturally better to have the tiler as a separate independent
> > > library/driver?
> >=20
> > Not easily, at least not if we want to manage to use tiler/dmm in a
> > more dynamic way, or to enable some additional features which are
> > still on the roadmap (like reprogramming dmm synchronized w/ scanout,
> > or some things which are coming if future hw generations).  We need
> > one place to keep track of which buffers are potentially evictable to
> > make room for mapping a new buffer.  And if you look at the tricks
> > that go on with mmap'ing tiled buffers to userspace, you *really*
> > don't want to duplicate that in N different drivers.
>=20
> So why can't all that code be in a tiler library/driver?

And I think we've discussed about this before, so sorry if I'm repeating
myself. I just find it odd that we are not able to create a nice
separate lib/driver for the tiler, which is a separate piece of HW that
multiple drivers might want to use.

 Tomi


--=-YSQXdAHo4RQTkKuKyv8l
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAABAgAGBQJPveGCAAoJEPo9qoy8lh71bgMQAJBPq9gnaycQhGWAtAdc0aRQ
ladIKzKXTdQ0hsLyGGjxC3jT8DnXhcgWAslIAUhOiWGTS13W6RCZNmDXXg1MBNWd
O+sy9iYrlNgqDCHcU1Ddky2TnCIlLyX7gDEqGrVxMZz4ICiwG//gMqSSxuGzMDVP
5bGslIBAI+wsEkuvNp+1r8dnwPrlw+sIdWoSBK+Pci7JU0Dtywr9DdWLJe7e8xrN
RGeQrUiDqiGfU+E/NDGBu/vl72ymED/SAQ2M9CRpbDXw4CyoNK9NJ59RR9HDA1Dq
gyxJ+jghw6l6t29q8gYLZdk/SDuFX3L1dFJ8pCp18VxzwRLh/N0Fj5KWqiq3i4GE
MXMNyfaTBTbmT7l1qeLDb+w4Nj65bgKPBcHpkE6CppaLOJu9hOQr/kTCjfz87Uh1
Y+24pM/ZsELyjgBWXYffax4E7d4Eu6O5k3jyiyrINRDkmlyPoIJqNR7Ex5LN9g3s
CZKF3YQjq13chFfNAjBo4MnVZC40KLzEA+to9CrNI+LkNQeSTKHeM+ZtBk30lCBo
Rukq3j6jKJcyFt7P+oyCyxfXpRlz/z73/E0Tc7fWe4n+n5H+4DYNJZOcGrpkUx/g
AZcVDEOnnwnOXF9AznNB1luaWXKYkR5aFd64T8AAnrlM/yxaETDD2FLLlm45FAr8
s/KsoEWsft6WQgXaTsny
=CEXg
-----END PGP SIGNATURE-----

--=-YSQXdAHo4RQTkKuKyv8l--


--===============1525384295==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
dri-devel mailing list
dri-devel@lists.freedesktop.org
http://lists.freedesktop.org/mailman/listinfo/dri-devel

--===============1525384295==--
