From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: Re: [PATCH/RFC 4/4] OMAP2/3 MMC: initial conversion to runtime PM
Date: Tue, 23 Feb 2010 15:14:30 -0800
Message-ID: <87635nwnmx.fsf@deeprootsystems.com>
References: <1265244688-4055-1-git-send-email-khilman@deeprootsystems.com>
	<1265244688-4055-5-git-send-email-khilman@deeprootsystems.com>
	<004501caaf57$480e1b20$544ff780@am.dhcp.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-fx0-f219.google.com ([209.85.220.219]:36661 "EHLO
	mail-fx0-f219.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752656Ab0BWXOh (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 23 Feb 2010 18:14:37 -0500
Received: by fxm19 with SMTP id 19so4424676fxm.21
        for <linux-omap@vger.kernel.org>; Tue, 23 Feb 2010 15:14:36 -0800 (PST)
In-Reply-To: <004501caaf57$480e1b20$544ff780@am.dhcp.ti.com> (Madhusudhan's message of "Tue\, 16 Feb 2010 16\:27\:53 -0600")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Madhusudhan <madhu.cr@ti.com>
Cc: linux-omap@vger.kernel.org, 'Paul Walmsley' <paul@pwsan.com>

"Madhusudhan" <madhu.cr@ti.com> writes:

> <snip>
>
>>  err_irq:
>>  	mmc_host_disable(host->mmc);
>> -	clk_disable(host->iclk);
>> +	pm_runtime_suspend(host->dev);
>
> Why not pm_runtime_put_sync() here? It can replace the calls:
> mmc_host_disable(host->mmc);
> clk_disable(host->iclk);

Not knowing a ton about this driver, I'd rather keep the
mmc_host_disable() since it matches the mmc_host_enable() earlier.

>>  	clk_put(host->fclk);
>>  	clk_put(host->iclk);
>> +
>>  	if (host->got_dbclk) {
>>  		clk_disable(host->dbclk);
>>  		clk_put(host->dbclk);
>> @@ -2216,7 +2164,8 @@ static int omap_hsmmc_remove(struct platform_device
>> *pdev)
>>  		flush_scheduled_work();
>> 
>>  		mmc_host_disable(host->mmc);
>> -		clk_disable(host->iclk);
>> +		pm_runtime_suspend(host->dev);
>> +
>
> Ditto
>
>
>>  		clk_put(host->fclk);
>>  		clk_put(host->iclk);
>>  		if (host->got_dbclk) {
>> @@ -2272,7 +2221,7 @@ static int omap_hsmmc_suspend(struct device *dev)
>>  			OMAP_HSMMC_WRITE(host->base, HCTL,
>>  				OMAP_HSMMC_READ(host->base, HCTL) & ~SDBP);
>>  			mmc_host_disable(host->mmc);
>> -			clk_disable(host->iclk);
>> +
>>  			if (host->got_dbclk)
>>  				clk_disable(host->dbclk);
>>  		} else {
>> @@ -2287,6 +2236,11 @@ static int omap_hsmmc_suspend(struct device *dev)
>>  			mmc_host_disable(host->mmc);
>>  		}
>> 
>> +		/*
>> +		 * HACK: "extra" put to compensate for DPM core keeping
>> +		 *       runtime PM disabled.  -- khilman
>> +		 */
>> +		pm_runtime_put_sync(host->dev);
>>  	}
>>  	return ret;
>>  }
>> @@ -2302,12 +2256,14 @@ static int omap_hsmmc_resume(struct device *dev)
>>  		return 0;
>> 
>>  	if (host) {
>> -		ret = clk_enable(host->iclk);
>> -		if (ret)
>> -			goto clk_en_err;
>> +		/*
>> +		 * HACK: "extra" get to compensate for DPM core keeping
>> +		 *       runtime PM disabled.  -- khilman
>> +		 */
>> +		pm_runtime_get_sync(host->dev);
>> 
>>  		if (mmc_host_enable(host->mmc) != 0) {
>> -			clk_disable(host->iclk);
>> +			pm_runtime_suspend(host->dev);
>>  			goto clk_en_err;
>>  		}
>> 
>> @@ -2346,9 +2302,37 @@ clk_en_err:
>>  #define omap_hsmmc_resume		NULL
>>  #endif
>> 
>> +/* called just before device is disabled */
>> +static int omap_hsmmc_runtime_suspend(struct device *dev)
>> +{
>> +	struct omap_hsmmc_host *host;
>> +
>> +	dev_dbg(dev, "%s\n", __func__);
>> +
>> +	host = platform_get_drvdata(to_platform_device(dev));
>> +	omap_hsmmc_context_save(host);
>
> The context_save fn is now empty. How does it help here?

It doesn't add anything, but I put it there to show that this is the
only place that context save would be needed, and as an example to other
drivers.

Kevin

>> +
>> +	return 0;
>> +}
>> +
>> +/* called after device is (re)enabled, ONLY if context was lost */
>> +static int omap_hsmmc_runtime_resume(struct device *dev)
>> +{
>> +	struct omap_hsmmc_host *host;
>> +
>> +	dev_dbg(dev, "%s\n", __func__);
>> +
>> +	host = platform_get_drvdata(to_platform_device(dev));
>> +	omap_hsmmc_context_restore(host);
>> +
>> +	return 0;
>> +}
>> +
>>  static struct dev_pm_ops omap_hsmmc_dev_pm_ops = {
>>  	.suspend	= omap_hsmmc_suspend,
>>  	.resume		= omap_hsmmc_resume,
>> +	.runtime_suspend = omap_hsmmc_runtime_suspend,
>> +	.runtime_resume = omap_hsmmc_runtime_resume,
>>  };
>> 
>>  static struct platform_driver omap_hsmmc_driver = {
>> --
>> 1.6.6
>> 
>> --
>> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
