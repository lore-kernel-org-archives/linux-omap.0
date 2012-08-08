From: Konstantin Baydarov <kbaidarov@dev.rtsoft.ru>
Subject: Re: [linux-pm] [PATCH v4 2/4] mfd: omap: control: core system control
 driver
Date: Wed, 08 Aug 2012 18:59:37 +0400
Message-ID: <50227ED9.3010508@dev.rtsoft.ru>
References: <500FD2EC.7060208@dev.rtsoft.ru> <20120808140507.GF11011@atomide.com> <20120808141051.GG11011@atomide.com> <20120808143929.GJ11011@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail.dev.rtsoft.ru ([213.79.90.226]:41588 "HELO
	mail.dev.rtsoft.ru" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1757375Ab2HHO7j (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 8 Aug 2012 10:59:39 -0400
In-Reply-To: <20120808143929.GJ11011@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: balbi@ti.com, kishon@ti.com, amit.kucheria@linaro.org, linux-pm@lists.linux-foundation.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

  Hi, Tony.

On 08/08/2012 06:39 PM, Tony Lindgren wrote:
> * Tony Lindgren <tony@atomide.com> [120808 07:11]:
>> * Tony Lindgren <tony@atomide.com> [120808 07:05]:
>>> * Konstantin Baydarov <kbaidarov@dev.rtsoft.ru> [120725 04:10]:
>>>> +
>>>> +u32 omap_control_status_read(void)
>>>> +{
>>>> +	return __raw_readl(omap_control_base);
>>>> +}
>>> Ah OK it's changed here.. Sorry I was looking at the older
>>> version.
>>>
>>>> +void __init of_omap_control_init(const struct of_device_id *matches)
>>>> +{
>>>> +	struct device_node *np;
>>>> +	struct property *pp = 0;
>>>> +
>>>> +	for_each_matching_node(np, matches) {
>>>> +		pp = of_find_property(np, "reg", NULL);
>>>> +		if(pp) {
>>>> +			omap_control_phys_base = (unsigned long)be32_to_cpup(pp->value);
>>>> +			omap_control_mapsize = (size_t)be32_to_cpup( (void*)((char*)pp->value + 4) );
>>>> +			/*
>>>> +			 * Map control module register CONTROL_STATUS register:
>>>> +			 * omap24xx - OMAP24XX_CONTROL_STATUS
>>>> +			 * am33xx   - AM33XX_CONTROL_STATUS
>>>> +			 * omap34xx - OMAP343X_CONTROL_STATUS
>>>> +			 * omap44xx - OMAP4_CTRL_MODULE_CORE_STATUS
>>>> +			 * omap54xx - OMAP5XXX_CONTROL_STATUS
>>>> +			 */
>>>> +			omap_control_base = ioremap(omap_control_phys_base, omap_control_mapsize);
>>>> +		}
>>>> +	}
>>>> +}
>>> You should probably add a function for setting omap_control_base
>>> separately from *set_globals* in arch/arm/mach-omap2/common.c.
>>> That way it's initialized early for id.c, and you can initialize
>>> everything else later as regular device drivers.
>>>
>>> FYI, we want to initialize as much as possible late so we have
>>> proper debugging console set up in case things go wrong.
>> Hmm it seems that omap_control_base is now only initialized for DT boot
>> case? This will break booting on almost all systems..
> Looking at things more, looks like omap_type() is getting called
> early from timer.c. So maybe just let set_globals initialize
> omap_control_base and let omap_type() read that directly. That way
> the SCM core driver can behave like a regular device driver and it
> does not need to be initialized early.

  Yes, omap_type() is called very early , that is why I'm using early_initcall for omap_control_base initialization.

Do you mean following?:
void __init omap2_set_globals_control(struct omap_globals *omap2_globals)
{
    if (omap2_globals->ctrl)
        omap2_ctrl_base = omap2_globals->ctrl;

    if (omap2_globals->ctrl_pad)
        omap4_ctrl_pad_base = omap2_globals->ctrl_pad;

    omap_control_base = omap2_ctrl_base;  // this line is added
}

  Or you suggest to move
void __init of_omap_control_init(const struct of_device_id *matches)
{
    struct device_node *np;
    struct property *pp = 0;

    for_each_matching_node(np, matches) {
        pp = of_find_property(np, "reg", NULL);
        if(pp) {
            omap_control_phys_base = (unsigned long)be32_to_cpup(pp->value);
            omap_control_mapsize = (size_t)be32_to_cpup( (void*)((char*)pp->value + 4) );
            /*
             * Map control module register CONTROL_STATUS register:
             * omap24xx - OMAP24XX_CONTROL_STATUS
             * am33xx   - AM33XX_CONTROL_STATUS
             * omap34xx - OMAP343X_CONTROL_STATUS
             * omap44xx - OMAP4_CTRL_MODULE_CORE_STATUS
             * omap54xx - OMAP5XXX_CONTROL_STATUS
             */
            omap_control_base = ioremap(omap_control_phys_base, omap_control_mapsize);
        }
    }
}

into omap2_set_globals_control() ?

Also if we move omap_control_base initialization to omap2_set_globals_control(), than the initialization routine of drivers/mfd/omap-control-core.c become empty, because omap_control_base is the only thing that is initialized in omap-control-core driver.

  BR,
    Konstantin Baydarov.

>
> Regards,
>
> Tony
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

