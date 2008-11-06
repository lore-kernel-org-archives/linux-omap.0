From: "Juha Kuikka" <juha.kuikka@gmail.com>
Subject: Re: [PATCH - Omapzoom][NAND] Add prefetch and DMA support
Date: Thu, 6 Nov 2008 10:44:55 -0800
Message-ID: <a46a26fd0811061044w15caa963l9eca4b39f0ae1444@mail.gmail.com>
References: <55273.192.168.10.89.1225979834.squirrel@dbdmail.itg.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from yx-out-2324.google.com ([74.125.44.28]:3457 "EHLO
	yx-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750701AbYKFSo5 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 6 Nov 2008 13:44:57 -0500
Received: by yx-out-2324.google.com with SMTP id 8so304862yxm.1
        for <linux-omap@vger.kernel.org>; Thu, 06 Nov 2008 10:44:55 -0800 (PST)
In-Reply-To: <55273.192.168.10.89.1225979834.squirrel@dbdmail.itg.ti.com>
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: vimal singh <vimalsingh@ti.com>
Cc: linux-omap@vger.kernel.org

Hi,

Do you have any plans to use the prefetch engine's feature to
synchronise to ready/busy pin? (GPMC_PREFETCH_CONFIG1's SYNCHROMODE=1)
That way we could avoid the busy-wait for the flash to be ready.

 - Juha

On Thu, Nov 6, 2008 at 5:57 AM, vimal singh <vimalsingh@ti.com> wrote:
> This patch adds prefetch support to access nand flash in both mpu and dma mode.
> This patch also adds 8-bit nand support (omap_read/write_buf8).
> Prefetch can be used for both 8- and 16-bit devices.
>
> Signed-off-by: Vimal Singh <vimalsingh at ti.com>
> ---
> API's to access 8- and 16-bit NAND devices (omap_read/wirte_buf8/16)can be
> removed after sometime (once sufficient amount of testing is done for both kind
> of devices).
>
> vimal
> ---
>  arch/arm/mach-omap2/gpmc.c             |   95 +++++++++++
>  arch/arm/plat-omap/include/mach/gpmc.h |    4
>  drivers/mtd/nand/Kconfig               |   17 ++
>  drivers/mtd/nand/omap2.c               |  277 ++++++++++++++++++++++++++++++++-
>  4 files changed, 386 insertions(+), 7 deletions(-)
>
> Index: omapkernel/arch/arm/mach-omap2/gpmc.c
> ===================================================================
> --- omapkernel.orig/arch/arm/mach-omap2/gpmc.c  2008-11-06 12:49:34.000000000 +0530
> +++ omapkernel/arch/arm/mach-omap2/gpmc.c       2008-11-06 12:49:57.000000000 +0530
> @@ -54,6 +54,12 @@
>  #define GPMC_CHUNK_SHIFT       24              /* 16 MB */
>  #define GPMC_SECTION_SHIFT     28              /* 128 MB */
>
> +#ifdef CONFIG_MTD_NAND_OMAP_PREFETCH
> +#define CS_NUM_SHIFT           24
> +#define ENABLE_PREFETCH                7
> +#define DMA_MPU_MODE           2
> +#endif
> +
>  #ifdef CONFIG_OMAP3_PM
>  /*
>  * Structure to save/restore gpmc context
> @@ -407,6 +413,92 @@
>  }
>  EXPORT_SYMBOL(gpmc_cs_free);
>
> +#ifdef CONFIG_MTD_NAND_OMAP_PREFETCH
> +/*
> + * gpmc_prefetch_init - configures default configuration for prefetch engine
> + */
> +static void gpmc_prefetch_init(void)
> +{
> +       /* Setting the default threshold to 64 */
> +       gpmc_write_reg(GPMC_PREFETCH_CONTROL, 0x0);
> +       gpmc_write_reg(GPMC_PREFETCH_CONFIG1, 0x40  << 8);
> +       gpmc_write_reg(GPMC_PREFETCH_CONFIG2, 0x0);
> +}
> +
> +/*
> + * gpmc_prefetch_start - configures and starts prefetch transfer
> + * @cs - nand cs (chip select) number
> + * @dma_mode: dma mode enable (1) or disable (0)
> + * @u32_count: number of bytes to be transferred
> + * @is_write: prefetch read(0) or write post(1) mode
> + */
> +void gpmc_prefetch_start(int cs, int dma_mode,
> +                               unsigned int u32_count, int is_write)
> +{
> +       uint32_t prefetch_config1;
> +       if (is_write) {
> +               /* Set the amount of bytes to be prefetched */
> +               gpmc_write_reg(GPMC_PREFETCH_CONFIG2, u32_count);
> +
> +               /* Set dma/mpu mode, the post write and enable the engine
> +                * Set which cs is using the post write
> +                */
> +               prefetch_config1 = gpmc_read_reg(GPMC_PREFETCH_CONFIG1);
> +               prefetch_config1 |= ((cs << CS_NUM_SHIFT) |
> +                                       (dma_mode << DMA_MPU_MODE) |
> +                                       (1 << ENABLE_PREFETCH) | 0x1);
> +               gpmc_write_reg(GPMC_PREFETCH_CONFIG1, prefetch_config1);
> +       } else {
> +               /* Set the amount of bytes to be prefetched */
> +               gpmc_write_reg(GPMC_PREFETCH_CONFIG2, u32_count);
> +
> +               /* Set dma/mpu mode, the prefech read and enable the engine
> +                * Set which cs is using the prefetch
> +                */
> +               prefetch_config1 = gpmc_read_reg(GPMC_PREFETCH_CONFIG1);
> +               prefetch_config1 |= (((cs << CS_NUM_SHIFT) |
> +                                       (dma_mode << DMA_MPU_MODE) |
> +                                       (1 << ENABLE_PREFETCH)) & ~0x1);
> +               gpmc_write_reg(GPMC_PREFETCH_CONFIG1, prefetch_config1);
> +       }
> +       /*  Start the prefetch engine */
> +       gpmc_write_reg(GPMC_PREFETCH_CONTROL, 0x1);
> +}
> +EXPORT_SYMBOL(gpmc_prefetch_start);
> +
> +/*
> + * gpmc_prefetch_stop - disables and stops the prefetch engine
> + */
> +void gpmc_prefetch_stop(void)
> +{
> +       uint32_t prefetch_config1;
> +       /* stop the PFPW engine */
> +       gpmc_write_reg(GPMC_PREFETCH_CONTROL, 0x0);
> +
> +       /* Disable the PFPW engine */
> +       prefetch_config1 = gpmc_read_reg(GPMC_PREFETCH_CONFIG1);
> +       prefetch_config1 &= ~((0x07 << CS_NUM_SHIFT) |
> +                               (1 << ENABLE_PREFETCH) |
> +                                       (1 << DMA_MPU_MODE) | 0x1);
> +       gpmc_write_reg(GPMC_PREFETCH_CONFIG1, prefetch_config1);
> +}
> +EXPORT_SYMBOL(gpmc_prefetch_stop);
> +
> +/*
> + * gpmc_prefetch_status - reads prefetch status of engine
> + */
> +int  gpmc_prefetch_status(void)
> +{
> +       return gpmc_read_reg(GPMC_PREFETCH_STATUS);
> +}
> +EXPORT_SYMBOL(gpmc_prefetch_status);
> +#else
> +int  gpmc_prefetch_status(void) {return 0; }
> +void gpmc_prefetch_stop(void) {}
> +void gpmc_prefetch_start(int cs, int dma_mode, unsigned int u32_count,
> +                                                       int is_write) {}
> +#endif
> +
>  static void __init gpmc_mem_init(void)
>  {
>        int cs;
> @@ -474,6 +566,9 @@
>        gpmc_freq_cfg.freq_cfg = NULL;
>        gpmc_freq_cfg.total_no_of_freq = 0;
>  #endif
> +#ifdef CONFIG_MTD_NAND_OMAP_PREFETCH
> +       gpmc_prefetch_init();
> +#endif
>        gpmc_mem_init();
>  }
>
> Index: omapkernel/arch/arm/plat-omap/include/mach/gpmc.h
> ===================================================================
> --- omapkernel.orig/arch/arm/plat-omap/include/mach/gpmc.h      2008-11-06
> 12:49:34.000000000 +0530
> +++ omapkernel/arch/arm/plat-omap/include/mach/gpmc.h   2008-11-06
> 12:49:57.000000000 +0530
> @@ -149,6 +149,10 @@
>  extern void gpmc_cs_free(int cs);
>  extern int gpmc_cs_set_reserved(int cs, int reserved);
>  extern int gpmc_cs_reserved(int cs);
> +extern void gpmc_prefetch_start(int cs, int dma_mode,
> +                                       unsigned int u32_count, int is_write);
> +extern void gpmc_prefetch_stop(void);
> +extern int  gpmc_prefetch_status(void);
>  extern void __init gpmc_init(void);
>
>  #endif
> Index: omapkernel/drivers/mtd/nand/Kconfig
> ===================================================================
> --- omapkernel.orig/drivers/mtd/nand/Kconfig    2008-11-06 12:49:34.000000000 +0530
> +++ omapkernel/drivers/mtd/nand/Kconfig 2008-11-06 12:49:57.000000000 +0530
> @@ -82,6 +82,23 @@
>            The ECC compuatation for the data to be written/read can be either by
>            software or omap has Hw ecc engine which calculates it.
>
> +config MTD_NAND_OMAP_PREFETCH
> +       bool "GPMC prefetch support for NAND Flash device"
> +       depends on MTD_NAND && MTD_NAND_OMAP2
> +       default y
> +       help
> +        The NAND device can be accessed for Read/Write using GPMC PREFETCH engine
> +        to improve the performance.
> +
> +config MTD_NAND_OMAP_PREFETCH_DMA
> +       depends on MTD_NAND_OMAP_PREFETCH
> +       bool "DMA mode"
> +       default n
> +       help
> +        The GPMC PREFETCH engine can be configured eigther in MPU interrupt mode
> +        or in DMA interrupt mode.
> +        Say y for DMA mode or MPU mode will be used
> +
>  config MTD_NAND_OMAP
>        tristate "NAND Flash device on OMAP H3/H2/P2 boards"
>        depends on ARM && ARCH_OMAP1 && MTD_NAND && (MACH_OMAP_H2 || MACH_OMAP_H3 ||
> MACH_OMAP_PERSEUS2)
> Index: omapkernel/drivers/mtd/nand/omap2.c
> ===================================================================
> --- omapkernel.orig/drivers/mtd/nand/omap2.c    2008-11-06 12:49:34.000000000 +0530
> +++ omapkernel/drivers/mtd/nand/omap2.c 2008-11-06 18:57:52.000000000 +0530
> @@ -111,6 +111,27 @@
>  static const char *part_probes[] = { "cmdlinepart", NULL };
>  #endif
>
> +#ifdef CONFIG_MTD_NAND_OMAP_PREFETCH
> +static int use_prefetch = 1;
> +
> +/* "modprobe ... use_prefetch=0" etc */
> +module_param(use_prefetch, bool, 0);
> +MODULE_PARM_DESC(use_prefetch, "enable/disable use of PREFETCH");
> +
> +#ifdef CONFIG_MTD_NAND_OMAP_PREFETCH_DMA
> +static int use_dma = 1;
> +
> +/* "modprobe ... use_dma=0" etc */
> +module_param(use_dma, bool, 0);
> +MODULE_PARM_DESC(use_dma, "enable/disable use of DMA");
> +#else
> +const int use_dma;
> +#endif
> +#else
> +const int use_prefetch;
> +const int use_dma;
> +#endif
> +
>  struct omap_nand_info {
>        struct nand_hw_control          controller;
>        struct omap_nand_platform_data  *pdata;
> @@ -123,6 +144,9 @@
>        unsigned long                   phys_base;
>        void __iomem                    *gpmc_cs_baseaddr;
>        void __iomem                    *gpmc_baseaddr;
> +       void __iomem                    *nand_pref_fifo_add;
> +       struct completion               comp;
> +       int                             dma_ch;
>  };
>
>  /*
> @@ -186,6 +210,124 @@
>                __raw_writeb(cmd, info->nand.IO_ADDR_W);
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
> +       complete((struct completion *) data);
> +}
> +
> +/*
> + * omap_nand_dma_transfer: configer and start dma transfer
> + * @mtd: MTD device structure
> + * @addr: virtual address in RAM of source/destination
> + * @len: number of data bytes to be transferred
> + * @is_write: flag for read/write operation
> + */
> +static inline int omap_nand_dma_transfer(struct mtd_info *mtd, void *addr,
> +                                       unsigned int len, int is_write)
> +{
> +       struct omap_nand_info *info = container_of(mtd,
> +                                       struct omap_nand_info, mtd);
> +       uint32_t prefetch_status = 0;
> +       enum dma_data_direction dir = is_write ? DMA_TO_DEVICE :
> +                                                       DMA_FROM_DEVICE;
> +       dma_addr_t dma_addr;
> +
> +       /* The fifo depth is 64 bytes. We have a sync at each frame and frame
> +        * length is 64 bytes.
> +        */
> +       int buf_len = len/64;
> +
> +       dma_addr = dma_map_single(&info->pdev->dev, addr, len, dir);
> +
> +       if (is_write) {
> +           omap_set_dma_dest_params(info->dma_ch, 0, OMAP_DMA_AMODE_CONSTANT,
> +                                               info->phys_base, 0, 0);
> +           omap_set_dma_dest_burst_mode(info->dma_ch, OMAP_DMA_DATA_BURST_16);
> +           omap_set_dma_src_params(info->dma_ch, 0, OMAP_DMA_AMODE_POST_INC,
> +                                                       dma_addr, 0, 0);
> +           omap_set_dma_src_burst_mode(info->dma_ch, OMAP_DMA_DATA_BURST_16);
> +           omap_set_dma_transfer_params(info->dma_ch, OMAP_DMA_DATA_TYPE_S32,
> +                                       0x10, buf_len, OMAP_DMA_SYNC_FRAME,
> +                                       OMAP24XX_DMA_GPMC, OMAP_DMA_DST_SYNC);
> +       } else {
> +           omap_set_dma_src_params(info->dma_ch, 0, OMAP_DMA_AMODE_CONSTANT,
> +                                               info->phys_base, 0, 0);
> +           omap_set_dma_src_burst_mode(info->dma_ch, OMAP_DMA_DATA_BURST_16);
> +           omap_set_dma_dest_params(info->dma_ch, 0, OMAP_DMA_AMODE_POST_INC,
> +                                                       dma_addr, 0, 0);
> +           omap_set_dma_dest_burst_mode(info->dma_ch, OMAP_DMA_DATA_BURST_16);
> +           omap_set_dma_transfer_params(info->dma_ch, OMAP_DMA_DATA_TYPE_S32,
> +                                       0x10, buf_len, OMAP_DMA_SYNC_FRAME,
> +                                       OMAP24XX_DMA_GPMC, OMAP_DMA_SRC_SYNC);
> +       }
> +       /*  configure and start prefetch transfer */
> +       gpmc_prefetch_start(info->gpmc_cs, 0x1, len, is_write);
> +       init_completion(&info->comp);
> +
> +       omap_start_dma(info->dma_ch);
> +
> +       /* setup and start DMA using dma_addr */
> +       wait_for_completion(&info->comp);
> +
> +       while (0x3fff & (prefetch_status = gpmc_prefetch_status()))
> +               ;
> +       /* disable and stop the PFPW engine */
> +       gpmc_prefetch_stop();
> +
> +       dma_unmap_single(&info->pdev->dev, dma_addr, len, dir);
> +       return 0;
> +}
> +#else
> +static void omap_nand_dma_cb(int lch, u16 ch_status, void *data) {}
> +static inline int omap_nand_dma_transfer(struct mtd_info *mtd, void *addr,
> +                                       unsigned int len, int is_write)
> +{
> +       return 0;
> +}
> +#endif
> +
> +/*
> + * omap_read_buf8 - read data from NAND controller into buffer
> + * @mtd: MTD device structure
> + * @buf: buffer to store date
> + * @len: number of bytes to read
> + */
> +static void omap_read_buf8(struct mtd_info *mtd, u_char *buf, int len)
> +{
> +       struct nand_chip *nand = mtd->priv;
> +       u_char *p = (u_char *)buf;
> +
> +       while (len--)
> +               *p++ = __raw_readb(nand->IO_ADDR_R);
> +}
> +
> +/*
> + * omap_write_buf8 - write buffer to NAND controller
> + * @mtd: MTD device structure
> + * @buf: data buffer
> + * @len: number of bytes to write
> + */
> +static void omap_write_buf8(struct mtd_info *mtd, const u_char *buf, int len)
> +{
> +       struct omap_nand_info *info = container_of(mtd,
> +                                               struct omap_nand_info, mtd);
> +       u_char *p = (u_char *)buf;
> +
> +       while (len--) {
> +               writeb(*p++, info->nand.IO_ADDR_W);
> +
> +               while (GPMC_BUF_EMPTY == (readl(info->gpmc_baseaddr +
> +                                               GPMC_STATUS) & GPMC_BUF_FULL));
> +       }
> +}
> +
>  /*
>  * omap_read_buf16 - read data from NAND controller into buffer
>  * @mtd: MTD device structure
> @@ -221,6 +363,94 @@
>                                                GPMC_STATUS) & GPMC_BUF_FULL));
>        }
>  }
> +
> +/*
> + * omap_read_buf_pref - read data from NAND controller into buffer
> + * @mtd: MTD device structure
> + * @buf: buffer to store date
> + * @len: number of bytes to read
> + */
> +static void omap_read_buf_pref(struct mtd_info *mtd, u_char *buf, int len)
> +{
> +       struct omap_nand_info *info = container_of(mtd,
> +                                               struct omap_nand_info, mtd);
> +       uint32_t prefetch_status = 0, read_count = 0;
> +       u16 *p = (u16 *)buf;
> +
> +       if ((use_dma && len <= mtd->oobsize) || (!use_dma)) {
> +
> +               /* take care of subpage reads */
> +               if (len % 2 != 0) {
> +                       *buf++ = __raw_readb(info->nand.IO_ADDR_R);
> +                       p = (u16 *) buf;
> +                       len--;
> +               }
> +
> +               /* configure and start prefetch transfer */
> +               gpmc_prefetch_start(info->gpmc_cs, 0x0, len, 0x0);
> +
> +               do {
> +                       prefetch_status = gpmc_prefetch_status();
> +                       read_count = ((prefetch_status >> 24) & 0x7F) >> 1;
> +                       __raw_readsw(info->nand_pref_fifo_add, p,
> +                                                       read_count);
> +                       p += read_count;
> +                       len -= read_count << 1;
> +               } while (len);
> +
> +               /* disable and stop the PFPW engine */
> +               gpmc_prefetch_stop();
> +       } else if (use_dma) {
> +               if (info->dma_ch >= 0)
> +                       /* start transfer in DMA mode */
> +                       omap_nand_dma_transfer(mtd, p, len, 0x0);
> +       }
> +}
> +
> +/*
> + * omap_write_buf_pref - write buffer to NAND controller
> + * @mtd: MTD device structure
> + * @buf: data buffer
> + * @len: number of bytes to write
> + */
> +static void omap_write_buf_pref(struct mtd_info *mtd,
> +                                       const u_char *buf, int len)
> +{
> +       struct omap_nand_info *info = container_of(mtd,
> +                                               struct omap_nand_info, mtd);
> +       uint32_t prefetch_status = 0, write_count = 0;
> +       int i = 0;
> +       u16 *p = (u16 *) buf;
> +
> +       if ((use_dma && len <= mtd->oobsize) || (!use_dma)) {
> +
> +               /* take care of subpage writes */
> +               if (len % 2 != 0) {
> +                       writeb(*buf, info->nand.IO_ADDR_R);
> +                       p = (u16 *)(buf + 1);
> +                       len--;
> +               }
> +
> +               /*  configure and start prefetch transfer */
> +               gpmc_prefetch_start(info->gpmc_cs, 0x0, len, 0x1);
> +
> +               prefetch_status = gpmc_prefetch_status();
> +               while (prefetch_status & 0x3FFF) {
> +                       write_count = ((prefetch_status >> 24) & 0x7F) >> 1;
> +                       for (i = 0; (i < write_count) && len; i++, len -= 2)
> +                               __raw_writew(*p++, info->nand_pref_fifo_add);
> +                               prefetch_status = gpmc_prefetch_status();
> +               }
> +
> +               /* disable and stop the PFPW engine */
> +               gpmc_prefetch_stop();
> +       } else if (use_dma) {
> +               if (info->dma_ch >= 0)
> +                       /* start transfer in DMA mode */
> +                       omap_nand_dma_transfer(mtd, p, len, 0x1);
> +       }
> +}
> +
>  /*
>  * omap_verify_buf - Verify chip data against buffer
>  * @mtd: MTD device structure
> @@ -635,17 +865,24 @@
>                err = -ENOMEM;
>                goto out_release_mem_region;
>        }
> +       if (use_prefetch) {
> +               /* copy the virtual address of nand base for fifo access */
> +               info->nand_pref_fifo_add = info->nand.IO_ADDR_R;
> +               if (use_dma) {
> +                       err = omap_request_dma(OMAP24XX_DMA_GPMC, "NAND",
> +                               omap_nand_dma_cb, &info->comp, &info->dma_ch);
> +                       if (err < 0) {
> +                               info->dma_ch = -1;
> +                               printk(KERN_WARNING "DMA request failed."
> +                                       " Non-dma data transfer mode\n");
> +                       }
> +               }
> +       }
>        info->nand.controller = &info->controller;
>
>        info->nand.IO_ADDR_W = info->nand.IO_ADDR_R;
>        info->nand.cmd_ctrl  = omap_hwcontrol;
>
> -       /* REVISIT:  only supports 16-bit NAND flash */
> -
> -       info->nand.read_buf   = omap_read_buf16;
> -       info->nand.write_buf  = omap_write_buf16;
> -       info->nand.verify_buf = omap_verify_buf;
> -
>        /*
>        * If RDY/BSY line is connected to OMAP then use the omap ready funcrtion
>        * and the generic nand_wait function which reads the status register
> @@ -666,6 +903,20 @@
>                                                                == 0x1000)
>                info->nand.options  |= NAND_BUSWIDTH_16;
>
> +       if (use_prefetch) {
> +               info->nand.read_buf   = omap_read_buf_pref;
> +               info->nand.write_buf  = omap_write_buf_pref;
> +       } else {
> +               if (info->nand.options & NAND_BUSWIDTH_16) {
> +                       info->nand.read_buf   = omap_read_buf16;
> +                       info->nand.write_buf  = omap_write_buf16;
> +               } else {
> +                       info->nand.read_buf   = omap_read_buf8;
> +                       info->nand.write_buf  = omap_write_buf8;
> +               }
> +       }
> +       info->nand.verify_buf = omap_verify_buf;
> +
>  #ifdef CONFIG_MTD_NAND_OMAP_HWECC
>        info->nand.ecc.bytes            = 3;
>        info->nand.ecc.size             = 512;
> @@ -721,9 +972,12 @@
>        struct omap_nand_info *info = mtd->priv;
>
>        platform_set_drvdata(pdev, NULL);
> +       if (use_dma)
> +               omap_free_dma(info->dma_ch);
> +
>        /* Release NAND device, its internal structures and partitions */
>        nand_release(&info->mtd);
> -       iounmap(info->nand.IO_ADDR_R);
> +       iounmap(info->nand_pref_fifo_add);
>        kfree(&info->mtd);
>        return 0;
>  }
> @@ -741,6 +995,15 @@
>  static int __init omap_nand_init(void)
>  {
>        printk(KERN_INFO "%s driver initializing\n", DRIVER_NAME);
> +
> +       /* This check is required if driver is being
> +        * loaded run time as a module
> +        */
> +       if ((1 == use_dma) && (0 == use_prefetch)) {
> +               printk(KERN_INFO"Wrong parameters: 'use_dma' can not be 1 "
> +                               "without use_prefetch'. Prefetch will not be"
> +                               " used in either mode (mpu or dma)\n");
> +       }
>        return platform_driver_register(&omap_nand_driver);
>  }
>
>
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>



-- 
Madness takes it's toll. Please have exact change.
