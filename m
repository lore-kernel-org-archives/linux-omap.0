From: Afzal Mohammed <afzal@ti.com>
Subject: Re: [PATCH v4 07/11] ARM: OMAP2+: CM: AM43x clockdomain data
Date: Mon, 30 Sep 2013 16:35:39 +0530
Message-ID: <52495B03.3050006@ti.com>
References: <cover.1380179370.git.afzal@ti.com> <a6758751113ef93bc912ccefb9cdb0ba383f19d5.1380179370.git.afzal@ti.com> <alpine.DEB.2.02.1309300927520.17980@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:48501 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753590Ab3I3LGH (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 30 Sep 2013 07:06:07 -0400
In-Reply-To: <alpine.DEB.2.02.1309300927520.17980@utopia.booyaka.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>, Ambresh K <ambresh@ti.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Benoit Cousson <bcousson@baylibre.com>, Tony Lindgren <tony@atomide.com>, Rajendra Nayak <rnayak@ti.com>

Hi Paul,

On Monday 30 September 2013 03:01 PM, Paul Walmsley wrote:
> On Thu, 26 Sep 2013, Afzal Mohammed wrote:

>> From: Ambresh K <ambresh@ti.com>
>>
>> Add the data file to describe clock domains in AM43x SoC.
>> OMAP4 clockdomain operations is being reused here.
>>
>> Signed-off-by: Ambresh K <ambresh@ti.com>
>> Signed-off-by: Afzal Mohammed <afzal@ti.com>
>> ---
>>  arch/arm/mach-omap2/clockdomain.h           |   2 +
>>  arch/arm/mach-omap2/clockdomains43xx_data.c | 196 ++++++++++++++++++++++++++++
>>  arch/arm/mach-omap2/cminst44xx.c            |   9 ++
>>  3 files changed, 207 insertions(+)
>>  create mode 100644 arch/arm/mach-omap2/clockdomains43xx_data.c
>>
> 
> ...
> 
>> diff --git a/arch/arm/mach-omap2/clockdomains43xx_data.c b/arch/arm/mach-omap2/clockdomains43xx_data.c
>> new file mode 100644
>> index 0000000..6d71c60
>> --- /dev/null
>> +++ b/arch/arm/mach-omap2/clockdomains43xx_data.c
>> @@ -0,0 +1,196 @@
> 
> ...
> 
>> +static struct clockdomain l3s_tsc_43xx_clkdm = {
>> +	.name		  = "l3s_tsc_clkdm",
>> +	.pwrdm		  = { .name = "wkup_pwrdm" },
>> +	.prcm_partition	  = AM43XX_CM_PARTITION,
>> +	.cm_inst	  = AM43XX_CM_WKUP_INST,
>> +	.clkdm_offs	  = AM43XX_CM_WKUP_L3S_TSC_CDOFFS,
>> +	.flags		  = CLKDM_CAN_SWSUP,
>> +};

> The references to "wkup_pwrdm" on some of these clockdomains don't 
> look right to me.  For example, this clockdomain is listed as being in 
> AM43XX_CM_WKUP_INST, but its enclosing powerdomain is listed as being in 
> AM43XX_PRM_WKUP_INST.  Looks to me like it's best to have two different 
> wakeup powerdomains: one CM_WKUP, and one PRM_WKUP.

On AM43x, prcm is a single block as in AM335x and is part of wakeup
domain. This is different from OMAP4 that had separate prm and cm
blocks. Script also generated the same output.

Regards
Afzal
