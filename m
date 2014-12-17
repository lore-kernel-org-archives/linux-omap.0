From: Tony Lindgren <tony@atomide.com>
Subject: Re: OMAP 4430 SDP: rather sick with recent kernels
Date: Wed, 17 Dec 2014 09:23:33 -0800
Message-ID: <20141217172333.GE23854@atomide.com>
References: <20141217095252.GH11502@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-03-ewr.mailhop.org ([204.13.248.66]:45839 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1750983AbaLQR03 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 17 Dec 2014 12:26:29 -0500
Content-Disposition: inline
In-Reply-To: <20141217095252.GH11502@n2100.arm.linux.org.uk>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Tero Kristo <t-kristo@ti.com>, Tomi Valkeinen <tomi.valkeinen@ti.com>, Joel Fernandes <joelf@ti.com>, Peter Ujfalusi <peter.ujfalusi@ti.com>, Jyri Sarha <jsarha@ti.com>, Nishanth Menon <nm@ti.com>

Hi,

* Russell King - ARM Linux <linux@arm.linux.org.uk> [141217 01:55]:
> Tony,
> 
> As the IOMMU stuff was merged last night, which removed a really quite
> horrid conflict resolution, I updated my nightly build tree from its
> previous state last Thursday.
> 
> Now, SDP4430 seems to be really quite broken.

Sigh, things are just break left and right every merge window :(

Anyways, I've added a bunch of ti.com people to Cc, let's fix up 
the noisy dmesg --level=err and dmesg --level=warn output too so we
can notice the real issues easier, see below.
 
> ti_dt_clocks_register: failed to lookup clock node dss_fck
> ti_dt_clocks_register: failed to lookup clock node dss_fck
> ti_dt_clocks_register: failed to lookup clock node div_ts_ck
> ti_dt_clocks_register: failed to lookup clock node bandgap_ts_fclk

And then there are these too in the current mainline that are
clock related:

omap4xxx_dt_clk_init: failed to configure ABE DPLL!
...
clock: dpll_abe_ck failed transition to 'locked'
clock: dpll_abe_ck failed transition to 'locked'
clock: dpll_abe_ck failed transition to 'locked'
------------[ cut here ]------------
WARNING: CPU: 0 PID: 1 at drivers/clk/clk.c:851 clk_disable+0x24/0x30()
Modules linked in:
CPU: 0 PID: 1 Comm: swapper/0 Not tainted 3.18.0-09274-g53c5279 #699
Hardware name: Generic OMAP4 (Flattened Device Tree)
[<c00154b4>] (unwind_backtrace) from [<c0011b7c>] (show_stack+0x10/0x14)
[<c0011b7c>] (show_stack) from [<c05d5068>] (dump_stack+0x80/0x9c)
[<c05d5068>] (dump_stack) from [<c003e104>] (warn_slowpath_common+0x78/0xb4)
[<c003e104>] (warn_slowpath_common) from [<c003e15c>] (warn_slowpath_null+ 0x1c/0x24)
[<c003e15c>] (warn_slowpath_null) from [<c04dfc1c>] (clk_disable+0x24/0x30)
[<c04dfc1c>] (clk_disable) from [<c0024ea0>] (_disable_clocks+0x18/0x68)
[<c0024ea0>] (_disable_clocks) from [<c0026410>] (_idle+0x15c/0x240)
[<c0026410>] (_idle) from [<c086fc48>] (_setup+0x174/0x22c)
[<c086fc48>] (_setup) from [<c002684c>] (omap_hwmod_for_each+0x30/0x5c)
[<c002684c>] (omap_hwmod_for_each) from [<c0870054>] (__omap_hwmod_setup_all+0x30/0x40)
[<c0870054>] (__omap_hwmod_setup_all) from [<c00089e4>] (do_one_initcall+0x80/0x1d8)
[<c00089e4>] (do_one_initcall) from [<c0862ea4>] (kernel_init_freeable+0x1f4/0x2cc)
[<c0862ea4>] (kernel_init_freeable) from [<c05cf184>] (kernel_init+0x8/0xe4)
[<c05cf184>] (kernel_init) from [<c000e8e8>] (ret_from_fork+0x14/0x2c)
---[ end trace f0d1b75165d8ef11 ]---
clock: dpll_abe_ck failed transition to 'locked'
clock: dpll_abe_ck failed transition to 'locked'
...

Tero & Tomi, can you please look into these clock issues above?

> omap_hwmod: l3_main_3 using broken dt data from ocp
> omap_hwmod: l3_main_2 using broken dt data from ocp

This is a known issue that will take a while to get fixed to
get things match with compatible and ti,hwmods and the hwmod
data we have.

> irq: no irq domain found for /ocp/pinmux@4a100040 !
> irq: no irq domain found for /ocp/pinmux@4a100040 !
> irq: no irq domain found for /ocp/pinmux@4a100040 !

All these deferred probe issues should go away when we can
remove the custom initcall levels for drivers once omap3 is
DT only. Some of that we may be able to do already by making
all the GPIO usage in the remaining board-*.c files happen
later.

> platform 4b501000.aes: Cannot lookup hwmod 'aes'
> platform 480a5000.des: Cannot lookup hwmod 'des'

Looks like Joel added the .dts entries for aes and des, but somehow
the related omap_hwmod_data_44xx.c entries never made it. Probably
because Paul was not in Cc for the thread "[PATCH 00/10] ARM: OMAP:
dts and HWMOD entries for crypto modules"

Joel, can you please update that series, and repost with Paul also
in Cc? Looks like there there's a dependency to omap_hwmod_sysc_type4
for aes and des for the des and aes hwmod data.

> twl: not initialized
> twl6030_uv_to_vsel:OUT OF RANGE! non mapped vsel for 1375000 Vs max 1316660
> twl6030_uv_to_vsel:OUT OF RANGE! non mapped vsel for 1375000 Vs max 1316660
> twl6030_uv_to_vsel:OUT OF RANGE! non mapped vsel for 1375000 Vs max 1316660
> twl6030_uv_to_vsel:OUT OF RANGE! non mapped vsel for 1375000 Vs max 1316660
> twl6030_uv_to_vsel:OUT OF RANGE! non mapped vsel for 1375000 Vs max 1316660
> twl6030_uv_to_vsel:OUT OF RANGE! non mapped vsel for 1375000 Vs max 1316660
> twl6030_uv_to_vsel:OUT OF RANGE! non mapped vsel for 1410000 Vs max 1316660

This seems to be some twl related init order issue, I'll take a
look at this one.

> omap2_set_init_voltage: unable to find boot up OPP for vdd_mpu
> omap2_set_init_voltage: unable to set vdd_mpu
> omap2_set_init_voltage: unable to find boot up OPP for vdd_core
> omap2_set_init_voltage: unable to set vdd_core
> omap2_set_init_voltage: unable to find boot up OPP for vdd_iva
> omap2_set_init_voltage: unable to set vdd_iva

I believe Nishanth has some plans for these?

> From there, the system crash'n'burns badly due to an ASoC DAPM oops.
> 
> The "combined" kernel boot follows a similar pattern, but yets a bit
> further before oopsing, with ASoC DAPM code printing random bits of
> kernel memory.

Jyri, Tomi & Peter, can you please take a look at ASoC DAPM issue? 

Regards,

Tony
