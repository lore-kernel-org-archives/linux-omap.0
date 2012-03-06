From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: Re: [PATCH] omap2+: add drm device
Date: Tue, 06 Mar 2012 16:35:44 +0200
Message-ID: <1331044544.2059.150.camel@deskari>
References: <1330966464-28662-1-git-send-email-rob.clark@linaro.org>
	<1331040371.2059.113.camel@deskari>
	<CAF6AEGs74aygOjFLKSxmZNoo1YC3yuW4aNqHLGO8bifcAwkjKg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1123010714=="
Return-path: <dri-devel-bounces+sf-dri-devel=m.gmane.org@lists.freedesktop.org>
In-Reply-To: <CAF6AEGs74aygOjFLKSxmZNoo1YC3yuW4aNqHLGO8bifcAwkjKg@mail.gmail.com>
List-Unsubscribe: <http://lists.freedesktop.org/mailman/options/dri-devel>,
	<mailto:dri-devel-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <http://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <http://lists.freedesktop.org/mailman/listinfo/dri-devel>,
	<mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Sender: dri-devel-bounces+sf-dri-devel=m.gmane.org@lists.freedesktop.org
Errors-To: dri-devel-bounces+sf-dri-devel=m.gmane.org@lists.freedesktop.org
To: Rob Clark <rob.clark@linaro.org>
Cc: Greg KH <greg@kroah.com>, linux-omap@vger.kernel.org, dri-devel@lists.freedesktop.org, patches@linaro.org
List-Id: linux-omap@vger.kernel.org


--===============1123010714==
Content-Type: multipart/signed; micalg="pgp-sha1"; protocol="application/pgp-signature"; boundary="=-zFv9DXMHOzJHLF8Jght7"


--=-zFv9DXMHOzJHLF8Jght7
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, 2012-03-06 at 08:01 -0600, Rob Clark wrote:
> On Tue, Mar 6, 2012 at 7:26 AM, Tomi Valkeinen <tomi.valkeinen@ti.com> wr=
ote:

> > Can there be more than one omapdrm device? I guess not. If so, the id
> > should be -1.
>=20
> in the past, we have used multiple devices (using the platform-data to
> divide up the dss resources), although this was sort of a
> special-case.  But in theory you could have multiple.  (Think of a
> multi-seat scenario, where multiple compositors need to run and each
> need to be drm-master of their own device to do mode-setting on their
> corresponding display.)
>=20
> I think if we use .id =3D -1, then we'd end up with a funny looking
> bus-id for the device: "platform:omapdrm:-1"

I don't know about that, but it's the way platform devices are meant to
be used if there can be only one instance. If the case where there are
multiple omapdrm devices is rather theoretical, or only used for certain
debugging scenarios or such, I think having the id as -1 in the mainline
is cleaner.

> >> +};
> >> +
> >> +static int __init omap_init_gpu(void)
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
> > The function is called omap_init_gpu(), but it doesn't do anything
> > related to the gpu... And aren't DMM and DRM totally separate things,
> > why are they bunched together like that?
>=20
> only legacy.. product branches also have sgx initialization here.  But
> I can change that to omap_init_drm()
>=20
> DMM is managed by the drm driver (and exposed to userspace as drm/gem
> buffers, shared with other devices via dma-buf, etc).  It is only
> split out to a separate device to play along with hwmod.

I have to say I don't know much about DMM, but my understanding is that
DMM is a bigger entity, of which TILER is only a small part, and DMM
manages all memory accesses.

Can there be other users for the DMM than DRM? I know there could be
other users for the TILER, and I know you want to combine that with the
DRM driver, but I'm wondering about the other parts of DMM than the
TILER.

Somehow having a DMM driver inside omapdrm sounds strange.

> >> +arch_initcall(omap_init_gpu);
> >> +
> >> +void omapdrm_reserve_vram(void)
> >> +{
> >> +#ifdef CONFIG_CMA
> >> +     /*
> >> +      * Create private 32MiB contiguous memory area for omapdrm.0 dev=
ice
> >> +      * TODO revisit size.. if uc/wc buffers are allocated from CMA p=
ages
> >> +      * then the amount of memory we need goes up..
> >> +      */
> >> +     dma_declare_contiguous(&omap_drm_device.dev, 32 * SZ_1M, 0, 0);
> >
> > What does this actually do? Does it reserve the memory, i.e. it's not
> > usable for others? If so, shouldn't there be a way for the user to
> > configure it?
>=20
> It can be re-used by others.. see http://lwn.net/Articles/479297/

The link didn't tell much. I looked at the patches, and
dma_declare_contiguous allocates the memory with memblock_alloc. So is
that allocated memory available for any users? If so, why does the
function want a device pointer as an argument...

Is the memory available for normal kmalloc, or only available via the
CMA functions? Surely there must be some downside to the above? =3D) And
if so, it should be configurable. You could have a board with no display
at all, and you probably don't want to have 32MB allocated for DRM in
that case.

 Tomi


--=-zFv9DXMHOzJHLF8Jght7
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAABAgAGBQJPViDAAAoJEPo9qoy8lh71kMoP/itytOHifLrwZ7fGRMUsHBDz
6SdjBKVLUFVgcPfN0QX1nNbijBVkeSHv4ks0CAN3LfB2BZ0DkVSWVzWbl0xeGs1f
L5PTZGWAlyOTAbrLSyzfsCjrJeA+fRdmKjW9tWNQNI6I3NOpQuyEyz3Jy/1asbV8
eOCvGLyU9y8dgMzRQiBMBb+S4oyFQKPtsivQhAwwWQLb/+pyzp8h5T61HFWqWtbj
YsvSripi19Z/NYAdF/+aC6xo5PNJEB89mKHi5lBvZR21gxUwfcuYBsMGLLH2fAjN
XiYH6SrzL4srpXkN9O2tevkLptQSCM1JVDnt0Ex0mm3j3TXpHTt5zcAl7RQo2TW1
gLxNYLbp8h05Dacy+aUzABZjymiF31Jh6AEf67e8dlvMiGtLy43jBgg0KFS6iAWz
LT4XkKmRnKQez46EAnT5M/RM/BPh6ZM1/yPPJHmKHY60gTfD8JfFYW3PoOPpwKXY
38RXy1bdNAOu6bDlZqvb+CZd6XPS2TN1wD5QXIckPvl6ExwfWMqEkVDAvBNhsAUu
1ny6A8UvPuOi3brZEJLlL1bXqz0UsVSoytT7R5v9myUyQvGVmcQp61cvG20SJPtx
kEXW79qWRcdJK923k0Exwi/ccWAi3OhwhgWyBnhd3fs1+3zVJuyGtNe6jefKH3ws
40sGXkJo4NpH6v/i9r+r
=zQWo
-----END PGP SIGNATURE-----

--=-zFv9DXMHOzJHLF8Jght7--


--===============1123010714==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
dri-devel mailing list
dri-devel@lists.freedesktop.org
http://lists.freedesktop.org/mailman/listinfo/dri-devel

--===============1123010714==--
