From: "Madhusudhan Chikkature" <madhu.cr@ti.com>
Subject: Re: [PATCH]Enable 4-bit in HSMMC1 and HSMMC2 platform data
Date: Fri, 12 Sep 2008 18:02:20 +0530
Message-ID: <007201c914d3$9c5b64a0$LocalHost@wipultra1303>
References: <62710.192.168.10.89.1218608010.squirrel@dbdmail.itg.ti.com> <20080910235646.GV21163@atomide.com> <20080911084828.GC26078@flint.arm.linux.org.uk> <20080911112315.GA10002@angel.research.nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:52861 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753066AbYILMcs convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 12 Sep 2008 08:32:48 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Jarkko Lavinen <jarkko.lavinen@nokia.com>, Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: Tony Lindgren <tony@atomide.com>, linux-omap@vger.kernel.org

Hi Jarko,

My comments inlined.

Regards,
Madhu
----- Original Message ----- 
From: "Jarkko Lavinen" <jarkko.lavinen@nokia.com>
To: "Russell King - ARM Linux" <linux@arm.linux.org.uk>
Cc: "Tony Lindgren" <tony@atomide.com>; "Madhusudhan Chikkature" <madhu.cr@ti.com>; <linux-omap@vger.kernel.org>
Sent: Thursday, September 11, 2008 4:53 PM
Subject: Re: [PATCH]Enable 4-bit in HSMMC1 and HSMMC2 platform data


