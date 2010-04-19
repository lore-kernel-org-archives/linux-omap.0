From: Venkatraman S <svenkatr@ti.com>
Subject: Re: [PATCH v2] dma: fix scope of errata i88 upto 3430ES1.0
Date: Mon, 19 Apr 2010 16:21:54 +0530
Message-ID: <v2g618f0c911004190351h438b8d14o83a57d631eef3a2c@mail.gmail.com>
References: <w2g618f0c911004020435qd281c5deoc3e0ade84cc2d0b1@mail.gmail.com>
	 <EAF47CD23C76F840A9E7FCE10091EFAB02C4C33347@dbde02.ent.ti.com>
	 <p2i618f0c911004050819u9af37b57ob399a52006f40017@mail.gmail.com>
	 <o2h618f0c911004050836ge9222b05i6520c8c7de9336ed@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-gw0-f46.google.com ([74.125.83.46]:61496 "EHLO
	mail-gw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753273Ab0DSKv4 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 19 Apr 2010 06:51:56 -0400
Received: by gwj19 with SMTP id 19so163509gwj.19
        for <linux-omap@vger.kernel.org>; Mon, 19 Apr 2010 03:51:55 -0700 (PDT)
In-Reply-To: <o2h618f0c911004050836ge9222b05i6520c8c7de9336ed@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Santosh Shilimkar <santosh.shilimkar@ti.com>, linux-omap@vger.kernel.org

Hi Tony,
> Venkatraman S <svenkatr@ti.com> wrote:
> From 2799506180649cbb61d24cf2b4171425b2e1fa80 Mon Sep 17 00:00:00 200=
1
> From: Venkatraman S <svenkatr@ti.com>
> Date: Mon, 5 Apr 2010 20:56:27 +0530
> Subject: [PATCH] dma: fix scope of errata i88 upto 3430ES1.0
>
> DMA errata for special end of block programming is applicable
> only for OMAP2430 & OMAP3430 ES1.0.
> This patch does the necessary checks before the workaround
> is applied. Tested on 3430 SDP
>
> Signed-off-by: Thara Gopinath <thara@ti.com>
> Signed-off-by: Venkatraman S <svenkatr@ti.com>
> Reviewed-by: Shilimkar Santosh <santosh.shilimkar@ti.com>
> ---
> From v1, removed the redundant omap3430() check
>
> =A0arch/arm/plat-omap/dma.c | =A0 20 ++++++++++++--------
> =A01 files changed, 12 insertions(+), 8 deletions(-)
>
> diff --git a/arch/arm/plat-omap/dma.c b/arch/arm/plat-omap/dma.c
> index 2ab224c..a9b480a 100644
> --- a/arch/arm/plat-omap/dma.c
> +++ b/arch/arm/plat-omap/dma.c
> @@ -1663,14 +1663,17 @@ int omap_stop_dma_chain_transfers(int chain_i=
d)
> =A0 =A0 =A0 =A0channels =3D dma_linked_lch[chain_id].linked_dmach_q;
>
> =A0 =A0 =A0 =A0/*
> - =A0 =A0 =A0 =A0* DMA Errata:
> - =A0 =A0 =A0 =A0* Special programming model needed to disable DMA be=
fore end of block
> + =A0 =A0 =A0 =A0* DMA Errata: i88
> + =A0 =A0 =A0 =A0* Special programming model needed
> + =A0 =A0 =A0 =A0* to disable DMA before end of block
> =A0 =A0 =A0 =A0 */
> =A0 =A0 =A0 =A0sys_cf =3D dma_read(OCP_SYSCONFIG);
> - =A0 =A0 =A0 l =3D sys_cf;
> - =A0 =A0 =A0 /* Middle mode reg set no Standby */
> - =A0 =A0 =A0 l &=3D ~((1 << 12)|(1 << 13));
> - =A0 =A0 =A0 dma_write(l, OCP_SYSCONFIG);
> + =A0 =A0 =A0 if (cpu_is_omap2430() || (omap_rev() =3D=3D OMAP3430_RE=
V_ES1_0)) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 l =3D sys_cf;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* Middle mode reg set no Standby */
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 l &=3D ~((1 << 12)|(1 << 13));
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 dma_write(l, OCP_SYSCONFIG);
> + =A0 =A0 =A0 }
>
> =A0 =A0 =A0 =A0for (i =3D 0; i < dma_linked_lch[chain_id].no_of_lchs_=
linked; i++) {
>
> @@ -1689,8 +1692,9 @@ int omap_stop_dma_chain_transfers(int chain_id)
> =A0 =A0 =A0 =A0/* Reset the Queue pointers */
> =A0 =A0 =A0 =A0OMAP_DMA_CHAIN_QINIT(chain_id);
>
> - =A0 =A0 =A0 /* Errata - put in the old value */
> - =A0 =A0 =A0 dma_write(sys_cf, OCP_SYSCONFIG);
> + =A0 =A0 =A0 /* Errata: put back the old value */
> + =A0 =A0 =A0 if (cpu_is_omap2430() || (omap_rev() =3D=3D OMAP3430_RE=
V_ES1_0))
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 dma_write(sys_cf, OCP_SYSCONFIG);
>
> =A0 =A0 =A0 =A0return 0;
> =A0}
> --
> 1.6.3.3
>

If there are no other concerns about this patch, can you please include=
 it ?
Many thanks,
Venkat.
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
