From: "Cousson, Benoit" <b-cousson@ti.com>
Subject: Re: [PATCH 1/2] arm: mach-omap2: devices: fix omap3_l3_init() return
 value
Date: Thu, 17 Mar 2011 09:19:43 +0100
Message-ID: <4D81C41F.8090702@ti.com>
References: <1300295763-497-1-git-send-email-aaro.koskinen@nokia.com> <324bffcaf53be55bd6f392af3f86fa10@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:54558 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751482Ab1CQITu (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 17 Mar 2011 04:19:50 -0400
In-Reply-To: <324bffcaf53be55bd6f392af3f86fa10@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Shilimkar, Santosh" <santosh.shilimkar@ti.com>
Cc: Aaro Koskinen <aaro.koskinen@nokia.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "tony@atomide.com" <tony@atomide.com>

Hi Santosh,

On 3/17/2011 6:52 AM, Shilimkar, Santosh wrote:
>> -----Original Message-----
>> From: linux-arm-kernel-bounces@lists.infradead.org [mailto:linux-
>> arm-kernel-bounces@lists.infradead.org] On Behalf Of Aaro Koskinen
>> Sent: Wednesday, March 16, 2011 10:46 PM
>> To: linux-omap@vger.kernel.org; linux-arm-
>> kernel@lists.infradead.org; tony@atomide.com
>> Cc: Aaro Koskinen
>> Subject: [PATCH 1/2] arm: mach-omap2: devices: fix omap3_l3_init()
>> return value
>>
>> Fix the return value for the successful case.
>>
>> Signed-off-by: Aaro Koskinen<aaro.koskinen@nokia.com>
>> ---
>>   arch/arm/mach-omap2/devices.c |    2 +-
>>   1 files changed, 1 insertions(+), 1 deletions(-)
>>
>> diff --git a/arch/arm/mach-omap2/devices.c b/arch/arm/mach-
>> omap2/devices.c
>> index 0d2d6a9..d478f53 100644
>> --- a/arch/arm/mach-omap2/devices.c
>> +++ b/arch/arm/mach-omap2/devices.c
>> @@ -65,7 +65,7 @@ static int __init omap3_l3_init(void)
>>
>>   	WARN(IS_ERR(od), "could not build omap_device for %s\n",
>> oh_name);
>>
>> -	return PTR_ERR(od);
>> +	return IS_ERR(od) ? PTR_ERR(od) : 0;
>>   }
>>   postcore_initcall(omap3_l3_init);

Maybe we should initialize that before, because in theory the timer12 
secure violation should have been captured easily with this code?

Regards,
Benoit
