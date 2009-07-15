From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: Re: [PATCH] OMAP3: PM: move context-loss counting into OMAP PM
Date: Wed, 15 Jul 2009 08:00:36 -0700
Message-ID: <87ocrm7zzf.fsf@deeprootsystems.com>
References: <1247078065-348-1-git-send-email-khilman@deeprootsystems.com>
	<005701ca04b8$27f39990$544ff780@am.dhcp.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from wf-out-1314.google.com ([209.85.200.170]:32064 "EHLO
	wf-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754893AbZGOPAl (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 15 Jul 2009 11:00:41 -0400
Received: by wf-out-1314.google.com with SMTP id 26so1259313wfd.4
        for <linux-omap@vger.kernel.org>; Wed, 15 Jul 2009 08:00:41 -0700 (PDT)
In-Reply-To: <005701ca04b8$27f39990$544ff780@am.dhcp.ti.com> (Madhusudhan's message of "Tue\, 14 Jul 2009 14\:20\:32 -0500")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>
Cc: linux-omap@vger.kernel.org, 'Rajendra Nayak' <rnayak@ti.com>, 'Peter 'p2' De Schrijver' <peter.de-schrijver@nokia.com>, Madhusudhan <madhu.cr@ti.com>

Paul,

"Madhusudhan" <madhu.cr@ti.com> writes:

>> From: Rajendra Nayak <rnayak@ti.com>
>> 
>> Drop get_last_off_on_transaction_id() and move functionality
>> into OMAP PM layer.
>> 
>> For SRF, use omapdev** to get powerdomain state counte
>> for NOOP, use an increasing counter to ensure context is always restord.
>> 
>> **NOTE: in future PM branch, this omapdev functinality will be replaced
>>         by omap_hwmod.  Thus, context loss counting will only exist
>>         for modules with omap_hwmod implementations.
>> 
>> Cc: Peter 'p2' De Schrijver <peter.de-schrijver@nokia.com>
>> Signed-off-by: Kevin Hilman <khilman@deeprootsystems.com>
>> ---
>> Applies to current PM branch and pm-2.6.29
>> 
>>  arch/arm/mach-omap2/pm.c          |   16 ----------------
>>  arch/arm/plat-omap/omap-pm-noop.c |    7 ++++++-
>>  arch/arm/plat-omap/omap-pm-srf.c  |   11 +++++++++++
>>  3 files changed, 17 insertions(+), 17 deletions(-)
>> 
>> diff --git a/arch/arm/mach-omap2/pm.c b/arch/arm/mach-omap2/pm.c
>> index 1192e01..fec7d00 100644
>> --- a/arch/arm/mach-omap2/pm.c
>> +++ b/arch/arm/mach-omap2/pm.c
>> @@ -31,7 +31,6 @@
>>  #include <asm/atomic.h>
>> 
>>  #include <mach/powerdomain.h>
>> -#include <mach/omapdev.h>
>>  #include <mach/resource.h>
>>  #include <mach/omap34xx.h>
>> 
>> @@ -221,21 +220,6 @@ void omap2_allow_sleep(void)
>>  	BUG_ON(i < 0);
>>  }
>> 
>> -unsigned get_last_off_on_transaction_id(struct device *dev)
>> -{
>> -	struct platform_device *pdev = to_platform_device(dev);
>> -	struct omapdev *odev = omapdev_find_pdev(pdev);
>> -	struct powerdomain *pwrdm;
>> -
>> -	if (odev) {
>> -		pwrdm = omapdev_get_pwrdm(odev);
>> -		if (pwrdm)
>> -			return pwrdm->state_counter[0];
>> -	}
>> -
>> -	return 0;
>> -}
>> -
>>  static int __init omap_pm_init(void)
>>  {
>>  	int error = -1;
>> diff --git a/arch/arm/plat-omap/omap-pm-noop.c b/arch/arm/plat-omap/omap-
>> pm-noop.c
>> index 4ba261a..07b208b 100644
>> --- a/arch/arm/plat-omap/omap-pm-noop.c
>> +++ b/arch/arm/plat-omap/omap-pm-noop.c
>> @@ -277,6 +277,8 @@ unsigned long omap_pm_cpu_get_freq(void)
>> 
>>  int omap_pm_get_dev_context_loss_count(struct device *dev)
>>  {
>> +	static u32 counter = 0;
>> +
>>  	if (!dev) {
>>  		WARN_ON(1);
>>  		return -EINVAL;
>> @@ -290,7 +292,10 @@ int omap_pm_get_dev_context_loss_count(struct device
>> *dev)
>>  	 * off counter.
>>  	 */
>> 
>> -	return 0;
>> +	/* For the noop case, we cannot know the off counter, so
>> +	 * return an increasing counter which will ensure that
>> +	 * context is always restored. */
>> +	return counter++;
>>  }
>> 
>>  /*
>> diff --git a/arch/arm/plat-omap/omap-pm-srf.c b/arch/arm/plat-omap/omap-
>> pm-srf.c
>> index 226662d..cac08e4 100644
>> --- a/arch/arm/plat-omap/omap-pm-srf.c
>> +++ b/arch/arm/plat-omap/omap-pm-srf.c
>> @@ -276,6 +276,10 @@ EXPORT_SYMBOL(omap_pm_cpu_get_freq);
>> 
>>  int omap_pm_get_dev_context_loss_count(struct device *dev)
>>  {
>> +	struct platform_device *pdev;
>> +	struct omapdev *odev;
>> +	struct powerdomain *pwrdm;
>> +
>>  	if (!dev) {
>>  		WARN_ON(1);
>>  		return -EINVAL;
>> @@ -288,7 +292,14 @@ int omap_pm_get_dev_context_loss_count(struct device
>> *dev)
>>  	 * Map the device to the powerdomain.  Return the powerdomain
>>  	 * off counter.
>>  	 */
>> +	pdev = to_platform_device(dev);
>> +	odev = omapdev_find_pdev(pdev);
>> 
>> +	if (odev) {
>> +		pwrdm = omapdev_get_pwrdm(odev);
>> +		if (pwrdm)
>> +			return pwrdm->state_counter[0];
>
> The state_counter is unsigned and the return type of this fn does not match.

Paul, any thoughts on this?

Kevin

