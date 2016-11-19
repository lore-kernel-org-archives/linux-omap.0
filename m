From: Joshua Clayton <stillcompiling-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [RFC 2/6] drm/etnaviv: allow building etnaviv on omap devices
Date: Sat, 19 Nov 2016 03:58:15 -0800
Message-ID: <2481825.ONQ5ft592J@diplodocus>
References: <20161118024436.13447-1-robertcnelson@gmail.com> <20161118024436.13447-2-robertcnelson@gmail.com> <20161118163342.5t2tbsw54k2gmqe3@rob-hp-laptop>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20161118163342.5t2tbsw54k2gmqe3@rob-hp-laptop>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
Cc: Rob Herring <robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Robert Nelson <robertcnelson-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org, Christian Gmeiner <christian.gmeiner-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Russell King <rmk+kernel-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Lucas Stach <l.stach-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

On Friday, November 18, 2016 10:33:42 AM Rob Herring wrote:
> On Thu, Nov 17, 2016 at 08:44:32PM -0600, Robert Nelson wrote:
> > Signed-off-by: Robert Nelson <robertcnelson-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
> > CC: Christian Gmeiner <christian.gmeiner-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
> > CC: Russell King <rmk+kernel-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>
> > CC: Lucas Stach <l.stach-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
> > ---
> >  drivers/gpu/drm/etnaviv/Kconfig | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >=20
> > diff --git a/drivers/gpu/drm/etnaviv/Kconfig b/drivers/gpu/drm/etna=
viv/Kconfig
> > index 2cde7a5..b776f41 100644
> > --- a/drivers/gpu/drm/etnaviv/Kconfig
> > +++ b/drivers/gpu/drm/etnaviv/Kconfig
> > @@ -2,7 +2,7 @@
> >  config DRM_ETNAVIV
> >  =09tristate "ETNAVIV (DRM support for Vivante GPU IP cores)"
> >  =09depends on DRM
> > -=09depends on ARCH_MXC || ARCH_DOVE
> > +=09depends on ARCH_MXC || ARCH_DOVE || ARCH_OMAP2PLUS
>=20
> Why not just drop this line. Then it will get better build testing, t=
oo.
>=20
> >  =09select SHMEM
> >  =09select TMPFS
> >  =09select IOMMU_API
>=20
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
...building with ARCH=3Dx86_64
            ^
drivers/gpu/drm/etnaviv/etnaviv_gpu.c: In function =E2=80=98etnaviv_gpu=
_init=E2=80=99:
drivers/gpu/drm/etnaviv/etnaviv_gpu.c:633:18: error: =E2=80=98PHYS_OFFS=
ET=E2=80=99 undeclared (first use in this function)
   if (dma_mask < PHYS_OFFSET + SZ_2G)
                  ^
drivers/gpu/drm/etnaviv/etnaviv_gpu.c:633:18: note: each undeclared ide=
ntifier is reported only once for each function it appears in
make[4]: *** [scripts/Makefile.build:290: drivers/gpu/drm/etnaviv/etnav=
iv_gpu.o] Error 1
make[3]: *** [scripts/Makefile.build:440: drivers/gpu/drm/etnaviv] Erro=
r 2
make[2]: *** [scripts/Makefile.build:440: drivers/gpu/drm] Error 2
make[1]: *** [scripts/Makefile.build:440: drivers/gpu] Error 2
make: *** [Makefile:968: drivers] Error 2


...looks like this snippit is the only (compile time) problem:
=20
 622         /*
 623          * Set the GPU linear window to be at the end of the DMA w=
indow, where
 624          * the CMA area is likely to reside. This ensures that we =
are able to
 625          * map the command buffers while having the linear window =
overlap as
 626          * much RAM as possible, so we can optimize mappings for o=
ther buffers.
 627          *
 628          * For 3D cores only do this if MC2.0 is present, as with =
MC1.0 it leads
 629          * to different views of the memory on the individual engi=
nes.
 630          */
 631         if (!(gpu->identity.features & chipFeatures_PIPE_3D) ||
 632             (gpu->identity.minor_features0 & chipMinorFeatures0_MC=
20)) {
 633                 u32 dma_mask =3D (u32)dma_get_required_mask(gpu->d=
ev);
 634                 if (dma_mask < PHYS_OFFSET + SZ_2G)
 635                         gpu->memory_base =3D PHYS_OFFSET;
 636                 else
 637                         gpu->memory_base =3D dma_mask - SZ_2G + 1;=

 638         }

Joshua
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
