From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: Re: [PATCH 10/13] OMAP: omap_device: add flag to disable automatic bus-level suspend/resume
Date: Thu, 24 Jun 2010 10:39:26 -0700
Message-ID: <87zkykfhyp.fsf@deeprootsystems.com>
References: <1277336563-24988-1-git-send-email-khilman@deeprootsystems.com>
	<1277336563-24988-11-git-send-email-khilman@deeprootsystems.com>
	<alpine.DEB.2.00.1006232136440.1550@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-pv0-f174.google.com ([74.125.83.174]:60334 "EHLO
	mail-pv0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755022Ab0FXRj2 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 24 Jun 2010 13:39:28 -0400
Received: by pvg2 with SMTP id 2so459360pvg.19
        for <linux-omap@vger.kernel.org>; Thu, 24 Jun 2010 10:39:28 -0700 (PDT)
In-Reply-To: <alpine.DEB.2.00.1006232136440.1550@utopia.booyaka.com> (Paul
	Walmsley's message of "Wed, 23 Jun 2010 21:40:05 -0600 (MDT)")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>
Cc: linux-omap@vger.kernel.org

Paul Walmsley <paul@pwsan.com> writes:

> Hi Kevin,
>
> A few comments:
>
> Your "add runtime PM support at bus-level" series has a unstated 
> dependency on this patch.  If you fix one minor issue (below), it's 
> probably easiest if you merge it with that other series to avoid 
> cross-dependencies.

If I switch (back) to just using pm_runtime_* API in the system PM
path _noirq methods, then rather than setting this flag at the
omap_device level, drivers that want to prevent this can simply
do a runtime_pm_get_sync() if they want to prevent a bus-level
suspend.

Any thoughts/objectsion to that?

Kevin


> On Wed, 23 Jun 2010, Kevin Hilman wrote:
>
>> As part of the runtime PM support, bus-level code can automatically
>> handle the enable/idle for each omap_device.  There are, however, some
>> special cases where we don't want the bus-level layer to handle this,
>> and instead handle it manually.
>> 
>> Specific use cases are for omap_devices that are controlled
>> inside the idle path (like UART.)
>> 
>> Signed-off-by: Kevin Hilman <khilman@deeprootsystems.com>
>> ---
>>  arch/arm/plat-omap/include/plat/omap_device.h |    5 +++++
>>  1 files changed, 5 insertions(+), 0 deletions(-)
>> 
>> diff --git a/arch/arm/plat-omap/include/plat/omap_device.h b/arch/arm/plat-omap/include/plat/omap_device.h
>> index 3694b62..2cdbcdd 100644
>> --- a/arch/arm/plat-omap/include/plat/omap_device.h
>> +++ b/arch/arm/plat-omap/include/plat/omap_device.h
>> @@ -68,12 +68,16 @@ struct omap_device {
>>  	struct omap_device_pm_latency	*pm_lats;
>>  	u32				dev_wakeup_lat;
>>  	u32				_dev_wakeup_lat_limit;
>> +	u32                             flags;
>
> This should be a u8.  Fix that and it is 
>
> Acked-by: Paul Walmsley <paul@pwsan.com>
>
>>  	u8				pm_lats_cnt;
>>  	s8				pm_lat_level;
>>  	u8				hwmods_cnt;
>>  	u8				_state;
>>  };
>>  
>> +/* flags for struct omap_device */
>> +#define OMAP_DEVICE_NO_BUS_SUSPEND     BIT(0)
>> +
>>  /* Device driver interface (call via platform_data fn ptrs) */
>>  
>>  int omap_device_enable(struct platform_device *pdev);
>> @@ -142,6 +146,7 @@ struct omap_device_pm_latency {
>>  	u32 flags;
>>  };
>>  
>> +/* flags for struct omap_device_pm_latency */
>>  #define OMAP_DEVICE_LATENCY_AUTO_ADJUST BIT(1)
>>  
>>  /* Get omap_device pointer from platform_device pointer */
>> -- 
>> 1.7.0.2
>> 
>> --
>> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>> 
>
>
> - Paul
