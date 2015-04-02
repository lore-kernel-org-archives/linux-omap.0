From: Lokesh Vutla <lokeshvutla@ti.com>
Subject: Re: [rtc-linux] [PATCH 1/3] rtc: omap: Unlock and Lock rtc registers
 before and after register writes
Date: Thu, 2 Apr 2015 16:42:28 +0530
Message-ID: <551D241C.8040709@ti.com>
References: <1427867698-1326-1-git-send-email-lokeshvutla@ti.com> <1427867698-1326-2-git-send-email-lokeshvutla@ti.com> <20150401155204.GC20669@piout.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:36308 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752420AbbDBLNB (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 2 Apr 2015 07:13:01 -0400
In-Reply-To: <20150401155204.GC20669@piout.net>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Alexandre Belloni <alexandre.belloni@free-electrons.com>, rtc-linux@googlegroups.com
Cc: a.zummo@towertech.it, t-kristo@ti.com, nsekhar@ti.com, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org

Hi,

On Wednesday 01 April 2015 09:22 PM, Alexandre Belloni wrote:
> Hi,
> 
> On 01/04/2015 at 11:24:56 +0530, Lokesh Vutla wrote :
>> RTC module contains a kicker mechanism to prevent any spurious writes
>> from changing the register values. This mechanism requires two MMR
>> writes to the KICK0 and KICK1 registers with exact data values
>> before the kicker lock mechanism is released.
>>
>> Currently the driver release the lock in the probe and leaves it enabled
>> until the rtc driver removal. This eliminates the idea of preventing
>> spurious writes when RTC driver is loaded.
>> So implement rtc lock and unlock functions before and after register writes.
>>
>> Signed-off-by: Lokesh Vutla <lokeshvutla@ti.com>
>> ---
>> - This is as advised by Paul to implement lock and unlock functions in
>>   the driver and not to unlock and leave it in probe.
>>   The same discussion can be seen here:
>>   http://www.mail-archive.com/linux-omap%40vger.kernel.org/msg111588.html
>>
>>  drivers/rtc/rtc-omap.c | 46 ++++++++++++++++++++++++++++++++++++++--------
>>  1 file changed, 38 insertions(+), 8 deletions(-)
>>
>> diff --git a/drivers/rtc/rtc-omap.c b/drivers/rtc/rtc-omap.c
>> index 8e5851a..96cc613 100644
>> --- a/drivers/rtc/rtc-omap.c
>> +++ b/drivers/rtc/rtc-omap.c
>> @@ -156,6 +156,22 @@ static inline void rtc_writel(struct omap_rtc *rtc, unsigned int reg, u32 val)
>>  	writel(val, rtc->base + reg);
>>  }
>>  
>> +static void rtc_unlock(struct omap_rtc *rtc)
>> +{
>> +	if (rtc->type->has_kicker) {
> 
> Instead of testing for has_kicker each time, I would add .lock and
> .unlock to omap_rtc_device_type and directly use rtc->type->lock and
> rtc->type->unlock.
Makes sense. I have posted v2 of my series updating this.

Thanks and regards,
Lokesh
> 
>> +		rtc_writel(rtc, OMAP_RTC_KICK0_REG, KICK0_VALUE);
>> +		rtc_writel(rtc, OMAP_RTC_KICK1_REG, KICK1_VALUE);
>> +	}
>> +}
>> +

