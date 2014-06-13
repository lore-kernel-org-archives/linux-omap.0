From: Roger Quadros <rogerq@ti.com>
Subject: Re: [PATCH 01/36] ARM: OMAP3: hwmod: Fix gpmc memory resource space
Date: Fri, 13 Jun 2014 10:15:38 +0300
Message-ID: <539AA51A.9000101@ti.com>
References: <1402477001-31132-1-git-send-email-rogerq@ti.com> <1402477001-31132-2-git-send-email-rogerq@ti.com> <20140613071357.GH17845@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:49358 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751160AbaFMHQO (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 13 Jun 2014 03:16:14 -0400
In-Reply-To: <20140613071357.GH17845@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: dwmw2@infradead.org, computersforpeace@gmail.com, kyungmin.park@samsung.com, pekon@ti.com, ezequiel.garcia@free-electrons.com, javier@dowhile0.org, nsekhar@ti.com, linux-omap@vger.kernel.org, linux-mtd@lists.infradead.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org

On 06/13/2014 10:13 AM, Tony Lindgren wrote:
> * Roger Quadros <rogerq@ti.com> [140611 01:58]:
> 
> Missing description? Probably not an urgent fix or does
> this fix something?

Doesn't fix anything. It is just for correctness. I'll add the description.

cheers,
-roger

> 
>> Signed-off-by: Roger Quadros <rogerq@ti.com>
>> ---
>>  arch/arm/mach-omap2/omap_hwmod_3xxx_data.c | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/arch/arm/mach-omap2/omap_hwmod_3xxx_data.c b/arch/arm/mach-omap2/omap_hwmod_3xxx_data.c
>> index 71ac7d5..f2848a8 100644
>> --- a/arch/arm/mach-omap2/omap_hwmod_3xxx_data.c
>> +++ b/arch/arm/mach-omap2/omap_hwmod_3xxx_data.c
>> @@ -3426,7 +3426,7 @@ static struct omap_hwmod_addr_space omap3xxx_counter_32k_addrs[] = {
>>  static struct omap_hwmod_addr_space omap3xxx_gpmc_addrs[] = {
>>  	{
>>  		.pa_start	= 0x6e000000,
>> -		.pa_end		= 0x6e000fff,
>> +		.pa_end		= 0x6e0002d4,
>>  		.flags		= ADDR_TYPE_RT
>>  	},
>>  	{ }
>> -- 
>> 1.8.3.2
>>