> On Thu, Sep 11, 2008 at 09:48:28AM +0100, ext Russell King - ARM Linux wrote:
>> So, given my update for this, shouldn't this be something sent almost
>> immediately to me so stuff for mainline isn't falling behind.
> 
> Hi Russell and all
> 
> Here is a hopefully self-explaining patch, which enables 8-bit
> support similar to the 4-bit support in Omap HSMMC when then mmc
> confifuration from platform data tells it is available.
> 
> I have tested it on a testboard with 2.6.26 beased kernel and
> write speed increased some 30..40%.
> 
> Cheers,
> Jarkko
> 
> ---
> 
> From f739457703988da18a5509bd297c4f6ebed83291 Mon Sep 17 00:00:00 2001
> From: Jarkko Lavinen <jarkko.lavinen@nokia.com>
> Date: Thu, 11 Sep 2008 14:15:31 +0300
> Subject: [PATCH] HSMMC: Enable 8-bit transfer when available.
> 
> Signed-off-by: Jarkko Lavinen <jarkko.lavinen@nokia.com>
> ---
> arch/arm/plat-omap/devices.c            |    8 ++++++--
> arch/arm/plat-omap/include/mach/board.h |    4 +++-
> drivers/mmc/core/mmc.c                  |   17 +++++++++++++----
> drivers/mmc/host/omap_hsmmc.c           |   10 ++++++++++
> include/linux/mmc/host.h                |   12 +++++++-----
> 5 files changed, 39 insertions(+), 12 deletions(-)
> 
> diff --git a/arch/arm/plat-omap/devices.c b/arch/arm/plat-omap/devices.c
> index 3bd1da2..aa1299f 100644
> --- a/arch/arm/plat-omap/devices.c
> +++ b/arch/arm/plat-omap/devices.c
> @@ -289,13 +289,17 @@ static void __init omap_init_mmc(void)
>  mmc = &mmc_conf->mmc[0];
> 
>  if (cpu_is_omap2430() || cpu_is_omap34xx()) {
> - if (mmc->enabled)
> + if (mmc->enabled) {
> + mmc1_data.conf = *mmc;
>  (void) platform_device_register(&mmc_omap_device1);
> + }
> 
> #if defined(CONFIG_ARCH_OMAP2430) || defined(CONFIG_ARCH_OMAP34XX)
>  mmc = &mmc_conf->mmc[1];
> - if (mmc->enabled)
> + if (mmc->enabled) {
> + mmc2_data.conf = *mmc;
>  (void) platform_device_register(&mmc_omap_device2);
> + }
> #endif
> 
The above changes are already pushed by Tony.

>  return;
> diff --git a/arch/arm/plat-omap/include/mach/board.h b/arch/arm/plat-omap/include/mach/board.h
> index a1a66ac..cd287dd 100644
> --- a/arch/arm/plat-omap/include/mach/board.h
> +++ b/arch/arm/plat-omap/include/mach/board.h
> @@ -46,8 +46,10 @@ struct omap_mmc_conf {
>  unsigned nomux:1;
>  /* switch pin can be for card detect (default) or card cover */
>  unsigned cover:1;
> - /* 4 wire signaling is optional, and is only used for SD/SDIO */
> + /* 4 and 8 wire signaling are optional */
>  unsigned wire4:1;
> + unsigned wire8:1;
> +
>  /* use the internal clock */
>  unsigned internal_clock:1;
>  s16 power_pin;
> diff --git a/drivers/mmc/core/mmc.c b/drivers/mmc/core/mmc.c
> index fdd7c76..8c55df3 100644
> --- a/drivers/mmc/core/mmc.c
> +++ b/drivers/mmc/core/mmc.c
> @@ -434,13 +434,23 @@ static int mmc_init_card(struct mmc_host *host, u32 ocr,
>  * Activate wide bus (if supported).
>  */
>  if ((card->csd.mmca_vsn >= CSD_SPEC_VER_4) &&
> - (host->caps & MMC_CAP_4_BIT_DATA)) {
> +     (host->caps & (MMC_CAP_4_BIT_DATA | MMC_CAP_8_BIT_DATA))) {
> + unsigned ext_csd_bit, driver_width;
> +
> + if (host->caps & MMC_CAP_8_BIT_DATA) {
> + ext_csd_bit = EXT_CSD_BUS_WIDTH_8;
> + driver_width = MMC_BUS_WIDTH_8;
> + } else {
> + ext_csd_bit = EXT_CSD_BUS_WIDTH_4;
> + driver_width = MMC_BUS_WIDTH_4;
> + }
> +
>  err = mmc_switch(card, EXT_CSD_CMD_SET_NORMAL,
> - EXT_CSD_BUS_WIDTH, EXT_CSD_BUS_WIDTH_4);
> + EXT_CSD_BUS_WIDTH, ext_csd_bit);
>  if (err)
>  goto free_card;
> 
> - mmc_set_bus_width(card->host, MMC_BUS_WIDTH_4);
> + mmc_set_bus_width(card->host, driver_width);
>  }
> 
>  if (!oldcard)
> @@ -624,4 +634,3 @@ err:
> 
>  return err;
> }
> -
> diff --git a/drivers/mmc/host/omap_hsmmc.c b/drivers/mmc/host/omap_hsmmc.c
> index af34871..92ad67e 100644
> --- a/drivers/mmc/host/omap_hsmmc.c
> +++ b/drivers/mmc/host/omap_hsmmc.c
> @@ -72,6 +72,7 @@
> #define MSBS 1<<5
> #define BCE 1<<1
> #define FOUR_BIT 1 << 1
> +#define DW8 (1 << 5)
> #define CC 0x1
> #define TC 0x02
> #define OD 0x1
> @@ -631,6 +632,7 @@ static void omap_mmc_set_ios(struct mmc_host *mmc, struct mmc_ios *ios)
>  u16 dsor = 0;
>  unsigned long regval;
>  unsigned long timeout;
> + u32 con;
> 
>  switch (ios->power_mode) {
>  case MMC_POWER_OFF:
> @@ -641,12 +643,18 @@ static void omap_mmc_set_ios(struct mmc_host *mmc, struct mmc_ios *ios)
>  break;
>  }
> 
> + con =  OMAP_HSMMC_READ(host->base, CON);
>  switch (mmc->ios.bus_width) {
> + case MMC_BUS_WIDTH_8:
> + OMAP_HSMMC_WRITE(host->base, CON, con | DW8);
> + break;
>  case MMC_BUS_WIDTH_4:
> + OMAP_HSMMC_WRITE(host->base, CON, con & ~DW8);
>  OMAP_HSMMC_WRITE(host->base, HCTL,
>  OMAP_HSMMC_READ(host->base, HCTL) | FOUR_BIT);
>  break;
>  case MMC_BUS_WIDTH_1:
> + OMAP_HSMMC_WRITE(host->base, CON, con & ~DW8);
>  OMAP_HSMMC_WRITE(host->base, HCTL,
>  OMAP_HSMMC_READ(host->base, HCTL) & ~FOUR_BIT);
>  break;
> @@ -814,6 +822,8 @@ static int __init omap_mmc_probe(struct platform_device *pdev)
> 
>  if (pdata->conf.wire4)
>  mmc->caps |= MMC_CAP_4_BIT_DATA;
> + if (pdata->conf.wire8)
> + mmc->caps |= MMC_CAP_8_BIT_DATA;
Have you tested an SD card after this change? Does the SD card switch to 4-bit mode?
My guess is that it might fail due to the below check in the SD core.
/*
         * Switch to wider bus (if supported).
         */
        if ((host->caps & MMC_CAP_4_BIT_DATA) &&
                (card->scr.bus_widths & SD_SCR_BUS_WIDTH_4)) {


> 
>  /* Only MMC1 supports 3.0V */
>  if (host->id == OMAP_MMC1_DEVID) {
> diff --git a/include/linux/mmc/host.h b/include/linux/mmc/host.h
> index 9c288c9..ddd8b97 100644
> --- a/include/linux/mmc/host.h
> +++ b/include/linux/mmc/host.h
> @@ -41,6 +41,7 @@ struct mmc_ios {
> 
> #define MMC_BUS_WIDTH_1 0
> #define MMC_BUS_WIDTH_4 2
> +#define MMC_BUS_WIDTH_8 3
> 
>  unsigned char timing; /* timing specification used */
> 
> @@ -111,11 +112,12 @@ struct mmc_host {
>  unsigned long caps; /* Host capabilities */
> 
> #define MMC_CAP_4_BIT_DATA (1 << 0) /* Can the host do 4 bit transfers */
> -#define MMC_CAP_MMC_HIGHSPEED (1 << 1) /* Can do MMC high-speed timing */
> -#define MMC_CAP_SD_HIGHSPEED (1 << 2) /* Can do SD high-speed timing */
> -#define MMC_CAP_SDIO_IRQ (1 << 3) /* Can signal pending SDIO IRQs */
> -#define MMC_CAP_SPI (1 << 4) /* Talks only SPI protocols */
> -#define MMC_CAP_NEEDS_POLL (1 << 5) /* Needs polling for card-detection */
> +#define MMC_CAP_8_BIT_DATA (1 << 1) /* Can the host do 8 bit transfers */
> +#define MMC_CAP_MMC_HIGHSPEED (1 << 2) /* Can do MMC high-speed timing */
> +#define MMC_CAP_SD_HIGHSPEED (1 << 3) /* Can do SD high-speed timing */
> +#define MMC_CAP_SDIO_IRQ (1 << 4) /* Can signal pending SDIO IRQs */
> +#define MMC_CAP_SPI (1 << 5) /* Talks only SPI protocols */
> +#define MMC_CAP_NEEDS_POLL (1 << 6) /* Needs polling for card-detection */
> 
>  /* host specific block data */
>  unsigned int max_seg_size; /* see blk_queue_max_segment_size */
> -- 
> 1.5.6.5
> 
> 
>
