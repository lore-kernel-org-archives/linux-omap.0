From: Venkatraman S <svenkatr@ti.com>
Subject: Re: [PATCH v2 12/32] OMAP: PM: DMA context save/restore for off-mode
	support
Date: Fri, 23 Oct 2009 19:24:47 +0530
Message-ID: <618f0c910910230654l3a7e241esd3f838878424310b@mail.gmail.com>
References: <1256252993-24328-1-git-send-email-khilman@deeprootsystems.com>
	 <1256252993-24328-5-git-send-email-khilman@deeprootsystems.com>
	 <1256252993-24328-6-git-send-email-khilman@deeprootsystems.com>
	 <1256252993-24328-7-git-send-email-khilman@deeprootsystems.com>
	 <1256252993-24328-8-git-send-email-khilman@deeprootsystems.com>
	 <1256252993-24328-9-git-send-email-khilman@deeprootsystems.com>
	 <1256252993-24328-10-git-send-email-khilman@deeprootsystems.com>
	 <1256252993-24328-11-git-send-email-khilman@deeprootsystems.com>
	 <1256252993-24328-12-git-send-email-khilman@deeprootsystems.com>
	 <1256252993-24328-13-git-send-email-khilman@deeprootsystems.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-pw0-f42.google.com ([209.85.160.42]:58772 "EHLO
	mail-pw0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751604AbZJWNyn convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 23 Oct 2009 09:54:43 -0400
Received: by pwj9 with SMTP id 9so181045pwj.21
        for <linux-omap@vger.kernel.org>; Fri, 23 Oct 2009 06:54:47 -0700 (PDT)
In-Reply-To: <1256252993-24328-13-git-send-email-khilman@deeprootsystems.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@deeprootsystems.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Tero Kristo <tero.kristo@nokia.com>

On Fri, Oct 23, 2009 at 4:39 AM, Kevin Hilman
<khilman@deeprootsystems.com> wrote:
> From: Tero Kristo <tero.kristo@nokia.com>
>
> For HS/EMU devices, these additional features are also used:
>
> - DMA interrupt disable routine added
> - Added DMA controller reset to DMA context restore
>
> Signed-off-by: Tero Kristo <tero.kristo@nokia.com>
> Signed-off-by: Kevin Hilman <khilman@deeprootsystems.com>
> ---
> =A0arch/arm/mach-omap2/pm34xx.c =A0 =A0 =A0 =A0 =A0| =A0 =A03 ++
> =A0arch/arm/plat-omap/dma.c =A0 =A0 =A0 =A0 =A0 =A0 =A0| =A0 41 +++++=
++++++++++++++++++++++++++++
> =A0arch/arm/plat-omap/include/plat/dma.h | =A0 =A05 ++++
> =A03 files changed, 49 insertions(+), 0 deletions(-)
> =A0mode change 100644 =3D> 100755 arch/arm/plat-omap/include/plat/dma=
=2Eh
>
> diff --git a/arch/arm/mach-omap2/pm34xx.c b/arch/arm/mach-omap2/pm34x=
x.c
> index bab9b48..54fea79 100644
> --- a/arch/arm/mach-omap2/pm34xx.c
> +++ b/arch/arm/mach-omap2/pm34xx.c
> @@ -34,6 +34,7 @@
> =A0#include <plat/sdrc.h>
> =A0#include <plat/prcm.h>
> =A0#include <plat/gpmc.h>
> +#include <plat/dma.h>
>
> =A0#include <asm/tlbflush.h>
>
> @@ -95,6 +96,7 @@ static void omap3_core_save_context(void)
> =A0 =A0 =A0 =A0omap3_gpmc_save_context();
> =A0 =A0 =A0 =A0/* Save the system control module context, padconf alr=
eady save above*/
> =A0 =A0 =A0 =A0omap3_control_save_context();
> + =A0 =A0 =A0 omap_dma_global_context_save();
> =A0}
>
> =A0static void omap3_core_restore_context(void)
> @@ -105,6 +107,7 @@ static void omap3_core_restore_context(void)
> =A0 =A0 =A0 =A0omap3_gpmc_restore_context();
> =A0 =A0 =A0 =A0/* Restore the interrupt controller context */
> =A0 =A0 =A0 =A0omap_intc_restore_context();
> + =A0 =A0 =A0 omap_dma_global_context_restore();
> =A0}
>
> =A0/*
> diff --git a/arch/arm/plat-omap/dma.c b/arch/arm/plat-omap/dma.c
> index 3edffde..c0a6060 100644
> --- a/arch/arm/plat-omap/dma.c
> +++ b/arch/arm/plat-omap/dma.c
> @@ -54,6 +54,12 @@ enum { DMA_CHAIN_STARTED, DMA_CHAIN_NOTSTARTED };
>
> =A0static int enable_1510_mode;
>
> +static struct omap_dma_global_context_registers {
> + =A0 =A0 =A0 u32 dma_irqenable_l0;
> + =A0 =A0 =A0 u32 dma_ocp_sysconfig;
> + =A0 =A0 =A0 u32 dma_gcr;
> +} omap_dma_global_context;
> +
> =A0struct omap_dma_lch {
> =A0 =A0 =A0 =A0int next_lch;
> =A0 =A0 =A0 =A0int dev_id;
> @@ -2341,6 +2347,41 @@ void omap_stop_lcd_dma(void)
> =A0}
> =A0EXPORT_SYMBOL(omap_stop_lcd_dma);
>
> +void omap_dma_global_context_save(void)
> +{
> + =A0 =A0 =A0 omap_dma_global_context.dma_irqenable_l0 =3D
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 dma_read(IRQENABLE_L0);
> + =A0 =A0 =A0 omap_dma_global_context.dma_ocp_sysconfig =3D
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 dma_read(OCP_SYSCONFIG);
> + =A0 =A0 =A0 omap_dma_global_context.dma_gcr =3D dma_read(GCR);
> +}
> +EXPORT_SYMBOL(omap_dma_global_context_save);
> +
> +void omap_dma_global_context_restore(void)
> +{
> + =A0 =A0 =A0 dma_write(0x2, OCP_SYSCONFIG);
> + =A0 =A0 =A0 while (!__raw_readl(omap_dma_base + OMAP_DMA4_SYSSTATUS=
))
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 ;
> + =A0 =A0 =A0 dma_write(omap_dma_global_context.dma_gcr, GCR);
> + =A0 =A0 =A0 dma_write(omap_dma_global_context.dma_ocp_sysconfig,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 OCP_SYSCONFIG);
> + =A0 =A0 =A0 dma_write(omap_dma_global_context.dma_irqenable_l0,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 IRQENABLE_L0);
> +}
> +EXPORT_SYMBOL(omap_dma_global_context_restore);
> +
> +void omap_dma_disable_irq(int lch)
> +{
> + =A0 =A0 =A0 u32 val;
> +
> + =A0 =A0 =A0 if (cpu_class_is_omap2()) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* Disable interrupts */
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 val =3D dma_read(IRQENABLE_L0);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 val &=3D ~(1 << lch);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 dma_write(val, IRQENABLE_L0);
> + =A0 =A0 =A0 }
> +}
> +
Just curious - Doesn't it need EXPORT_SYMBOL() ?
Is this used somewhere ? If yes,
would be nice to have omap_dma_enable_irq as well

> =A0/*----------------------------------------------------------------=
------------*/
>
> =A0static int __init omap_init_dma(void)
> diff --git a/arch/arm/plat-omap/include/plat/dma.h b/arch/arm/plat-om=
ap/include/plat/dma.h
> old mode 100644
> new mode 100755
> index 72f680b..1c017b2
> --- a/arch/arm/plat-omap/include/plat/dma.h
> +++ b/arch/arm/plat-omap/include/plat/dma.h
> @@ -633,6 +633,11 @@ extern void omap_set_dma_dst_endian_type(int lch=
, enum end_type etype);
> =A0extern void omap_set_dma_src_endian_type(int lch, enum end_type et=
ype);
> =A0extern int omap_get_dma_index(int lch, int *ei, int *fi);
>
> +void omap_dma_global_context_save(void);
> +void omap_dma_global_context_restore(void);
> +
> +extern void omap_dma_disable_irq(int lch);
> +
> =A0/* Chaining APIs */
> =A0#ifndef CONFIG_ARCH_OMAP1
> =A0extern int omap_request_dma_chain(int dev_id, const char *dev_name=
,
> --
> 1.6.4.3
>
> --
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
