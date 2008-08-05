From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 1/3] HSMMC driver fix for core ret
Date: Tue, 5 Aug 2008 17:05:05 +0300
Message-ID: <20080805140504.GO7193@atomide.com>
References: <39478.192.168.10.88.1216981939.squirrel@dbdmail.itg.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-bos.mailhop.org ([63.208.196.178]:59092 "EHLO
	mho-01-bos.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755010AbYHEOFR (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 5 Aug 2008 10:05:17 -0400
Content-Disposition: inline
In-Reply-To: <39478.192.168.10.88.1216981939.squirrel@dbdmail.itg.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Madhusudhan Chikkature <madhu.cr@ti.com>
Cc: linux-omap@vger.kernel.org

* Madhusudhan Chikkature <madhu.cr@ti.com> [080725 13:32]:
> From: Madhusudhan Chikkature<madhu.cr@ti.com>
> 
> ARM: OMAP3: HSMMC fix for core ret.
> 
> The core ret seem to be prevented by HSMMC CTO errors. This patch provides a
> fix for the same.

Pushing today.

Tony


> Signed-off-by: Madhusudhan Chikkature<madhu.cr@ti.com>
> ---
>  drivers/mmc/host/omap_hsmmc.c |   11 +++++++++--
>  1 files changed, 9 insertions(+), 2 deletions(-)
> 
> Index: linux-omap-ti.git-07142008/drivers/mmc/host/omap_hsmmc.c
> ===================================================================
> --- linux-omap-ti.git-07142008.orig/drivers/mmc/host/omap_hsmmc.c	2008-07-10
> 14:59:37.000000000 +0530
> +++ linux-omap-ti.git-07142008/drivers/mmc/host/omap_hsmmc.c	2008-07-17
> 15:08:29.000000000 +0530
> @@ -84,6 +84,7 @@
>  #define STAT_CLEAR		0xFFFFFFFF
>  #define INIT_STREAM_CMD		0x00000000
>  #define DUAL_VOLT_OCR_BIT	7
> +#define SRC			(1 << 25)
> 
>  #define OMAP_MMC1_DEVID		1
>  #define OMAP_MMC2_DEVID		2
> @@ -315,10 +316,16 @@ static irqreturn_t mmc_omap_irq(int irq,
>  		if ((status & CMD_TIMEOUT) ||
>  			(status & CMD_CRC)) {
>  			if (host->cmd) {
> -				if (status & CMD_TIMEOUT)
> +				if (status & CMD_TIMEOUT) {
> +					OMAP_HSMMC_WRITE(host->base, SYSCTL,
> +						OMAP_HSMMC_READ(host->base,
> +								SYSCTL) | SRC);
> +					while (OMAP_HSMMC_READ(host->base,
> +								SYSCTL) & SRC) ;
>  					host->cmd->error = -ETIMEDOUT;
> -				else
> +				} else {
>  					host->cmd->error = -EILSEQ;
> +				}
>  				end_cmd = 1;
>  			}
>  			if (host->data)
> 
> 
