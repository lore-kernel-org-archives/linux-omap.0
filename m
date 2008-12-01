From: jouni.hogander@nokia.com (=?utf-8?Q?H=C3=B6gander?= Jouni)
Subject: Re: [PATCH 1/1] OMAP3: DMA: Enable idlemodes for DMA OCP
Date: Mon, 01 Dec 2008 11:06:06 +0200
Message-ID: <87zljgclj5.fsf@trdhcp146196.ntc.nokia.com>
References: <1228121725-14062-1-git-send-email-ext-kalle.jokiniemi@nokia.com>
	<1228121725-14062-2-git-send-email-ext-kalle.jokiniemi@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.233]:29901 "EHLO
	mgw-mx06.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750946AbYLAJGc convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 1 Dec 2008 04:06:32 -0500
In-Reply-To: <1228121725-14062-2-git-send-email-ext-kalle.jokiniemi@nokia.com>
	(ext Kalle Jokiniemi's message of "Mon, 1 Dec 2008 10:55:25 +0200")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: ext Kalle Jokiniemi <ext-kalle.jokiniemi@nokia.com>
Cc: linux-omap@vger.kernel.org, khilman@deeprootsystems.com, tony@atomide.com

"ext Kalle Jokiniemi" <ext-kalle.jokiniemi@nokia.com> writes:

> This patch enables MStandby smart-idle mode, autoidle smartidle mode,
> and the autoidle bit for DMA4_OCP_SYSCONFIG.
>
> Signed-off-by: Kalle Jokiniemi <ext-kalle.jokiniemi@nokia.com>
> ---
>  arch/arm/plat-omap/dma.c              |   13 +++++++++++++
>  arch/arm/plat-omap/include/mach/dma.h |   15 +++++++++++++++
>  2 files changed, 28 insertions(+), 0 deletions(-)
>
> diff --git a/arch/arm/plat-omap/dma.c b/arch/arm/plat-omap/dma.c
> index c4e5ba3..9d8d28c 100644
> --- a/arch/arm/plat-omap/dma.c
> +++ b/arch/arm/plat-omap/dma.c
> @@ -2420,6 +2420,19 @@ static int __init omap_init_dma(void)
>  	if (cpu_class_is_omap2())
>  		setup_irq(INT_24XX_SDMA_IRQ0, &omap24xx_dma_irq);
> =20
> +	/* Enable smartidle idlemodes and autoidle */
> +	if (cpu_is_omap34xx()) {

I think this can be done for omap2 also.

> +		u32 v =3D dma_read(OCP_SYSCONFIG);
> +		v &=3D ~(DMA_SYSCONFIG_MIDLEMODE_MASK |
> +				DMA_SYSCONFIG_SIDLEMODE_MASK |
> +				DMA_SYSCONFIG_AUTOIDLE);
> +		v |=3D (DMA_SYSCONFIG_MIDLEMODE(DMA_IDLEMODE_SMARTIDLE) |
> +			DMA_SYSCONFIG_SIDLEMODE(DMA_IDLEMODE_SMARTIDLE) |
> +			DMA_SYSCONFIG_AUTOIDLE);
> +		dma_write(v , OCP_SYSCONFIG);
> +	}
> +
> +
>  	/* FIXME: Update LCD DMA to work on 24xx */
>  	if (cpu_class_is_omap1()) {
>  		r =3D request_irq(INT_DMA_LCD, lcd_dma_irq_handler, 0,
> diff --git a/arch/arm/plat-omap/include/mach/dma.h
>  	b/arch/arm/plat-omap/include/mach/dma.h

--=20
Jouni H=C3=B6gander

--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
