From: "Pedanekar, Hemant" <hemantp@ti.com>
Subject: RE: [PATCH v2 3/6] TI816X: Update common OMAP machine specific
 sources
Date: Fri, 22 Oct 2010 23:37:36 +0530
Message-ID: <2A3DCF3DA181AD40BDE86A3150B27B6B03569BEEA3@dbde02.ent.ti.com>
References: <1281546664-11477-1-git-send-email-hemantp@ti.com>
 <20100916222459.GQ29610@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:34278 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751406Ab0JVSHv convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 22 Oct 2010 14:07:51 -0400
In-Reply-To: <20100916222459.GQ29610@atomide.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "khilman@deeprootsystems.com" <khilman@deeprootsystems.com>

Tony Lindgren wrote on Friday, September 17, 2010 3:55 AM:

> * Hemant Pedanekar <hemantp@ti.com> [100811 10:03]:
>> This patch updates the common machine spcific source files with support
>> for TI816X. 
>> 
>> Note that the nr_irqs is overridden in INTC driver since the number of
>> IRQs on TI816X are different (128) comapared to other OMAPs (96).
> 
> <snip>
> 
>> --- a/arch/arm/mach-omap2/id.c
>> +++ b/arch/arm/mach-omap2/id.c
>> @@ -419,6 +441,9 @@ void __init omap2_check_revision(void)
>>  	} else if (cpu_is_omap44xx()) {
>>  		omap4_check_revision();
>>  		return;
>> +	} else if (cpu_is_ti816x()) {
>> +		ti816x_check_revision();
>> +		return;
>>  	} else {
>>  		pr_err("OMAP revision unknown, please fix!\n");
>>  	}
> 
> This does not look right, at this point you should just know
> the processor class set by the set_globals call.
> 
> Please take a look at plat-omap/common.c and add an entry for
> omap2_set_globals_ti816x. This gets called very early from
> the board-*.c
> file, so you can initialize things.

Tony,

Do you mean following changes in the patch I sent earlier?

In arch/arm/mach-omap2/common.c -->

#if defined(CONFIG_ARCH_TI816X)
static struct omap_globals ti816x_globals = {
-        .class  = TI816X_CLASS,
+        .class  = TI81XX_CLASS,

In arch/arm/mach-omap2/id.c -->
-void __init ti816x_check_revision(void)
+void __init ti81xx_check_revision(void)
 {
        u32 idcode;
        u16 partnum;
        u8 rev;

-       idcode = read_tap_reg(TI816X_CONTROL_DEVICE_ID);
+       idcode = read_tap_reg(TI81XX_CONTROL_DEVICE_ID);
        partnum = (idcode >> 12) & 0xffff;
        rev = (idcode >> 28) & 0xff;

@@ -490,8 +490,8 @@ void __init omap2_check_revision(void)
        } else if (cpu_is_omap44xx()) {
                omap4_check_revision();
                return;
-       } else if (cpu_is_ti816x()) {
-               ti816x_check_revision();
+       } else if (cpu_is_ti81xx()) {
+               ti81xx_check_revision();
                return;

> 
> Note that by default we are building in support for omap2, 3 and 4
> and support for all the boards too. This allows booting them
> with the same kernel binary for developers and distros.
> 
> In general, you might want to see how we added support for omap36xx.
> TI816X seems to be very close to omap3 with some extra registers, and
> I'm not at all convinced that we even need to set it up as a separate
> processor. Basically adding the set_globals + doing the more
> accurate detection in id.c should do the trick.
> 

The TI816X series, though similar to Omap architecture wise, has 
differences in PRCM, PLL etc w.r.t. Omap3.

Please refer following link for more details about the series:
http://focus.ti.com/general/docs/gencontent.tsp?contentId=77960

Thanks
-
Hemant

