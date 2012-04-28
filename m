From: "Derald D. Woods" <woods.rt@gmail.com>
Subject: Re: [PATCH/RFT 0/8] ARM: OMAP: remove IP checks from SoC family
 detection
Date: Sat, 28 Apr 2012 15:20:48 -0500
Message-ID: <20120428202047.GA7068@numbers.woodsts.org>
References: <1335482993-14035-1-git-send-email-khilman@ti.com>
 <20120427220813.GE19196@animalcreek.com>
 <87aa1wyfq5.fsf@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-iy0-f174.google.com ([209.85.210.174]:56900 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751748Ab2D1UU6 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sat, 28 Apr 2012 16:20:58 -0400
Received: by iadi9 with SMTP id i9so2489492iad.19
        for <linux-omap@vger.kernel.org>; Sat, 28 Apr 2012 13:20:57 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <87aa1wyfq5.fsf@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@ti.com>
Cc: linux-omap@vger.kernel.org, "Mark A. Greer" <mgreer@animalcreek.com>

On Fri, Apr 27, 2012 at 03:25:38PM -0700, Kevin Hilman wrote:
> "Mark A. Greer" <mgreer@animalcreek.com> writes:
> 
> > On Thu, Apr 26, 2012 at 04:29:45PM -0700, Kevin Hilman wrote:
> >
> > Hi Kevin.
> >
> >> This is a rebased version of this series which is ready for broader
> >> testing.  I'd especially appreciate testing from those of you with
> >> AM35x platforms.
> >> 
> >> Currently, our SoC detection is based on SoC family detection
> >> (using die ID) and the presence of specific IP blocks (or feature.)
> >> 
> >> This series begins the separation of the SoC family detection and
> >> specific IP detection by completely removing IP detection from the SoC
> >> family detection (cpu_is_*.)
> >> 
> >> Applies on top of v3.4-rc4, boot tested on AM3517 EVM.
> >
> > Your series applied and booted without issue until the point that
> > pm_idle is called.  At that point it hung because its doing a wfi
> > and not getting an interrupt to wake up back up.  That's expected
> > behaviour so your patches are good (IMHO) but I need to finish and
> > submit a new version of my patches to fix that issue.
> 
> For the benefit of others wanting to test this:
> 
> You have to use 'nohlt' on the cmdline on AM35x in order to avoid WFI
> and the wakeup problems that are still being worked on.
> 
> Kevin
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

Hello Kevin,

I have a Logic PD AM3517 Zoom Experimenter [SOMAM3517-10-1780RJXR-C (REV A)].

My board booted to the Linux login on MMC rootfs.

The following is from 'dmesg' output:

[start]-----------------------------------------------------------------

...

[    0.000000] Kernel command line: console=ttyO2,115200n8 root=/dev/mmcblk0p2 rw nohlt rootfstype=ext3 rootwait omapdss.def_disp=dvi omapfb.mode=dvi:1280x800@60

...

[    0.107727] omap_hwmod: am35x_otg_hs: cannot be enabled (3)
[    0.121704] omap_hwmod: uart4: softreset failed (waited 10000 usec)

...

[    0.136505] ------------[ cut here ]------------
[    0.136566] WARNING: at /sandbox/linux/arch/arm/mach-omap2/pm.c:48 _init_omap_device+0x74/0x94()
[    0.136566] _init_omap_device: could not find omap_hwmod for iva
[    0.136596] Modules linked in:
[    0.136657] [<c001855c>] (unwind_backtrace+0x0/0x11c) from [<c0032540>] (warn_slowpath_common+0x4c/0x64)
[    0.136718] [<c0032540>] (warn_slowpath_common+0x4c/0x64) from [<c00325d8>] (warn_slowpath_fmt+0x2c/0x3c)
[    0.136749] [<c00325d8>] (warn_slowpath_fmt+0x2c/0x3c) from [<c0649b80>] (_init_omap_device+0x74/0x94)
[    0.136779] [<c0649b80>] (_init_omap_device+0x74/0x94) from [<c0649bd4>] (omap2_common_pm_init+0x34/0x5c)
[    0.136810] [<c0649bd4>] (omap2_common_pm_init+0x34/0x5c) from [<c0008644>] (do_one_initcall+0x90/0x164)
[    0.136840] [<c0008644>] (do_one_initcall+0x90/0x164) from [<c06418c4>] (kernel_init+0x120/0x1dc)
[    0.136901] [<c06418c4>] (kernel_init+0x120/0x1dc) from [<c00136e8>] (kernel_thread_exit+0x0/0x8)
[    0.137207] ---[ end trace 1b75b31a2719ed1c ]---

...

[    0.184143] dpll3_m2_clk rate change failed: -22
[    0.186218]  usbhs_omap: alias fck already exists
[    0.191223] _omap_mux_init_gpio: Multiple gpio paths (2) for gpio126

...

[    0.547546] usbhs_omap usbhs_omap: xclk60mhsp1_ck set parentfailed error:-22
[    0.547607] usbhs_omap usbhs_omap: xclk60mhsp2_ck set parentfailed error:-22

...

[    0.858215] omapdss_venc supply vdda_dac not found, using dummy regulator
[    e.863067] omapdss supply vdds_dsi not found, using dummy regulator

...

[    1.864593] davinci_mdio davinci_mdio.0: davinci mdio revision 1.5
[    1.871093] davinci_mdio davinci_mdio.0: detected phy mask fffffffe
[    1.881072] davinci_mdio.0: probed
[    1.884643] davinci_mdio davinci_mdio.0: phy[0]: device davinci_mdio-0:00, driver SMSC LAN8710/LAN8720

...

[    4.477539] voltdm_scale: No voltage scale API registered for vdd_mpu_iva
[    4.484832] voltdm_scale: No voltage scale API registered for vdd_core

...

[    4.569549] omapfb omapfb: failed to allocate fbmem
[    4.579437] omapfb omapfb: failed to setup omapfb
[    4.588745] omapfb: probe of omapfb failed with error -12

[end]-------------------------------------------------------------------


Mark Greer's patches from earlier this month helped with some of these
IVA related items. I would like to help test some of the AM3517 changes.
I have two SOMAM3517 cards (one with WiFi). Is there a kernel config
that is commonly used by those testing the AM3517? or modified
omap2plus? I think some issues that I am seeing involve wrong
configuration assumptions by me.


--
Derald D. Woods
