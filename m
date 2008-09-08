From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [Resend][PATCH - Omapzoom][NAND] Add prefetch and DMA support
Date: Mon, 8 Sep 2008 19:13:19 +0100
Message-ID: <20080908181319.GH8266@flint.arm.linux.org.uk>
References: <1220897015-14338-1-git-send-email-nskamat@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([78.32.30.218]:36955 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752930AbYIHSNh (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 8 Sep 2008 14:13:37 -0400
Content-Disposition: inline
In-Reply-To: <1220897015-14338-1-git-send-email-nskamat@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: nskamat@ti.com
Cc: linux-omap@vger.kernel.org, Vimal Singh <vimalsingh@ti.com>

On Mon, Sep 08, 2008 at 01:03:35PM -0500, nskamat@ti.com wrote:
> +#ifdef CONFIG_MTD_NAND_OMAP_PREFETCH
> +	static int use_prefetch = 1;
> +
> +	/* "modprobe ... use_prefetch=0" etc */
> +	module_param(use_prefetch, bool, 0);
> +	MODULE_PARM_DESC(use_prefetch, "enable/disable use of PREFETCH");

Don't indent C code just because there's preprocessor stuff around it.

> @@ -127,6 +148,9 @@
>  	unsigned long			phys_base;
>  	void __iomem			*gpmc_cs_baseaddr;
>  	void __iomem			*gpmc_baseaddr;
> +	void __iomem			*nand_pref_fifo_add;

Ok, nand_pref_fifo_add is MMIO.

> +	struct completion		comp;
> +	int				dma_ch;
>  };
>  
>  /*
> @@ -190,6 +214,85 @@
>  		__raw_writeb(cmd, info->nand.IO_ADDR_W);
>  }
>  
> +#ifdef CONFIG_MTD_NAND_OMAP_PREFETCH_DMA
> +/*
> + * omap_nand_dma_cb: callback on the completion of dma transfer
> + * @lch: logical channel
> + * @ch_satuts: channel status
> + * @data: pointer to completion data structure
> + */
> +static void omap_nand_dma_cb(int lch, u16 ch_status, void *data)
> +{
> +	complete((struct completion *) data);
> +}
> +
> +/*
> + * omap_nand_dma_transfer: configer and start dma transfer
> + * @mtd: MTD device structure
> + * @addr: virtual address in RAM of source/destination
> + * @count: number of data bytes to be transferred
> + * @is_write: flag for read/write operation
> + */
> +static inline int omap_nand_dma_transfer(struct mtd_info *mtd, void *addr,
> +					unsigned int count, int is_write)
> +{
> +	struct omap_nand_info *info = container_of(mtd,
> +					struct omap_nand_info, mtd);
> +
> +	uint32_t prefetch_status = 0;
> +
> +	/* The fifo depth is 64 bytes. We have a synch at each frame and frame
> +	 * length is 64 bytes.
> +	 */
> +	int buf_len = count/64;
> +
> +	if (is_write) {
> +	    omap_set_dma_dest_params(info->dma_ch, 0, OMAP_DMA_AMODE_CONSTANT,
> +						info->phys_base, 0, 0);
> +	    omap_set_dma_dest_burst_mode(info->dma_ch, OMAP_DMA_DATA_BURST_16);
> +	    omap_set_dma_src_params(info->dma_ch, 0, OMAP_DMA_AMODE_POST_INC,
> +						virt_to_phys(addr), 0, 0);
> +	    omap_set_dma_src_burst_mode(info->dma_ch, OMAP_DMA_DATA_BURST_16);
> +	    omap_set_dma_transfer_params(info->dma_ch, OMAP_DMA_DATA_TYPE_S32,
> +					0x10, buf_len, OMAP_DMA_SYNC_FRAME,
> +					OMAP24XX_DMA_GPMC, OMAP_DMA_DST_SYNC);
> +	} else {
> +	    omap_set_dma_src_params(info->dma_ch, 0, OMAP_DMA_AMODE_CONSTANT,
> +						info->phys_base, 0, 0);
> +	    omap_set_dma_src_burst_mode(info->dma_ch, OMAP_DMA_DATA_BURST_16);
> +	    omap_set_dma_dest_params(info->dma_ch, 0, OMAP_DMA_AMODE_POST_INC,
> +						virt_to_phys(addr), 0, 0);
> +	    omap_set_dma_dest_burst_mode(info->dma_ch, OMAP_DMA_DATA_BURST_16);
> +	    omap_set_dma_transfer_params(info->dma_ch, OMAP_DMA_DATA_TYPE_S32,
> +					0x10, buf_len, OMAP_DMA_SYNC_FRAME,
> +					OMAP24XX_DMA_GPMC, OMAP_DMA_SRC_SYNC);
> +	}
> +
> +	/*  configure and start prefetch transfer */
> +	gpmc_prefetch_start(info->gpmc_cs, 0x1, count, is_write);
> +	init_completion(&info->comp);
> +	dma_sync_single_for_cpu(&info->pdev->dev,
> +				virt_to_phys(addr), count, DMA_TO_DEVICE);

Please read the DMA API and use the proper functions.  This is an abuse
of the DMA API.

> +	omap_start_dma(info->dma_ch);
> +	wait_for_completion(&info->comp);
> +	if (!is_write)
> +		dma_sync_single_for_cpu(&info->pdev->dev,
> +				virt_to_phys(addr), count, DMA_FROM_DEVICE);

Ditto.  This is an abuse of the API.  This is how it's supposed to work:


	enum dma_direction dir = is_write ? DMA_TO_DEVICE : DMA_FROM_DEVICE;
	dma_addr_t dma_addr;

	dma_addr = dma_map_single(&info->pdev->dev, addr, count, dir);

	/* setup and start DMA using dma_addr */

	wait_for_completion(&info->comp);

	dma_unmap_single(&info->pdev->dev, dma_addr, count, dir);


> +	prefetch_status = gpmc_prefetch_status();
> +	while (prefetch_status & 0x3FFF)
> +		prefetch_status = gpmc_prefetch_status();
> +
> +	/* disable and stop the PFPW engine */
> +	gpmc_prefetch_stop();
> +	return 0;
> +}
> +#else
> +static void omap_nand_dma_cb(int lch, u16 ch_status, void *data) {}
> +static inline int omap_nand_dma_transfer(struct mtd_info *mtd, void *addr,
> +					unsigned int count, int is_write)
> +{return 0; }
> +#endif
> +
>  /*
>   * omap_read_buf - read data from NAND controller into buffer
>   * @mtd: MTD device structure
> @@ -201,11 +304,33 @@
>  	struct omap_nand_info *info = container_of(mtd,
>  					struct omap_nand_info, mtd);
>  	u16 *p = (u16 *) buf;
> -
> -	len >>= 1;
> -
> -	while (len--)
> -		*p++ = cpu_to_le16(readw(info->nand.IO_ADDR_R));

This driver needs work (see endianness explaination below.)

> +	if (use_prefetch) {
> +		uint32_t prefetch_status = 0;
> +		int i = 0, bytes_to_read = 0;
> +
> +		if ((use_dma && len == mtd->oobsize) || (!use_dma)) {
> +			/* configure and start prefetch transfer */
> +			gpmc_prefetch_start(info->gpmc_cs, 0x0, len, 0x0);
> +
> +			prefetch_status = gpmc_prefetch_status();
> +			while (len) {
> +				bytes_to_read  = ((prefetch_status >> 24) & 0x7F) >> 1;
> +				for (i = 0; (i < bytes_to_read) && (len); i++, len -= 2)
> +					*p++ = cpu_to_le16(*(volatile u16 *)(info->nand_pref_fifo_add));

Yet you dereference it.  This is illegal according to the Linux APIs.
Use __raw_readw() here.

Moreover, 'p' is a pointer to CPU endian memory, not le16 memory, so
using cpu_to_le16 is wrong here.  What endian is there data in flash?

> +				prefetch_status = gpmc_prefetch_status();
> +			}
> +			/* disable and stop the PFPW engine */
> +			gpmc_prefetch_stop();
> +		} else if (use_dma) {
> +			if (info->dma_ch >= 0)
> +				/* start transfer in DMA mode */
> +				omap_nand_dma_transfer(mtd, p, len, 0x0);
> +		}
> +	} else {
> +		len >>= 1;
> +		while (len--)
> +			*p++ = cpu_to_le16(readw(info->nand.IO_ADDR_R));

Same problem wrt endianness.

> +	}
>  }
>  
>  /*
> @@ -220,13 +345,35 @@
>  						struct omap_nand_info, mtd);
>  	u16 *p = (u16 *) buf;
>  
> -	len >>= 1;
> -
> -	while (len--) {
> -		writew(cpu_to_le16(*p++), info->nand.IO_ADDR_W);
> -
> -		while (GPMC_BUF_EMPTY == (readl(info->gpmc_baseaddr +
> +	if (use_prefetch) {
> +		uint32_t prefetch_status = 0;
> +		int i = 0, bytes_to_write = 0;
> +
> +		if ((use_dma && len == mtd->oobsize) || (!use_dma)) {
> +			/*  configure and start prefetch transfer */
> +			gpmc_prefetch_start(info->gpmc_cs, 0x0, len, 0x1);
> +
> +			prefetch_status = gpmc_prefetch_status();
> +			while (prefetch_status & 0x3FFF) {
> +				bytes_to_write = ((prefetch_status >> 24) & 0x7F)>>1;
> +				for (i = 0; (i < bytes_to_write) && (len); i++, len -= 2)
> +					*(volatile u16 *)(info->nand_pref_fifo_add) = cpu_to_le16(*p++);

Ditto.

> +				prefetch_status = gpmc_prefetch_status();
> +			}
> +			/* disable and stop the PFPW engine */
> +			gpmc_prefetch_stop();
> +		} else if (use_dma) {
> +			if (info->dma_ch >= 0)
> +				/* start transfer in DMA mode */
> +				omap_nand_dma_transfer(mtd, p, len, 0x1);
> +		}
> +	} else {
> +		len >>= 1;
> +		while (len--) {
> +			writew(cpu_to_le16(*p++), info->nand.IO_ADDR_W);

Ditto.

