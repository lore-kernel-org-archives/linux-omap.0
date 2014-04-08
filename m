From: Sekhar Nori <nsekhar@ti.com>
Subject: Re: [PATCH v2 3/3] ARM: OMAP2+: AM43x: L2 cache support
Date: Tue, 8 Apr 2014 20:23:39 +0530
Message-ID: <53440D73.6060504@ti.com>
References: <cover.1396605300.git.nsekhar@ti.com> <efa5fda5ae625a43fac14bf173cbd96ad7b44e7a.1396605300.git.nsekhar@ti.com> <20140404101808.GG27282@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:46692 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757086AbaDHOyN (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 8 Apr 2014 10:54:13 -0400
In-Reply-To: <20140404101808.GG27282@n2100.arm.linux.org.uk>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: Tony Lindgren <tony@atomide.com>, Linux OMAP Mailing List <linux-omap@vger.kernel.org>, Linux ARM Mailing List <linux-arm-kernel@lists.infradead.org>

On Friday 04 April 2014 03:48 PM, Russell King - ARM Linux wrote:
> On Fri, Apr 04, 2014 at 03:40:29PM +0530, Sekhar Nori wrote:
>> diff --git a/arch/arm/mach-omap2/omap4-common.c b/arch/arm/mach-omap2/omap4-common.c
>> index f8b8dac..6b2a056 100644
>> --- a/arch/arm/mach-omap2/omap4-common.c
>> +++ b/arch/arm/mach-omap2/omap4-common.c
>> @@ -224,6 +224,14 @@ int __init omap4_l2_cache_init(void)
>>  
>>  	return omap_l2_cache_init(aux_ctrl, 0xc19fffff);
>>  }
>> +
>> +int __init am43xx_l2_cache_init(void)
>> +{
>> +	u32 aux_ctrl = L310_AUX_CTRL_DATA_PREFETCH |
>> +		       L310_AUX_CTRL_INSTR_PREFETCH;
> 
> It would be good to documenting the difference between this and OMAP4,
> and why you have chosen different values.

There are two main differences:

1) OMAP4 sets Shared attribute override enable bit. TBH, I think this is
not needed even in OMAP4 with latest kernel, but I am not sure if I can
do this safely without breaking any usecase currently working with OMAP4.

2) OMAP4 sets NS lockdown and NS interrupt access control bits. I
searched through the commit history of L2 cache support on OMAP4 but
there is no mention of why this was needed on OMAP4. I am checking
internally on the history behind this.

3) OMAP4 sets cache replacement policy to RR which is not a big deal
since thats the default anyway. We can probably drop this setting even
from OMAP4.

Thanks,
Sekhar

