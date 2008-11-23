From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Please fix or remove OMAP2 onenand driver
Date: Sun, 23 Nov 2008 16:50:11 +0000
Message-ID: <20081123165011.GB17438@flint.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([78.32.30.218]:47578 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750871AbYKWQuX (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sun, 23 Nov 2008 11:50:23 -0500
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-mtd@lists.infradead.org
Cc: dwmw2@infradead.org

Clearly this driver has been put into mainline prematurely - it takes
no account of the relocation of headers.

It's causing a regression - omap_2430sdp_defconfig used to build in
mainline, and it no longer does.

Please fix, or remove this broken driver from mainline.

drivers/mtd/onenand/omap2.c:38:27: error: asm/arch/gpmc.h: No such file or directory
drivers/mtd/onenand/omap2.c:39:30: error: asm/arch/onenand.h: No such file or directory
drivers/mtd/onenand/omap2.c:40:27: error: asm/arch/gpio.h: No such file or directory
drivers/mtd/onenand/omap2.c:41:25: error: asm/arch/pm.h: No such file or directory
drivers/mtd/onenand/omap2.c:45:26: error: asm/arch/dma.h: No such file or directory
drivers/mtd/onenand/omap2.c:47:28: error: asm/arch/board.h: No such file or directory
drivers/mtd/onenand/omap2.c: In function 'omap2_onenand_wait':
drivers/mtd/onenand/omap2.c:153: error: implicit declaration of function 'omap_get_gpio_datain'
drivers/mtd/onenand/omap2.c: In function 'omap2_onenand_read_bufferram':
drivers/mtd/onenand/omap2.c:469: error: implicit declaration of function 'omap_set_dma_transfer_params'
drivers/mtd/onenand/omap2.c:469: error: 'OMAP_DMA_DATA_TYPE_S32' undeclared (first use in this function)
drivers/mtd/onenand/omap2.c:469: error: (Each undeclared identifier is reported only once
drivers/mtd/onenand/omap2.c:469: error: for each function it appears in.)
drivers/mtd/onenand/omap2.c:471: error: implicit declaration of function 'omap_set_dma_src_params'
drivers/mtd/onenand/omap2.c:471: error: 'OMAP_DMA_AMODE_POST_INC' undeclared (first use in this function)
drivers/mtd/onenand/omap2.c:473: error: implicit declaration of function 'omap_set_dma_dest_params'
drivers/mtd/onenand/omap2.c:477: error: implicit declaration of function 'omap_start_dma'
drivers/mtd/onenand/omap2.c: In function 'omap2_onenand_write_bufferram':
drivers/mtd/onenand/omap2.c:514: error: 'OMAP_DMA_DATA_TYPE_S16' undeclared (first use in this function)
drivers/mtd/onenand/omap2.c:516: error: 'OMAP_DMA_AMODE_POST_INC' undeclared (first use in this function)
drivers/mtd/onenand/omap2.c: In function 'omap2_onenand_probe':
drivers/mtd/onenand/omap2.c:595: error: dereferencing pointer to incomplete type
drivers/mtd/onenand/omap2.c:596: error: dereferencing pointer to incomplete type
drivers/mtd/onenand/omap2.c:597: error: dereferencing pointer to incomplete type
drivers/mtd/onenand/omap2.c:603: error: implicit declaration of function 'gpmc_cs_request'
drivers/mtd/onenand/omap2.c:622: error: dereferencing pointer to incomplete type
drivers/mtd/onenand/omap2.c:623: error: dereferencing pointer to incomplete type
drivers/mtd/onenand/omap2.c:629: error: dereferencing pointer to incomplete type
drivers/mtd/onenand/omap2.c:633: error: implicit declaration of function 'omap_request_gpio'
drivers/mtd/onenand/omap2.c:638: error: implicit declaration of function 'omap_set_gpio_direction'
drivers/mtd/onenand/omap2.c:640: error: implicit declaration of function 'OMAP_GPIO_IRQ'
drivers/mtd/onenand/omap2.c:647: error: implicit declaration of function 'omap_request_dma'
drivers/mtd/onenand/omap2.c:651: error: implicit declaration of function 'omap_set_dma_write_mode'
drivers/mtd/onenand/omap2.c:652: error: 'OMAP_DMA_WRITE_NON_POSTED' undeclared (first use in this function)
drivers/mtd/onenand/omap2.c:653: error: implicit declaration of function 'omap_set_dma_src_data_pack'
drivers/mtd/onenand/omap2.c:654: error: implicit declaration of function 'omap_set_dma_src_burst_mode'
drivers/mtd/onenand/omap2.c:655: error: 'OMAP_DMA_DATA_BURST_8' undeclared (first use in this function)
drivers/mtd/onenand/omap2.c:656: error: implicit declaration of function 'omap_set_dma_dest_data_pack'
drivers/mtd/onenand/omap2.c:657: error: implicit declaration of function 'omap_set_dma_dest_burst_mode'
drivers/mtd/onenand/omap2.c:708: error: dereferencing pointer to incomplete type
drivers/mtd/onenand/omap2.c:709: error: dereferencing pointer to incomplete type
drivers/mtd/onenand/omap2.c:710: error: dereferencing pointer to incomplete type
drivers/mtd/onenand/omap2.c:725: error: implicit declaration of function 'omap_free_dma'
drivers/mtd/onenand/omap2.c:730: error: implicit declaration of function 'omap_free_gpio'
drivers/mtd/onenand/omap2.c:736: error: implicit declaration of function 'gpmc_cs_free'
make[3]: *** [drivers/mtd/onenand/omap2.o] Error 1
