From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 2/3]HSMMC fix for hotplug scenario with I/O in progress
Date: Tue, 5 Aug 2008 17:04:49 +0300
Message-ID: <20080805140449.GN7193@atomide.com>
References: <40116.192.168.10.88.1216982001.squirrel@dbdmail.itg.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-bos.mailhop.org ([63.208.196.178]:58761 "EHLO
	mho-01-bos.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752159AbYHEOEz (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 5 Aug 2008 10:04:55 -0400
Content-Disposition: inline
In-Reply-To: <40116.192.168.10.88.1216982001.squirrel@dbdmail.itg.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Madhusudhan Chikkature <madhu.cr@ti.com>
Cc: linux-omap@vger.kernel.org

* Madhusudhan Chikkature <madhu.cr@ti.com> [080725 13:33]:
> From: Madhusudhan Chikkature<madhu.cr@ti.com>
> 
> ARM: OMAP3: HSMMC fix for hotplug scenario.
> 
> This patch fixes the inconsistancy noted if the card is removed from the slot
> duing an active I/O.

Pushing today.

Tony

> Signed-off-by: Madhusudhan Chikkature<madhu.cr@ti.com>
> Signed-off-by: Romit Dasgupta <romit@ti.com>
> ---
>  drivers/mmc/host/omap_hsmmc.c |   11 +++++++++--
>  1 files changed, 9 insertions(+), 2 deletions(-)
> 
> Index: linux-omap-ti.git-07142008/drivers/mmc/host/omap_hsmmc.c
> ===================================================================
> --- linux-omap-ti.git-07142008.orig/drivers/mmc/host/omap_hsmmc.c	2008-07-17
> 16:07:05.000000000 +0530
> +++ linux-omap-ti.git-07142008/drivers/mmc/host/omap_hsmmc.c	2008-07-17
> 16:08:48.000000000 +0530
> @@ -85,6 +85,7 @@
>  #define INIT_STREAM_CMD		0x00000000
>  #define DUAL_VOLT_OCR_BIT	7
>  #define SRC			(1 << 25)
> +#define SRD			(1 << 26)
> 
>  #define OMAP_MMC1_DEVID		1
>  #define OMAP_MMC2_DEVID		2
> @@ -301,6 +302,7 @@ static void mmc_dma_cleanup(struct mmc_o
>  static irqreturn_t mmc_omap_irq(int irq, void *dev_id)
>  {
>  	struct mmc_omap_host *host = dev_id;
> +	struct mmc_data *data;
>  	int end_cmd = 0, end_trans = 0, status;
> 
>  	if (host->cmd == NULL && host->data == NULL) {
> @@ -309,6 +311,7 @@ static irqreturn_t mmc_omap_irq(int irq,
>  		return IRQ_HANDLED;
>  	}
> 
> +	data = host->data;
>  	status = OMAP_HSMMC_READ(host->base, STAT);
>  	dev_dbg(mmc_dev(host->mmc), "IRQ Status is %x\n", status);
> 
> @@ -356,7 +359,7 @@ static irqreturn_t mmc_omap_irq(int irq,
>  	if (end_cmd || (status & CC))
>  		mmc_omap_cmd_done(host, host->cmd);
>  	if (end_trans || (status & TC))
> -		mmc_omap_xfer_done(host, host->data);
> +		mmc_omap_xfer_done(host, data);
> 
>  	return IRQ_HANDLED;
>  }
> @@ -436,8 +439,12 @@ static void mmc_omap_detect(struct work_
>  				host->mmc->ios.vdd = vdd;
>  		}
>  		mmc_detect_change(host->mmc, (HZ * 200) / 1000);
> -	} else
> +	} else {
> +		OMAP_HSMMC_WRITE(host->base, SYSCTL,
> +			OMAP_HSMMC_READ(host->base, SYSCTL) | SRD);
> +		while (OMAP_HSMMC_READ(host->base, SYSCTL) & SRD) ;
>  		mmc_detect_change(host->mmc, (HZ * 50) / 1000);
> +	}
>  }
> 
>  /*
> 
> 
