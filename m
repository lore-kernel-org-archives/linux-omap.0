From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 1/9] OMAP: HSMMC: Make driver support dynamic idle
Date: Wed, 26 Nov 2008 11:11:09 -0800
Message-ID: <20081126191109.GY11997@atomide.com>
References: <49267E3B.7080303@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-bos.mailhop.org ([63.208.196.178]:63232 "EHLO
	mho-01-bos.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751193AbYKZTLJ (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 26 Nov 2008 14:11:09 -0500
Content-Disposition: inline
In-Reply-To: <49267E3B.7080303@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Adrian Hunter <ext-adrian.hunter@nokia.com>
Cc: "linux-omap@vger.kernel.org Mailing List" <linux-omap@vger.kernel.org>

* Adrian Hunter <ext-adrian.hunter@nokia.com> [081121 01:15]:
> Add a timer that is kept active by MMC requests. FCLK is disabled on timeout

Let's keep these patches on hold until we have the hsmmc.c driver in
mainline, then get them integrated via LKML.

Meanwhile, maybe you want to set up a git branch for hsmmc to queue these?
And then I could mirror your hsmmc branch.

Regards,

Tony


> Signed-off-by: Amit Kucheria <amit.kucheria@verdurent.com>
> ---
> drivers/mmc/host/omap_hsmmc.c |   73 +++++++++++++++++++++++++++++++++-------
> 1 files changed, 60 insertions(+), 13 deletions(-)
>
> diff --git a/drivers/mmc/host/omap_hsmmc.c b/drivers/mmc/host/omap_hsmmc.c
> index 0df6841..ee21a64 100644
> --- a/drivers/mmc/host/omap_hsmmc.c
> +++ b/drivers/mmc/host/omap_hsmmc.c
> @@ -121,6 +121,9 @@
> #define OMAP_HSMMC_WRITE(base, reg, val) \
> 	__raw_writel((val), (base) + OMAP_HSMMC_##reg)
>
> +enum {OFF = 0, ON};
> +#define IDLE_TIMEOUT (5*HZ)
> +
> struct mmc_omap_host {
> 	struct	device		*dev;
> 	struct	mmc_host	*mmc;
> @@ -148,9 +151,50 @@ struct mmc_omap_host {
> 	int			initstr;
> 	int			slot_id;
> 	int			dbclk_enabled;
> +
> +	struct timer_list       idle_timer;
> +	spinlock_t		clk_lock;     /* for changing enabled state */
> +	int			fclk_enabled:1;
> +
> 	struct	omap_mmc_platform_data	*pdata;
> };
>
> +int mmc_omap_fclk_state(struct mmc_omap_host *host, unsigned int state)
> +{
> +	unsigned long flags;
> +	int ret;
> +
> +	spin_lock_irqsave(&host->clk_lock, flags);
> +	if (host->fclk_enabled != state) {
> +		if (state == ON) {
> +			if (host->fclk_enabled == OFF) {
> +				ret = clk_enable(host->fclk);
> +				if (ret != 0)
> +					return ret;
> +				dev_dbg(mmc_dev(host->mmc),
> +					"mmc_fclk: enabled\n");
> +			}
> +			/* Revisit: Change the timer bump based on real
> +			   MMC usage characteristics */
> +			mod_timer(&host->idle_timer, jiffies + IDLE_TIMEOUT);
> +		} else {
> +			clk_disable(host->fclk);
> +			dev_dbg(mmc_dev(host->mmc), "mmc_fclk: disabled\n");
> +			del_timer(&host->idle_timer);
> +		}
> +		host->fclk_enabled = state;
> +	}
> +	spin_unlock_irqrestore(&host->clk_lock, flags);
> +	return 0;
> +}
> +
> +static void mmc_omap_idle_timer(unsigned long data)
> +{
> +	struct mmc_omap_host *host = (struct mmc_omap_host *) data;
> +
> +	mmc_omap_fclk_state(host, OFF);
> +}
> +
> /*
>  * Stop clock to the card
>  */
> @@ -457,7 +501,7 @@ static int omap_mmc_switch_opcond(struct mmc_omap_host *host, int vdd)
> 	int ret;
>
> 	/* Disable the clocks */
> -	clk_disable(host->fclk);
> +	mmc_omap_fclk_state(host, OFF);
> 	clk_disable(host->iclk);
> 	clk_disable(host->dbclk);
>
> @@ -471,7 +515,7 @@ static int omap_mmc_switch_opcond(struct mmc_omap_host *host, int vdd)
> 	if (ret != 0)
> 		goto err;
>
> -	clk_enable(host->fclk);
> +	mmc_omap_fclk_state(host, ON);
> 	clk_enable(host->iclk);
> 	clk_enable(host->dbclk);
>
> @@ -742,10 +786,10 @@ static void omap_mmc_request(struct mmc_host *mmc, struct mmc_request *req)
> 	WARN_ON(host->mrq != NULL);
> 	host->mrq = req;
> 	mmc_omap_prepare_data(host, req);
> +	mmc_omap_fclk_state(host, ON);
> 	mmc_omap_start_command(host, req->cmd, req->data);
> }
>
> -
> /* Routine to configure clock values. Exposed API to core */
> static void omap_mmc_set_ios(struct mmc_host *mmc, struct mmc_ios *ios)
> {
> @@ -824,6 +868,7 @@ static void omap_mmc_set_ios(struct mmc_host *mmc, struct mmc_ios *ios)
> 	if (ios->bus_mode == MMC_BUSMODE_OPENDRAIN)
> 		OMAP_HSMMC_WRITE(host->base, CON,
> 				OMAP_HSMMC_READ(host->base, CON) | OD);
> +
> }
>
> static int omap_hsmmc_get_cd(struct mmc_host *mmc)
> @@ -860,7 +905,7 @@ static int __init omap_mmc_probe(struct platform_device *pdev)
> 	struct mmc_host *mmc;
> 	struct mmc_omap_host *host = NULL;
> 	struct resource *res;
> -	int ret = 0, irq;
> +	int ret = 0, irq, reg;
> 	u32 hctl, capa;
>
> 	if (pdata == NULL) {
> @@ -925,14 +970,17 @@ static int __init omap_mmc_probe(struct platform_device *pdev)
> 		goto err1;
> 	}
>
> -	if (clk_enable(host->fclk) != 0) {
> +	spin_lock_init(&host->clk_lock);
> +	setup_timer(&host->idle_timer, mmc_omap_idle_timer,
> +		    (unsigned long) host);
> +
> +	if (mmc_omap_fclk_state(host, ON) != 0) {
> 		clk_put(host->iclk);
> 		clk_put(host->fclk);
> 		goto err1;
> 	}
> -
> 	if (clk_enable(host->iclk) != 0) {
> -		clk_disable(host->fclk);
> +		mmc_omap_fclk_state(host, OFF);
> 		clk_put(host->iclk);
> 		clk_put(host->fclk);
> 		goto err1;
> @@ -1047,7 +1095,7 @@ err_irq_cd:
> err_irq_cd_init:
> 	free_irq(host->irq, host);
> err_irq:
> -	clk_disable(host->fclk);
> +	mmc_omap_fclk_state(host, OFF);
> 	clk_disable(host->iclk);
> 	clk_put(host->fclk);
> 	clk_put(host->iclk);
> @@ -1096,7 +1144,7 @@ static int omap_mmc_remove(struct platform_device *pdev)
> 			free_irq(mmc_slot(host).card_detect_irq, host);
> 		flush_scheduled_work();
>
> -		clk_disable(host->fclk);
> +		mmc_omap_fclk_state(host, OFF);
> 		clk_disable(host->iclk);
> 		clk_put(host->fclk);
> 		clk_put(host->iclk);
> @@ -1149,7 +1197,7 @@ static int omap_mmc_suspend(struct platform_device *pdev, pm_message_t state)
> 					| SDBP);
> 			}
>
> -			clk_disable(host->fclk);
> +			mmc_omap_fclk_state(host, OFF);
> 			clk_disable(host->iclk);
> 			clk_disable(host->dbclk);
> 		}
> @@ -1169,13 +1217,12 @@ static int omap_mmc_resume(struct platform_device *pdev)
>
> 	if (host) {
>
> -		ret = clk_enable(host->fclk);
> -		if (ret)
> +		if (mmc_omap_fclk_state(host, ON) != 0)
> 			goto clk_en_err;
>
> 		ret = clk_enable(host->iclk);
> 		if (ret) {
> -			clk_disable(host->fclk);
> +			mmc_omap_fclk_state(host, OFF);
> 			clk_put(host->fclk);
> 			goto clk_en_err;
> 		}
> -- 
> 1.5.4.3
