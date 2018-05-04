From: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
Subject: Re: [PATCH] drivers: omap2: Kconfig: make FB_OMAP2_DSS_INIT depend
 on OF
Date: Fri, 4 May 2018 07:59:06 -0300
Message-ID: <20180504075906.02ecf32e@vento.lan>
References: <20180420112551.27027-1-anders.roxell@linaro.org>
        <CGME20180503154901epcas2p417fd08a4daaf1520ec4d8ed1312728c8@epcas2p4.samsung.com>
        <16e74acc-1265-faec-0c36-49681a7760e4@infradead.org>
        <44871995.YYHkG5ofpC@amdc3058>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <44871995.YYHkG5ofpC@amdc3058>
Sender: linux-kernel-owner@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Cc: Randy Dunlap <rdunlap@infradead.org>, Anders Roxell <anders.roxell@linaro.org>, tomi.valkeinen@ti.com, linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

Em Fri, 04 May 2018 12:48:46 +0200
Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com> escreveu:

> On Thursday, May 03, 2018 08:48:56 AM Randy Dunlap wrote:
> > On 04/20/2018 04:25 AM, Anders Roxell wrote: =20
> > > Commit 7378f1149884 ("media: omap2: omapfb: allow building it with
> > > COMPILE_TEST") broke compilation without CONFIG_OF selected.
> > >   CC      drivers/video/fbdev/core/fbmem.o
> > > drivers/video/fbdev/omap2/omapfb/dss/omapdss-boot-init.c: In function=
 =E2=80=98omapdss_update_prop=E2=80=99:
> > > drivers/video/fbdev/omap2/omapfb/dss/omapdss-boot-init.c:68:2: error:=
 implicit declaration of function =E2=80=98of_update_property=E2=80=99; did=
 you mean =E2=80=98of_get_property=E2=80=99? [-Werror=3Dimplicit-function-d=
eclaration]
> > >   of_update_property(node, prop);
> > >   ^~~~~~~~~~~~~~~~~~
> > >   of_get_property
> > > cc1: some warnings being treated as errors
> > > scripts/Makefile.build:312: recipe for target 'drivers/video/fbdev/om=
ap2/omapfb/dss/omapdss-boot-init.o' failed
> > > make[7]: *** [drivers/video/fbdev/omap2/omapfb/dss/omapdss-boot-init.=
o] Error 1
> > > scripts/Makefile.build:559: recipe for target 'drivers/video/fbdev/om=
ap2/omapfb/dss' failed
> > > make[6]: *** [drivers/video/fbdev/omap2/omapfb/dss] Error 2
> > > make[6]: *** Waiting for unfinished jobs....
> > >=20
> > > Add OF dependency in order to make all configurations work again.
> > >=20
> > > of_update_property() has no inline stub, and that that could be added=
 as
> > > an alternative.
> > >=20
> > > Signed-off-by: Anders Roxell <anders.roxell@linaro.org>
> > > ---
> > >  drivers/video/fbdev/omap2/Kconfig | 2 +-
> > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > >=20
> > > diff --git a/drivers/video/fbdev/omap2/Kconfig b/drivers/video/fbdev/=
omap2/Kconfig
> > > index 82008699d253..4de381f2452e 100644
> > > --- a/drivers/video/fbdev/omap2/Kconfig
> > > +++ b/drivers/video/fbdev/omap2/Kconfig
> > > @@ -1,4 +1,4 @@
> > > -if ARCH_OMAP2PLUS || COMPILE_TEST
> > > +if OF && (ARCH_OMAP2PLUS || COMPILE_TEST)
> > > =20
> > >  source "drivers/video/fbdev/omap2/omapfb/Kconfig"
> > > =20
> > >  =20
> >=20
> > Hi,
> >=20
> > This patch certainly fixes the build errors that I have been seeing in
> > linux-next for several days now, so:
> >=20
> > Acked-by: Randy Dunlap <rdunlap@infradead.org>
> > Tested-by: Randy Dunlap <rdunlap@infradead.org> =20
>=20
> Thanks.
>=20
> Since there has been no follow up from Mauro on this ([1]) I guess
> that the best thing I can do is simply merging both patches to fbdev
> tree..
>=20
> [1] https://www.spinics.net/lists/linux-media/msg132583.html

Sorry, it seems I missed it. If you didn't merge them yet, I'll
merge it on my tree today, if you think it would be best to have
it together with the patch that enabled FB_OMAP builds with
COMPILE_TEST.

If you prefer, instead, feel free to merge via your tree, as this is
FB stuff anyway.

If you need/want:

Acked-by: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>



Thanks,
Mauro
