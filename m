From: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
Subject: Re: [PATCH 01/16] ARM: OMAP2+: Drop unused pm-noop
Date: Mon, 30 Apr 2018 15:57:24 -0300
Message-ID: <20180430155724.53cae9f9@vento.lan>
References: <20180423174549.57412-1-tony@atomide.com>
        <20180423174549.57412-2-tony@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180423174549.57412-2-tony@atomide.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: linux-omap@vger.kernel.org, Dave Gerlach <d-gerlach@ti.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Nishanth Menon <nm@ti.com>, Suman Anna <s-anna@ti.com>, Tero Kristo <t-kristo@ti.com>, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com>, Kevin Hilman <khilman@kernel.org>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Mauro Carvalho Chehab <mchehab@kernel.org>, Tomi Valkeinen <tomi.valkeinen@ti.com>
List-Id: linux-omap@vger.kernel.org

Em Mon, 23 Apr 2018 10:45:34 -0700
Tony Lindgren <tony@atomide.com> escreveu:

> Looks like these functions don't do anything in the mainline kernel so
> we can just drop it.
>=20
> Note that we must now also remove ir-rx51 pdata as it relies on the dummy
> platform data that does not do anything. And ir-rx51 is calling a pdata
> callback that doesn't do anything without checking if it exists first.
>=20
> For configuring device specific minimal latencies, the interface to use
> is pm_qos_add_request(). For an example, see what was done in commit
> 9834ffd1ecc3 ("ASoC: omap-mcbsp: Add PM QoS support for McBSP to prevent
> glitches"). I've added some comments to ir-rx51 so people using it can
> add pm_qos support and test it.
>=20
> Cc: Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com>
> Cc: Kevin Hilman <khilman@kernel.org>
> Cc: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
> Cc: Mauro Carvalho Chehab <mchehab@kernel.org>

Acked-by: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>

> Cc: Tomi Valkeinen <tomi.valkeinen@ti.com>
> Signed-off-by: Tony Lindgren <tony@atomide.com>
> ---
>  arch/arm/mach-omap2/Makefile                |   1 -
>  arch/arm/mach-omap2/display.c               |   7 -
>  arch/arm/mach-omap2/hsmmc.c                 |   1 -
>  arch/arm/mach-omap2/i2c.c                   |   1 -
>  arch/arm/mach-omap2/io.c                    |   3 -
>  arch/arm/mach-omap2/omap-pm-noop.c          | 176 --------------------
>  arch/arm/mach-omap2/omap-pm.h               | 161 ------------------
>  arch/arm/mach-omap2/pdata-quirks.c          |  15 --
>  arch/arm/mach-omap2/pm-debug.c              |   5 -
>  arch/arm/mach-omap2/pm.c                    |  10 +-
>  arch/arm/mach-omap2/timer.c                 |   1 -
>  arch/arm/plat-omap/Kconfig                  |  10 --
>  drivers/media/rc/ir-rx51.c                  |  17 +-
>  include/linux/platform_data/media/ir-rx51.h |   9 -
>  14 files changed, 4 insertions(+), 413 deletions(-)
>  delete mode 100644 arch/arm/mach-omap2/omap-pm-noop.c
>  delete mode 100644 arch/arm/mach-omap2/omap-pm.h
>  delete mode 100644 include/linux/platform_data/media/ir-rx51.h
>=20
> diff --git a/arch/arm/mach-omap2/Makefile b/arch/arm/mach-omap2/Makefile
> --- a/arch/arm/mach-omap2/Makefile
> +++ b/arch/arm/mach-omap2/Makefile
> @@ -78,7 +78,6 @@ endif
>  omap-4-5-pm-common			=3D omap-mpuss-lowpower.o
>  obj-$(CONFIG_ARCH_OMAP4)		+=3D $(omap-4-5-pm-common)
>  obj-$(CONFIG_SOC_OMAP5)			+=3D $(omap-4-5-pm-common)
> -obj-$(CONFIG_OMAP_PM_NOOP)		+=3D omap-pm-noop.o
> =20
>  ifeq ($(CONFIG_PM),y)
>  obj-$(CONFIG_ARCH_OMAP2)		+=3D pm24xx.o
> diff --git a/arch/arm/mach-omap2/display.c b/arch/arm/mach-omap2/display.c
> --- a/arch/arm/mach-omap2/display.c
> +++ b/arch/arm/mach-omap2/display.c
> @@ -32,7 +32,6 @@
>  #include <linux/platform_data/omapdss.h>
>  #include "omap_hwmod.h"
>  #include "omap_device.h"
> -#include "omap-pm.h"
>  #include "common.h"
> =20
>  #include "soc.h"
> @@ -126,11 +125,6 @@ static void omap_dsi_disable_pads(int dsi_id, unsign=
ed lane_mask)
>  		omap4_dsi_mux_pads(dsi_id, 0);
>  }
> =20
> -static int omap_dss_set_min_bus_tput(struct device *dev, unsigned long t=
put)
> -{
> -	return omap_pm_set_min_bus_tput(dev, OCP_INITIATOR_AGENT, tput);
> -}
> -
>  static enum omapdss_version __init omap_display_get_version(void)
>  {
>  	if (cpu_is_omap24xx())
> @@ -169,7 +163,6 @@ static int __init omapdss_init_fbdev(void)
>  	static struct omap_dss_board_info board_data =3D {
>  		.dsi_enable_pads =3D omap_dsi_enable_pads,
>  		.dsi_disable_pads =3D omap_dsi_disable_pads,
> -		.set_min_bus_tput =3D omap_dss_set_min_bus_tput,
>  	};
>  	struct device_node *node;
>  	int r;
> diff --git a/arch/arm/mach-omap2/hsmmc.c b/arch/arm/mach-omap2/hsmmc.c
> --- a/arch/arm/mach-omap2/hsmmc.c
> +++ b/arch/arm/mach-omap2/hsmmc.c
> @@ -18,7 +18,6 @@
> =20
>  #include "soc.h"
>  #include "omap_device.h"
> -#include "omap-pm.h"
> =20
>  #include "hsmmc.h"
>  #include "control.h"
> diff --git a/arch/arm/mach-omap2/i2c.c b/arch/arm/mach-omap2/i2c.c
> --- a/arch/arm/mach-omap2/i2c.c
> +++ b/arch/arm/mach-omap2/i2c.c
> @@ -22,7 +22,6 @@
>  #include "soc.h"
>  #include "omap_hwmod.h"
>  #include "omap_device.h"
> -#include "omap-pm.h"
> =20
>  #include "prm.h"
>  #include "common.h"
> diff --git a/arch/arm/mach-omap2/io.c b/arch/arm/mach-omap2/io.c
> --- a/arch/arm/mach-omap2/io.c
> +++ b/arch/arm/mach-omap2/io.c
> @@ -37,7 +37,6 @@
>  #include "clock.h"
>  #include "clock2xxx.h"
>  #include "clock3xxx.h"
> -#include "omap-pm.h"
>  #include "sdrc.h"
>  #include "control.h"
>  #include "serial.h"
> @@ -421,8 +420,6 @@ static void __init __maybe_unused omap_hwmod_init_pos=
tsetup(void)
>  	postsetup_state =3D _HWMOD_STATE_ENABLED;
>  #endif
>  	omap_hwmod_for_each(_set_hwmod_postsetup_state, &postsetup_state);
> -
> -	omap_pm_if_early_init();
>  }
> =20
>  static void __init __maybe_unused omap_common_late_init(void)
> diff --git a/arch/arm/mach-omap2/omap-pm-noop.c b/arch/arm/mach-omap2/oma=
p-pm-noop.c
> deleted file mode 100644
> --- a/arch/arm/mach-omap2/omap-pm-noop.c
> +++ /dev/null
> @@ -1,176 +0,0 @@
> -// SPDX-License-Identifier: GPL-2.0
> -/*
> - * omap-pm-noop.c - OMAP power management interface - dummy version
> - *
> - * This code implements the OMAP power management interface to
> - * drivers, CPUIdle, CPUFreq, and DSP Bridge.  It is strictly for
> - * debug/demonstration use, as it does nothing but printk() whenever a
> - * function is called (when DEBUG is defined, below)
> - *
> - * Copyright (C) 2008-2009 Texas Instruments, Inc.
> - * Copyright (C) 2008-2009 Nokia Corporation
> - * Paul Walmsley
> - *
> - * Interface developed by (in alphabetical order):
> - * Karthik Dasu, Tony Lindgren, Rajendra Nayak, Sakari Poussa, Veeramani=
kandan
> - * Raju, Anand Sawant, Igor Stoppa, Paul Walmsley, Richard Woodruff
> - */
> -
> -#undef DEBUG
> -
> -#include <linux/init.h>
> -#include <linux/cpufreq.h>
> -#include <linux/device.h>
> -#include <linux/platform_device.h>
> -
> -#include "omap_device.h"
> -#include "omap-pm.h"
> -
> -static bool off_mode_enabled;
> -static int dummy_context_loss_counter;
> -
> -/*
> - * Device-driver-originated constraints (via board-*.c files)
> - */
> -
> -int omap_pm_set_max_mpu_wakeup_lat(struct device *dev, long t)
> -{
> -	if (!dev || t < -1) {
> -		WARN(1, "OMAP PM: %s: invalid parameter(s)", __func__);
> -		return -EINVAL;
> -	}
> -
> -	if (t =3D=3D -1)
> -		pr_debug("OMAP PM: remove max MPU wakeup latency constraint: dev %s\n",
> -			 dev_name(dev));
> -	else
> -		pr_debug("OMAP PM: add max MPU wakeup latency constraint: dev %s, t =
=3D %ld usec\n",
> -			 dev_name(dev), t);
> -
> -	/*
> -	 * For current Linux, this needs to map the MPU to a
> -	 * powerdomain, then go through the list of current max lat
> -	 * constraints on the MPU and find the smallest.  If
> -	 * the latency constraint has changed, the code should
> -	 * recompute the state to enter for the next powerdomain
> -	 * state.
> -	 *
> -	 * TI CDP code can call constraint_set here.
> -	 */
> -
> -	return 0;
> -}
> -
> -int omap_pm_set_min_bus_tput(struct device *dev, u8 agent_id, unsigned l=
ong r)
> -{
> -	if (!dev || (agent_id !=3D OCP_INITIATOR_AGENT &&
> -	    agent_id !=3D OCP_TARGET_AGENT)) {
> -		WARN(1, "OMAP PM: %s: invalid parameter(s)", __func__);
> -		return -EINVAL;
> -	}
> -
> -	if (r =3D=3D 0)
> -		pr_debug("OMAP PM: remove min bus tput constraint: dev %s for agent_id=
 %d\n",
> -			 dev_name(dev), agent_id);
> -	else
> -		pr_debug("OMAP PM: add min bus tput constraint: dev %s for agent_id %d=
: rate %ld KiB\n",
> -			 dev_name(dev), agent_id, r);
> -
> -	/*
> -	 * This code should model the interconnect and compute the
> -	 * required clock frequency, convert that to a VDD2 OPP ID, then
> -	 * set the VDD2 OPP appropriately.
> -	 *
> -	 * TI CDP code can call constraint_set here on the VDD2 OPP.
> -	 */
> -
> -	return 0;
> -}
> -
> -/*
> - * DSP Bridge-specific constraints
> - */
> -
> -
> -/**
> - * omap_pm_enable_off_mode - notify OMAP PM that off-mode is enabled
> - *
> - * Intended for use only by OMAP PM core code to notify this layer
> - * that off mode has been enabled.
> - */
> -void omap_pm_enable_off_mode(void)
> -{
> -	off_mode_enabled =3D true;
> -}
> -
> -/**
> - * omap_pm_disable_off_mode - notify OMAP PM that off-mode is disabled
> - *
> - * Intended for use only by OMAP PM core code to notify this layer
> - * that off mode has been disabled.
> - */
> -void omap_pm_disable_off_mode(void)
> -{
> -	off_mode_enabled =3D false;
> -}
> -
> -/*
> - * Device context loss tracking
> - */
> -
> -#ifdef CONFIG_ARCH_OMAP2PLUS
> -
> -int omap_pm_get_dev_context_loss_count(struct device *dev)
> -{
> -	struct platform_device *pdev =3D to_platform_device(dev);
> -	int count;
> -
> -	if (WARN_ON(!dev))
> -		return -ENODEV;
> -
> -	if (dev->pm_domain =3D=3D &omap_device_pm_domain) {
> -		count =3D omap_device_get_context_loss_count(pdev);
> -	} else {
> -		WARN_ONCE(off_mode_enabled, "omap_pm: using dummy context loss counter=
; device %s should be converted to omap_device",
> -			  dev_name(dev));
> -
> -		count =3D dummy_context_loss_counter;
> -
> -		if (off_mode_enabled) {
> -			count++;
> -			/*
> -			 * Context loss count has to be a non-negative value.
> -			 * Clear the sign bit to get a value range from 0 to
> -			 * INT_MAX.
> -			 */
> -			count &=3D INT_MAX;
> -			dummy_context_loss_counter =3D count;
> -		}
> -	}
> -
> -	pr_debug("OMAP PM: context loss count for dev %s =3D %d\n",
> -		 dev_name(dev), count);
> -
> -	return count;
> -}
> -
> -#else
> -
> -int omap_pm_get_dev_context_loss_count(struct device *dev)
> -{
> -	return dummy_context_loss_counter;
> -}
> -
> -#endif
> -
> -/* Should be called before clk framework init */
> -int __init omap_pm_if_early_init(void)
> -{
> -	return 0;
> -}
> -
> -/* Must be called after clock framework is initialized */
> -int __init omap_pm_if_init(void)
> -{
> -	return 0;
> -}
> diff --git a/arch/arm/mach-omap2/omap-pm.h b/arch/arm/mach-omap2/omap-pm.h
> deleted file mode 100644
> --- a/arch/arm/mach-omap2/omap-pm.h
> +++ /dev/null
> @@ -1,161 +0,0 @@
> -/* SPDX-License-Identifier: GPL-2.0 */
> -/*
> - * omap-pm.h - OMAP power management interface
> - *
> - * Copyright (C) 2008-2010 Texas Instruments, Inc.
> - * Copyright (C) 2008-2010 Nokia Corporation
> - * Paul Walmsley
> - *
> - * Interface developed by (in alphabetical order): Karthik Dasu, Jouni
> - * H=C3=B6gander, Tony Lindgren, Rajendra Nayak, Sakari Poussa,
> - * Veeramanikandan Raju, Anand Sawant, Igor Stoppa, Paul Walmsley,
> - * Richard Woodruff
> - */
> -
> -#ifndef ASM_ARM_ARCH_OMAP_OMAP_PM_H
> -#define ASM_ARM_ARCH_OMAP_OMAP_PM_H
> -
> -#include <linux/device.h>
> -#include <linux/cpufreq.h>
> -#include <linux/clk.h>
> -#include <linux/pm_opp.h>
> -
> -/*
> - * agent_id values for use with omap_pm_set_min_bus_tput():
> - *
> - * OCP_INITIATOR_AGENT is only valid for devices that can act as
> - * initiators -- it represents the device's L3 interconnect
> - * connection.  OCP_TARGET_AGENT represents the device's L4
> - * interconnect connection.
> - */
> -#define OCP_TARGET_AGENT		1
> -#define OCP_INITIATOR_AGENT		2
> -
> -/**
> - * omap_pm_if_early_init - OMAP PM init code called before clock fw init
> - * @mpu_opp_table: array ptr to struct omap_opp for MPU
> - * @dsp_opp_table: array ptr to struct omap_opp for DSP
> - * @l3_opp_table : array ptr to struct omap_opp for CORE
> - *
> - * Initialize anything that must be configured before the clock
> - * framework starts.  The "_if_" is to avoid name collisions with the
> - * PM idle-loop code.
> - */
> -int __init omap_pm_if_early_init(void);
> -
> -/**
> - * omap_pm_if_init - OMAP PM init code called after clock fw init
> - *
> - * The main initialization code.  OPP tables are passed in here.  The
> - * "_if_" is to avoid name collisions with the PM idle-loop code.
> - */
> -int __init omap_pm_if_init(void);
> -
> -/*
> - * Device-driver-originated constraints (via board-*.c files, platform_d=
ata)
> - */
> -
> -
> -/**
> - * omap_pm_set_max_mpu_wakeup_lat - set the maximum MPU wakeup latency
> - * @dev: struct device * requesting the constraint
> - * @t: maximum MPU wakeup latency in microseconds
> - *
> - * Request that the maximum interrupt latency for the MPU to be no
> - * greater than @t microseconds. "Interrupt latency" in this case is
> - * defined as the elapsed time from the occurrence of a hardware or
> - * timer interrupt to the time when the device driver's interrupt
> - * service routine has been entered by the MPU.
> - *
> - * It is intended that underlying PM code will use this information to
> - * determine what power state to put the MPU powerdomain into, and
> - * possibly the CORE powerdomain as well, since interrupt handling
> - * code currently runs from SDRAM.  Advanced PM or board*.c code may
> - * also configure interrupt controller priorities, OCP bus priorities,
> - * CPU speed(s), etc.
> - *
> - * This function will not affect device wakeup latency, e.g., time
> - * elapsed from when a device driver enables a hardware device with
> - * clk_enable(), to when the device is ready for register access or
> - * other use.  To control this device wakeup latency, use
> - * omap_pm_set_max_dev_wakeup_lat()
> - *
> - * Multiple calls to omap_pm_set_max_mpu_wakeup_lat() will replace the
> - * previous t value.  To remove the latency target for the MPU, call
> - * with t =3D -1.
> - *
> - * XXX This constraint will be deprecated soon in favor of the more
> - * general omap_pm_set_max_dev_wakeup_lat()
> - *
> - * Returns -EINVAL for an invalid argument, -ERANGE if the constraint
> - * is not satisfiable, or 0 upon success.
> - */
> -int omap_pm_set_max_mpu_wakeup_lat(struct device *dev, long t);
> -
> -
> -/**
> - * omap_pm_set_min_bus_tput - set minimum bus throughput needed by device
> - * @dev: struct device * requesting the constraint
> - * @tbus_id: interconnect to operate on (OCP_{INITIATOR,TARGET}_AGENT)
> - * @r: minimum throughput (in KiB/s)
> - *
> - * Request that the minimum data throughput on the OCP interconnect
> - * attached to device @dev interconnect agent @tbus_id be no less
> - * than @r KiB/s.
> - *
> - * It is expected that the OMAP PM or bus code will use this
> - * information to set the interconnect clock to run at the lowest
> - * possible speed that satisfies all current system users.  The PM or
> - * bus code will adjust the estimate based on its model of the bus, so
> - * device driver authors should attempt to specify an accurate
> - * quantity for their device use case, and let the PM or bus code
> - * overestimate the numbers as necessary to handle request/response
> - * latency, other competing users on the system, etc.  On OMAP2/3, if
> - * a driver requests a minimum L4 interconnect speed constraint, the
> - * code will also need to add an minimum L3 interconnect speed
> - * constraint,
> - *
> - * Multiple calls to omap_pm_set_min_bus_tput() will replace the
> - * previous rate value for this device.  To remove the interconnect
> - * throughput restriction for this device, call with r =3D 0.
> - *
> - * Returns -EINVAL for an invalid argument, -ERANGE if the constraint
> - * is not satisfiable, or 0 upon success.
> - */
> -int omap_pm_set_min_bus_tput(struct device *dev, u8 agent_id, unsigned l=
ong r);
> -
> -
> -/*
> - * CPUFreq-originated constraint
> - *
> - * In the future, this should be handled by custom OPP clocktype
> - * functions.
> - */
> -
> -
> -/*
> - * Device context loss tracking
> - */
> -
> -/**
> - * omap_pm_get_dev_context_loss_count - return count of times dev has lo=
st ctx
> - * @dev: struct device *
> - *
> - * This function returns the number of times that the device @dev has
> - * lost its internal context.  This generally occurs on a powerdomain
> - * transition to OFF.  Drivers use this as an optimization to avoid rest=
oring
> - * context if the device hasn't lost it.  To use, drivers should initial=
ly
> - * call this in their context save functions and store the result.  Earl=
y in
> - * the driver's context restore function, the driver should call this fu=
nction
> - * again, and compare the result to the stored counter.  If they differ,=
 the
> - * driver must restore device context.   If the number of context losses
> - * exceeds the maximum positive integer, the function will wrap to 0 and
> - * continue counting.  Returns the number of context losses for this dev=
ice,
> - * or negative value upon error.
> - */
> -int omap_pm_get_dev_context_loss_count(struct device *dev);
> -
> -void omap_pm_enable_off_mode(void);
> -void omap_pm_disable_off_mode(void);
> -
> -#endif
> diff --git a/arch/arm/mach-omap2/pdata-quirks.c b/arch/arm/mach-omap2/pda=
ta-quirks.c
> --- a/arch/arm/mach-omap2/pdata-quirks.c
> +++ b/arch/arm/mach-omap2/pdata-quirks.c
> @@ -26,14 +26,12 @@
>  #include <linux/platform_data/iommu-omap.h>
>  #include <linux/platform_data/ti-sysc.h>
>  #include <linux/platform_data/wkup_m3.h>
> -#include <linux/platform_data/media/ir-rx51.h>
>  #include <linux/platform_data/asoc-ti-mcbsp.h>
> =20
>  #include "common.h"
>  #include "common-board-devices.h"
>  #include "control.h"
>  #include "omap_device.h"
> -#include "omap-pm.h"
>  #include "omap-secure.h"
>  #include "soc.h"
>  #include "hsmmc.h"
> @@ -514,18 +512,6 @@ void omap_auxdata_legacy_init(struct device *dev)
>  	dev->platform_data =3D &twl_gpio_auxdata;
>  }
> =20
> -static struct ir_rx51_platform_data __maybe_unused rx51_ir_data =3D {
> -	.set_max_mpu_wakeup_lat =3D omap_pm_set_max_mpu_wakeup_lat,
> -};
> -
> -static struct platform_device __maybe_unused rx51_ir_device =3D {
> -	.name           =3D "ir_rx51",
> -	.id             =3D -1,
> -	.dev            =3D {
> -		.platform_data =3D &rx51_ir_data,
> -	},
> -};
> -
>  #if IS_ENABLED(CONFIG_SND_OMAP_SOC_MCBSP)
>  static struct omap_mcbsp_platform_data mcbsp_pdata;
>  static void __init omap3_mcbsp_init(void)
> @@ -569,7 +555,6 @@ static struct of_dev_auxdata omap_auxdata_lookup[] =
=3D {
>  		       "480c9000.smartreflex", &omap_sr_pdata[OMAP_SR_MPU]),
>  	OF_DEV_AUXDATA("ti,omap3-hsmmc", 0x4809c000, "4809c000.mmc", &mmc_pdata=
[0]),
>  	OF_DEV_AUXDATA("ti,omap3-hsmmc", 0x480b4000, "480b4000.mmc", &mmc_pdata=
[1]),
> -	OF_DEV_AUXDATA("nokia,n900-ir", 0, "n900-ir", &rx51_ir_data),
>  	/* Only on am3517 */
>  	OF_DEV_AUXDATA("ti,davinci_mdio", 0x5c030000, "davinci_mdio.0", NULL),
>  	OF_DEV_AUXDATA("ti,am3517-emac", 0x5c000000, "davinci_emac.0",
> diff --git a/arch/arm/mach-omap2/pm-debug.c b/arch/arm/mach-omap2/pm-debu=
g.c
> --- a/arch/arm/mach-omap2/pm-debug.c
> +++ b/arch/arm/mach-omap2/pm-debug.c
> @@ -31,7 +31,6 @@
>  #include "clock.h"
>  #include "powerdomain.h"
>  #include "clockdomain.h"
> -#include "omap-pm.h"
> =20
>  #include "soc.h"
>  #include "cm2xxx_3xxx.h"
> @@ -240,10 +239,6 @@ static int option_set(void *data, u64 val)
>  	*option =3D val;
> =20
>  	if (option =3D=3D &enable_off_mode) {
> -		if (val)
> -			omap_pm_enable_off_mode();
> -		else
> -			omap_pm_disable_off_mode();
>  		if (cpu_is_omap34xx())
>  			omap3_pm_off_mode_enable(val);
>  	}
> diff --git a/arch/arm/mach-omap2/pm.c b/arch/arm/mach-omap2/pm.c
> --- a/arch/arm/mach-omap2/pm.c
> +++ b/arch/arm/mach-omap2/pm.c
> @@ -16,11 +16,11 @@
>  #include <linux/pm_opp.h>
>  #include <linux/export.h>
>  #include <linux/suspend.h>
> +#include <linux/clk.h>
>  #include <linux/cpu.h>
> =20
>  #include <asm/system_misc.h>
> =20
> -#include "omap-pm.h"
>  #include "omap_device.h"
>  #include "common.h"
> =20
> @@ -230,14 +230,6 @@ static void __init omap4_init_voltages(void)
>  	omap2_set_init_voltage("iva", "dpll_iva_m5x2_ck", "iva");
>  }
> =20
> -static int __init omap2_common_pm_init(void)
> -{
> -	omap_pm_if_init();
> -
> -	return 0;
> -}
> -omap_postcore_initcall(omap2_common_pm_init);
> -
>  int __init omap2_common_pm_late_init(void)
>  {
>  	/* Init the voltage layer */
> diff --git a/arch/arm/mach-omap2/timer.c b/arch/arm/mach-omap2/timer.c
> --- a/arch/arm/mach-omap2/timer.c
> +++ b/arch/arm/mach-omap2/timer.c
> @@ -50,7 +50,6 @@
>  #include "omap_device.h"
>  #include <plat/counter-32k.h>
>  #include <clocksource/timer-ti-dm.h>
> -#include "omap-pm.h"
> =20
>  #include "soc.h"
>  #include "common.h"
> diff --git a/arch/arm/plat-omap/Kconfig b/arch/arm/plat-omap/Kconfig
> --- a/arch/arm/plat-omap/Kconfig
> +++ b/arch/arm/plat-omap/Kconfig
> @@ -115,16 +115,6 @@ config OMAP_SERIAL_WAKE
>  	  to data on the serial RX line. This allows you to wake the
>  	  system from serial console.
> =20
> -choice
> -	prompt "OMAP PM layer selection"
> -	depends on ARCH_OMAP
> -	default OMAP_PM_NOOP
> -
> -config OMAP_PM_NOOP
> -	bool "No-op/debug PM layer"
> -
> -endchoice
> -
>  endmenu
> =20
>  endif
> diff --git a/drivers/media/rc/ir-rx51.c b/drivers/media/rc/ir-rx51.c
> --- a/drivers/media/rc/ir-rx51.c
> +++ b/drivers/media/rc/ir-rx51.c
> @@ -22,7 +22,6 @@
>  #include <linux/hrtimer.h>
> =20
>  #include <media/rc-core.h>
> -#include <linux/platform_data/media/ir-rx51.h>
> =20
>  #define WBUF_LEN 256
> =20
> @@ -31,7 +30,6 @@ struct ir_rx51 {
>  	struct pwm_device *pwm;
>  	struct hrtimer timer;
>  	struct device	     *dev;
> -	struct ir_rx51_platform_data *pdata;
>  	wait_queue_head_t     wqueue;
> =20
>  	unsigned int	freq;		/* carrier frequency */
> @@ -130,10 +128,9 @@ static int ir_rx51_tx(struct rc_dev *dev, unsigned i=
nt *buffer,
>  		ir_rx51->wbuf[count] =3D -1; /* Insert termination mark */
> =20
>  	/*
> -	 * Adjust latency requirements so the device doesn't go in too
> -	 * deep sleep states
> +	 * REVISIT: Adjust latency requirements so the device doesn't go in too
> +	 * deep sleep states with pm_qos_add_request().
>  	 */
> -	ir_rx51->pdata->set_max_mpu_wakeup_lat(ir_rx51->dev, 50);
> =20
>  	ir_rx51_on(ir_rx51);
>  	ir_rx51->wbuf_index =3D 1;
> @@ -146,8 +143,7 @@ static int ir_rx51_tx(struct rc_dev *dev, unsigned in=
t *buffer,
>  	 */
>  	wait_event_interruptible(ir_rx51->wqueue, ir_rx51->wbuf_index < 0);
> =20
> -	/* We can sleep again */
> -	ir_rx51->pdata->set_max_mpu_wakeup_lat(ir_rx51->dev, -1);
> +	/* REVISIT: Remove pm_qos constraint, we can sleep again */
> =20
>  	return count;
>  }
> @@ -244,13 +240,6 @@ static int ir_rx51_probe(struct platform_device *dev)
>  	struct pwm_device *pwm;
>  	struct rc_dev *rcdev;
> =20
> -	ir_rx51.pdata =3D dev->dev.platform_data;
> -
> -	if (!ir_rx51.pdata) {
> -		dev_err(&dev->dev, "Platform Data is missing\n");
> -		return -ENXIO;
> -	}
> -
>  	pwm =3D pwm_get(&dev->dev, NULL);
>  	if (IS_ERR(pwm)) {
>  		int err =3D PTR_ERR(pwm);
> diff --git a/include/linux/platform_data/media/ir-rx51.h b/include/linux/=
platform_data/media/ir-rx51.h
> deleted file mode 100644
> --- a/include/linux/platform_data/media/ir-rx51.h
> +++ /dev/null
> @@ -1,9 +0,0 @@
> -/* SPDX-License-Identifier: GPL-2.0 */
> -#ifndef _IR_RX51_H
> -#define _IR_RX51_H
> -
> -struct ir_rx51_platform_data {
> -	int(*set_max_mpu_wakeup_lat)(struct device *dev, long t);
> -};
> -
> -#endif



Thanks,
Mauro
