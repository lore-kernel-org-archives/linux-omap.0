From: "Kyungmin Park" <kmpark@infradead.org>
Subject: Re: [PATCH] Performance enhancement for MMCSD when feature CONFIG_MMC_BLOCK_BOUNCE is enabled in the MMC core
Date: Fri, 16 May 2008 10:03:45 +0900
Message-ID: <9c9fda240805151803x63d4e8eck40770a9b0e13a0e3@mail.gmail.com>
References: <B85A65D85D7EB246BE421B3FB0FBB593010A9B60D4@dbde02.ent.ti.com>
	 <31e679430805150630h194f6c93j5b67ef7a9d41917e@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from rv-out-0506.google.com ([209.85.198.229]:58109 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751279AbYEPBDs (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 15 May 2008 21:03:48 -0400
Received: by rv-out-0506.google.com with SMTP id l9so804966rvb.1
        for <linux-omap@vger.kernel.org>; Thu, 15 May 2008 18:03:46 -0700 (PDT)
In-Reply-To: <31e679430805150630h194f6c93j5b67ef7a9d41917e@mail.gmail.com>
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Felipe Balbi <felipebalbi@users.sourceforge.net>
Cc: "Kumar, Purushotam" <purushotam@ti.com>, "linux-omap-open-source@linux.omap.com" <linux-omap-open-source@linux.omap.com>, "Gole, Anant" <anantgole@ti.com>, linux-omap@vger.kernel.org

Hi,

On Thu, May 15, 2008 at 10:30 PM, Felipe Balbi
<felipebalbi@users.sourceforge.net> wrote:
> Hi,
>
> this list moved to linux-omap@vger.kernel.org ;-)
>
> On Thu, May 15, 2008 at 4:25 PM, Kumar, Purushotam <purushotam@ti.com> wrote:
>> This patch will increase performance significantly. In my testing with a SD Extreme III high speed 2GB SD card using FAT file system on OMAP35X TI EVM, write speed has improved by 2x whereas read speed has improved by 3 times for MMCSD when CONFIG_MMC_BLOCK_BOUNCE is enabled.  It is supposed that larger/bounce buffers will be used by mmc core if CONFIG_MMC_BLOCK_BOUNCE is defined. But, in the mmc core, size of buffer is set to mmc->max_req_size if mmc->max_req_size is smaller than MMC_QUEUE_BOUNCESZ i.e. bounce buffer size (which is 64KB). By default, mmc->max_req_size is set to 4K. So, buffers of 4K will be used instead of 64K even if CONFIG_MMC_BLOCK_BOUNCE is defined without this patch. This patches forces mmc core to use bounce buffer of size MMC_QUEUE_BOUNCESZ and so performance is
  increased.
>>
>> Signed-off-by: Purushotam Kumar <purushotam@ti.com>
>> ---
>> Index: linux-omap-2.6/drivers/mmc/host/omap_hsmmc.c
>> ===================================================================
>> --- linux-omap-2.6.orig/drivers/mmc/host/omap_hsmmc.c
>> +++ linux-omap-2.6/drivers/mmc/host/omap_hsmmc.c
>> @@ -782,6 +782,15 @@ static int __init omap_mmc_probe(struct
>>                else
>>                        host->dbclk_enabled = 1;
>>
>> +#ifdef CONFIG_MMC_BLOCK_BOUNCE
>> +       mmc->max_phys_segs = 1;
>> +       mmc->max_hw_segs = 1;
>> +#endif
>> +       mmc->max_blk_size = 512;       /* Block Length at max can be 1024 */
>> +       mmc->max_blk_count = 0xFFFF;    /* No. of Blocks is 16 bits */
>> +       mmc->max_req_size = mmc->max_blk_size * mmc->max_blk_count;
>> +       mmc->max_seg_size = mmc->max_req_size;
>> +
>>        mmc->ocr_avail = mmc_slot(host).ocr_mask;
>>        mmc->caps |= MMC_CAP_MULTIWRITE | MMC_CAP_MMC_HIGHSPEED |
>>                                MMC_CAP_SD_HIGHSPEED;
>
> Do you have any measurements results to share :-p
>

similar ways omap.c does, but it's almost same or degraded.
It was tested on apollon (OMAP2420)

Thank you,
Kyungmin Park

# iozone -A -s 128m -q 256k -U /mmc -f /mmc/test -e

% before
131072       4    3014    2317     6577     6575
131072       8    2918    2702     6577     6568
131072      16    2895    2287     6560     6556
131072      32    2839    2430     6567     6551
131072      64    2929    2688     6548     6545
131072     128   2956    2534     6572     6565
131072     256    2861    2356     6571     6569

% after
131072       4    2917    2784     6383     6379
131072       8    2806    2615     6377     6397
131072      16    2834    2953     6383     6379
131072      32    2844    2492     6376     6375
131072      64    2976    2625     6395     6379

Here's patch

diff --git a/drivers/mmc/host/omap.c b/drivers/mmc/host/omap.c
index 549517c..a0c0d38 100644
--- a/drivers/mmc/host/omap.c
+++ b/drivers/mmc/host/omap.c
@@ -1332,12 +1335,17 @@ static int __init mmc_omap_new_slot(struct mmc_omap_host
                mmc->f_max = min(host->pdata->max_freq, mmc->f_max);
        mmc->ocr_avail = slot->pdata->ocr_mask;

+#ifdef CONFIG_MMC_BLOCK_BOUNCE
+       mmc->max_phys_segs = 1;
+       mmc->max_hw_segs = 1;
+#else
        /* Use scatterlist DMA to reduce per-transfer costs.
         * NOTE max_seg_size assumption that small blocks aren't
         * normally used (except e.g. for reading SD registers).
         */
        mmc->max_phys_segs = 32;
        mmc->max_hw_segs = 32;
+#endif
        mmc->max_blk_size = 2048;       /* BLEN is 11 bits (+1) */
        mmc->max_blk_count = 2048;      /* NBLK is 11 bits (+1) */
        mmc->max_req_size = mmc->max_blk_size * mmc->max_blk_count;
