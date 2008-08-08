From: "Madhusudhan Chikkature" <madhu.cr@ti.com>
Subject: Re: [PATCH 3/3] Fixes required for HSMMC driver to work as module
Date: Fri, 8 Aug 2008 09:40:32 +0530 (IST)
Message-ID: <41545.192.168.10.89.1218168632.squirrel@dbdmail.itg.ti.com>
References: <40516.192.168.10.88.1216982063.squirrel@dbdmail.itg.ti.com>
    <20080805140430.GM7193@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from soda.ext.ti.com ([198.47.26.145]:37545 "EHLO soda.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750733AbYHHEKj (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 8 Aug 2008 00:10:39 -0400
In-Reply-To: <20080805140430.GM7193@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: linux-omap@vger.kernel.org

> * Madhusudhan Chikkature <madhu.cr@ti.com> [080725 13:34]:
>> From: Madhusudhan Chikkature<madhu.cr@ti.com>
>>
>> ARM: OMAP3: Fixes required to make HSMMC driver as module.
>>
>> This patch provides the necessary fixes to make the HSMMC driver work as
>> loadble module.
>
> This one does not apply, can you take a look?
>
> Thanks,
>
> Tony

Hi Tony,

I see that you have pushed this patch which did not apply correctly. So the
patch seems to have applied in part. Also the title for the commit seems to
have been wronly put as removing some usb defines.

I will post a patch which will complete the patch that I had send for HSMMC
driver to work as a module.

Regards,
Madhu

>
>
>> Signed-off-by: Madhusudhan Chikkature<madhu.cr@ti.com>
>> Signed-off-by: Romit Dasgupta <romit@ti.com>
>> ---
>>  drivers/mmc/host/omap_hsmmc.c |   43
>> +++++++++++++++++++++++++++++++-----------
>>  1 files changed, 32 insertions(+), 11 deletions(-)
>>
>> Index: linux-omap-ti.git-07142008/drivers/mmc/host/omap_hsmmc.c
>> ===================================================================
>> --- linux-omap-ti.git-07142008.orig/drivers/mmc/host/omap_hsmmc.c	2008-07-23
>> 16:31:56.000000000 +0530
>> +++ linux-omap-ti.git-07142008/drivers/mmc/host/omap_hsmmc.c	2008-07-24
>> 12:07:40.000000000 +0530
>> @@ -764,23 +764,27 @@ static int __init omap_mmc_probe(struct
>>  	if (IS_ERR(host->iclk)) {
>>  		ret = PTR_ERR(host->iclk);
>>  		host->iclk = NULL;
>> -		goto err;
>> +		goto err1;
>>  	}
>>  	host->fclk = clk_get(&pdev->dev, "mmchs_fck");
>>  	if (IS_ERR(host->fclk)) {
>>  		ret = PTR_ERR(host->fclk);
>>  		host->fclk = NULL;
>>  		clk_put(host->iclk);
>> -		goto err;
>> +		goto err1;
>>  	}
>>
>> -	if (clk_enable(host->fclk) != 0)
>> -		goto err;
>> +	if (clk_enable(host->fclk) != 0) {
>> +		clk_put(host->iclk);
>> +		clk_put(host->fclk);
>> +		goto err1;
>> +	}
>>
>>  	if (clk_enable(host->iclk) != 0) {
>>  		clk_disable(host->fclk);
>> +		clk_put(host->iclk);
>>  		clk_put(host->fclk);
>> -		goto err;
>> +		goto err1;
>>  	}
>>
>>  	host->dbclk = clk_get(&pdev->dev, "mmchsdb_fck");
>> @@ -873,12 +877,6 @@ static int __init omap_mmc_probe(struct
>>
>>  	return 0;
>>
>> -err:
>> -	dev_dbg(mmc_dev(host->mmc), "Probe Failed\n");
>> -	if (host)
>> -		mmc_free_host(mmc);
>> -	return ret;
>> -
>>  irq_err:
>>  	dev_dbg(mmc_dev(host->mmc), "Unable to configure MMC IRQs\n");
>>  	clk_disable(host->fclk);
>> @@ -890,6 +888,11 @@ irq_err:
>>  		clk_put(host->dbclk);
>>  	}
>>
>> +err1:
>> +	iounmap(host->base);
>> +err:
>> +	dev_dbg(mmc_dev(host->mmc), "Probe Failed\n");
>> +	release_mem_region(res->start, res->end - res->start + 1);
>>  	if (host)
>>  		mmc_free_host(mmc);
>>  	return ret;
>> @@ -898,9 +901,26 @@ irq_err:
>>  static int omap_mmc_remove(struct platform_device *pdev)
>>  {
>>  	struct mmc_omap_host *host = platform_get_drvdata(pdev);
>> +	struct resource *res;
>> +	u16 vdd = 0;
>> +
>> +	if (!(OMAP_HSMMC_READ(host->base, HCTL) & SDVSDET)) {
>> +	/*
>> +	 * Set the vdd back to 3V,
>> +	 * applicable for dual volt support.
>> +	 */
>> +		vdd = fls(host->mmc->ocr_avail) - 1;
>> +		if (omap_mmc_switch_opcond(host, vdd) != 0)
>> +			host->mmc->ios.vdd = vdd;
>> +	}
>> +
>> +	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
>> +	if (res)
>> +		release_mem_region(res->start, res->end - res->start + 1);
>>
>>  	platform_set_drvdata(pdev, NULL);
>>  	if (host) {
>> +		mmc_remove_host(host->mmc);
>>  		host->pdata->cleanup(&pdev->dev);
>>  		free_irq(host->irq, host);
>>  		if (mmc_slot(host).card_detect_irq)
>> @@ -917,6 +937,7 @@ static int omap_mmc_remove(struct platfo
>>  		}
>>
>>  		mmc_free_host(host->mmc);
>> +		iounmap(host->base);
>>  	}
>>
>>  	return 0;
>>
>>
>


