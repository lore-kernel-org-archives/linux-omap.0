From: Tony Lindgren <tony@atomide.com>
Subject: Re: [RFC PATCH 4/4] bus: ti-sysc: Ensure PRU-ICSS doesn't break
 suspend/resume
Date: Tue, 2 Apr 2019 09:57:23 -0700
Message-ID: <20190402165723.GM49658@atomide.com>
References: <20190402133752.6912-1-rogerq@ti.com>
 <20190402133752.6912-5-rogerq@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190402133752.6912-5-rogerq@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Roger Quadros <rogerq@ti.com>
Cc: nsekhar@ti.com, s-anna@ti.com, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

* Roger Quadros <rogerq@ti.com> [190402 13:38]:
> The PRU-ICSS subsystem's SYSCONFIG register is similar to
> omap4-simple but has 2 special bits STANDBY_INIT and SUB_MWAIT.
> 
> The STANDBY_INIT bit initiates a Standby sequence (when set) and
> triggers a MStandby request to the SoC's PRCM module. This same
> bit is also used to enable the OCP master ports (when cleared).
> 
> Some PRU applications require the OCP master port access to be
> enabled thus keeping it out of standby.

So do we need to configure this depending on the application?

> During sustem suspend/resume we must ensure that the PRUSS is in
> standby else it will break resume.
> 
> NOTE:
> 1. This patch only adds the PM callbacks with code to fix the System
> Suspend/Resume hang issue on AM33xx/AM437x SoCs, but does not
> implement the full context save and restore required for the PRUSS
> drivers to work across system suspend/resume when the power domain
> is switched off (L4PER domain is switched OFF on AM335x/AM437x
> during system suspend/resume, so PRUSS modules do lose context).

I think we already restore the interconnect target module access
properly on resume. If not we should fix that.

Saving and restoring the child device state is up to the device
drivers managing the child device(s), and there's not much ti-sysc.c
can do about it, right?

> @@ -92,6 +93,7 @@ struct sysc {
>  	bool enabled;
>  	bool needs_resume;
>  	bool child_needs_resume;
> +	bool in_standby;
>  	struct delayed_work idle_work;
>  };

We should start using bitfields for the bool here, might as well
already do it now:

unsigned long in_standby:1;

See "17) Using bool" in Documentation/process/coding-style.rst.

> @@ -1023,6 +1025,21 @@ static int __maybe_unused sysc_noirq_suspend(struct device *dev)
>  	if (ddata->cfg.quirks & SYSC_QUIRK_LEGACY_IDLE)
>  		return 0;
>  
> +	if (ddata->cap->type == TI_SYSC_PRUSS) {

Should this test be made more generic based on the mstandby
bit being configured?

And can you please make these into separate functions to
avoid cluttering the suspend and resume functions. Something
like sysc_handle_mstandby() maybe?

> +		u32 reg, mask;
> +		const struct sysc_regbits *regbits = ddata->cap->regbits;
> +
> +		mask = BIT(regbits->standby_init_shift);
> +		reg = sysc_read(ddata, ddata->offsets[SYSC_SYSCONFIG]);
> +		ddata->in_standby = reg & mask;

Hmm so could we just assume that the device drivers for child device(s)
configure the MSTANDBY bit? Or do we need to manage it in ti-sysc?

See for example drivers/usb/musb/omap2430.c omap2430_low_level_init()
and omap2430_low_level_exit(). That's a separate register though.

Regards,

Tony
