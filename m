From: Paul Walmsley <paul@pwsan.com>
Subject: RE: [PATCH 01/10] ARM: OMAP3/4: cpuidle: fix sparse and checkpatch
 warnings
Date: Thu, 13 Dec 2012 07:29:49 +0000 (UTC)
Message-ID: <alpine.DEB.2.00.1212130726160.25415@utopia.booyaka.com>
References: <20121209011755.19716.25244.stgit@dusk.lan> <20121209012334.19716.44831.stgit@dusk.lan> <50C840C9.5000407@ti.com> <alpine.DEB.2.00.1212130541320.25415@utopia.booyaka.com> <79CD15C6BA57404B839C016229A409A83EBAF47B@DBDE01.ent.ti.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([74.50.51.50]:52185 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750786Ab2LMH3u (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 13 Dec 2012 02:29:50 -0500
In-Reply-To: <79CD15C6BA57404B839C016229A409A83EBAF47B@DBDE01.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Hiremath, Vaibhav" <hvaibhav@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

On Thu, 13 Dec 2012, Hiremath, Vaibhav wrote:

> On Thu, Dec 13, 2012 at 11:11:49, Paul Walmsley wrote:
> > 
> > The branch name to use is:
> > 
> > "TEST_pwrdm_post_fpwrst_devel_a_3.9"
> 
> If I am correct, it only includes one additional patch (merge commit), 
> right???
> 
> commit d94831e0005fee743cefd28f4c20b7c435c71236
> Merge: 3e885c6 80ab3b2
> Author: Paul Walmsley <paul@pwsan.com>
> Date:   Sun Dec 9 13:06:51 2012 -0700
> 
>     build fixes
> 
> 
> 
> Does this also fix sparse warnings? 

Just ran a quick sparse check on mach-omap2 at 3e885c6 and d94831e with 
'make -j4 C=2 arch/arm/mach-omap2', and no warnings showed up.  There were 
some sparse issues that got fixed at an earlier point, though, so perhaps 
you have an older copy of the branches somehow?


- Paul

paul@dusk:/kernel/kernel/current$ git log -1
commit d94831e0005fee743cefd28f4c20b7c435c71236
Merge: 3e885c6 80ab3b2
Author: Paul Walmsley <paul@pwsan.com>
Date:   Sun Dec 9 13:06:51 2012 -0700

    build fixes
paul@dusk:/kernel/kernel/current$ make C=2 -j4 arch/arm/mach-omap2/
  CHK     include/generated/uapi/linux/version.h
  CHECK   scripts/mod/empty.c
  CHK     include/generated/utsrelease.h
  UPD     include/generated/utsrelease.h
make[1]: `include/generated/mach-types.h' is up to date.
  CC      kernel/bounds.s
  GEN     include/generated/bounds.h
  CC      arch/arm/kernel/asm-offsets.s
  GEN     include/generated/asm-offsets.h
  CALL    scripts/checksyscalls.sh
  CHECK   arch/arm/mach-omap2/id.c
  CHECK   arch/arm/mach-omap2/io.c
  CHECK   arch/arm/mach-omap2/control.c
  CHECK   arch/arm/mach-omap2/mux.c
  CC      arch/arm/mach-omap2/id.o
  CC      arch/arm/mach-omap2/control.o
  CC      arch/arm/mach-omap2/io.o
  CC      arch/arm/mach-omap2/mux.o
  CHECK   arch/arm/mach-omap2/devices.c
  CHECK   arch/arm/mach-omap2/serial.c
  CHECK   arch/arm/mach-omap2/gpmc.c
  CC      arch/arm/mach-omap2/devices.o
  CC      arch/arm/mach-omap2/serial.o
  CC      arch/arm/mach-omap2/gpmc.o
  CHECK   arch/arm/mach-omap2/timer.c
  CHECK   arch/arm/mach-omap2/pm.c
  CC      arch/arm/mach-omap2/timer.o
  CC      arch/arm/mach-omap2/pm.o
  CHECK   arch/arm/mach-omap2/common.c
  CC      arch/arm/mach-omap2/common.o
  CHECK   arch/arm/mach-omap2/gpio.c
  CC      arch/arm/mach-omap2/gpio.o
  CHECK   arch/arm/mach-omap2/dma.c
  CC      arch/arm/mach-omap2/dma.o
  CHECK   arch/arm/mach-omap2/wd_timer.c
  CHECK   arch/arm/mach-omap2/display.c
  CHECK   arch/arm/mach-omap2/i2c.c
  CC      arch/arm/mach-omap2/wd_timer.o
  CC      arch/arm/mach-omap2/i2c.o
  CC      arch/arm/mach-omap2/display.o
  CHECK   arch/arm/mach-omap2/hdq1w.c
  CC      arch/arm/mach-omap2/hdq1w.o
  CHECK   arch/arm/mach-omap2/omap_hwmod.c
  CHECK   arch/arm/mach-omap2/omap_device.c
  CC      arch/arm/mach-omap2/omap_hwmod.o
  CC      arch/arm/mach-omap2/omap_device.o
  CHECK   arch/arm/mach-omap2/irq.c
  CHECK   arch/arm/mach-omap2/omap_hwmod_common_data.c
  CC      arch/arm/mach-omap2/irq.o
  CC      arch/arm/mach-omap2/omap_hwmod_common_data.o
  CHECK   arch/arm/mach-omap2/omap-secure.c
  CC      arch/arm/mach-omap2/omap-secure.o
  CHECK   arch/arm/mach-omap2/prm44xx.c
  CHECK   arch/arm/mach-omap2/mcbsp.c
  CC      arch/arm/mach-omap2/prm44xx.o
  CC      arch/arm/mach-omap2/mcbsp.o
  CHECK   arch/arm/mach-omap2/omap_twl.c
  CC      arch/arm/mach-omap2/omap_twl.o
  CHECK   arch/arm/mach-omap2/sdrc.c
  CC      arch/arm/mach-omap2/sdrc.o
  CHECK   arch/arm/mach-omap2/omap-smp.c
  CHECK   arch/arm/mach-omap2/omap-hotplug.c
  CC      arch/arm/mach-omap2/omap-smp.o
  CC      arch/arm/mach-omap2/omap-hotplug.o
  CHECK   arch/arm/mach-omap2/omap4-common.c
  CC      arch/arm/mach-omap2/omap4-common.o
  CHECK   arch/arm/mach-omap2/omap-wakeupgen.c
  AS      arch/arm/mach-omap2/sram242x.o
  AS      arch/arm/mach-omap2/sram243x.o
  CC      arch/arm/mach-omap2/omap-wakeupgen.o
  AS      arch/arm/mach-omap2/sram34xx.o
  CHECK   arch/arm/mach-omap2/omap2-restart.c
  CHECK   arch/arm/mach-omap2/omap3-restart.c
  CC      arch/arm/mach-omap2/omap2-restart.o
  CC      arch/arm/mach-omap2/omap3-restart.o
  CHECK   arch/arm/mach-omap2/mux2420.c
  CC      arch/arm/mach-omap2/mux2420.o
  CHECK   arch/arm/mach-omap2/mux2430.c
  CHECK   arch/arm/mach-omap2/mux34xx.c
  CHECK   arch/arm/mach-omap2/mux44xx.c
  CC      arch/arm/mach-omap2/mux2430.o
  CC      arch/arm/mach-omap2/mux34xx.o
  CC      arch/arm/mach-omap2/mux44xx.o
  CHECK   arch/arm/mach-omap2/sdrc2xxx.c
  CHECK   arch/arm/mach-omap2/opp.c
  CC      arch/arm/mach-omap2/sdrc2xxx.o
  CC      arch/arm/mach-omap2/opp.o
  CHECK   arch/arm/mach-omap2/opp3xxx_data.c
  CHECK   arch/arm/mach-omap2/opp4xxx_data.c
  CC      arch/arm/mach-omap2/opp3xxx_data.o
  CC      arch/arm/mach-omap2/opp4xxx_data.o
  CHECK   arch/arm/mach-omap2/pm24xx.c
  AS      arch/arm/mach-omap2/sleep24xx.o
  CHECK   arch/arm/mach-omap2/pm34xx.c
  AS      arch/arm/mach-omap2/sleep34xx.o
  CHECK   arch/arm/mach-omap2/pm44xx.c
  CC      arch/arm/mach-omap2/pm24xx.o
  CHECK   arch/arm/mach-omap2/omap-mpuss-lowpower.c
  CC      arch/arm/mach-omap2/pm34xx.o
  CC      arch/arm/mach-omap2/pm44xx.o
  CC      arch/arm/mach-omap2/omap-mpuss-lowpower.o
  CHECK   arch/arm/mach-omap2/pm-debug.c
  CHECK   arch/arm/mach-omap2/prm_common.c
  CC      arch/arm/mach-omap2/pm-debug.o
  CHECK   arch/arm/mach-omap2/cm_common.c
  CC      arch/arm/mach-omap2/prm_common.o
  CC      arch/arm/mach-omap2/cm_common.o
  CHECK   arch/arm/mach-omap2/prm2xxx_3xxx.c
  CC      arch/arm/mach-omap2/prm2xxx_3xxx.o
  CHECK   arch/arm/mach-omap2/prm2xxx.c
  CHECK   arch/arm/mach-omap2/cm2xxx.c
  CC      arch/arm/mach-omap2/prm2xxx.o
  CC      arch/arm/mach-omap2/cm2xxx.o
  CHECK   arch/arm/mach-omap2/prm3xxx.c
  CC      arch/arm/mach-omap2/prm3xxx.o
  CHECK   arch/arm/mach-omap2/cm3xxx.c
  CC      arch/arm/mach-omap2/cm3xxx.o
  CHECK   arch/arm/mach-omap2/vc3xxx_data.c
  CHECK   arch/arm/mach-omap2/vp3xxx_data.c
  CC      arch/arm/mach-omap2/vc3xxx_data.o
  CC      arch/arm/mach-omap2/vp3xxx_data.o
  CHECK   arch/arm/mach-omap2/prm33xx.c
  CC      arch/arm/mach-omap2/prm33xx.o
  CHECK   arch/arm/mach-omap2/cm33xx.c
  CHECK   arch/arm/mach-omap2/cminst44xx.c
  CC      arch/arm/mach-omap2/cm33xx.o
  CC      arch/arm/mach-omap2/cminst44xx.o
  CHECK   arch/arm/mach-omap2/cm44xx.c
  CC      arch/arm/mach-omap2/cm44xx.o
  CHECK   arch/arm/mach-omap2/prcm_mpu44xx.c
  CC      arch/arm/mach-omap2/prcm_mpu44xx.o
  CHECK   arch/arm/mach-omap2/prminst44xx.c
  CHECK   arch/arm/mach-omap2/vc44xx_data.c
  CC      arch/arm/mach-omap2/prminst44xx.o
  CHECK   arch/arm/mach-omap2/vp44xx_data.c
  CC      arch/arm/mach-omap2/vc44xx_data.o
  CHECK   arch/arm/mach-omap2/voltage.c
  CC      arch/arm/mach-omap2/vp44xx_data.o
  CC      arch/arm/mach-omap2/voltage.o
  CHECK   arch/arm/mach-omap2/vc.c
  CC      arch/arm/mach-omap2/vc.o
  CHECK   arch/arm/mach-omap2/vp.c
  CHECK   arch/arm/mach-omap2/voltagedomains2xxx_data.c
  CC      arch/arm/mach-omap2/voltagedomains2xxx_data.o
  CC      arch/arm/mach-omap2/vp.o
  CHECK   arch/arm/mach-omap2/voltagedomains3xxx_data.c
  CC      arch/arm/mach-omap2/voltagedomains3xxx_data.o
  CHECK   arch/arm/mach-omap2/voltagedomains44xx_data.c
  CHECK   arch/arm/mach-omap2/voltagedomains33xx_data.c
  CC      arch/arm/mach-omap2/voltagedomains33xx_data.o
  CC      arch/arm/mach-omap2/voltagedomains44xx_data.o
  CHECK   arch/arm/mach-omap2/powerdomain.c
  CC      arch/arm/mach-omap2/powerdomain.o
  CHECK   arch/arm/mach-omap2/powerdomain-common.c
  CC      arch/arm/mach-omap2/powerdomain-common.o
  CHECK   arch/arm/mach-omap2/powerdomains2xxx_data.c
  CC      arch/arm/mach-omap2/powerdomains2xxx_data.o
  CHECK   arch/arm/mach-omap2/powerdomains2xxx_3xxx_data.c
  CC      arch/arm/mach-omap2/powerdomains2xxx_3xxx_data.o
  CHECK   arch/arm/mach-omap2/powerdomains3xxx_data.c
  CHECK   arch/arm/mach-omap2/powerdomains44xx_data.c
  CC      arch/arm/mach-omap2/powerdomains3xxx_data.o
  CHECK   arch/arm/mach-omap2/powerdomains33xx_data.c
  CC      arch/arm/mach-omap2/powerdomains33xx_data.o
  CC      arch/arm/mach-omap2/powerdomains44xx_data.o
  CHECK   arch/arm/mach-omap2/clockdomain.c
  CC      arch/arm/mach-omap2/clockdomain.o
  CHECK   arch/arm/mach-omap2/clockdomains2xxx_3xxx_data.c
  CC      arch/arm/mach-omap2/clockdomains2xxx_3xxx_data.o
  CHECK   arch/arm/mach-omap2/clockdomains2420_data.c
  CHECK   arch/arm/mach-omap2/clockdomains2430_data.c
  CC      arch/arm/mach-omap2/clockdomains2420_data.o
  CC      arch/arm/mach-omap2/clockdomains2430_data.o
  CHECK   arch/arm/mach-omap2/clockdomains3xxx_data.c
  CHECK   arch/arm/mach-omap2/clockdomains44xx_data.c
  CC      arch/arm/mach-omap2/clockdomains3xxx_data.o
  CHECK   arch/arm/mach-omap2/clockdomains33xx_data.c
  CC      arch/arm/mach-omap2/clockdomains44xx_data.o
  CC      arch/arm/mach-omap2/clockdomains33xx_data.o
  CHECK   arch/arm/mach-omap2/clock.c
  CHECK   arch/arm/mach-omap2/clock_common_data.c
  CC      arch/arm/mach-omap2/clock_common_data.o
  CC      arch/arm/mach-omap2/clock.o
  CHECK   arch/arm/mach-omap2/clkt_dpll.c
  CHECK   arch/arm/mach-omap2/clkt_clksel.c
  CC      arch/arm/mach-omap2/clkt_dpll.o
  CHECK   arch/arm/mach-omap2/clock2xxx.c
  CC      arch/arm/mach-omap2/clkt_clksel.o
  CC      arch/arm/mach-omap2/clock2xxx.o
  CHECK   arch/arm/mach-omap2/clkt2xxx_sys.c
  CC      arch/arm/mach-omap2/clkt2xxx_sys.o
  CHECK   arch/arm/mach-omap2/clkt2xxx_dpllcore.c
  CC      arch/arm/mach-omap2/clkt2xxx_dpllcore.o
  CHECK   arch/arm/mach-omap2/clkt2xxx_virt_prcm_set.c
  CC      arch/arm/mach-omap2/clkt2xxx_virt_prcm_set.o
  CHECK   arch/arm/mach-omap2/clkt2xxx_apll.c
  CC      arch/arm/mach-omap2/clkt2xxx_apll.o
  CHECK   arch/arm/mach-omap2/clkt2xxx_osc.c
  CC      arch/arm/mach-omap2/clkt2xxx_osc.o
  CHECK   arch/arm/mach-omap2/clkt2xxx_dpll.c
  CC      arch/arm/mach-omap2/clkt2xxx_dpll.o
  CHECK   arch/arm/mach-omap2/clkt_iclk.c
  CC      arch/arm/mach-omap2/clkt_iclk.o
  CHECK   arch/arm/mach-omap2/clock2420_data.c
  CHECK   arch/arm/mach-omap2/clock2430.c
  CHECK   arch/arm/mach-omap2/clock2430_data.c
  CC      arch/arm/mach-omap2/clock2430.o
  CC      arch/arm/mach-omap2/clock2420_data.o
  CC      arch/arm/mach-omap2/clock2430_data.o
  CHECK   arch/arm/mach-omap2/clock3xxx.c
  CC      arch/arm/mach-omap2/clock3xxx.o
  CHECK   arch/arm/mach-omap2/clock34xx.c
  CC      arch/arm/mach-omap2/clock34xx.o
  CHECK   arch/arm/mach-omap2/clkt34xx_dpll3m2.c
  CHECK   arch/arm/mach-omap2/clock3517.c
  CHECK   arch/arm/mach-omap2/clock36xx.c
  CC      arch/arm/mach-omap2/clock3517.o
  CC      arch/arm/mach-omap2/clkt34xx_dpll3m2.o
  CC      arch/arm/mach-omap2/clock36xx.o
  CHECK   arch/arm/mach-omap2/dpll3xxx.c
  CC      arch/arm/mach-omap2/dpll3xxx.o
  CHECK   arch/arm/mach-omap2/clock3xxx_data.c
  CHECK   arch/arm/mach-omap2/clock44xx_data.c
  CHECK   arch/arm/mach-omap2/dpll44xx.c
  CC      arch/arm/mach-omap2/clock3xxx_data.o
  CC      arch/arm/mach-omap2/dpll44xx.o
  CC      arch/arm/mach-omap2/clock44xx_data.o
  CHECK   arch/arm/mach-omap2/clock33xx_data.c
  CHECK   arch/arm/mach-omap2/opp2420_data.c
  CC      arch/arm/mach-omap2/opp2420_data.o
  CHECK   arch/arm/mach-omap2/opp2430_data.c
  CHECK   arch/arm/mach-omap2/omap_hwmod_2xxx_ipblock_data.c
  CC      arch/arm/mach-omap2/clock33xx_data.o
  CC      arch/arm/mach-omap2/opp2430_data.o
  CHECK   arch/arm/mach-omap2/omap_hwmod_2xxx_3xxx_ipblock_data.c
  CC      arch/arm/mach-omap2/omap_hwmod_2xxx_ipblock_data.o
  CC      arch/arm/mach-omap2/omap_hwmod_2xxx_3xxx_ipblock_data.o
  CHECK   arch/arm/mach-omap2/omap_hwmod_2xxx_interconnect_data.c
  CC      arch/arm/mach-omap2/omap_hwmod_2xxx_interconnect_data.o
  CHECK   arch/arm/mach-omap2/omap_hwmod_2xxx_3xxx_interconnect_data.c
  CHECK   arch/arm/mach-omap2/omap_hwmod_2420_data.c
  CHECK   arch/arm/mach-omap2/omap_hwmod_2430_data.c
  CC      arch/arm/mach-omap2/omap_hwmod_2xxx_3xxx_interconnect_data.o
  CC      arch/arm/mach-omap2/omap_hwmod_2420_data.o
  CC      arch/arm/mach-omap2/omap_hwmod_2430_data.o
  CHECK   arch/arm/mach-omap2/omap_hwmod_3xxx_data.c
  CC      arch/arm/mach-omap2/omap_hwmod_3xxx_data.o
  CHECK   arch/arm/mach-omap2/omap_hwmod_33xx_data.c
  CHECK   arch/arm/mach-omap2/omap_hwmod_44xx_data.c
  CHECK   arch/arm/mach-omap2/pmu.c
  CC      arch/arm/mach-omap2/omap_hwmod_33xx_data.o
  CC      arch/arm/mach-omap2/omap_hwmod_44xx_data.o
  CC      arch/arm/mach-omap2/pmu.o
  CHECK   arch/arm/mach-omap2/msdi.c
  CC      arch/arm/mach-omap2/msdi.o
  CHECK   arch/arm/mach-omap2/board-generic.c
  CHECK   arch/arm/mach-omap2/board-h4.c
  CC      arch/arm/mach-omap2/board-generic.o
  CHECK   arch/arm/mach-omap2/board-2430sdp.c
  CC      arch/arm/mach-omap2/board-h4.o
  CC      arch/arm/mach-omap2/board-2430sdp.o
  CHECK   arch/arm/mach-omap2/board-apollon.c
  CHECK   arch/arm/mach-omap2/board-omap3beagle.c
  CC      arch/arm/mach-omap2/board-apollon.o
  CC      arch/arm/mach-omap2/board-omap3beagle.o
  CHECK   arch/arm/mach-omap2/board-devkit8000.c
  CC      arch/arm/mach-omap2/board-devkit8000.o
  CHECK   arch/arm/mach-omap2/board-ldp.c
  CHECK   arch/arm/mach-omap2/board-omap3logic.c
  CC      arch/arm/mach-omap2/board-ldp.o
  CC      arch/arm/mach-omap2/board-omap3logic.o
  CHECK   arch/arm/mach-omap2/board-overo.c
  CC      arch/arm/mach-omap2/board-overo.o
  CHECK   arch/arm/mach-omap2/board-omap3evm.c
  CC      arch/arm/mach-omap2/board-omap3evm.o
  CHECK   arch/arm/mach-omap2/board-omap3pandora.c
  CHECK   arch/arm/mach-omap2/board-3430sdp.c
  CC      arch/arm/mach-omap2/board-omap3pandora.o
  CC      arch/arm/mach-omap2/board-3430sdp.o
  CHECK   arch/arm/mach-omap2/board-n8x0.c
  CC      arch/arm/mach-omap2/board-n8x0.o
  CHECK   arch/arm/mach-omap2/board-rm680.c
  CC      arch/arm/mach-omap2/board-rm680.o
  CHECK   arch/arm/mach-omap2/sdram-nokia.c
  CHECK   arch/arm/mach-omap2/board-rx51.c
  CC      arch/arm/mach-omap2/sdram-nokia.o
  CC      arch/arm/mach-omap2/board-rx51.o
  CHECK   arch/arm/mach-omap2/board-rx51-peripherals.c
  CC      arch/arm/mach-omap2/board-rx51-peripherals.o
  CHECK   arch/arm/mach-omap2/board-rx51-video.c
  CC      arch/arm/mach-omap2/board-rx51-video.o
  CHECK   arch/arm/mach-omap2/board-zoom-peripherals.c
  CHECK   arch/arm/mach-omap2/board-zoom.c
  CC      arch/arm/mach-omap2/board-zoom.o
  CC      arch/arm/mach-omap2/board-zoom-peripherals.o
  CHECK   arch/arm/mach-omap2/board-zoom-display.c
  CHECK   arch/arm/mach-omap2/board-zoom-debugboard.c
  CC      arch/arm/mach-omap2/board-zoom-display.o
  CC      arch/arm/mach-omap2/board-zoom-debugboard.o
  CHECK   arch/arm/mach-omap2/board-3630sdp.c
  CHECK   arch/arm/mach-omap2/board-cm-t35.c
  CC      arch/arm/mach-omap2/board-3630sdp.o
  CHECK   arch/arm/mach-omap2/board-cm-t3517.c
  CC      arch/arm/mach-omap2/board-cm-t35.o
  CC      arch/arm/mach-omap2/board-cm-t3517.o
  CHECK   arch/arm/mach-omap2/board-igep0020.c
  CHECK   arch/arm/mach-omap2/board-omap3touchbook.c
  CC      arch/arm/mach-omap2/board-igep0020.o
  CC      arch/arm/mach-omap2/board-omap3touchbook.o
  CHECK   arch/arm/mach-omap2/board-4430sdp.c
  CHECK   arch/arm/mach-omap2/board-omap4panda.c
  CC      arch/arm/mach-omap2/board-4430sdp.o
  CC      arch/arm/mach-omap2/board-omap4panda.o
  CHECK   arch/arm/mach-omap2/board-am3517evm.c
  CHECK   arch/arm/mach-omap2/board-omap3stalker.c
  CC      arch/arm/mach-omap2/board-am3517evm.o
  CC      arch/arm/mach-omap2/board-omap3stalker.o
  CHECK   arch/arm/mach-omap2/board-ti8168evm.c
  CC      arch/arm/mach-omap2/board-ti8168evm.o
  CHECK   arch/arm/mach-omap2/board-flash.c
  CC      arch/arm/mach-omap2/board-flash.o
  CHECK   arch/arm/mach-omap2/hsmmc.c
  CHECK   arch/arm/mach-omap2/usb-musb.c
  CC      arch/arm/mach-omap2/hsmmc.o
  CHECK   arch/arm/mach-omap2/omap_phy_internal.c
  CC      arch/arm/mach-omap2/usb-musb.o
  CC      arch/arm/mach-omap2/omap_phy_internal.o
  CHECK   arch/arm/mach-omap2/usb-tusb6010.c
  CHECK   arch/arm/mach-omap2/usb-host.c
  CC      arch/arm/mach-omap2/usb-tusb6010.o
  CC      arch/arm/mach-omap2/usb-host.o
  CHECK   arch/arm/mach-omap2/gpmc-onenand.c
  CC      arch/arm/mach-omap2/gpmc-onenand.o
  CHECK   arch/arm/mach-omap2/gpmc-nand.c
  CHECK   arch/arm/mach-omap2/gpmc-smc91x.c
  CC      arch/arm/mach-omap2/gpmc-smc91x.o
  CC      arch/arm/mach-omap2/gpmc-nand.o
  CHECK   arch/arm/mach-omap2/gpmc-smsc911x.c
  CC      arch/arm/mach-omap2/gpmc-smsc911x.o
  CHECK   arch/arm/mach-omap2/common-board-devices.c
  CHECK   arch/arm/mach-omap2/twl-common.c
  CC      arch/arm/mach-omap2/common-board-devices.o
  CC      arch/arm/mach-omap2/twl-common.o
  LD      arch/arm/mach-omap2/built-in.o
paul@dusk:/kernel/kernel/current$ 

