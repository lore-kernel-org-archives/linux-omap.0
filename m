From: Mike Rapoport <mike@compulab.co.il>
Subject: Re: [PATCH 3/3] omap3 nand: fix issue in board file to detect the
 nand
Date: Wed, 12 May 2010 11:30:17 +0300
Message-ID: <4BEA6719.1050400@compulab.co.il>
References: <[Sukumar Ghorai <s-ghorai@ti.com>]> <1273652243-6303-1-git-send-email-s-ghorai@ti.com> <1273652243-6303-2-git-send-email-s-ghorai@ti.com> <1273652243-6303-3-git-send-email-s-ghorai@ti.com> <1273652243-6303-4-git-send-email-s-ghorai@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from compulab.co.il ([67.18.134.219]:48627 "EHLO compulab.co.il"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753169Ab0ELIaa (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 12 May 2010 04:30:30 -0400
In-Reply-To: <1273652243-6303-4-git-send-email-s-ghorai@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Sukumar Ghorai <s-ghorai@ti.com>
Cc: linux-omap@vger.kernel.org, linux-mtd@lists.infradead.org, tony@atomide.com, sakoman@gmail.com, Artem.Bityutskiy@nokia.com

[Sukumar Ghorai wrote:
> From: Sukumar Ghorai <s-ghorai@ti.com>
> 
> Board file modified to pass the GMPC phys_base address to nand driver. This is
> required to adopt the _prob function as in omap2.c
> 
> Signed-off-by: Sukumar Ghorai <s-ghorai@ti.com>
> ---
>  arch/arm/mach-omap2/board-cm-t35.c         |   10 ++++++++++
>  arch/arm/mach-omap2/board-devkit8000.c     |    9 +++++++++
>  arch/arm/mach-omap2/board-omap3beagle.c    |    9 +++++++++
>  arch/arm/mach-omap2/board-omap3touchbook.c |    9 +++++++++
>  arch/arm/mach-omap2/board-overo.c          |    8 ++++++++
>  5 files changed, 45 insertions(+), 0 deletions(-)
> 
> diff --git a/arch/arm/mach-omap2/board-cm-t35.c b/arch/arm/mach-omap2/board-cm-t35.c
> index fb23122..73a32bd
> --- a/arch/arm/mach-omap2/board-cm-t35.c
> +++ b/arch/arm/mach-omap2/board-cm-t35.c
> @@ -240,6 +240,16 @@ static struct platform_device cm_t35_nand_device = {
>  
>  static void __init cm_t35_init_nand(void)
>  {
> +	struct device *dev = &cm_t35_nand_device.dev;
> +	int err = 0;
> +
> +	err = gpmc_cs_request(cm_t35_nand_data.cs,
> +					NAND_IO_SIZE, &cm_t35_nand_data.phys_base);
> +	if (err < 0) {
> +		dev_err(dev, "Cannot request GPMC CS\n");
> +		return;
> +	}
> +	
>  	if (platform_device_register(&cm_t35_nand_device) < 0)
>  		pr_err("CM-T35: Unable to register NAND device\n");

Why won't you use gpmc_nand_init instead of platform_device_register? 
With gpmc_nand_init there would be no need to request NAND CS in the 
board files. Besides, if you convert the boards to use gpmc_nand_init at 
the first place, it would simplify further patches.

>  }
> diff --git a/arch/arm/mach-omap2/board-devkit8000.c b/arch/arm/mach-omap2/board-devkit8000.c
> index be50d18..86358e3
> --- a/arch/arm/mach-omap2/board-devkit8000.c
> +++ b/arch/arm/mach-omap2/board-devkit8000.c
> @@ -578,6 +578,9 @@ static void __init devkit8000_flash_init(void)
>  	u8 cs = 0;
>  	u8 nandcs = GPMC_CS_NUM + 1;
>  
> +	struct device *dev = &devkit8000_nand_device.dev;
> +	int err = 0;
> +
>  	/* find out the chip-select on which NAND exists */
>  	while (cs < GPMC_CS_NUM) {
>  		u32 ret = 0;
> @@ -599,6 +602,12 @@ static void __init devkit8000_flash_init(void)
>  
>  	if (nandcs < GPMC_CS_NUM) {
>  		devkit8000_nand_data.cs = nandcs;
> +		err = gpmc_cs_request(devkit8000_nand_data.cs,
> +					NAND_IO_SIZE, &devkit8000_nand_data.phys_base);
> +		if (err < 0) {
> +			dev_err(dev, "Cannot request GPMC CS\n");
> +			return;
> +		}
>  
>  		printk(KERN_INFO "Registering NAND on CS%d\n", nandcs);
>  		if (platform_device_register(&devkit8000_nand_device) < 0)
> diff --git a/arch/arm/mach-omap2/board-omap3beagle.c b/arch/arm/mach-omap2/board-omap3beagle.c
> index becaebe..d54719d
> --- a/arch/arm/mach-omap2/board-omap3beagle.c
> +++ b/arch/arm/mach-omap2/board-omap3beagle.c
> @@ -374,6 +374,9 @@ static void __init omap3beagle_flash_init(void)
>  	u8 cs = 0;
>  	u8 nandcs = GPMC_CS_NUM + 1;
>  
> +	struct device *dev = &omap3beagle_nand_device.dev;
> +	int err = 0;
> +
>  	/* find out the chip-select on which NAND exists */
>  	while (cs < GPMC_CS_NUM) {
>  		u32 ret = 0;
> @@ -395,6 +398,12 @@ static void __init omap3beagle_flash_init(void)
>  
>  	if (nandcs < GPMC_CS_NUM) {
>  		omap3beagle_nand_data.cs = nandcs;
> +		err = gpmc_cs_request(omap3beagle_nand_data.cs,
> +						NAND_IO_SIZE, &omap3beagle_nand_data.phys_base);
> +		if (err < 0) {
> +			dev_err(dev, "Cannot request GPMC CS\n");
> +			return;
> +		}
>  
>  		printk(KERN_INFO "Registering NAND on CS%d\n", nandcs);
>  		if (platform_device_register(&omap3beagle_nand_device) < 0)
> diff --git a/arch/arm/mach-omap2/board-omap3touchbook.c b/arch/arm/mach-omap2/board-omap3touchbook.c
> index d6f1b12..088a704
> --- a/arch/arm/mach-omap2/board-omap3touchbook.c
> +++ b/arch/arm/mach-omap2/board-omap3touchbook.c
> @@ -456,6 +456,9 @@ static void __init omap3touchbook_flash_init(void)
>  	u8 cs = 0;
>  	u8 nandcs = GPMC_CS_NUM + 1;
>  
> +	struct device *dev = &omap3touchbook_nand_device.dev;
> +	int err = 0;
> +
>  	/* find out the chip-select on which NAND exists */
>  	while (cs < GPMC_CS_NUM) {
>  		u32 ret = 0;
> @@ -477,6 +480,12 @@ static void __init omap3touchbook_flash_init(void)
>  
>  	if (nandcs < GPMC_CS_NUM) {
>  		omap3touchbook_nand_data.cs = nandcs;
> +		err = gpmc_cs_request(omap3touchbook_nand_data.cs,
> +					NAND_IO_SIZE, &omap3touchbook_nand_data.phys_base);
> +		if (err < 0) {
> +			dev_err(dev, "Cannot request GPMC CS\n");
> +			return;
> +		}
>  
>  		printk(KERN_INFO "Registering NAND on CS%d\n", nandcs);
>  		if (platform_device_register(&omap3touchbook_nand_device) < 0)
> diff --git a/arch/arm/mach-omap2/board-overo.c b/arch/arm/mach-omap2/board-overo.c
> index d843a0a..d6658b5
> --- a/arch/arm/mach-omap2/board-overo.c
> +++ b/arch/arm/mach-omap2/board-overo.c
> @@ -236,6 +236,8 @@ static void __init overo_flash_init(void)
>  {
>  	u8 cs = 0;
>  	u8 nandcs = GPMC_CS_NUM + 1;
> +	struct device *dev = &overo_nand_device.dev;
> +	int err = 0;
>  
>  	/* find out the chip-select on which NAND exists */
>  	while (cs < GPMC_CS_NUM) {
> @@ -258,6 +260,12 @@ static void __init overo_flash_init(void)
>  
>  	if (nandcs < GPMC_CS_NUM) {
>  		overo_nand_data.cs = nandcs;
> +		err = gpmc_cs_request(overo_nand_data.cs,
> +						NAND_IO_SIZE, &overo_nand_data.phys_base);
> +		if (err < 0) {
> +			dev_err(dev, "Cannot request GPMC CS\n");
> +			return;
> +		}
>  
>  		printk(KERN_INFO "Registering NAND on CS%d\n", nandcs);
>  		if (platform_device_register(&overo_nand_device) < 0)


-- 
Sincerely yours,
Mike.
