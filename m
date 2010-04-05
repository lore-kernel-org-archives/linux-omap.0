From: "Lesly Arackal Manuel" <leslyam@ti.com>
Subject: RE: [PATCH] MFD: TWL4030: changes for TRITON glitch fix
Date: Mon, 5 Apr 2010 20:30:04 +0530
Message-ID: <000601cad4d0$ae09e2d0$518918ac@apr.dhcp.ti.com>
References: <1268410296-28993-1-git-send-email-leslyam@ti.com> <87tysddvsh.fsf@deeprootsystems.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:55904 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755006Ab0DEPAQ (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 5 Apr 2010 11:00:16 -0400
In-Reply-To: <87tysddvsh.fsf@deeprootsystems.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: 'Kevin Hilman' <khilman@deeprootsystems.com>
Cc: linux-omap@vger.kernel.org, 'Nishanth Menon' <nm@ti.com>, 'David Derrick' <dderrick@ti.com>, 'Samuel Ortiz' <sameo@linux.intel.com>



-----Original Message-----
From: Kevin Hilman [mailto:khilman@deeprootsystems.com] 
Sent: Friday, March 19, 2010 5:31 AM
To: Lesly A M
Cc: linux-omap@vger.kernel.org; Nishanth Menon; David Derrick; Samuel Ortiz
Subject: Re: [PATCH] MFD: TWL4030: changes for TRITON glitch fix

Lesly A M <leslyam@ti.com> writes:

> Fix for TWL5030 Silicon Errata 27 & 28:
> 27 - VDD1, VDD2, may have glitches when their output value is updated.
> 28 - VDD1 and / or VDD2 DCDC clock may stop working when internal clock
> is switched from internal to external.
>
> Workaround requires the TWL DCDCs to use HFCLK instead of internal
oscillator.
> Also enable TWL watchdog before switching the osc to recover
> if the VDD1/VDD2 stop working.
>
> Fix is required for TWL5030 Silicon version less than or equal to ES1.1
> Changes are done under the macro CONFIG_TWL5030_GLITCH_FIX,
> since the IDCODE register on TWL5030 Si is not updated correctly.
>
> Updated the TWL resource settings and volt, clock setuptime.
>
> Changes taken from Nishanth Menons gaia glitch fix patch.
>
> Signed-off-by: Lesly A M <leslyam@ti.com>
> Cc: Nishanth Menon <nm@ti.com>
> Cc: David Derrick <dderrick@ti.com>
> Cc: Samuel Ortiz <sameo@linux.intel.com>
> ---

Some general comments:

Why do you need a Kconfig option for this?  

The changelog says IDCODE is not updated correctly, but the code is
using detection in SW to see if the fix is required, so that should be
default behavior.

Even if SW detection is not reliable, Kconfig is not the right
approach here.  Board code should simply set a flag or register
a hook if the fix is required.

This patch has failed my 15 minute rule (if I can't understand a patch
in 15 minutes, blame it on the changelog.)

I'm having troubles understanding the intended sequence of events
here.  Various script pointers are being passed around and overwritten
etc., and it is not terribly clear what the outcome is.  The changelog
needs some updating to clarify that.   A lot of the confusion stems
from what belongs in board files and what belongs in common code.

More comments inline below...

[Lesly] Since the GAIA version checking will note correct, Kconfig option is
added if somebody wants to disable the gai_glitch_fix code during
menuconfig.

We expect the GAIA IDCODE register will be updated properly in the next Si
version.

Do you mean to say that we can add one function ptr in
twl4030_platform_data, which can updated from the board file with the
function for glitch_fix changes.

And this can be passed to twl4030_power_init() along with script_data for
executing if GAIA Si ver less_than 1.2


> This patch has dependency on:
> 	SmartReflex patch series from Thara.
> 	Update TRITON power scripts from Lesly.
>
> This patch series is based off Kevin's tree origin/pm branch.
>
> This changes are tested on OMAP3430 SDP board with:
> 	enable_off_mode
> 	voltage_off_while_idle
> 	sleep_while_idle (VDD1/VDD2 voltage scaling to 0v) enabled in
cpuidle and suspned path.
>
> Also tested for reboot and dvfs.
>
>  arch/arm/mach-omap2/board-3430sdp.c           |   40 +++++++++
>  arch/arm/mach-omap2/board-zoom-peripherals.c  |   40 +++++++++
>  arch/arm/mach-omap2/include/mach/board-sdp.h  |    4 +
>  arch/arm/mach-omap2/include/mach/board-zoom.h |    4 +
>  arch/arm/mach-omap2/twl4030-script.c          |   84 +++++++++++++++++++
>  arch/arm/mach-omap2/twl4030-script.h          |    9 ++
>  arch/arm/mach-omap2/voltage.c                 |   10 +++
>  arch/arm/mach-omap2/voltage.h                 |    4 +
>  arch/arm/plat-omap/Kconfig                    |    7 ++
>  drivers/mfd/twl4030-power.c                   |  106
+++++++++++++++++++++++++
>  10 files changed, 308 insertions(+), 0 deletions(-)
>
> diff --git a/arch/arm/mach-omap2/board-3430sdp.c
b/arch/arm/mach-omap2/board-3430sdp.c
> index 4f94b6f..d174d21 100644
> --- a/arch/arm/mach-omap2/board-3430sdp.c
> +++ b/arch/arm/mach-omap2/board-3430sdp.c
> @@ -475,6 +475,36 @@ static struct twl4030_resconfig twl4030_rconfig[] = {
>  	{ 0, 0},
>  };
>  
> +#ifdef CONFIG_TWL5030_GLITCH_FIX
> +static struct twl4030_resconfig twl4030_rconfig_glitchfix[] = {
> +	{ .resource = RES_VPLL1, .devgroup = DEV_GRP_P1 | DEV_GRP_P3,
> +		.type = 3, .type2 = 1, .remap_sleep = RES_STATE_OFF },
> +	{ .resource = RES_VINTANA1, .devgroup = DEV_GRP_ALL, .type = 1,
> +		.type2 = 2, .remap_sleep = RES_STATE_SLEEP },
> +	{ .resource = RES_VINTANA2, .devgroup = DEV_GRP_ALL, .type = 0,
> +		.type2 = 2, .remap_sleep = RES_STATE_SLEEP },
> +	{ .resource = RES_VINTDIG, .devgroup = DEV_GRP_ALL, .type = 1,
> +		.type2 = 2, .remap_sleep = RES_STATE_SLEEP },
> +	{ .resource = RES_VIO, .devgroup = DEV_GRP_ALL, .type = 2,
> +		.type2 = 2, .remap_sleep = RES_STATE_SLEEP },
> +	{ .resource = RES_VDD1, .devgroup = DEV_GRP_P1 | DEV_GRP_P3,
> +		.type = 4, .type2 = 1, .remap_sleep = RES_STATE_OFF },
> +	{ .resource = RES_VDD2, .devgroup = DEV_GRP_P1 | DEV_GRP_P3,
> +		.type = 3, .type2 = 1, .remap_sleep = RES_STATE_OFF },
> +	{ .resource = RES_REGEN, .devgroup = DEV_GRP_ALL, .type = 2,
> +		.type2 = 1, .remap_sleep = RES_STATE_SLEEP },
> +	{ .resource = RES_NRES_PWRON, .devgroup = DEV_GRP_ALL, .type = 0,
> +		.type2 = 1, .remap_sleep = RES_STATE_SLEEP },
> +	{ .resource = RES_CLKEN, .devgroup = DEV_GRP_ALL, .type = 3,
> +		.type2 = 2, .remap_sleep = RES_STATE_SLEEP },
> +	{ .resource = RES_SYSEN, .devgroup = DEV_GRP_ALL, .type = 6,
> +		.type2 = 1, .remap_sleep = RES_STATE_SLEEP },
> +	{ .resource = RES_HFCLKOUT, .devgroup = DEV_GRP_P1 | DEV_GRP_P3,
> +		.type = 0, .type2 = 1, .remap_sleep = RES_STATE_SLEEP },
> +	{ 0, 0},
> +};
> +#endif
> +
>  static struct twl4030_power_data sdp3430_t2scripts_data __initdata = {
>  	.resource_config = twl4030_rconfig,
>  };
> @@ -840,6 +870,16 @@ static struct omap_musb_board_data musb_board_data =
{
>  	.power			= 100,
>  };
>  
> +#ifdef CONFIG_TWL5030_GLITCH_FIX
> +void twl5030_glitchfix_changes_3430sdp(void)
> +{
> +	sdp3430_t2scripts_data.resource_config = twl4030_rconfig_glitchfix;
> +	use_twl4030_script_glitchfix(&sdp3430_t2scripts_data);
> +	omap_voltage_twl5030_glitchfix();
> +}
> +EXPORT_SYMBOL(twl5030_glitchfix_changes_3430sdp);
> +#endif

No board-specific callbacks via global functions please.  If this is
needed, please make a platform_data hook function for this.

That being said, Is don't really see what is board specific about this
fix.  

Maybe I'm mising something, and I didn't compare in detail, but it
looks like the scripts below for SDP and Zoom2 are identical.

That suggests to me that the modified scripts belong in common code.

[...]

[Lesly] There is no board specific changes.
Since 3430SDP and zoom board is not using a common t2scripts_data struct
created separate functions to update the t2scripts_data in each board file.

> diff --git a/arch/arm/mach-omap2/twl4030-script.c
b/arch/arm/mach-omap2/twl4030-script.c
> index cfa623b..90117b6 100644
> --- a/arch/arm/mach-omap2/twl4030-script.c
> +++ b/arch/arm/mach-omap2/twl4030-script.c
> @@ -74,6 +74,68 @@ static struct twl4030_script wakeup_p3_script
__initdata = {
>  	.flags  = TWL4030_WAKEUP3_SCRIPT,
>  };
>  
> +#ifdef CONFIG_TWL5030_GLITCH_FIX
> +struct prm_setup_vc twl4030_voltsetup_time_glitchfix = {
> +	/* VOLT SETUPTIME for RET & OFF */
> +	.voltsetup_time1_ret = 0x005B,
> +	.voltsetup_time2_ret = 0x0055,
> +	.voltsetup_time1_off = 0x00B3,
> +	.voltsetup_time2_off = 0x00A0,
> +	.voltoffset = 0x10,
> +	.voltsetup2 = 0x16B,
> +};

I don't see where this struct is used in this patch.

[Lesly] not used. I will cleanup in next patch.

> +/*
> + * Sequence to controll the TRITON Power resources,
> + * when the system goes into sleep.
> + * Executed upon P1_P2/P3 transition for sleep.
> + */
> +static struct twl4030_ins __initdata sleep_on_seq_glitchfix[] = {
> +	/* Singular message to disable HCLKOUT */
> +	{MSG_SINGULAR(DEV_GRP_NULL, RES_HFCLKOUT, RES_STATE_SLEEP), 20},
> +	/* Broadcast message to put res to sleep */
> +	{MSG_BROADCAST(DEV_GRP_NULL, RES_GRP_ALL, RES_TYPE_R0, RES_TYPE2_R1,
> +							RES_STATE_SLEEP),
2},
> +	{MSG_BROADCAST(DEV_GRP_NULL, RES_GRP_ALL, RES_TYPE_R0, RES_TYPE2_R2,
> +							RES_STATE_SLEEP),
2},
> +};
> +
> +static struct twl4030_script sleep_on_script_glitchfix __initdata = {
> +	.script	= sleep_on_seq_glitchfix,
> +	.size	= ARRAY_SIZE(sleep_on_seq_glitchfix),
> +	.flags	= TWL4030_SLEEP_SCRIPT,
> +};
> +
> +/*
> + * Sequence to controll the TRITON Power resources,
> + * when the system wakeup from sleep.
> + * Executed upon P1/P2/P3 transition for wakeup.
> + */
> +static struct twl4030_ins wakeup_seq_glitchfix[] __initdata = {
> +	/* Broadcast message to put res(TYPE2 =1) to active */
> +	{MSG_BROADCAST(DEV_GRP_NULL, RES_GRP_ALL, RES_TYPE_R0, RES_TYPE2_R2,
> +							RES_STATE_ACTIVE),
55},
> +	{MSG_BROADCAST(DEV_GRP_NULL, RES_GRP_ALL, RES_TYPE_R0, RES_TYPE2_R2,
> +							RES_STATE_ACTIVE),
55},
> +	{MSG_BROADCAST(DEV_GRP_NULL, RES_GRP_ALL, RES_TYPE_R0, RES_TYPE2_R2,
> +							RES_STATE_ACTIVE),
54},
> +	{MSG_BROADCAST(DEV_GRP_NULL, RES_GRP_ALL, RES_TYPE_R0, RES_TYPE2_R2,
> +							RES_STATE_ACTIVE),
1},
> +	/* Singular message to enable HCLKOUT */
> +	{MSG_SINGULAR(DEV_GRP_NULL, RES_HFCLKOUT, RES_STATE_ACTIVE), 1},
> +	/* Broadcast message to put res(TYPE2 =1) to active */
> +	{MSG_BROADCAST(DEV_GRP_NULL, RES_GRP_ALL, RES_TYPE_R0, RES_TYPE2_R1,
> +							RES_STATE_ACTIVE),
2},
> +};
> +
> +static struct twl4030_script wakeup_script_glitchfix __initdata = {
> +	.script	= wakeup_seq_glitchfix,
> +	.size	= ARRAY_SIZE(wakeup_seq_glitchfix),
> +	.flags	= TWL4030_WAKEUP12_SCRIPT | TWL4030_WAKEUP3_SCRIPT,
> +};
> +
> +#endif
> +
>  /*
>   * Sequence to reset the TRITON Power resources,
>   * when the system gets warm reset.
> @@ -140,4 +202,26 @@ void twl4030_get_vc_timings(struct prm_setup_vc
*setup_vc)
>  	setup_vc->voltoffset = twl4030_voltsetup_time.voltoffset;
>  	setup_vc->voltsetup2 = twl4030_voltsetup_time.voltsetup2;
>  }
> +
> +#ifdef CONFIG_TWL5030_GLITCH_FIX
> +/* TRITON script for sleep, wakeup & warm_reset */
> +static struct twl4030_script *twl4030_scripts_glitchfix[] __initdata = {
> +	&sleep_on_script_glitchfix,
> +	&wakeup_script_glitchfix,
> +	&wrst_script,
> +};
> +
> +struct twl4030_power_data twl4030_script_glitchfix __initdata = {
> +	.scripts	= twl4030_scripts_glitchfix,
> +	.num		= ARRAY_SIZE(twl4030_scripts_glitchfix),
> +};
> +
> +void use_twl4030_script_glitchfix(
> +		struct twl4030_power_data *t2scripts_data)
> +{
> +	t2scripts_data->scripts = twl4030_script_glitchfix.scripts;
> +	t2scripts_data->num = twl4030_script_glitchfix.num;
> +}
> +#endif
> +
>  #endif
> diff --git a/arch/arm/mach-omap2/twl4030-script.h
b/arch/arm/mach-omap2/twl4030-script.h
> index 5161861..418f5af 100644
> --- a/arch/arm/mach-omap2/twl4030-script.h
> +++ b/arch/arm/mach-omap2/twl4030-script.h
> @@ -7,9 +7,18 @@
>  #ifdef CONFIG_TWL4030_POWER
>  extern void twl4030_get_scripts(struct twl4030_power_data
*t2scripts_data);
>  extern void twl4030_get_vc_timings(struct prm_setup_vc *setup_vc);
> +#ifdef CONFIG_TWL5030_GLITCH_FIX
> +void use_twl4030_script_glitchfix(
> +		struct twl4030_power_data *t2scripts_data);
> +#endif
> +
>  #else
>  extern void twl4030_get_scripts(struct twl4030_power_data
*t2scripts_data) {}
>  extern void twl4030_get_vc_timings(struct prm_setup_vc *setup_vc) {}
> +#ifdef CONFIG_TWL5030_GLITCH_FIX
> +void use_twl4030_script_glitchfix(
> +		struct twl4030_power_data *t2scripts_data) {}
> +#endif
>  #endif
>  
>  #endif
> diff --git a/arch/arm/mach-omap2/voltage.c b/arch/arm/mach-omap2/voltage.c
> index 4b1dcdb..45590f3 100644
> --- a/arch/arm/mach-omap2/voltage.c
> +++ b/arch/arm/mach-omap2/voltage.c
> @@ -525,6 +525,16 @@ void __init omap_voltage_init_vc(struct prm_setup_vc
*setup_vc)
>  	vc_config.vdd2_off = setup_vc->vdd2_off;
>  }
>  
> +#ifdef CONFIG_TWL5030_GLITCH_FIX
> +void omap_voltage_twl5030_glitchfix(void)
> +{
> +	vc_config.clksetup_off = 0x17B;
> +
> +	vc_config.voltoffset = 0x10;
> +	vc_config.voltsetup2 = 0x16B;
> +}
> +#endif
> +

