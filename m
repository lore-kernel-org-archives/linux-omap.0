From: "Hiremath, Vaibhav" <hvaibhav-l0cyMroinI0@public.gmane.org>
Subject: RE: [RFC RESEND 2/4] ARM: OMAP3: Dynamically disable secure timer
 nodes for secure devices
Date: Fri, 17 Aug 2012 05:32:53 +0000
Message-ID: <79CD15C6BA57404B839C016229A409A83EA91D63@DBDE01.ent.ti.com>
References: <1342218413-30116-1-git-send-email-jon-hunter@ti.com>
 <1342218413-30116-3-git-send-email-jon-hunter@ti.com>
 <502B6838.9080907@ti.com> <502D2686.4090107@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
In-Reply-To: <502D2686.4090107-l0cyMroinI0@public.gmane.org>
Content-Language: en-US
List-Unsubscribe: <https://lists.ozlabs.org/options/devicetree-discuss>,
 <mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/devicetree-discuss/>
List-Post: <mailto:devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
List-Help: <mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/devicetree-discuss>,
 <mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=subscribe>
Errors-To: devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org
Sender: "devicetree-discuss"
 <devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
To: "Hunter, Jon" <jon-hunter-l0cyMroinI0@public.gmane.org>
Cc: device-tree <devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>, Rob Herring <rob.herring-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org>, linux-omap <linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "DebBarma, Tarun Kanti" <tarun.kanti-l0cyMroinI0@public.gmane.org>, linux-arm <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

