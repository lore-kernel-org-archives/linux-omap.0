From: Adrian Hunter <adrian.hunter@nokia.com>
Subject: Re: [PATCH 20/32] omap_hsmmc: put MMC regulator to sleep
Date: Sun, 26 Jul 2009 09:34:03 +0300
Message-ID: <4A6BF8DB.2020100@nokia.com>
References: <20090710124004.1262.10422.sendpatchset@ahunter-tower>	<20090710124227.1262.7056.sendpatchset@ahunter-tower> <20090724155144.4c621e6d.akpm@linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.105.134]:31577 "EHLO
	mgw-mx09.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752614AbZGZGeX (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sun, 26 Jul 2009 02:34:23 -0400
In-Reply-To: <20090724155144.4c621e6d.akpm@linux-foundation.org>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Andrew Morton <akpm@linux-foundation.org>
Cc: "pierre@ossman.eu" <pierre@ossman.eu>, "Lavinen Jarkko (Nokia-D/Helsinki)" <jarkko.lavinen@nokia.com>, "Karpov Denis.2 (EXT-Teleca/Helsinki)" <ext-denis.2.karpov@nokia.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

Andrew Morton wrote:
> On Fri, 10 Jul 2009 15:42:27 +0300
> Adrian Hunter <adrian.hunter@nokia.com> wrote:
> 
>> +static int omap_mmc_regsleep_to_enabled(struct mmc_omap_host *host)
>> +{
>> +	unsigned long timeout;
>> +
>> +	dev_dbg(mmc_dev(host->mmc), "REGSLEEP -> ENABLED\n");
>> +
>> +	clk_enable(host->fclk);
>> +	clk_enable(host->iclk);
>> +
>> +	if (clk_enable(host->dbclk))
>> +		dev_dbg(mmc_dev(host->mmc),
>> +			"Enabling debounce clk failed\n");
>> +
>> +	omap_mmc_restore_ctx(host);
>> +
>> +	/*
>> +	 * We turned off interrupts and bus power.  Interrupts
>> +	 * are turned on by 'mmc_omap_start_command()' so we
>> +	 * just need to turn on the bus power here.
>> +	 */
>> +	OMAP_HSMMC_WRITE(host->base, HCTL,
>> +			 OMAP_HSMMC_READ(host->base, HCTL) | SDBP);
>> +
>> +	timeout = jiffies + msecs_to_jiffies(MMC_TIMEOUT_MS);
>> +	while ((OMAP_HSMMC_READ(host->base, HCTL) & SDBP) != SDBP &&
>> +	       time_before(jiffies, timeout))
>> +		;
>> +
>> +	if (mmc_slot(host).set_sleep)
>> +		mmc_slot(host).set_sleep(host->dev, host->slot_id,
>> +					 0, host->vdd, 0);
>> +
>> +	host->dpm_state = ENABLED;
>> +
>> +	return 0;
>> +}
> 
> We take no action if the wait for SDBP timed out?

Yeah that is on my TODO list, but SDBP (and other bits we wait for)
will not timeout unless the hardware is broken or there is a bug
in the driver.  In either of those cases we are ruined anyway.

