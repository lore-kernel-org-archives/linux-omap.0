From: Nishanth Menon <nm@ti.com>
Subject: Re: [PATCH 14/19] omap3+: sr: introduce notifiers flags
Date: Thu, 03 Mar 2011 06:17:00 +0530
Message-ID: <4D6EE504.8030100@ti.com>
References: <1298116918-30744-1-git-send-email-nm@ti.com>	<1298116918-30744-15-git-send-email-nm@ti.com> <87vd01ukek.fsf@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog106.obsmtp.com ([74.125.149.77]:55725 "EHLO
	na3sys009aog106.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756658Ab1CCArf (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 2 Mar 2011 19:47:35 -0500
Received: by mail-vw0-f49.google.com with SMTP id 7so554727vws.8
        for <linux-omap@vger.kernel.org>; Wed, 02 Mar 2011 16:47:34 -0800 (PST)
In-Reply-To: <87vd01ukek.fsf@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@ti.com>
Cc: linux-omap <linux-omap@vger.kernel.org>, Tony Lindgren <tony@atomide.com>

Kevin Hilman wrote, on 03/03/2011 05:47 AM:
[..]
>
>> diff --git a/arch/arm/plat-omap/include/plat/smartreflex.h b/arch/arm/plat-omap/include/plat/smartreflex.h
>> index 8b6ecd9..ff07d1e 100644
>> --- a/arch/arm/plat-omap/include/plat/smartreflex.h
>> +++ b/arch/arm/plat-omap/include/plat/smartreflex.h
>> @@ -141,6 +141,12 @@
>>   #define OMAP3430_SR_ERRWEIGHT		0x04
>>   #define OMAP3430_SR_ERRMAXLIMIT		0x02
>>
>> +/* Smart reflex notifiers for class drivers to use */
>> +#define SR_NOTIFY_MCUACCUM     (0x1<<  0)
>> +#define SR_NOTIFY_MCUVALID     (0x1<<  1)
>> +#define SR_NOTIFY_MCUBOUND     (0x1<<  2)
>> +#define SR_NOTIFY_MCUDISACK    (0x1<<  3)
>> +
>
> Please use BIT(x)

Ack.

-- 
Regards,
Nishanth Menon
