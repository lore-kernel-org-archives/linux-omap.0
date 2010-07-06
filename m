From: Nishanth Menon <nm@ti.com>
Subject: Re: [PATCH 9/9] omap: id: add feature check for omap1
Date: Tue, 6 Jul 2010 07:53:50 -0500
Message-ID: <4C33275E.4030506@ti.com>
References: <1277259375-18521-1-git-send-email-nm@ti.com> <1277259375-18521-10-git-send-email-nm@ti.com> <20100706124606.GP3192@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:38422 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755762Ab0GFMxw (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 6 Jul 2010 08:53:52 -0400
In-Reply-To: <20100706124606.GP3192@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: linux-omap <linux-omap@vger.kernel.org>, "S, Venkatraman" <svenkatr@ti.com>, "Guruswamy, Senthilvadivu" <svadivu@ti.com>

On 07/06/2010 07:46 AM, Tony Lindgren wrote:
> * Nishanth Menon<nm@ti.com>  [100623 05:10]:
>> add a minimalist feature - l2cache for omap1.
>>
>> Signed-off-by: Nishanth Menon<nm@ti.com>
>> ---
>>   arch/arm/mach-omap1/id.c |    6 ++++++
>>   1 files changed, 6 insertions(+), 0 deletions(-)
>>
>> diff --git a/arch/arm/mach-omap1/id.c b/arch/arm/mach-omap1/id.c
>> index 91dbb71..b98a17f 100644
>> --- a/arch/arm/mach-omap1/id.c
>> +++ b/arch/arm/mach-omap1/id.c
>> @@ -200,5 +200,11 @@ void __init omap1_check_revision(void)
>>   	printk(KERN_INFO " revision %i handled as %02xxx id: %08x%08x\n",
>>   	       die_rev, omap_revision&  0xff, system_serial_low,
>>   	       system_serial_high);
>> +
>> +	/*
>> +	 * TODO: add a better check feature once we have
>> +	 * more decent feature check
>> +	 */
>> +	omap_features |= OMAP_HAS_L2CACHE;
>>   }
>
> There's no L2 cache on omap1?

I thought it did, hence added.. am I wrong?
Regards,
Nishanth Menon

