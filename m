From: "Pedanekar, Hemant" <hemantp@ti.com>
Subject: RE: [PATCH v2 3/6] TI816X: Update common OMAP machine specific
 sources
Date: Mon, 29 Nov 2010 22:47:15 +0530
Message-ID: <2A3DCF3DA181AD40BDE86A3150B27B6B0369E7C04D@dbde02.ent.ti.com>
References: <1281546664-11477-1-git-send-email-hemantp@ti.com>
 <20100916222459.GQ29610@atomide.com>
 <2A3DCF3DA181AD40BDE86A3150B27B6B03569BEEA3@dbde02.ent.ti.com>
 <20101105205943.GS9264@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:53034 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754893Ab0K2RRY convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 29 Nov 2010 12:17:24 -0500
In-Reply-To: <20101105205943.GS9264@atomide.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "khilman@deeprootsystems.com" <khilman@deeprootsystems.com>

Tony Lindgren wrote on Saturday, November 06, 2010 2:30 AM:

> * Pedanekar, Hemant <hemantp@ti.com> [101022 10:58]:
>> Tony Lindgren wrote on Friday, September 17, 2010 3:55 AM:
>> 
>>> * Hemant Pedanekar <hemantp@ti.com> [100811 10:03]:
>>>> This patch updates the common machine spcific source files with support
>>>> for TI816X. 
>>>> 
>>>> Note that the nr_irqs is overridden in INTC driver since the number of
>>>> IRQs on TI816X are different (128) comapared to other OMAPs (96).
>>> 
>>> <snip>
>>> 
>>>> --- a/arch/arm/mach-omap2/id.c
>>>> +++ b/arch/arm/mach-omap2/id.c
>>>> @@ -419,6 +441,9 @@ void __init omap2_check_revision(void)
>>>>  	} else if (cpu_is_omap44xx()) {
>>>>  		omap4_check_revision();
>>>>  		return;
>>>> +	} else if (cpu_is_ti816x()) {
>>>> +		ti816x_check_revision();
>>>> +		return;
>>>>  	} else {
>>>>  		pr_err("OMAP revision unknown, please fix!\n");
>>>>  	}
>>> 
>>> This does not look right, at this point you should just know
>>> the processor class set by the set_globals call.
>>> 
>>> Please take a look at plat-omap/common.c and add an entry for
>>> omap2_set_globals_ti816x. This gets called very early from the board-*.c
>>> file, so you can initialize things.
>> 
>> Tony,
>> 
>> Do you mean following changes in the patch I sent earlier?
> 
> No, I'm mostly wondering how come you can't use cpu_is_omap34xx
> for ti816x and then detect based on the values set in
> omap2_set_globals. Then cpu_is_ti816x just becomes a set of features.
> 
> In general, we should initialize more things in set_globals
> if necessary rather than sprinkle cpu_is_omap tests all over
> the place to add support for new omaps.
> 

Tony,

Though based on Cortex A8, TI816X series has differences in PRCM, PLL, clock
structure compared to OMAP3.

Many of the OMAP3 specific checks are not applicable for TI816X. For example, 
consider following:
File - arch/arm/mach-omap2/omap_hwmod.c 
Function - _wait_target_ready()

	if (cpu_is_omap24xx() || cpu_is_omap34xx()) {
		ret = omap2_cm_wait_module_ready(oh->prcm.omap2.module_offs,
				oh->prcm.omap2.idlest_reg_id,
				oh->prcm.omap2.idlest_idle_bit);

The above code inside cpu_is_omap34xx() check is not applicable for TI816X as
there are no CM_IDELST registers.

Thanks
-
Hemant