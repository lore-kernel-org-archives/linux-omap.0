From: Rajendra Nayak <rnayak@ti.com>
Subject: Re: [PATCH v2 3/4] ARM: OMAP2+: Add machine entry for dra72x devices
Date: Wed, 23 Apr 2014 16:43:11 +0530
Message-ID: <5357A047.5030200@ti.com>
References: <1398243775-4145-1-git-send-email-rnayak@ti.com> <1398243775-4145-4-git-send-email-rnayak@ti.com> <66310471.kybX1mlztt@wuerfel>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:44539 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751793AbaDWLO7 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 23 Apr 2014 07:14:59 -0400
In-Reply-To: <66310471.kybX1mlztt@wuerfel>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, devicetree@vger.kernel.org, tony@atomide.com, nm@ti.com, bcousson@baylibre.com

On Wednesday 23 April 2014 03:21 PM, Arnd Bergmann wrote:
> On Wednesday 23 April 2014 14:32:54 Rajendra Nayak wrote:
>>
>>  #ifdef CONFIG_SOC_DRA7XX
>> -static const char *dra7xx_boards_compat[] __initdata = {
>> +static const char *dra74x_boards_compat[] __initconst = {
>> +       "ti,dra74x",
>>         "ti,dra7xx",
>>         "ti,dra7",
>>         NULL,
>>  };
>>  
>> -DT_MACHINE_START(DRA7XX_DT, "Generic DRA7XX (Flattened Device Tree)")
>> +DT_MACHINE_START(DRA74X_DT, "Generic DRA74X (Flattened Device Tree)")
>>         .reserve        = omap_reserve,
>>         .smp            = smp_ops(omap4_smp_ops),
>>         .map_io         = omap5_map_io,
>> @@ -255,7 +256,26 @@ DT_MACHINE_START(DRA7XX_DT, "Generic DRA7XX (Flattened Device Tree)")
>>         .init_irq       = omap_gic_of_init,
>>         .init_machine   = omap_generic_init,
>>         .init_time      = omap5_realtime_timer_init,
>> -       .dt_compat      = dra7xx_boards_compat,
>> +       .dt_compat      = dra74x_boards_compat,
>> +       .restart        = omap44xx_restart,
>> +MACHINE_END
>> +
>> +static const char *dra72x_boards_compat[] __initconst = {
>> +       "ti,dra72x",
>> +       "ti,dra7xx",
>> +       "ti,dra7",
>> +       NULL,
>> +};
> 
> Now you have two lists that both match "ti,dra7xx" and "ti,dra7", which will
> cause problems if you have a new machine that doesn't match the more specific
> strings.
> 
> Note that we intentionally don't allow wildcards in compatible strings
> to avoid this situation.
> 
> Please remove all strings with an "x" in them from the dts files and from
> the source, and make sure you have no duplication between the lists.

Okay, will fix and repost. thanks.

> 
> 	Arnd
> 

