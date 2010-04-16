From: Vimal Singh <vimal.newwork@gmail.com>
Subject: Re: [PATCH 3/6] OMAP NAND: configurable fifo threshold to gain the
	throughput
Date: Fri, 16 Apr 2010 18:15:01 +0530
Message-ID: <p2tce9ab5791004160545ye1d56355r506e0e9573c27d99@mail.gmail.com>
References: <s-ghorai@ti.com> <1271417714-4408-1-git-send-email-s-ghorai@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-yw0-f194.google.com ([209.85.211.194]:40962 "EHLO
	mail-yw0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753120Ab0DPMpW (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 16 Apr 2010 08:45:22 -0400
Received: by ywh32 with SMTP id 32so1317518ywh.33
        for <linux-omap@vger.kernel.org>; Fri, 16 Apr 2010 05:45:21 -0700 (PDT)
In-Reply-To: <1271417714-4408-1-git-send-email-s-ghorai@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Sukumar Ghorai <s-ghorai@ti.com>
Cc: linux-mtd@lists.infradead.org, sbranden@broadcom.com, leochen@broadcom.com, David.Woodhouse@intel.com, linux-omap@vger.kernel.org, tony@atomide.com, Vimal Singh <vimalsingh@ti.com>

Hi Ghorai,

On Fri, Apr 16, 2010 at 5:05 PM, Sukumar Ghorai <s-ghorai@ti.com> wrote:
[...]
> -       ret = gpmc_prefetch_enable(info->gpmc_cs, 0x0, len, 0x0);
> +       ret = gpmc_prefetch_enable(info->gpmc_cs, 0x40, 0x0, len, 0x0);

Use macros here too then.

>        if (ret) {
>                /* PFPW engine is busy, use cpu copy method */
>                if (info->nand.options & NAND_BUSWIDTH_16)
> @@ -354,7 +354,7 @@ static void omap_write_buf_pref(struct mtd_info *mtd,
>        }
>
>        /*  configure and start prefetch transfer */
> -       ret = gpmc_prefetch_enable(info->gpmc_cs, 0x0, len, 0x1);
> +       ret = gpmc_prefetch_enable(info->gpmc_cs, 0x40, 0x0, len, 0x1);

here too

>        if (ret) {
>                /* PFPW engine is busy, use cpu copy method */
>                if (info->nand.options & NAND_BUSWIDTH_16)
> @@ -405,10 +405,11 @@ static inline int omap_nand_dma_transfer(struct mtd_info *mtd, void *addr,
>        dma_addr_t dma_addr;
>        int ret;
>
> -       /* The fifo depth is 64 bytes. We have a sync at each frame and frame
> -        * length is 64 bytes.
> +       /* The fifo depth is 64 bytes max.
> +        * But configure the FIFO-threahold to 32 to get a sync at each frame
> +        * and frame length is 32 bytes.
>         */
> -       int buf_len = len >> 6;
> +       int buf_len = len >> 5;
>
>        if (addr >= high_memory) {
>                struct page *p1;
> @@ -447,7 +448,7 @@ static inline int omap_nand_dma_transfer(struct mtd_info *mtd, void *addr,
>                                        OMAP24XX_DMA_GPMC, OMAP_DMA_SRC_SYNC);
>        }
>        /*  configure and start prefetch transfer */
> -       ret = gpmc_prefetch_enable(info->gpmc_cs, 0x1, len, is_write);
> +       ret = gpmc_prefetch_enable(info->gpmc_cs, 0x20, 0x1, len, is_write);
>        if (ret)
>                /* PFPW engine is busy, use cpu copy methode */
>                goto out_copy;
> @@ -524,6 +525,7 @@ static void omap_write_buf_dma_pref(struct mtd_info *mtd,
>  static irqreturn_t omap_nand_irq(int this_irq, void *dev)
>  {
>        struct omap_nand_info *info = (struct omap_nand_info *) dev;
> +       u32 *p = (u32 *) info->buf;
>        u32 irq_enb = 0, pref_status = 0, bytes = 0;
>        u32 irq_stats = __raw_readl(info->gpmc_baseaddr + GPMC_IRQSTATUS);
>        u32 pref_config = __raw_readl(info->gpmc_baseaddr +
> @@ -533,14 +535,11 @@ static irqreturn_t omap_nand_irq(int this_irq, void *dev)
>                if (irq_stats & 0x2)
>                        goto done;
>
> -               u32 *p = (u32 *) info->buf;
> -               pref_status = gpmc_prefetch_status();
> -               bytes = ((pref_status >> 24) & 0x7F);
> +               bytes = PREFETCH_FIFOTHRESHOLD_WRITE;

By this, you are not really keeping prefetch the busyest.
you are filling only 'PREFETCH_FIFOTHRESHOLD_WRITE' bytes, while there
could be more free spaces.
Previous way of doing it was more efficent.

>                iowrite32_rep(info->nand_pref_fifo_add, p, bytes >> 2);
>                info->buf = info->buf + bytes;
>
>        } else {
> -               u32 *p = (u32 *) info->buf;
>                pref_status = gpmc_prefetch_status();
>                bytes = ((pref_status >> 24) & 0x7F);
>                ioread32_rep(info->nand_pref_fifo_add, p, bytes >> 2);
> @@ -586,7 +585,8 @@ static void omap_read_buf_irq_pref(struct mtd_info *mtd, u_char *buf, int len)
>        init_completion(&info->comp);
>
>        /*  configure and start prefetch transfer */
> -       ret = gpmc_prefetch_enable(info->gpmc_cs, 0x0, len, 0x0);
> +       ret = gpmc_prefetch_enable(info->gpmc_cs,
> +                               PREFETCH_FIFOTHRESHOLD_READ, 0x0, len, 0x0);
>        if (ret)
>                /* PFPW engine is busy, use cpu copy methode */
>                goto out_copy;
> @@ -630,7 +630,8 @@ static void omap_write_buf_irq_pref(struct mtd_info *mtd,
>        init_completion(&info->comp);
>
>        /*  configure and start prefetch transfer */
> -       ret = gpmc_prefetch_enable(info->gpmc_cs, 0x0, len, 0x1);
> +       ret = gpmc_prefetch_enable(info->gpmc_cs,
> +                               PREFETCH_FIFOTHRESHOLD_WRITE, 0x0, len, 0x1);

In case of write, in my experiments, fifo thresholed '24' was the best
compromise for throughput and cpu load.


Regards,
Vimal
