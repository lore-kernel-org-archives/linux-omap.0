From: "Arun KS" <arunks@mistralsolutions.com>
Subject: Re: [PATCH] OMAP2EVM: Adding NAND support
Date: Thu, 21 Aug 2008 10:48:07 +0530
Message-ID: <dfeb90390808202218q35ffa680td927191f5a27727d@mail.gmail.com>
References: <dfeb90390808200916t30756a73sf283f0e7dd9bf15@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from ti-out-0910.google.com ([209.85.142.188]:62936 "EHLO
	ti-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755226AbYHUFSJ (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 21 Aug 2008 01:18:09 -0400
Received: by ti-out-0910.google.com with SMTP id b6so453359tic.23
        for <linux-omap@vger.kernel.org>; Wed, 20 Aug 2008 22:18:07 -0700 (PDT)
In-Reply-To: <dfeb90390808200916t30756a73sf283f0e7dd9bf15@mail.gmail.com>
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

Hi Tony,

This patch has some issues regarding the partitioning.
Please ignore this. I will resend it again.

Best Regards,
Arun KS

On Wed, Aug 20, 2008 at 9:46 PM, Arun KS <arunks@mistralsolutions.com> wrote:
> This patch enables the nand support for omap2evm board
>
> Signed-off-by: Arun KS <arunks@mistralsolutions.com>
> ---
>  arch/arm/mach-omap2/board-omap2evm.c |   96 ++++++++++++++++++++++++++++++++++
>  1 files changed, 96 insertions(+), 0 deletions(-)
>
> diff --git a/arch/arm/mach-omap2/board-omap2evm.c
> b/arch/arm/mach-omap2/board-omap2evm.c
> index 4188222..0dc3205 100644
> --- a/arch/arm/mach-omap2/board-omap2evm.c
> +++ b/arch/arm/mach-omap2/board-omap2evm.c
> @@ -19,6 +19,9 @@
>  #include <linux/io.h>
>  #include <linux/input.h>
>  #include <linux/i2c/twl4030.h>
> +#include <linux/mtd/mtd.h>
> +#include <linux/mtd/partitions.h>
> +#include <linux/mtd/nand.h>
>
>  #include <mach/hardware.h>
>  #include <asm/mach-types.h>
> @@ -30,6 +33,62 @@
>  #include <mach/common.h>
>  #include <mach/hsmmc.h>
>  #include <mach/keypad.h>
> +#include <mach/gpmc.h>
> +#include <mach/nand.h>
> +
> +#define GPMC_CS0_BASE  0x60
> +#define GPMC_CS_SIZE   0x30
> +
> +static struct mtd_partition nand_partitions[] = {
> +       {
> +               .name           = "X-Loader",
> +               .offset         = 0,
> +               .size           = 4*(64*2048),  /* 0-3 blks reserved.
> +                                               Mandated by ROM code */
> +               .mask_flags     = MTD_WRITEABLE /* force read-only */
> +       },
> +       {
> +               .name           = "U-Boot",
> +               .offset         = MTDPART_OFS_APPEND,
> +               .size           =  4*(64*2048),
> +               .mask_flags     = MTD_WRITEABLE /* force read-only */
> +       },
> +       {
> +               .name           = "U-Boot Environment",
> +               .offset         = MTDPART_OFS_APPEND,
> +               .size           = 2*(64*2048),
> +       },
> +       {
> +               .name           = "Kernel",
> +               .offset         = MTDPART_OFS_APPEND,
> +               .size           = 32*(64*2048),         /* 4*1M */
> +       },
> +       {
> +               .name           = "File System",
> +               .offset         = MTDPART_OFS_APPEND,
> +               .size           = MTDPART_SIZ_FULL,
> +       },
> +};
> +
> +static struct omap_nand_platform_data omap2evm_nand_data = {
> +       .parts          = nand_partitions,
> +       .nr_parts       = ARRAY_SIZE(nand_partitions),
> +       .dma_channel    = -1,   /* disable DMA in OMAP OneNAND driver */
> +};
> +
> +static struct resource omap2evm_nand_resource = {
> +       .flags          = IORESOURCE_MEM,
> +};
> +
> +static struct platform_device omap2evm_nand_device = {
> +       .name           = "omap2-nand",
> +       .id             = -1,
> +       .dev = {
> +               .platform_data = &omap2evm_nand_data,
> +       },
> +       .num_resources  = 1,
> +       .resource       = &omap2evm_nand_resource,
> +};
>
>  static struct resource omap2evm_smc911x_resources[] = {
>        [0] =   {
> @@ -152,6 +211,42 @@ static struct platform_device
> *omap2_evm_devices[] __initdata = {
>        &omap2evm_smc911x_device,
>        &omap2evm_kp_device,
>  };
> +void __init omap2evm_flash_init(void)
> +{
> +       u8 cs = 0;
> +       u8 nandcs = GPMC_CS_NUM + 1;
> +
> +       u32 gpmc_base_add =  OMAP243X_GPMC_VIRT;
> +
> +       /* find out the chip-select on which NAND exists */
> +       while (cs < GPMC_CS_NUM) {
> +               u32 ret = 0;
> +               ret = gpmc_cs_read_reg(cs, GPMC_CS_CONFIG1);
> +
> +               if ((ret & 0xC00) == 0x800) {
> +                       printk(KERN_INFO "Found NAND on CS%d\n", cs);
> +                       if (nandcs > GPMC_CS_NUM)
> +                               nandcs = cs;
> +               }
> +               cs++;
> +       }
> +
> +       if (nandcs > GPMC_CS_NUM) {
> +               printk(KERN_INFO "NAND: Unable to find configuration "
> +                                "in GPMC\n ");
> +               return;
> +       }
> +       if (nandcs < GPMC_CS_NUM) {
> +               omap2evm_nand_data.cs = nandcs;
> +               omap2evm_nand_data.gpmc_cs_baseaddr = (void *)
> +                       (gpmc_base_add + GPMC_CS0_BASE + nandcs * GPMC_CS_SIZE);
> +               omap2evm_nand_data.gpmc_baseaddr = (void *) (gpmc_base_add);
> +
> +               printk(KERN_INFO "Registering NAND on CS%d\n", nandcs);
> +               if (platform_device_register(&omap2evm_nand_device) < 0)
> +                       printk(KERN_ERR "Unable to register NAND device\n");
> +       }
> +}
>
>  static void __init omap2_evm_init(void)
>  {
> @@ -160,6 +255,7 @@ static void __init omap2_evm_init(void)
>        omap_board_config_size = ARRAY_SIZE(omap2_evm_config);
>        omap_serial_init();
>        hsmmc_init();
> +       omap2evm_flash_init();
>  }
>
>  static void __init omap2_evm_map_io(void)
> --
> 1.5.3.4
>
