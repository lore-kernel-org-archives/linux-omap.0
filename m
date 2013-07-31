From: Tero Kristo <t-kristo@ti.com>
Subject: Re: [PATCHv4 09/33] CLK: omap: add omap4 clock init file
Date: Wed, 31 Jul 2013 17:52:58 +0300
Message-ID: <51F924CA.6000803@ti.com>
References: <1374564028-11352-1-git-send-email-t-kristo@ti.com> <1374564028-11352-10-git-send-email-t-kristo@ti.com> <51F81516.3050302@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:36112 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751310Ab3GaOxb (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 31 Jul 2013 10:53:31 -0400
In-Reply-To: <51F81516.3050302@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Nishanth Menon <nm@ti.com>
Cc: linux-omap@vger.kernel.org, paul@pwsan.com, khilman@linaro.org, tony@atomide.com, mturquette@linaro.org, rnayak@ti.com, linux-arm-kernel@lists.infradead.org, devicetree-discuss@lists.ozlabs.org

On 07/30/2013 10:33 PM, Nishanth Menon wrote:
> On 07/23/2013 02:20 AM, Tero Kristo wrote:
>> clk-44xx.c now contains the clock init functionality for omap4, including
>> DT clock registration and adding of static clkdev entries.
>>
>> Signed-off-by: Tero Kristo <t-kristo@ti.com>
>> ---
>>   drivers/clk/omap/clk-44xx.c |  118
>> +++++++++++++++++++++++++++++++++++++++++++
>>   1 file changed, 118 insertions(+)
>>   create mode 100644 drivers/clk/omap/clk-44xx.c
>>
>> diff --git a/drivers/clk/omap/clk-44xx.c b/drivers/clk/omap/clk-44xx.c
>> new file mode 100644
>> index 0000000..cc12134
>> --- /dev/null
>> +++ b/drivers/clk/omap/clk-44xx.c
>> @@ -0,0 +1,118 @@
>> +/*
>> + * OMAP4 Clock data
>> + *
>> + * Copyright (C) 2009-2012 Texas Instruments, Inc.
>> + * Copyright (C) 2009-2010 Nokia Corporation
>> + *
>> + * Paul Walmsley (paul@pwsan.com)
>> + * Rajendra Nayak (rnayak@ti.com)
>> + * Benoit Cousson (b-cousson@ti.com)
>> + * Mike Turquette (mturquette@ti.com)
>> + *
>> + * This program is free software; you can redistribute it and/or modify
>> + * it under the terms of the GNU General Public License version 2 as
>> + * published by the Free Software Foundation.
>> + *
>> + * XXX Some of the ES1 clocks have been removed/changed; once support
>> + * is added for discriminating clocks by ES level, these should be
>> added back
>> + * in.
>> + *
>> + * XXX All of the remaining MODULEMODE clock nodes should be removed
>> + * once the drivers are updated to use pm_runtime or to use the
>> appropriate
>> + * upstream clock node for rate/parent selection.
>> + */
>> +
>> +#include <linux/kernel.h>
>> +#include <linux/list.h>
>> +#include <linux/clk-private.h>
>> +#include <linux/clkdev.h>
>> +#include <linux/io.h>
>> +#include <linux/clk/omap.h>
>> +
>> +/*
>> + * OMAP4 ABE DPLL default frequency. In OMAP4460 TRM version V, section
>> + * "3.6.3.2.3 CM1_ABE Clock Generator" states that the "DPLL_ABE_X2_CLK
>> + * must be set to 196.608 MHz" and hence, the DPLL locked frequency is
>> + * half of this value.
>> + */
>> +#define OMAP4_DPLL_ABE_DEFFREQ                98304000
>> +
>> +/*
>> + * OMAP4 USB DPLL default frequency. In OMAP4430 TRM version V, section
>> + * "3.6.3.9.5 DPLL_USB Preferred Settings" shows that the preferred
>> + * locked frequency for the USB DPLL is 960MHz.
>> + */
>> +#define OMAP4_DPLL_USB_DEFFREQ                960000000
>> +
>> +static struct omap_dt_clk omap44xx_clks[] = {
>> +    DT_CLK("smp_twd",    NULL,            "mpu_periphclk"),
>> +    DT_CLK("omapdss_dss", "ick", "dss_fck"),
>> +    DT_CLK("usbhs_omap", "fs_fck", "usb_host_fs_fck"),
>> +    DT_CLK("usbhs_omap", "hs_fck", "usb_host_hs_fck"),
>> +    DT_CLK("usbhs_omap", "usbtll_ick", "usb_tll_hs_ick"),
>> +    DT_CLK("usbhs_tll", "usbtll_ick", "usb_tll_hs_ick"),
>> +    DT_CLK(NULL,    "timer_32k_ck",    "sys_32k_ck"),
>> +    /* TODO: Remove "omap_timer.X" aliases once DT migration is
>> complete */
>> +    DT_CLK("omap_timer.1",    "timer_sys_ck",    "sys_clkin_ck"),
>> +    DT_CLK("omap_timer.2",    "timer_sys_ck",    "sys_clkin_ck"),
>> +    DT_CLK("omap_timer.3",    "timer_sys_ck",    "sys_clkin_ck"),
>> +    DT_CLK("omap_timer.4",    "timer_sys_ck",    "sys_clkin_ck"),
>> +    DT_CLK("omap_timer.9",    "timer_sys_ck",    "sys_clkin_ck"),
>> +    DT_CLK("omap_timer.10",    "timer_sys_ck",    "sys_clkin_ck"),
>> +    DT_CLK("omap_timer.11",    "timer_sys_ck",    "sys_clkin_ck"),
>> +    DT_CLK("omap_timer.5",    "timer_sys_ck",    "syc_clk_div_ck"),
>> +    DT_CLK("omap_timer.6",    "timer_sys_ck",    "syc_clk_div_ck"),
>> +    DT_CLK("omap_timer.7",    "timer_sys_ck",    "syc_clk_div_ck"),
>> +    DT_CLK("omap_timer.8",    "timer_sys_ck",    "syc_clk_div_ck"),
>> +    DT_CLK("4a318000.timer",    "timer_sys_ck",    "sys_clkin_ck"),
>> +    DT_CLK("48032000.timer",    "timer_sys_ck",    "sys_clkin_ck"),
>> +    DT_CLK("48034000.timer",    "timer_sys_ck",    "sys_clkin_ck"),
>> +    DT_CLK("48036000.timer",    "timer_sys_ck",    "sys_clkin_ck"),
>> +    DT_CLK("4803e000.timer",    "timer_sys_ck",    "sys_clkin_ck"),
>> +    DT_CLK("48086000.timer",    "timer_sys_ck",    "sys_clkin_ck"),
>> +    DT_CLK("48088000.timer",    "timer_sys_ck",    "sys_clkin_ck"),
>> +    DT_CLK("40138000.timer",    "timer_sys_ck",    "syc_clk_div_ck"),
>> +    DT_CLK("4013a000.timer",    "timer_sys_ck",    "syc_clk_div_ck"),
>> +    DT_CLK("4013c000.timer",    "timer_sys_ck",    "syc_clk_div_ck"),
>> +    DT_CLK("4013e000.timer",    "timer_sys_ck",    "syc_clk_div_ck"),
>
>> +    DT_CLK(NULL,    "cpufreq_ck",    "dpll_mpu_ck"),
> please remove cpufreq.

Hmm why?

Because cpufreq is completely broken now and your current work on it? :)

>
>> +};
>> +
>> +int __init omap4xxx_clk_init(void)
>> +{
>> +    int rc;
>> +    struct clk *abe_dpll_ref, *abe_dpll, *sys_32k_ck, *usb_dpll;
>> +
>> +    /* FIXME register clocks from DT first */
>> +    dt_omap_clk_init();
>> +
>> +    omap_dt_clocks_register(omap44xx_clks, ARRAY_SIZE(omap44xx_clks));
>> +
>> +    omap2_clk_disable_autoidle_all();
>> +
>> +    /*
>> +     * On OMAP4460 the ABE DPLL fails to turn on if in idle low-power
>> +     * state when turning the ABE clock domain. Workaround this by
>> +     * locking the ABE DPLL on boot.
>> +     * Lock the ABE DPLL in any case to avoid issues with audio.
>> +     */
>
> But this code will be called for 4430 and 4460. if the requirement is
> only for 4460, then we are not adhering to the spec?

This is copy pasted from existing cclock44xx_data.c file init function.

>
>> +    abe_dpll_ref = clk_get_sys(NULL, "abe_dpll_refclk_mux_ck");
>> +    sys_32k_ck = clk_get_sys(NULL, "sys_32k_ck");
>> +    rc = clk_set_parent(abe_dpll_ref, sys_32k_ck);
>> +    abe_dpll = clk_get_sys(NULL, "dpll_abe_ck");
>> +    if (!rc)
>> +        rc = clk_set_rate(abe_dpll, OMAP4_DPLL_ABE_DEFFREQ);
>> +    if (rc)
>> +        pr_err("%s: failed to configure ABE DPLL!\n", __func__);
>> +
>> +    /*
>> +     * Lock USB DPLL on OMAP4 devices so that the L3INIT power
>> +     * domain can transition to retention state when not in use.
>> +     */
>> +    usb_dpll = clk_get_sys(NULL, "dpll_usb_ck");
>> +    rc = clk_set_rate(usb_dpll, OMAP4_DPLL_USB_DEFFREQ);
>> +    if (rc)
>> +        pr_err("%s: failed to configure USB DPLL!\n", __func__);
>
> ^^^^ why cant we have a generic property that does this "automagically"
> from dts property to the node?
> a) be able to select a parent
> b) be able to set a frequency.
> c) how do we ensure that CLK_SET_RATE_PARENT are setup for the clock
> nodes defined by dt?

This is probably for Mike to answer, currently such mechanism does not 
exist.

>
>> +
>> +    return 0;
>> +}
>>
>
>

