From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: Re: [PATCH/RFC 0/4] convert HS-MMC driver to hwmod + runtime PM
Date: Wed, 24 Feb 2010 16:23:59 -0800
Message-ID: <87vddmmacg.fsf@deeprootsystems.com>
References: <1265244688-4055-1-git-send-email-khilman@deeprootsystems.com>
	<87ocjftq0z.fsf@deeprootsystems.com>
	<005001cab56f$17db8460$544ff780@am.dhcp.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-pw0-f46.google.com ([209.85.160.46]:35075 "EHLO
	mail-pw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758593Ab0BYAYD (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 24 Feb 2010 19:24:03 -0500
Received: by pwj8 with SMTP id 8so5242735pwj.19
        for <linux-omap@vger.kernel.org>; Wed, 24 Feb 2010 16:24:02 -0800 (PST)
In-Reply-To: <005001cab56f$17db8460$544ff780@am.dhcp.ti.com> (Madhusudhan's message of "Wed\, 24 Feb 2010 10\:33\:27 -0600")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Madhusudhan <madhu.cr@ti.com>
Cc: linux-omap@vger.kernel.org

"Madhusudhan" <madhu.cr@ti.com> writes:

>> -----Original Message-----
>> From: linux-omap-owner@vger.kernel.org [mailto:linux-omap-
>> owner@vger.kernel.org] On Behalf Of Kevin Hilman
>> Sent: Tuesday, February 23, 2010 6:51 PM
>> To: linux-omap@vger.kernel.org
>> Subject: Re: [PATCH/RFC 0/4] convert HS-MMC driver to hwmod + runtime PM
>> 
>> Kevin Hilman <khilman@deeprootsystems.com> writes:
>> 
>> > This series converts the OMAP HS-MMC driver to use omap_hwmod +
>> > runtime PM API.
>> >
>> > Depends on MMC hwmods available in 'pm-wip/hwmods' branch of
>> > my git tree[1] as well as previously posted runtime PM series:
>> >
>> >    [PATCH/RFC 0/2] initial runtime PM layer for OMAP
>> >
>> > The easies way to experiment/test is to use my 'pm-wip/mmc' branch
>> > which has all the dependencies, and is based on omap/for-next'.
>> > It has been tested by merging with current PM branch.
>> >
>> > [1] http://git.kernel.org/?p=linux/kernel/git/khilman/linux-omap-pm.git
>> >
>> 
>> A question for those of you who actually understand the MMC driver...
>> I'm having problems getting my head around the current PM stuff in the
>> MMC driver.  My primary question is:
>> 
>> Why does the suspend hook need to re-enable the device before
>> suspending?
>>
>
> In the scenario where there is no activity on the bus the MMC clocks are
> kept disabled. Now in the suspend path the MMC core will issue certain CMDs
> like CMD7(to end the suspend path) to deselect the card(more of a protocol
> stuff). Hence the host need to be in enabled state before letting the core
> know that there is a suspend request.

I guess what I'm wondering is whether we can (should) have the exact
same path for runtime PM (idle) and static PM (suspend/resume.)

My current approach is that the suspend is a NOP if the device
is already runtime suspended.

>> When using runtime PM, the MMC device is disabled including
>> clocks off  and regulator off (if power_savings == true) when there
>> is no activity.
>> 
>> Then, in the static suspend hook, it's re-enabled (including taking it out
>> of
>> off, re-enabling regulators etc) only to be quickly disabled again.
>> This seems horribly inefficient.
>> 
>
> This is exactly for the reason I mentioned above.
>
>> I admit to not understanding the MMC layer terribly well, so can someone
>> enlighten me as to what is going on here?
>> 
>> What I am testing here is a patch on top of this series (below) that
>> adds a check to the static suspend hook.  If the device is already
>> runtime suspended, then the suspend and resume hooks should be noop.
>> 
>> This appears to work just fine while testing on omap3evm just doing
>> simple read/write tests before an after suspend resume.
>>
>
> I did some basic testing with your previously posted patches. But my testing
> was incomplete because on Zoom2 because for some reason the OFF mode was not
> working even without your patches.

OK, I will try on Zoom2.  I've only tested this so far on OMAP3EVM.

> My concern was more with respect to OFF mode in idle path since your patches
> removed context restore calls if I recall correctly. 

No, I didn't remove restore.  I just moved it into the runtime PM
resume callback.

> Are you able to hit CORE OFF and then come back and do the
> read/write transfers in idle as well as suspend/resume path?

Yes.

Kevin

>  
>> Note that if you want to test this patch, it also depends on this
>> patch to runtime PM from the linux-pm list:
>> https://lists.linux-foundation.org/pipermail/linux-pm/2010-
>> February/024275.html
>> 
>> These are all included in an updated version of my pm-wip/mmc branch
>> for ease of testing.  Merge it with the current PM branch, enable
>> CONFIG_PM_RUNTIME and test away.
>> 
>> Kevin
>> 
>> commit 166cba7679fa267ee6e6eb39fd1e871ede5ded16
>> Author: Kevin Hilman <khilman@deeprootsystems.com>
>> Date:   Tue Feb 23 16:21:56 2010 -0800
>> 
>>     MMC: omap_hsmmc: check for runtime-suspend in static suspend
>> 
>> diff --git a/drivers/mmc/host/omap_hsmmc.c b/drivers/mmc/host/omap_hsmmc.c
>> index 16d66b9..dd027bb 100644
>> --- a/drivers/mmc/host/omap_hsmmc.c
>> +++ b/drivers/mmc/host/omap_hsmmc.c
>> @@ -2222,6 +2222,9 @@ static int omap_hsmmc_suspend(struct device *dev)
>>  	if (host && host->suspended)
>>  		return 0;
>> 
>> +	if (pm_is_runtime_suspended(host->dev))
>> +		return 0;
>> +
>>  	if (host) {
>>  		host->suspended = 1;
>>  		if (host->pdata->suspend) {
>> @@ -2260,12 +2263,6 @@ static int omap_hsmmc_suspend(struct device *dev)
>>  			}
>>  			mmc_host_disable(host->mmc);
>>  		}
>> -
>> -		/*
>> -		 * HACK: "extra" put to compensate for DPM core keeping
>> -		 *       runtime PM disabled.  -- khilman
>> -		 */
>> -		pm_runtime_put_sync(host->dev);
>>  	}
>>  	return ret;
>>  }
>> @@ -2280,13 +2277,10 @@ static int omap_hsmmc_resume(struct device *dev)
>>  	if (host && !host->suspended)
>>  		return 0;
>> 
>> -	if (host) {
>> -		/*
>> -		 * HACK: "extra" get to compensate for DPM core keeping
>> -		 *       runtime PM disabled.  -- khilman
>> -		 */
>> -		pm_runtime_get_sync(host->dev);
>> +	if (pm_is_runtime_suspended(host->dev))
>> +		return 0;
>> 
>> +	if (host) {
>>  		if (mmc_host_enable(host->mmc) != 0) {
>>  			pm_runtime_suspend(host->dev);
>>  			goto clk_en_err;
>> 
>> 
>> 
>> --
>> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