This needs documentation, and use of symbolic constants intead of
hard-coded values.

>  void update_voltsetup_time(int core_next_state)
>  {
>  	/* update voltsetup time */
> diff --git a/arch/arm/mach-omap2/voltage.h b/arch/arm/mach-omap2/voltage.h
> index 7bc4948..0830274 100644
> --- a/arch/arm/mach-omap2/voltage.h
> +++ b/arch/arm/mach-omap2/voltage.h
> @@ -74,6 +74,10 @@ void omap_voltageprocessor_enable(int vp_id);
>  void omap_voltageprocessor_disable(int vp_id);
>  void omap_voltage_init_vc(struct prm_setup_vc *setup_vc);
>  void update_voltsetup_time(int core_next_state);
> +#ifdef CONFIG_TWL5030_GLITCH_FIX
> +void omap_voltage_twl5030_glitchfix(void);
> +#endif
> +
>  void omap_voltage_init(void);
>  int omap_voltage_scale(int vdd, u8 target_vsel, u8 current_vsel);
>  void omap_reset_voltage(int vdd);
> diff --git a/arch/arm/plat-omap/Kconfig b/arch/arm/plat-omap/Kconfig
> index 232fd9e..0e32ad2 100644
> --- a/arch/arm/plat-omap/Kconfig
> +++ b/arch/arm/plat-omap/Kconfig
> @@ -84,6 +84,13 @@ config OMAP_SMARTREFLEX_TESTING
>  
>  	  WARNING: Enabling this option may cause your device to hang!
>  
> +config TWL5030_GLITCH_FIX
> +	bool "TWL5030 glitch fix"
> +	depends on TWL4030_CORE
> +	default n
> +	help
> +	  Say Y if you want to enable TWL5030 glitch fix.
> +
>  config OMAP_RESET_CLOCKS
>  	bool "Reset unused clocks during boot"
>  	depends on ARCH_OMAP
> diff --git a/drivers/mfd/twl4030-power.c b/drivers/mfd/twl4030-power.c
> index bd98733..86f7176 100644
> --- a/drivers/mfd/twl4030-power.c
> +++ b/drivers/mfd/twl4030-power.c
> @@ -30,8 +30,11 @@
>  #include <linux/platform_device.h>
>  
>  #include <asm/mach-types.h>
> +#include <mach/board-sdp.h>
> +#include <mach/board-zoom.h>

Having to include board-specific headers in a generic driver should be
a red flag that there is something wrong with the approach being
taken.

[Lesly] If using a hook from twl4030_platform_data, we can avoid this.

>  static u8 twl4030_start_script_address = 0x2b;
> +static u32 twl4030_rev;
>  
>  #define PWR_P1_SW_EVENTS	0x10
>  #define PWR_DEVOFF	(1<<0)
> @@ -67,6 +70,23 @@ static u8 twl4030_start_script_address = 0x2b;
>  #define R_KEY_1			0xC0
>  #define R_KEY_2			0x0C
>  
> +#define R_VDD1_OSC		0x5C
> +#define R_VDD2_OSC		0x6A
> +#define R_VIO_OSC		0x52
> +#define EXT_FS_CLK_EN		(0x1 << 6)
> +
> +#define R_WDT_CFG		0x03
> +#define WDT_WRK_TIMEOUT		0x03
> +
> +#define R_UNLOCK_TEST_REG	0x12
> +#define TWL_EEPROM_R_UNLOCK	0x49
> +
> +#define TWL_SIL_TYPE(rev)	((rev) & 0x00FFFFFF)
> +#define TWL_SIL_REV(rev)	((rev) >> 24)
> +#define TWL_SIL_5030		0x09002F
> +#define TWL_REV_1_0		0x00
> +#define TWL_REV_1_1		0x10
> +
>  /* resource configuration registers
>     <RESOURCE>_DEV_GRP   at address 'n+0'
>     <RESOURCE>_TYPE      at address 'n+1'
> @@ -505,6 +525,79 @@ int twl4030_remove_script(u8 flags)
>  	return err;
>  }
>  
> +#ifdef CONFIG_TWL5030_GLITCH_FIX
> +/**
> + * @brief twl_workaround - Fix for TWL5030 Silicon Errata 27 & 28:
> + * 27 - VDD1, VDD2, may have glitches when their output value is updated.
> + * 28 - VDD1 and / or VDD2 DCDC clock may stop working when internal
clock is
> + * switched from internal to external.
> + *
> + * Workaround requires the TWL DCDCs to use HFCLK instead of
> + * internal oscillator. Also enable TWL watchdog before switching the osc
> + * to recover if the VDD1/VDD2 stop working.
> + *
> + * WARNING: Should change board dependent script file to handle
> + * RET and OFF mode sequences correctly.

Again, why is this board dependent?

Kevin

[Lesly] There is no board specific change for this fix, 
Sine the t2script_data is not common for 3430SDP & Zoom bord, used different
functions in each board files to update the same.

Thank& Regards,
Lesly A M

