From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] ARM: OMAP2+: omap-device: remove omap_device_late_init
 call completely
Date: Thu, 27 Aug 2015 09:38:56 -0700
Message-ID: <20150827163856.GX4215@atomide.com>
References: <1440611890-4935-1-git-send-email-grygorii.strashko@ti.com>
 <20150826181006.GT4215@atomide.com> <55DF12E7.10802@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <55DF12E7.10802@ti.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Grygorii Strashko <grygorii.strashko@ti.com>
Cc: linux@arm.linux.org.uk, Keerthy <j-keerthy@ti.com>, nsekhar@ti.com, balbi@ti.com, t-kristo@ti.com, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

* Grygorii Strashko <grygorii.strashko@ti.com> [150827 06:42]:
> Hi Tony,
> 
> On 08/26/2015 09:10 PM, Tony Lindgren wrote:
> > * Grygorii Strashko <grygorii.strashko@ti.com> [150826 11:01]:
> >> Now Kernel fails to boot 50% of times (form build to build) with
> >> RT-patchset applied due to the following race - on late boot
> >> stages deferred_probe_work_func races with omap_device_late_ini
> >>
> >> late_initcall
> >>   - deferred_probe_initcal() tries to re-probe all pending driver's probe.
> >>     [In general, It's NOT expected to probe any other built-in drivers after
> >>     deferred_probe_initcal() is finished, because most of
> >>     late_initcall_sync/late_initcall functions expected that all driver
> >>     or probed or deferred already.]
> >>
> >> - later on, some driver is probing in this case It's could cpsw.c
> >>    (but could be any other drivers)
> >>    cpsw_init
> >>    - platform_driver_register
> >>      - really_probe
> >>         - driver_bound
> >>           - driver_deferred_probe_trigger
> >>    and boot proceed.
> >>    So, at this moment we have  deferred_probe_work_func scheduled.
> >>
> >> late_initcall_sync
> >>    - omap_device_late_init
> >>      - omap_device_idle
> >>
> >> CPU1					CPU2
> >>    - deferred_probe_work_func
> >>      - really_probe
> >>        - omap_hsmmc_probe
> >> 	- pm_runtime_get_sync
> >> 					late_initcall_sync
> >> 					- omap_device_late_init
> >> 						if (od->_driver_status != BUS_NOTIFY_BOUND_DRIVER) {
> >> 							if (od->_state == OMAP_DEVICE_STATE_ENABLED) {
> >> 								- omap_device_idle [ops - IP is disabled, ]
> >> 	- [fail]
> >> 	- pm_runtime_put_sync
> >>            - omap_hsmmc_runtime_suspend [ooops!]
> > 
> > OK idling of unclaimed devices should not happen for deferred probe,
> > it should only happen when there's no driver and no probing happening.
> >   
> >> Lets remove just remove omap_device_late_init completely as suggested
> >> by Tero Kristo:
> >>
> >> "How about remove omap_device_late_init call completely. I don't think
> >> it does anything useful at the moment; none of the omap devices get
> >> enabled outside runtime_pm, so there should be no need to explicitly
> >> disable the devices."
> > 
> > I think this is still needed from PM point of view as otherwise we
> > don't idle any devices that don't have a driver available. Or am I
> > missing something?
> > 
> > To me it seems the bug is relying on the BUS_NOTIFY_BOUND_DRIVER is
> > not set in the deferred probe case.
> > 
> 
> 
> What do you think about below alternative?
> 
> diff --git a/arch/arm/mach-omap2/omap_device.c b/arch/arm/mach-omap2/omap_device.c
> index 4cb8fd9..72ebc4c 100644
> --- a/arch/arm/mach-omap2/omap_device.c
> +++ b/arch/arm/mach-omap2/omap_device.c
> @@ -901,7 +901,8 @@ static int __init omap_device_late_idle(struct device *dev, void *data)
>                 if (od->hwmods[i]->flags & HWMOD_INIT_NO_IDLE)
>                         return 0;
>  
> -       if (od->_driver_status != BUS_NOTIFY_BOUND_DRIVER) {
> +       if (od->_driver_status != BUS_NOTIFY_BOUND_DRIVER &&
> +           od->_driver_status != BUS_NOTIFY_BIND_DRIVER) {
>                 if (od->_state == OMAP_DEVICE_STATE_ENABLED) {
>                         dev_warn(dev, "%s: enabled but no driver.  Idling\n",
>                                  __func__);

Seems better to me if it really fixes the issue.

Regards,

Tony
