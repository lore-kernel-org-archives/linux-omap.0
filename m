From: Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH 20/32] omap_hsmmc: put MMC regulator to sleep
Date: Fri, 24 Jul 2009 15:51:44 -0700
Message-ID: <20090724155144.4c621e6d.akpm@linux-foundation.org>
References: <20090710124004.1262.10422.sendpatchset@ahunter-tower>
	<20090710124227.1262.7056.sendpatchset@ahunter-tower>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1755015AbZGXWvz@vger.kernel.org>
In-Reply-To: <20090710124227.1262.7056.sendpatchset@ahunter-tower>
Sender: linux-kernel-owner@vger.kernel.org
Cc: pierre@ossman.eu, jarkko.lavinen@nokia.com, ext-denis.2.karpov@nokia.com, adrian.hunter@nokia.com, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

On Fri, 10 Jul 2009 15:42:27 +0300
Adrian Hunter <adrian.hunter@nokia.com> wrote:

> +static int omap_mmc_regsleep_to_enabled(struct mmc_omap_host *host)
> +{
> +	unsigned long timeout;
> +
> +	dev_dbg(mmc_dev(host->mmc), "REGSLEEP -> ENABLED\n");
> +
> +	clk_enable(host->fclk);
> +	clk_enable(host->iclk);
> +
> +	if (clk_enable(host->dbclk))
> +		dev_dbg(mmc_dev(host->mmc),
> +			"Enabling debounce clk failed\n");
> +
> +	omap_mmc_restore_ctx(host);
> +
> +	/*
> +	 * We turned off interrupts and bus power.  Interrupts
> +	 * are turned on by 'mmc_omap_start_command()' so we
> +	 * just need to turn on the bus power here.
> +	 */
> +	OMAP_HSMMC_WRITE(host->base, HCTL,
> +			 OMAP_HSMMC_READ(host->base, HCTL) | SDBP);
> +
> +	timeout = jiffies + msecs_to_jiffies(MMC_TIMEOUT_MS);
> +	while ((OMAP_HSMMC_READ(host->base, HCTL) & SDBP) != SDBP &&
> +	       time_before(jiffies, timeout))
> +		;
> +
> +	if (mmc_slot(host).set_sleep)
> +		mmc_slot(host).set_sleep(host->dev, host->slot_id,
> +					 0, host->vdd, 0);
> +
> +	host->dpm_state = ENABLED;
> +
> +	return 0;
> +}

We take no action if the wait for SDBP timed out?
