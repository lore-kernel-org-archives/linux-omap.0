From: Lokesh Vutla <lokeshvutla@ti.com>
Subject: Re: [PATCH 2/3] ARM: OMAP2+: AM43x: Add ID for ES1.1
Date: Fri, 7 Feb 2014 09:38:52 +0530
Message-ID: <52F45C54.7020604@ti.com>
References: <1391676348-32339-1-git-send-email-lokeshvutla@ti.com> <1391676348-32339-3-git-send-email-lokeshvutla@ti.com> <52F39E74.3030404@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:38828 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751224AbaBGEJX (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 6 Feb 2014 23:09:23 -0500
In-Reply-To: <52F39E74.3030404@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Nishanth Menon <nm@ti.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, tony@atomide.com, linux@arm.linux.org.uk, rnayak@ti.com, nsekhar@ti.com

Hi Nishanth,
On Thursday 06 February 2014 08:08 PM, Nishanth Menon wrote:
> On 02/06/2014 02:45 AM, Lokesh Vutla wrote:
>> Adding ID for AM437x ES1.1 silicon.
>>
>> Signed-off-by: Lokesh Vutla <lokeshvutla@ti.com>
>> ---
>>  arch/arm/mach-omap2/id.c  |   14 ++++++++++++--
>>  arch/arm/mach-omap2/soc.h |    3 ++-
>>  2 files changed, 14 insertions(+), 3 deletions(-)
>>
>> diff --git a/arch/arm/mach-omap2/id.c b/arch/arm/mach-omap2/id.c
>> index 9428c5f..8a05eaf 100644
>> --- a/arch/arm/mach-omap2/id.c
>> +++ b/arch/arm/mach-omap2/id.c
>> @@ -465,8 +465,18 @@ void __init omap3xxx_check_revision(void)
>>  		}
>>  		break;
>>  	case 0xb98c:
>> -		omap_revision = AM437X_REV_ES1_0;
>> -		cpu_rev = "1.0";
>> +		switch (rev) {
>> +		case 0:
>> +			omap_revision = AM437X_REV_ES1_0;
>> +			cpu_rev = "1.0";
>> +			break;
>> +		case 1:
>> +		/* FALLTHROUGH */
>> +		default:
>> +			omap_revision = AM437X_REV_ES1_1;
>> +			cpu_rev = "1.1";
>> +			break;
>> +		}
>>  		break;
>>  	case 0xb8f2:
>>  		switch (rev) {
>> diff --git a/arch/arm/mach-omap2/soc.h b/arch/arm/mach-omap2/soc.h
>> index 076bd90..30abcc8 100644
>> --- a/arch/arm/mach-omap2/soc.h
>> +++ b/arch/arm/mach-omap2/soc.h
>> @@ -438,7 +438,8 @@ IS_OMAP_TYPE(3430, 0x3430)
>>  #define AM335X_REV_ES2_1	(AM335X_CLASS | (0x2 << 8))
>>  
>>  #define AM437X_CLASS		0x43700000
>> -#define AM437X_REV_ES1_0	AM437X_CLASS
>> +#define AM437X_REV_ES1_0	(AM437X_CLASS | (0x10 << 8))
>> +#define AM437X_REV_ES1_1	(AM437X_CLASS | (0x11 << 8))
>>  
>>  #define OMAP443X_CLASS		0x44300044
>>  #define OMAP4430_REV_ES1_0	(OMAP443X_CLASS | (0x10 << 8))
>>
> 
> can you also check if socbus shows proper results?
> I had http://slexy.org/view/s20e3OsIVx with v3.14-rc1
Oops....missed out formating and sending "AM43x : determine features patch".
Thanks for pointing it out. ll update and send a v2 for this series.

Thanks and regards,
Lokesh
> 

