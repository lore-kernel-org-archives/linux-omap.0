From: Kyungmin Park <kyungmin.park@samsung.com>
Subject: Question about DMA on omap2420
Date: Thu, 11 May 2006 18:20:44 +0900
Message-ID: <004101c674dc$2e45a0a0$c7a3580a@swcenter.sec.samsung.co.kr>
Reply-To: kyungmin.park@samsung.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ks_c_5601-1987
Content-Transfer-Encoding: 7BIT
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

Hi

I have a problem with DMA transfer on OMAP2420.

As previous mail the MMC with DMA is working well.
Data is copied from MMC to SDRAM wirh dedicated MMC DMA.
So I think DMA routine has no problem to use

But the problem is happended when copy from GPMC (OneNAND) to SDRAM

In my understanding

DMA programming as follow.

1. omap_request_dma(OMAP24XX_DMA_NO_DEVICE, ..., dma_callback, ...);

2. dma mapping & translate virt to phys

3. set src & dest configurations
	omap_set_dma_src_params(dma->ch, 0, OMAP_DMA_AMODE_POST_INC,
src_phys, 0, 0);
	omap_set_dma_dest_params(dma->ch, 0, OMAP_DMA_AMODE_POST_INC,
dest_phys, 0, 0);
	omap_set_dma_transfer_params(dma->ch, OMAP_DMA_DATA_TYPE_S16,
                                1, count >> 1, OMAP_DMA_SYNC_ELEMENT,
                                0, 0);
	or
	omap_set_dma_transfer_params(dma->ch, OMAP_DMA_DATA_TYPE_S32,
                                1, count >> 2, OMAP_DMA_SYNC_ELEMENT,
                                0, 0);

4. start dma
	omap_start_dma(dma->ch);

5. wait until work done 
	dma_callback send wakeup

In this sequence. DMA go works well but some time later it failed.

I think data copy from GPMC to SDRAM is memory copy. so I set GPMC part as
SDRAM does

Are there any other configurations for GPMC for DMA?
E.g., I need to set OMAP24XX_DMA_GPMC instead of OMAP24XX_DMA_NO_DEVICE.
       or need to set dma_trigger?

Thanks you
Kyungmin Park
