From: Johan Hovold <johan-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH v2 2/2] memory: ti-emif-sram: introduce relocatable
 suspend/resume handlers
Date: Mon, 10 Jul 2017 13:31:55 +0200
Message-ID: <20170710113155.GH29638@localhost>
References: <20170519175708.6070-1-d-gerlach@ti.com>
 <20170519175708.6070-3-d-gerlach@ti.com>
 <20170703161716.GA27842@localhost>
 <577c4595-74b4-c10d-2dbf-07b58e87a263@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <577c4595-74b4-c10d-2dbf-07b58e87a263-l0cyMroinI0@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Dave Gerlach <d-gerlach-l0cyMroinI0@public.gmane.org>
Cc: Johan Hovold <johan-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, Santosh Shilimkar <ssantosh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Russell King <linux-I+IVW8TIWO2tmTQ+vhA3Yw@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Keerthy J <j-keerthy-l0cyMroinI0@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: linux-omap@vger.kernel.org

On Thu, Jul 06, 2017 at 01:59:08PM -0500, Dave Gerlach wrote:
> On 07/03/2017 11:17 AM, Johan Hovold wrote:
> > On Fri, May 19, 2017 at 12:57:08PM -0500, Dave Gerlach wrote:
> >> Certain SoCs like Texas Instruments AM335x and AM437x require parts
> >> of the EMIF PM code to run late in the suspend sequence from SRAM,
> >> such as saving and restoring the EMIF context and placing the memory
> >> into self-refresh.
> >>
> >> One requirement for these SoCs to suspend and enter its lowest power
> >> mode, called DeepSleep0, is that the PER power domain must be shut off.
> >> Because the EMIF (DDR Controller) resides within this power domain, it
> >> will lose context during a suspend operation, so we must save it so we
> >> can restore once we resume. However, we cannot execute this code from
> >> external memory, as it is not available at this point, so the code must
> >> be executed late in the suspend path from SRAM.
> >>
> >> This patch introduces a ti-emif-sram driver that includes several
> >> functions written in ARM ASM that are relocatable so the PM SRAM
> >> code can use them. It also allocates a region of writable SRAM to
> >> be used by the code running in the executable region of SRAM to save
> >> and restore the EMIF context. It can export a table containing the
> >> absolute addresses of the available PM functions so that other SRAM
> >> code can branch to them. This code is required for suspend/resume on
> >> AM335x and AM437x to work.
> > 
> > Thanks for pushing this forward, Dave. 
> > 
> > I did a quick review of this one and found a few issues.
> > 
> >> +static phys_addr_t ti_emif_sram_phys, ti_emif_sram_data_phys;
> >> +static unsigned long ti_emif_sram_virt, ti_emif_sram_data_virt;
> >> +static struct gen_pool *sram_pool_code, *sram_pool_data;
> >> +static struct ti_emif_pm_data pm_data;
> >> +static struct ti_emif_pm_functions pm_functions;
> > 
> > Should these not be driver private data rather than static as you also
> > are tying (and need to tie) this into the device model?
> > 
> > Sure there might never be two of these devices in practise, but in
> > theory there could be. A proper device abstraction would probably allow
> > for a cleaner implementation and help with some of the dependency issues
> > (more below).
> > 
> 
> Well, I would say that at this point the hardware is well defined and there is
> no case where we would have two instances of this. Allowing two instances of
> this code would also unnecessarily complicate the assembly portions because of
> the absolute SRAM memory addresses that some of the variables are stored in.

Sure, but there's currently nothing preventing you from defining another
node with the same compatible string which would overwrite that static
data when probed, nor is anything preventing the driver from being
unbound (and the sram-allocation from being released and possibly
repurposed).

> >> +/**
> >> + * ti_emif_copy_pm_function_table - copy mapping of pm funcs in sram
> >> + * @sram_pool: pointer to struct gen_pool where dst resides
> >> + * @dst: void * to address that table should be copied
> >> + *
> >> + * Returns 0 if success other error code if table is not available
> >> + */
> >> +int ti_emif_copy_pm_function_table(struct gen_pool *sram_pool, void *dst)
> >> +{
> >> +	void *copy_addr;
> >> +
> >> +	if (!ti_emif_sram_virt)
> >> +		return -EINVAL;
> >> +
> >> +	copy_addr = sram_exec_copy(sram_pool, dst, &pm_functions,
> >> +				   sizeof(pm_functions));
> >> +	if (!copy_addr)
> >> +		return -ENODEV;
> >> +
> >> +	return 0;
> >> +}
> >> +EXPORT_SYMBOL_GPL(ti_emif_copy_pm_function_table);
> > 
> > This is fragile as nothing guarantees that the pm_functions have been
> > setup (ti_emif_sram_virt might still be non-NULL after a probe error).
> > The driver can also have been unloaded (and then pm_functions is gone).
> > 
> > It seems you need to create a device link between your pm33xx device
> > (consumer) and the ti-emif-pm device (supplier) to prevent the latter
> > from going away (possibly after never having been fully initialised).
> > 
> 
> After a probe error ti-emif-pm will not be loaded, and because of this, pm33xx
> cannot load because it depends on ti-emif-pm directly. Furthermore, we call
> these exported symbols directly from pm33xx so as long as pm33xx is loaded
> ti-emif-pm cannot be unloaded.

The drivers (modules) can always be loaded, but the pm33xx driver
*might* fail to bind after a failed probe of the ti-emif-pm driver. With
the current code it is however possible that such a failed probe leaves
the pm_data.ti_emif_base_addr_virt set to an address which is no longer
mapped (or ti_emif_sram_virt pointing to memory that's been freed).

> The link between pm33xx and ti-emif-pm is already there because we call some
> functions in ti-emif-pm directly.

Yes, you're right that the emif driver module cannot be unloaded due to
those calls, but nothing is preventing the driver from being unbound
from the emif device (e.g. through sysfs).

So what is missing is a link expressing the dependency between the
devices, which would prevent the supplier driver from being unbound.
We've only recently gained support for modelling such dependencies, and
it may not be worth using it in this case (as least as long as we do not
allow parallel probes), but the failed probe case at least needs to be
handled.

> >> +
> >> +/**
> >> + * ti_emif_get_mem_type - return type for memory type in use
> >> + *
> >> + * Returns memory type value read from EMIF or error code if fails
> >> + */
> >> +int ti_emif_get_mem_type(void)
> >> +{
> >> +	unsigned long temp;
> >> +
> >> +	if (!pm_data.ti_emif_base_addr_virt ||
> >> +	    IS_ERR(pm_data.ti_emif_base_addr_virt))
> >> +		return -ENODEV;
> >> +
> >> +	temp = readl(pm_data.ti_emif_base_addr_virt +
> >> +		     EMIF_SDRAM_CONFIG);
> >> +
> >> +	temp = (temp & SDRAM_TYPE_MASK) >> SDRAM_TYPE_SHIFT;
> >> +	return temp;
> >> +}
> >> +EXPORT_SYMBOL_GPL(ti_emif_get_mem_type);
> > 
> > Similar problem with this one (even if you do catch one possible probe
> > error with the IS_ERR()).
> 
> Yes I will look closer at the error handling. Probably need to clear
> ti_emif_base_addr_virt on a defer.

Right.

Johan
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
