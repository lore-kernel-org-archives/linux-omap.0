From: "Felipe Balbi" <felipebalbi@users.sourceforge.net>
Subject: Re: [PATCH] Performance enhancement for MMCSD when feature CONFIG_MMC_BLOCK_BOUNCE is enabled in the MMC core
Date: Thu, 15 May 2008 16:30:10 +0300
Message-ID: <31e679430805150630h194f6c93j5b67ef7a9d41917e@mail.gmail.com>
References: <B85A65D85D7EB246BE421B3FB0FBB593010A9B60D4@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from fg-out-1718.google.com ([72.14.220.156]:15027 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751424AbYEONaM (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 15 May 2008 09:30:12 -0400
Received: by fg-out-1718.google.com with SMTP id 19so340174fgg.17
        for <linux-omap@vger.kernel.org>; Thu, 15 May 2008 06:30:11 -0700 (PDT)
In-Reply-To: <B85A65D85D7EB246BE421B3FB0FBB593010A9B60D4@dbde02.ent.ti.com>
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Kumar, Purushotam" <purushotam@ti.com>
Cc: "linux-omap-open-source@linux.omap.com" <linux-omap-open-source@linux.omap.com>, "Gole, Anant" <anantgole@ti.com>, linux-omap@vger.kernel.org

Hi,

this list moved to linux-omap@vger.kernel.org ;-)

On Thu, May 15, 2008 at 4:25 PM, Kumar, Purushotam <purushotam@ti.com> wrote:
> This patch will increase performance significantly. In my testing with a SD Extreme III high speed 2GB SD card using FAT file system on OMAP35X TI EVM, write speed has improved by 2x whereas read speed has improved by 3 times for MMCSD when CONFIG_MMC_BLOCK_BOUNCE is enabled.  It is supposed that larger/bounce buffers will be used by mmc core if CONFIG_MMC_BLOCK_BOUNCE is defined. But, in the mmc core, size of buffer is set to mmc->max_req_size if mmc->max_req_size is smaller than MMC_QUEUE_BOUNCESZ i.e. bounce buffer size (which is 64KB). By default, mmc->max_req_size is set to 4K. So, buffers of 4K will be used instead of 64K even if CONFIG_MMC_BLOCK_BOUNCE is defined without this patch. This patches forces mmc core to use bounce buffer of size MMC_QUEUE_BOUNCESZ and so performance is 
 increased.
>
> Signed-off-by: Purushotam Kumar <purushotam@ti.com>
> ---
> Index: linux-omap-2.6/drivers/mmc/host/omap_hsmmc.c
> ===================================================================
> --- linux-omap-2.6.orig/drivers/mmc/host/omap_hsmmc.c
> +++ linux-omap-2.6/drivers/mmc/host/omap_hsmmc.c
> @@ -782,6 +782,15 @@ static int __init omap_mmc_probe(struct
>                else
>                        host->dbclk_enabled = 1;
>
> +#ifdef CONFIG_MMC_BLOCK_BOUNCE
> +       mmc->max_phys_segs = 1;
> +       mmc->max_hw_segs = 1;
> +#endif
> +       mmc->max_blk_size = 512;       /* Block Length at max can be 1024 */
> +       mmc->max_blk_count = 0xFFFF;    /* No. of Blocks is 16 bits */
> +       mmc->max_req_size = mmc->max_blk_size * mmc->max_blk_count;
> +       mmc->max_seg_size = mmc->max_req_size;
> +
>        mmc->ocr_avail = mmc_slot(host).ocr_mask;
>        mmc->caps |= MMC_CAP_MULTIWRITE | MMC_CAP_MMC_HIGHSPEED |
>                                MMC_CAP_SD_HIGHSPEED;

Do you have any measurements results to share :-p

-- 
Best Regards,

Felipe Balbi
felipebalbi@users.sourceforge.net