On Thu, Aug 16, 2012 at 22:27:42, Hunter, Jon wrote:
> 
> On 08/15/2012 04:13 AM, Vaibhav Hiremath wrote:
> > 
> > 
> > On 7/14/2012 3:56 AM, Jon Hunter wrote:
> >> OMAP3 devices may or may not have security features enabled. Security enabled
> >> devices are known as high-secure (HS) and devices without security are known as
> >> general purpose (GP).
> >>
> >> For OMAP3 devices there are 12 general purpose timers available. On secure
> >> devices the 12th timer is reserved for secure usage and so cannot be used by
> >> the kernel, where as for a GP device it is available. We can detect the OMAP
> >> device type, secure or GP, at runtime via an on-chip register. Today, when not
> >> using DT, we do not register the 12th timer as a linux device if the device is
> >> secure.
> >>
> >> When using device tree, device tree is going to register all the timer devices
> >> it finds in the device tree blob. To prevent device tree from registering 12th
> >> timer on a secure OMAP3 device we can add a status property to the timer
> >> binding with the value "disabled" at boot time. Note that timer 12 on a OMAP3
> >> device has a property "ti,timer-secure" to indicate that it will not be
> >> available on a secure device and so for secure OMAP3 devices, we search for
> >> timers with this property and then disable them. Using the prom_add_property()
> >> function to dynamically add a property was a recommended approach suggested by
> >> Rob Herring [1].
> >>
> >> I have tested this on an OMAP3 GP device and faking it to pretend to be a
> >> secure device to ensure that any timers marked with "ti,timer-secure" are not
> >> registered on boot. I have also made sure that all timers are registered as
> >> expected on a GP device by default.
> >>
> >> [1] http://comments.gmane.org/gmane.linux.ports.arm.omap/79203
> >>
> >> Signed-off-by: Jon Hunter <jon-hunter-l0cyMroinI0@public.gmane.org>
> >> ---
> >>  arch/arm/mach-omap2/board-generic.c |    1 +
> >>  arch/arm/mach-omap2/common.h        |    1 +
> >>  arch/arm/mach-omap2/timer.c         |   36 +++++++++++++++++++++++++++++++++++
> >>  3 files changed, 38 insertions(+)
> >>
> >> diff --git a/arch/arm/mach-omap2/board-generic.c b/arch/arm/mach-omap2/board-generic.c
> >> index 6f93a20..20124d7 100644
> >> --- a/arch/arm/mach-omap2/board-generic.c
> >> +++ b/arch/arm/mach-omap2/board-generic.c
> >> @@ -40,6 +40,7 @@ static struct of_device_id omap_dt_match_table[] __initdata = {
> >>  static void __init omap_generic_init(void)
> >>  {
> >>  	omap_sdrc_init(NULL, NULL);
> >> +	omap_dmtimer_init();
> >>  
> >>  	of_platform_populate(NULL, omap_dt_match_table, NULL, NULL);
> >>  }
> >> diff --git a/arch/arm/mach-omap2/common.h b/arch/arm/mach-omap2/common.h
> >> index 1f65b18..d6a4875 100644
> >> --- a/arch/arm/mach-omap2/common.h
> >> +++ b/arch/arm/mach-omap2/common.h
> >> @@ -326,6 +326,7 @@ extern void omap_sdrc_init(struct omap_sdrc_params *sdrc_cs0,
> >>  				      struct omap_sdrc_params *sdrc_cs1);
> >>  struct omap2_hsmmc_info;
> >>  extern int omap4_twl6030_hsmmc_init(struct omap2_hsmmc_info *controllers);
> >> +extern void omap_dmtimer_init(void);
> >>  
> >>  #endif /* __ASSEMBLER__ */
> >>  #endif /* __ARCH_ARM_MACH_OMAP2PLUS_COMMON_H */
> >> diff --git a/arch/arm/mach-omap2/timer.c b/arch/arm/mach-omap2/timer.c
> >> index 13d20c8..e3b9931 100644
> >> --- a/arch/arm/mach-omap2/timer.c
> >> +++ b/arch/arm/mach-omap2/timer.c
> >> @@ -36,6 +36,7 @@
> >>  #include <linux/clocksource.h>
> >>  #include <linux/clockchips.h>
> >>  #include <linux/slab.h>
> >> +#include <linux/of.h>
> >>  
> >>  #include <asm/mach/time.h>
> >>  #include <plat/dmtimer.h>
> >> @@ -482,6 +483,41 @@ static int __init omap2_dm_timer_init(void)
> >>  }
> >>  arch_initcall(omap2_dm_timer_init);
> >>  
> >> +static struct property timer_disabled = {
> >> +	.name = "status",
> >> +	.length = sizeof("disabled"),
> >> +	.value = "disabled",
> >> +};
> >> +
> >> +static struct of_device_id omap3_timer_match[] __initdata = {
> >> +	{ .compatible = "ti,omap3-timer", },
> >> +	{ }
> >> +};
> >> +
> >> +/**
> >> + * omap_dmtimer_init - initialisation function when device tree is used
> >> + *
> >> + * For secure OMAP3 devices, timers with device type "timer-secure" cannot
> >> + * be used by the kernel as they are reserved. Therefore, to prevent the
> >> + * kernel registering these devices remove them dynamically from the device
> >> + * tree on boot.
> >> + */
> >> +void __init omap_dmtimer_init(void)
> >> +{
> >> +	struct device_node *np;
> >> +
> >> +	if (!cpu_is_omap34xx())
> >> +		return;
> >> +
> > 
> > Sorry for responding so late, but why only omap34xx check here?
> > Isn't this applicable to all omap & non-omap devices?
> 
> It is only applicable to omap3 devices as far as omap is concerned.
> 
> By non-omap, you are referring to the AMxxx stuff?
> 
> Do AMxxx devices even support security (ie. secure boot and have secure
> peripherals)? If not then this will work for AMxxx devices too.
> 

Yes it does. 

AM33xx has 8 timers and Timer-0 is a secure timer. As in case of OMAP3, we 
do not even register timer-0 to kernel.


> Let me know if the changelog is not clear why this is needed for an
> omap3 device.
> 

The changelog description is clear, but it is not only restricted to OMAP3.

Thanks,
Vaibhav
