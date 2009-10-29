From: Sergey Lapin <slapinid@gmail.com>
Subject: OMAP3 SDMA + RFBI_PARAM register
Date: Thu, 29 Oct 2009 19:14:43 +0300
Message-ID: <48239d390910290914n323cd057tb83fc6bacd01f3a8@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-ew0-f209.google.com ([209.85.219.209]:54186 "EHLO
	mail-ew0-f209.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753607AbZJ2QUv (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 29 Oct 2009 12:20:51 -0400
Received: by ewy5 with SMTP id 5so160502ewy.37
        for <linux-omap@vger.kernel.org>; Thu, 29 Oct 2009 09:20:54 -0700 (PDT)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, Alexander Shishkin <alexander.shishckin@gmail.com>

Hi, all!

I need to transfer block of data using sDMA from memory address
to RFBI_PARAM FIFO, so to put that into display module.

I do this like this:

/* DMA */
#define RFBI_BASE 0x48050800
#define RFBI_PARAM 0x0050
static void configure_dma(int dma_ch, u32 data, int size)
{
        int nblk;
        omap_set_dma_dest_params(dma_ch, 0, OMAP_DMA_AMODE_CONSTANT,
                (RFBI_BASE + RFBI_PARAM), 0, 0);
        omap_set_dma_src_params(dma_ch, 0, OMAP_DMA_AMODE_POST_INC,
                data, 0, 0);
        nblk = (size + PAGE_SIZE - 1) / PAGE_SIZE;
        omap_set_dma_transfer_params(dma_ch, OMAP_DMA_DATA_TYPE_S8,
                PAGE_SIZE, nblk, OMAP_DMA_SYNC_FRAME, 0, 0);
        omap_start_dma(dma_ch);
}

/*
 * DMA call back function
 */
static void hx8340_dma_cb(int lch, u16 ch_status, void *data)
{
        if (ch_status & OMAP2_DMA_MISALIGNED_ERR_IRQ)
                dev_dbg(hx8340.fbdev->dev, "Misaligned access\n");
        if (hx8340.dma_ch < 0)
                return;
        omap_free_dma(hx8340.dma_ch);
        hx8340.dma_ch = -1;
}

/* data is physical address of buffer */
static int transfer_dma(u32 data, int size)
{
        int ret = 0;
        int i;
        if (hx8340.dma_ch != -1) {
                set_current_state(TASK_UNINTERRUPTIBLE);
                schedule_timeout(100);
                omap_free_dma(hx8340.dma_ch);
                return ret;
        }
        ret = omap_request_dma(OMAP34XX_DSS_DMA3, "HX8340",
hx8340_dma_cb, NULL, &hx8340.dma_ch);
        if (ret != 0) {
                printk("HX8340: dma request failure\n");
                return ret;
        }
        configure_dma(hx8340.dma_ch, data, size);
        return 0;
}
But all I get is
DMA transaction error with device 75

Is what I try to achieve at all possible? At RFBI part of CPU
datasheet it is mentioned it is possible using sDMA
to write these registers. So, is there some examples? I tried to use
drivers/mmc/host/omap_hsmmc.c as example,
but that seems to be not enough. Any ideas?

S.
