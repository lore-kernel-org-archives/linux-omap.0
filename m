From: Nishanth Menon <nm@ti.com>
Subject: omap based boards (next-20140409-omap2plus_defconfig) - boot time
 warning:
Date: Wed, 9 Apr 2014 08:15:47 -0500
Message-ID: <53454803.3090703@ti.com>
References: <53453FF1.60803@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:47321 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932685AbaDINPs (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 9 Apr 2014 09:15:48 -0400
Received: from dlelxv90.itg.ti.com ([172.17.2.17])
	by bear.ext.ti.com (8.13.7/8.13.7) with ESMTP id s39DFmjs031284
	for <linux-omap@vger.kernel.org>; Wed, 9 Apr 2014 08:15:48 -0500
Received: from DLEE71.ent.ti.com (dlee71.ent.ti.com [157.170.170.114])
	by dlelxv90.itg.ti.com (8.14.3/8.13.8) with ESMTP id s39DFmoq002039
	for <linux-omap@vger.kernel.org>; Wed, 9 Apr 2014 08:15:48 -0500
In-Reply-To: <53453FF1.60803@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap <linux-omap@vger.kernel.org>, Roger Quadros <rogerq@ti.com>, "Balbi, Felipe" <balbi@ti.com>, Sourav Poddar <sourav.poddar@ti.com>

On 04/09/2014 07:41 AM, Nishanth Menon wrote:
> Hi,
> http://slexy.org/raw/s2pkLsiFBX
> 
> I noticed the following sets of warnings with omap2plus_defconfig on
> next-20140409. As per older logs, next-20140401 had it and v3.14 tag
> also had it (I have'nt retained older logs).
> 

Here is a quick list of 20 odd boards I am testing with:

next-20140409-omap2plus_defconfig

 1: am335x-evm:  Boot PASS: http://slexy.org/raw/s2Ho7WPbaZ
omap_hwmod: tptc* using broken dt data from edma
platform 49000000.edma: alias fck already exists

 2:  am335x-sk:  Boot PASS: http://slexy.org/raw/s2A5ZJjsuZ
same for tptc, edma

 3: am3517-evm:  Boot PASS: http://slexy.org/raw/s20q8rTwCJ
omap_hwmod: mcbsp2_sidetone using broken dt data from mcbsp
omap_hwmod: usb_host_hs: could not associate to clkdm l3_init_clkdm
Address Hole seen by USB_OTG  at address dc0f9c0c
platform iva.2: Cannot lookup hwmod 'iva'
platform 480c5000.aes: Cannot lookup hwmod 'aes'
platform 48094000.mailbox: Cannot lookup hwmod 'mailbox'
platform 480bd400.mmu: Cannot lookup hwmod 'mmu_isp'
platform 480c3000.sham: Cannot lookup hwmod 'sham'
platform 480cb000.smartreflex: Cannot lookup hwmod 'smartreflex_core'
platform 480cb000.smartreflex: Cannot lookup hwmod 'smartreflex_iva'
edma-dma-engine: probe of edma-dma-engine.0 failed with error -5

 4:  am37x-evm:  Boot PASS: http://slexy.org/raw/s21kcHKdyf
nothing interesting.

 5: am43xx-epos:  Boot PASS: http://slexy.org/raw/s210geZKgS
platform 53701000.des: Cannot lookup hwmod 'des'
platform 49000000.edma: alias fck already exists
the usb and qspi issue reported.

 6: am43xx-gpevm:  Boot FAIL: http://slexy.org/raw/s20t5JOyI4
known issue. (gpio reset for DDR)

 7: BeagleBoard-XM:  Boot PASS: http://slexy.org/raw/s2TXdBONNI
 omap_hwmod: mcbsp2_sidetone using broken dt data from mcbsp
 omap_hwmod: mcbsp3_sidetone using broken dt data from mcbsp
 omap_hwmod: usb_host_hs: could not associate to clkdm l3_init_clkdm
 omap_hwmod: usb_tll_hs: could not associate to clkdm l3_init_clkdm
edma-dma-engine: probe of edma-dma-engine.0 failed with error -5

 8: beagleboard-vanilla:  Boot PASS: http://slexy.org/raw/s24pDuZ7S7
omap_hwmod: mcbsp2_sidetone using broken dt data from mcbsp
omap_hwmod: mcbsp3_sidetone using broken dt data from mcbsp
omap_hwmod: ssi: doesn't have mpu register target base
omap_hwmod: usb_host_hs: could not associate to clkdm l3_init_clkdm
omap_hwmod: usb_tll_hs: could not associate to clkdm l3_init_clkdm
omap_hwmod: mcbsp2: cannot be enabled for reset (3)
edma-dma-engine: probe of edma-dma-engine.0 failed with error -5

 9: beaglebone-black:  Boot PASS: http://slexy.org/raw/s21ztl1meX
omap_hwmod: tptc0 using broken dt data from edma
omap_hwmod: tptc1 using broken dt data from edma
omap_hwmod: tptc2 using broken dt data from edma
omap_hwmod: debugss: _wait_target_disable failed
platform 49000000.edma: alias fck already exists
platform 49000000.edma: alias fck already exists
platform 49000000.edma: alias fck already exists

10: beaglebone:  Boot PASS: http://slexy.org/raw/s2a2JO9MVd
omap_hwmod: tptc0 using broken dt data from edma
omap_hwmod: tptc1 using broken dt data from edma
omap_hwmod: tptc2 using broken dt data from edma
omap_hwmod: debugss: _wait_target_disable failed
platform 49000000.edma: alias fck already exists
platform 49000000.edma: alias fck already exists
platform 49000000.edma: alias fck already exists

11: craneboard:  Boot PASS: http://slexy.org/raw/s20xtW58E3
Address Hole seen by USB_OTG  at address 4de96fbc
omap_hwmod: mcbsp2_sidetone using broken dt data from mcbsp
omap_hwmod: mcbsp3_sidetone using broken dt data from mcbsp
omap_hwmod: usb_host_hs: could not associate to clkdm l3_init_clkdm
omap_hwmod: usb_tll_hs: could not associate to clkdm l3_init_clkdm
omap_hwmod: uart4: cannot be enabled for reset (3)
platform iva.2: Cannot lookup hwmod 'iva'
platform 480c5000.aes: Cannot lookup hwmod 'aes'
platform 48094000.mailbox: Cannot lookup hwmod 'mailbox'
platform 480bd400.mmu: Cannot lookup hwmod 'mmu_isp'
platform 480c3000.sham: Cannot lookup hwmod 'sham'
platform 480cb000.smartreflex: Cannot lookup hwmod 'smartreflex_core'
platform 480c9000.smartreflex: Cannot lookup hwmod 'smartreflex_mpu_iva'
platform 480ab000.usb_otg_hs: Cannot lookup hwmod 'usb_otg_hs'
edma-dma-engine: probe of edma-dma-engine.0 failed with error -5

12: DRA7xx-EVM:  Boot PASS: http://slexy.org/raw/s2TR2UyTxS
omap_hwmod: l3_main_2 using broken dt data from ocp
omap_hwmod: dss_core: _wait_target_disable failed
omap_hwmod: dss_core: cannot be enabled for reset (3)
omap_hwmod: dss_dispc: cannot be enabled for reset (3)
omap_hwmod: dss_hdmi: cannot be enabled for reset (3)
platform 4e000000.dmm: Cannot lookup hwmod 'dmm'
 omap_l3_noc 44000000.ocp: couldn't find resource 2
edma-dma-engine: probe of edma-dma-engine.0 failed with error -5
drivers/rtc/hctosys.c: unable to open rtc device (rtc0)

13: OMAP3430-Labrador(LDP):  Boot PASS: http://slexy.org/raw/s21ZRwPGPg
omap_hwmod: ssi: doesn't have mpu register target base
omap_hwmod: mcbsp2_sidetone using broken dt data from mcbsp
omap_hwmod: mcbsp3_sidetone using broken dt data from mcbsp
omap_hwmod: usb_host_hs: could not associate to clkdm l3_init_clkdm
omap_hwmod: usb_tll_hs: could not associate to clkdm l3_init_clkdm
omap_hwmod: mcbsp2: cannot be enabled for reset (3)
omap-gpmc 6e000000.gpmc: GPMC revision 5.0
gpmc_probe_nand_child: ti,elm-id property not found
gpmc_cs_program_settings: invalid width 0!
edma-dma-engine: probe of edma-dma-engine.0 failed with error -5

14:       n900:  Boot PASS: http://slexy.org/raw/s21oybPlxa
omap_hwmod: mcbsp2_sidetone using broken dt data from mcbsp
omap_hwmod: mcbsp3_sidetone using broken dt data from mcbsp
omap_hwmod: ssi: doesn't have mpu register target base
 omap_hwmod: usb_host_hs: could not associate to clkdm l3_init_clkdm
 omap_hwmod: usb_tll_hs: could not associate to clkdm l3_init_clkdm
 omap_hwmod: mcbsp2: cannot be enabled for reset (3)
rx51_video_init cannot configure MUX for LCD RESET
edma-dma-engine: probe of edma-dma-engine.0 failed with error -5

15: pandaboard-es:  Boot PASS: http://slexy.org/raw/s2qoGzHvAL
 omap_hwmod: l3_main_3 using broken dt data from ocp
 omap_hwmod: l3_main_2 using broken dt data from ocp
edma-dma-engine: probe of edma-dma-engine.0 failed with error -5
platform 4b501000.aes: Cannot lookup hwmod 'aes'
platform 480a5000.des: Cannot lookup hwmod 'des'


16: pandaboard-vanilla:  Boot PASS: http://slexy.org/raw/s21kH0Lsga
omap_hwmod: l3_main_3 using broken dt data from ocp
omap_hwmod: l3_main_2 using broken dt data from ocp
platform 4b501000.aes: Cannot lookup hwmod 'aes'
platform 480a5000.des: Cannot lookup hwmod 'des'
edma-dma-engine: probe of edma-dma-engine.0 failed with error -5

17:    sdp2430:  Boot PASS: http://slexy.org/raw/s206Fygl3J
omap_hwmod: usb_otg_hs: cannot be enabled for reset (3)
twl4030_keypad: probe of keypad.29 failed with error -2

18:    sdp3430:  Boot PASS: http://slexy.org/raw/s24cAq4vMt
 omap_hwmod: ssi: doesn't have mpu register target base
omap_hwmod: mcbsp2_sidetone using broken dt data from mcbsp
omap_hwmod: mcbsp3_sidetone using broken dt data from mcbsp
omap_hwmod: usb_host_hs: could not associate to clkdm l3_init_clkdm
omap_hwmod: usb_tll_hs: could not associate to clkdm l3_init_clkdm
gpmc_probe_nand_child: ti,elm-id property not found
gpmc_cs_program_settings: invalid width 0!
hw-breakpoint: debug architecture 0x4 unsupported.
edma-dma-engine: probe of edma-dma-engine.0 failed with error -5
twl4030_keypad: probe of keypad.28 failed with error -2
of_get_named_gpiod_flags: can't parse gpios property of node
'/ocp/mmc@4809c000[0]'

19:    sdp4430:  Boot PASS: http://slexy.org/raw/s2VTGsB5Zb
omap_hwmod: l3_main_3 using broken dt data from ocp
omap_hwmod: l3_main_2 using broken dt data from ocp
 platform 4b501000.aes: Cannot lookup hwmod 'aes'
 platform 480a5000.des: Cannot lookup hwmod 'des'
edma-dma-engine: probe of edma-dma-engine.0 failed with error -5

20: OMAP5432uEVM:  Boot PASS: http://slexy.org/raw/s21I4dKlfe
 omap_hwmod: l3_main_3 using broken dt data from ocp
 omap_hwmod: l3_main_2 using broken dt data from ocp
omap_hwmod: mailbox: doesn't have mpu register target base
platform 50000000.gpmc: Cannot lookup hwmod 'gpmc'
map-gpmc 50000000.gpmc: _od_fail_runtime_resume: FIXME: missing
hwmod/omap_dev info

TOTAL = 20 boards, Booted Boards = 19, No Boot boards = 1




-- 
Regards,
Nishanth Menon
