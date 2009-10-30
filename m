From: Venkatraman S <svenkatr@gmail.com>
Subject: Re: [PATCH] Fix race condition in omap_request_dma()
Date: Fri, 30 Oct 2009 22:52:20 +0530
Message-ID: <618f0c910910301022m313cc0f3sb3f1f3439571d950@mail.gmail.com>
References: <F12CE1A68F023D498A2691C7B539311503B17F61@ZMY16EXM66.ds.mot.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-px0-f179.google.com ([209.85.216.179]:50951 "EHLO
	mail-px0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932137AbZJ3RWR convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 30 Oct 2009 13:22:17 -0400
Received: by pxi9 with SMTP id 9so1959595pxi.4
        for <linux-omap@vger.kernel.org>; Fri, 30 Oct 2009 10:22:21 -0700 (PDT)
In-Reply-To: <F12CE1A68F023D498A2691C7B539311503B17F61@ZMY16EXM66.ds.mot.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: HU TAO-TGHK48 <taohu@motorola.com>
Cc: linux-omap@vger.kernel.org, Tony Lindgren <tony@atomide.com>, Yang Fei-AFY095 <fei.yang@motorola.com>, jon-hunter@ti.com, Zhou Ming-a17711 <a17711@motorola.com>, "Ye Yuan.Bo-A22116" <yuan-bo.ye@motorola.com>

On Fri, Oct 30, 2009 at 9:00 AM, HU TAO-TGHK48 <taohu@motorola.com> wro=
te:
> From a36dac7ee6140ffa23f0adc024964aaf3e266e5f Mon Sep 17 00:00:00 200=
1
> From: Tao Hu <taohu@motorola.com>
> Date: Thu, 29 Oct 2009 17:17:21 -0500
> Subject: [PATCH] Fix race condition in omap_request_dma()
>
> The bug could cause irq enable bit of one DMA channel is
> cleared unexpectedly when 2 (or more) drivers are calling
> omap_request_dma() simultaneously
>
> Signed-off-by: Fei Yang <AFY095@motorola.com>
> Signed-off-by: Tao Hu =A0<taohu@motorola.com>
> ---
> =A0arch/arm/plat-omap/dma.c | =A0 =A02 ++
> =A01 files changed, 2 insertions(+), 0 deletions(-)
>
> diff --git a/arch/arm/plat-omap/dma.c b/arch/arm/plat-omap/dma.c
> index cd53b28..6895484 100755
> --- a/arch/arm/plat-omap/dma.c
> +++ b/arch/arm/plat-omap/dma.c
> @@ -749,11 +749,13 @@ int omap_request_dma(int dev_id, const char
> *dev_name,
> =A0 =A0 =A0 =A0}
>
> =A0 =A0 =A0 =A0if (cpu_class_is_omap2()) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 spin_lock_irqsave(&dma_chan_lock, flags=
);
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0omap2_enable_irq_lch(free_ch);
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0omap_enable_channel_irq(free_ch);
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0/* Clear the CSR register and IRQ stat=
us register */
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0dma_write(OMAP2_DMA_CSR_CLEAR_MASK, CS=
R(free_ch));
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0dma_write(1 << free_ch, IRQSTATUS_L0);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 spin_unlock_irqrestore(&dma_chan_lock, =
flags);
> =A0 =A0 =A0 =A0}

Nice catch. I think the lock needs to be applied only for the global
registers which are changed using the read - update - write method.
The dma_write to per channel configuration registers need not be
locked.
Hence the lock is better placed "within" omap2_enable_irq_lch
function. That way, if it's reused, the locking would also be in
place.
Thank you !
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
