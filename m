From: Felipe Balbi <felipe.balbi@nokia.com>
Subject: Re: [PATCH]Enable 4-bit in HSMMC1 and HSMMC2 platform data
Date: Thu, 11 Sep 2008 14:35:04 +0300
Message-ID: <20080911113504.GD16796@gandalf.research.nokia.com>
References: <62710.192.168.10.89.1218608010.squirrel@dbdmail.itg.ti.com> <20080910235646.GV21163@atomide.com> <20080911084828.GC26078@flint.arm.linux.org.uk> <20080911112315.GA10002@angel.research.nokia.com>
Reply-To: felipe.balbi@nokia.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.105.134]:36072 "EHLO
	mgw-mx09.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752321AbYIKLfl (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 11 Sep 2008 07:35:41 -0400
Content-Disposition: inline
In-Reply-To: <20080911112315.GA10002@angel.research.nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: ext Jarkko Lavinen <jarkko.lavinen@nokia.com>
Cc: Russell King - ARM Linux <linux@arm.linux.org.uk>, Tony Lindgren <tony@atomide.com>, Madhusudhan Chikkature <madhu.cr@ti.com>, linux-omap@vger.kernel.org, Pierre Ossman <drzeus-list@drzeus.cx>

On Thu, Sep 11, 2008 at 02:23:15PM +0300, ext Jarkko Lavinen wrote:
> On Thu, Sep 11, 2008 at 09:48:28AM +0100, ext Russell King - ARM Linux wrote:
> > So, given my update for this, shouldn't this be something sent almost
> > immediately to me so stuff for mainline isn't falling behind.
> 
> Hi Russell and all
> 
> Here is a hopefully self-explaining patch, which enables 8-bit
> support similar to the 4-bit support in Omap HSMMC when then mmc
> confifuration from platform data tells it is available.
> 
> I have tested it on a testboard with 2.6.26 beased kernel and
> write speed increased some 30..40%.

Maybe Pierre should be watching this patch as well. I'm putting him in
the loop.

> diff --git a/drivers/mmc/core/mmc.c b/drivers/mmc/core/mmc.c
> index fdd7c76..8c55df3 100644
> --- a/drivers/mmc/core/mmc.c
> +++ b/drivers/mmc/core/mmc.c
> @@ -434,13 +434,23 @@ static int mmc_init_card(struct mmc_host *host, u32 ocr,
>  	 * Activate wide bus (if supported).
>  	 */
>  	if ((card->csd.mmca_vsn >= CSD_SPEC_VER_4) &&
> -		(host->caps & MMC_CAP_4_BIT_DATA)) {
> +	    (host->caps & (MMC_CAP_4_BIT_DATA | MMC_CAP_8_BIT_DATA))) {
> +		unsigned ext_csd_bit, driver_width;
> +
> +		if (host->caps & MMC_CAP_8_BIT_DATA) {
> +			ext_csd_bit = EXT_CSD_BUS_WIDTH_8;
> +			driver_width = MMC_BUS_WIDTH_8;
> +		} else {
> +			ext_csd_bit = EXT_CSD_BUS_WIDTH_4;
> +			driver_width = MMC_BUS_WIDTH_4;
> +		}

maybe you could:

	[...]
	unsigned ext_csd_bit, driver_width;
	[...]

	if ((card->csd.mmca_vsn >= CSD_SPEC_VER_4) &&
		(host->caps & MMC_CAP_4_BIT_DATA)) {
			ext_csd_bit = EXT_CSD_BUS_WIDTH_8;
			driver_width = MMC_BUS_WIDTH_8;
	}

	if ((card->csd.mmca_vsn >= CSD_SPEC_VER_4) &&
		(host->caps & MMC_CAP_8_BIT_DATA)) {
			ext_csd_bit = EXT_CSD_BUS_WIDTH_4;
			driver_width = MMC_BUS_WIDTH_4;
	}

> diff --git a/drivers/mmc/host/omap_hsmmc.c b/drivers/mmc/host/omap_hsmmc.c
> index af34871..92ad67e 100644
> --- a/drivers/mmc/host/omap_hsmmc.c
> +++ b/drivers/mmc/host/omap_hsmmc.c
> @@ -72,6 +72,7 @@
>  #define MSBS			1<<5
>  #define BCE			1<<1
>  #define FOUR_BIT		1 << 1

someone needs to clean up those #defines...

> @@ -111,11 +112,12 @@ struct mmc_host {
>  	unsigned long		caps;		/* Host capabilities */
>  
>  #define MMC_CAP_4_BIT_DATA	(1 << 0)	/* Can the host do 4 bit transfers */
> -#define MMC_CAP_MMC_HIGHSPEED	(1 << 1)	/* Can do MMC high-speed timing */
> -#define MMC_CAP_SD_HIGHSPEED	(1 << 2)	/* Can do SD high-speed timing */
> -#define MMC_CAP_SDIO_IRQ	(1 << 3)	/* Can signal pending SDIO IRQs */
> -#define MMC_CAP_SPI		(1 << 4)	/* Talks only SPI protocols */
> -#define MMC_CAP_NEEDS_POLL	(1 << 5)	/* Needs polling for card-detection */
> +#define MMC_CAP_8_BIT_DATA	(1 << 1)	/* Can the host do 8 bit transfers */
> +#define MMC_CAP_MMC_HIGHSPEED	(1 << 2)	/* Can do MMC high-speed timing */
> +#define MMC_CAP_SD_HIGHSPEED	(1 << 3)	/* Can do SD high-speed timing */
> +#define MMC_CAP_SDIO_IRQ	(1 << 4)	/* Can signal pending SDIO IRQs */
> +#define MMC_CAP_SPI		(1 << 5)	/* Talks only SPI protocols */
> +#define MMC_CAP_NEEDS_POLL	(1 << 6)	/* Needs polling for card-detection */

This would require changes to all other mmc host drivers, right ?
How about:

+#define MMC_CAP_8_BIT_DATA	(1 << 6)	/* Can the host do 8 bit transfers */

-- 
balbi
