From: Vinod Koul <vinod.koul-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: Re: [GIT PULL for 4.4] DT/dmaengine: edma: Update for the new
 bindings
Date: Thu, 10 Dec 2015 08:45:09 +0530
Message-ID: <20151210031509.GI1854@localhost>
References: <56680C1A.3050009@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <56680C1A.3050009-l0cyMroinI0@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Peter Ujfalusi <peter.ujfalusi-l0cyMroinI0@public.gmane.org>
Cc: Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>, Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, linux-omap <linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>, "Nori, Sekhar" <nsekhar-l0cyMroinI0@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

On Wed, Dec 09, 2015 at 01:10:18PM +0200, Peter Ujfalusi wrote:
> Hi Arnd, Vinod,
>=20
> As Arnd suggested, the two patch from the following series:
> https://www.mail-archive.com/linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org/msg122201.htm=
l
>=20
> plus Acked-by from Arnd is available for pull if you prefer that way.

Sorry saw this after I pushed out the fixes/edma..

>=20
>=20
> Regards,
> P=E9ter
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> The following changes since commit 8005c49d9aea74d382f474ce11afbbc7d7=
130bec:
>=20
>   Linux 4.4-rc1 (2015-11-15 17:00:27 -0800)
>=20
> are available in the git repository at:
>=20
>   https://github.com/omap-audio/linux-audio.git for-4.4/peter/edma_bi=
nding_update
>=20
> for you to fetch changes up to af9089852e0ecd6ae7336992d29b04d7d82b40=
4a:
>=20
>   dmaengine: edma: DT: Change reserved slot array from 16bit to 32bit=
 type (2015-12-09 11:56:56 +0200)
>=20
> ----------------------------------------------------------------
> Peter Ujfalusi (2):
>       dmaengine: edma: DT: Change memcpy channel array from 16bit to =
32bit type
>       dmaengine: edma: DT: Change reserved slot array from 16bit to 3=
2bit type
>=20
>  Documentation/devicetree/bindings/dma/ti-edma.txt | 10 ++++------
>  drivers/dma/edma.c                                | 53 +++++++++++++=
++++++++++++++++++++++------------------
>  include/linux/platform_data/edma.h                |  2 +-
>  3 files changed, 40 insertions(+), 25 deletions(-)

--=20
~Vinod
--
To unsubscribe from this list: send the line "unsubscribe devicetree" i=
n
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
