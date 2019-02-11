From: Roger Quadros <rogerq@ti.com>
Subject: Re: [PATCH 2/4] bus: ti-sysc: Add support for PRUSS SYSC type
Date: Mon, 11 Feb 2019 14:11:25 +0200
Message-ID: <5C61666D.3030308@ti.com>
References: <1549295637-24890-1-git-send-email-rogerq@ti.com>
 <1549295637-24890-3-git-send-email-rogerq@ti.com>
 <20190204180031.GL5720@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190204180031.GL5720@atomide.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: s-anna@ti.com, nsekhar@ti.com, linux-omap@vger.kernel.org, t-kristo@ti.com, nsaulnier@ti.com, jreeder@ti.com, m-karicheri2@ti.com, david@lechnology.com, woods.technical@gmail.com, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

Tony,

On 04/02/19 20:00, Tony Lindgren wrote:
> * Roger Quadros <rogerq@ti.com> [190204 15:54]:
>> +static int sysc_enable_pruss(struct sysc *sysc)
>> +{
>> +	int i;
>> +	u32 reg;
>> +	bool ready;
>> +
>> +	/* configure for Smart Idle & Smart Standby */
>> +	reg = sysc_read(sysc, sysc->offsets[SYSC_SYSCONFIG]);
>> +	reg &= ~(SYSC_PRUSS_STANDBY_MASK | SYSC_PRUSS_IDLE_MASK);
>> +	reg |= SYSC_PRUSS_STANDBY_SMART | SYSC_IDLE_SMART;
>> +	sysc_write(sysc, sysc->offsets[SYSC_SYSCONFIG], reg);
> 
> I think you can get rid of the SYSC_PRUSS_ defines here
> if you define the bits for it in struct sysc_regbits. The
> idle modes are SYSC_IDLE_* defines we already have in
> include/dt-bindings/bus/ti-sysc.h.
> 
> My guess is these will just become generic sysc_enable()
> and sysc_disable() functions :)
> 
> If you need module specific handling, you could add function
> pointers for enable and disable to struct sysc_capabilities.

OK. I'll move all this to a generic handler then.
> 
>> @@ -649,6 +693,9 @@ static int __maybe_unused sysc_runtime_suspend(struct device *dev)
>>  		goto idled;
>>  	}
>>  
>> +	if (ddata->cap->type == TI_SYSC_PRUSS)
>> +		sysc_disable_pruss(ddata);
>> +
>>  	for (i = 0; i < ddata->nr_clocks; i++) {
>>  		if (IS_ERR_OR_NULL(ddata->clocks[i]))
>>  			continue;
> 
> Ideally this would be just unconditional call to generic
> sysc_disable() here for non-legacy mode. Then if module
> specific enable and disable are there, sysc_enable() and
> disable() can call them.

OK.

> 
>> +static const struct sysc_regbits sysc_regbits_pruss = {
>> +	.midle_shift = -ENODEV,
>> +	.clkact_shift = -ENODEV,
>> +	.sidle_shift = -ENODEV,
>> +	.enwkup_shift = -ENODEV,
>> +	.srst_shift = -ENODEV,
>> +	.autoidle_shift = -ENODEV,
>> +	.dmadisable_shift = -ENODEV,
>> +	.emufree_shift = -ENODEV,
>> +};
> 
> So it seems you should populate at least midle_shift and sidle_shift
> bits here as in PRUSS_SYSCFG. I think STANDBY_MODE offset should go
> into the .midle_shift as it mentions initiator in TRM, and IDLE_MODE
> offset should go into .sidle_shift. So this might be really just using
> sysc_regbits_omap4_simple except it has an additional STANDBY_INIT
> bit which you could add for struct sysc_regbits if we don't have
> something similar already.

Got it.

> 
>> @@ -1702,6 +1772,10 @@ static int sysc_probe(struct platform_device *pdev)
>>  
>>  	INIT_DELAYED_WORK(&ddata->idle_work, ti_sysc_idle);
>>  
>> +	/* FIXME: how to ensure PRUSS stays enabled? */
>> +	if (ddata->cap->type == TI_SYSC_PRUSS)
>> +		goto skip_pm_put;
>> +

This was my bad. I forgot to move the pm_runtime_enable/get from the old
pruss_soc_bus.c to pruss.c :). It work after than and this hack is not required.

>>  	/* At least earlycon won't survive without deferred idle */
>>  	if (ddata->cfg.quirks & (SYSC_QUIRK_NO_IDLE_ON_INIT |
>>  				 SYSC_QUIRK_NO_RESET_ON_INIT)) {
> 
> Hmm so do you need to specify ti,no-idle-on-init or what's
> the logic needed here?

I was using "ti,no-reset-on-init" but that was because sysc_reset() was returning error
due to missing syss mask. That can be fixed like so.

diff --git a/drivers/bus/ti-sysc.c b/drivers/bus/ti-sysc.c
index 5b9c81a..f5f2000 100644
--- a/drivers/bus/ti-sysc.c
+++ b/drivers/bus/ti-sysc.c
@@ -941,6 +941,7 @@ static int sysc_reset(struct sysc *ddata)
 	int val;
 
 	if (ddata->legacy_mode || offset < 0 ||
+	    ddata->cap->regbits->srst_shift == -ENODEV ||
 	    ddata->cfg.quirks & SYSC_QUIRK_NO_RESET_ON_INIT)
 		return 0;


> 
>> diff --git a/include/dt-bindings/bus/ti-sysc.h b/include/dt-bindings/bus/ti-sysc.h
>> index 8ec78e8..7138384 100644
>> --- a/include/dt-bindings/bus/ti-sysc.h
>> +++ b/include/dt-bindings/bus/ti-sysc.h
>> @@ -17,17 +17,6 @@
>>  
>>  #define SYSC_DRA7_MCAN_ENAWAKEUP	(1 << 4)
>>  
>> -/* SYSCONFIG specific to PRUSS */
>> -#define SYSC_PRUSS_SUB_MWAIT		(1 << 5)
>> -#define SYSC_PRUSS_STANDBY_INIT		(1 << 4)
>> -
>> -#define SYSC_PRUSS_STANDBY_FORCE	(0 << 2)
>> -#define SYSC_PRUSS_STANDBY_NO		(1 << 2)
>> -#define SYSC_PRUSS_STANDBY_SMART	(2 << 2)
>> -#define SYSC_PRUSS_STANDBY_MASK		(3 << 2)
>> -
>> -#define SYSC_PRUSS_IDLE_MASK		3
>> -
>>  /* SYSCONFIG STANDBYMODE/MIDLEMODE/SIDLEMODE supported by hardware */
>>  #define SYSC_IDLE_FORCE			0
>>  #define SYSC_IDLE_NO			1
> 
> I suggest you make this series independent of the
> rest of the PRUSS patches as we can add this
> separately. So no need to define these bits at all
> AFAIK.

OK. Thanks.

cheers,
-roger

> 
> Regards,
> 
> Tony
> 

-- 
Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki
