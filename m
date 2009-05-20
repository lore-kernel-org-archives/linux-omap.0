From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH 5/7] omap iommu: entries for Kconfig and Makefile
Date: Wed, 20 May 2009 16:40:53 +0300
Message-ID: <94a0d4530905200640l76687115i83cf0e9e2585acf6@mail.gmail.com>
References: <20090520064211.24734.80725.stgit@oreo.research.nokia.com>
	 <20090520064232.24734.19153.stgit@oreo.research.nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from fg-out-1718.google.com ([72.14.220.156]:45877 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751126AbZETNky convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 20 May 2009 09:40:54 -0400
Received: by fg-out-1718.google.com with SMTP id 16so160835fgg.17
        for <linux-omap@vger.kernel.org>; Wed, 20 May 2009 06:40:54 -0700 (PDT)
In-Reply-To: <20090520064232.24734.19153.stgit@oreo.research.nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Hiroshi DOYU <Hiroshi.DOYU@nokia.com>
Cc: linux-arm-kernel@lists.arm.linux.org.uk, linux-omap@vger.kernel.org, h-kanigeri2@ti.com, omar.ramirez@ti.com, sakari.ailus@maxwell.research.nokia.com, tony@atomide.com

On Wed, May 20, 2009 at 9:42 AM, Hiroshi DOYU <Hiroshi.DOYU@nokia.com> =
wrote:
> Signed-off-by: Hiroshi DOYU <Hiroshi.DOYU@nokia.com>
> ---
>
> =C2=A0arch/arm/plat-omap/Kconfig =C2=A0| =C2=A0 =C2=A06 ++++++
> =C2=A0arch/arm/plat-omap/Makefile | =C2=A0 =C2=A01 +
> =C2=A02 files changed, 7 insertions(+), 0 deletions(-)
>
> diff --git a/arch/arm/plat-omap/Kconfig b/arch/arm/plat-omap/Kconfig
> index 9dd68fa..30e47a3 100644
> --- a/arch/arm/plat-omap/Kconfig
> +++ b/arch/arm/plat-omap/Kconfig
> @@ -115,6 +115,12 @@ config OMAP_MBOX_FWK
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0Say Y here if you want to use OMAP =
Mailbox framework support for
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0DSP, IVA1.0 and IVA2 in OMAP1/2/3.
>
> +config OMAP_IOMMU
> + =C2=A0 =C2=A0 =C2=A0 tristate "IOMMU support"

Should be:
+       tristate

As Russell suggested there's not point in letting users manually
enable or disable it. It only makes sense when you use camera or dsp.

> + =C2=A0 =C2=A0 =C2=A0 help
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 Say Y here if you want to use OMAP IOMM=
U support for IVA2 and
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 Camera in OMAP3.
> +
> =C2=A0choice
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 prompt "System timer"
> =C2=A0 =C2=A0 =C2=A0 =C2=A0default OMAP_MPU_TIMER
> diff --git a/arch/arm/plat-omap/Makefile b/arch/arm/plat-omap/Makefil=
e
> index 04a100c..a832795 100644
> --- a/arch/arm/plat-omap/Makefile
> +++ b/arch/arm/plat-omap/Makefile
> @@ -13,6 +13,7 @@ obj- =C2=A0:=3D
> =C2=A0obj-$(CONFIG_ARCH_OMAP16XX) +=3D ocpi.o
>
> =C2=A0obj-$(CONFIG_OMAP_MCBSP) +=3D mcbsp.o
> +obj-$(CONFIG_OMAP_IOMMU) +=3D iommu.o iovmm.o
>
> =C2=A0obj-$(CONFIG_CPU_FREQ) +=3D cpu-omap.o
> =C2=A0obj-$(CONFIG_OMAP_DM_TIMER) +=3D dmtimer.o
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap"=
 in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =C2=A0http://vger.kernel.org/majordomo-info.ht=
ml
>



--=20
=46elipe Contreras
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
