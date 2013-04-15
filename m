From: Paul Walmsley <paul@pwsan.com>
Subject: OMAP baseline test results for v3.9-rc7
Date: Mon, 15 Apr 2013 05:33:48 +0000 (UTC)
Message-ID: <alpine.DEB.2.00.1304150530520.17469@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([74.50.51.50]:41157 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933432Ab3DOFdt (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 15 Apr 2013 01:33:49 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org


Here are some basic OMAP test results for Linux v3.9-rc7.
Logs and other details at:

    http://www.pwsan.com/omap/testlogs/test_v3.9-rc7/20130414220303/


Test summary
------------

Build:
    FAIL ( 2/16): am33xx_only, omap2plus_defconfig_2430sdp_only
    Pass (14/16): n800_multi_omap2xxx, n800_only_a, omap1_defconfig, 
                  omap1_defconfig_1510innovator_only, 
                  omap1_defconfig_5912osk_only, omap2plus_defconfig, 
                  omap2plus_defconfig_cpupm, omap2plus_defconfig_no_pm, 
                  omap2plus_defconfig_omap2_4_only, 
                  omap2plus_defconfig_omap3_4_only, 
                  rmk_omap3430_ldp_allnoconfig, 
                  rmk_omap3430_ldp_oldconfig, 
                  rmk_omap4430_sdp_allnoconfig, 
                  rmk_omap4430_sdp_oldconfig

Boot to userspace:
    FAIL ( 1/11): am335xbone
    Pass (10/11): 2420n800, 2430sdp, 3517evm, 3530es3beagle,
                  3730beaglexm, 37xxevm, 4430es2panda, 4460pandaes,
                  5912osk, cmt3517

PM ret, suspend:
    FAIL ( 2/ 6): 2430sdp, 4430es2panda
    Pass ( 4/ 6): 3530es3beagle, 3730beaglexm, 37xxevm, 4460pandaes

PM ret, dynamic idle:
    FAIL ( 3/ 6): 2430sdp, 4430es2panda, 4460pandaes
    Pass ( 3/ 6): 3530es3beagle, 3730beaglexm, 37xxevm

PM off, suspend:
    FAIL ( 2/ 5): 4430es2panda, 4460pandaes
    Pass ( 3/ 5): 3530es3beagle, 3730beaglexm, 37xxevm

PM off, dynamic idle:
    FAIL ( 2/ 5): 4430es2panda, 4460pandaes
    Pass ( 3/ 5): 3530es3beagle, 3730beaglexm, 37xxevm



Failing tests: fixed by posted patches
--------------------------------------

Build:

* am33xx_only, omap2plus_defconfig_2430sdp_only: omap-{smp,hotplug}.c link errors
  - Discussion & RFC patch: http://www.spinics.net/lists/arm-kernel/msg230017.html
  - Still needs revision of the patch


Failing tests: needing investigation
------------------------------------

Boot tests:

* 3517EVM & CM-T3517: boot hangs with NFS root
  - Likely some Kconfig, board file, and PM issues with EMAC
  - Longstanding bug
  - Not currently part of the automated test suite

Boot warnings:

* CM-T3517: L3 in-band error with IPSS during boot
  - Cause unknown but see http://marc.info/?l=linux-omap&m=134833869730129&w=2
  - Longstanding issue; does not occur on the 3517EVM

PM tests:

* 2430sdp: pwrdm state mismatch(dsp_pwrdm) 0 != 3
  - need to doublecheck wakeup dependencies
  - (am assuming it's still there; userspace problems prevent the test
     from running, probably due to the lock warning)

* 2430sdp: power domains not entering retention
  - Cause unknown
  - (am assuming it's still there; userspace problems prevent the test
     from running, probably due to the lock warning)

* 4430es2panda, 4460pandaes: pwrdm state mismatch on CAM, DSS, ABE

* 4460pandaes: pwrdm state mismatch on IVAHD, TESLA 

* 4430es2panda: CORE, TESLA, IVAHD, L3INIT didn't enter target state
  - Probably due to lack of reset code for M3, DSP, SL2IF, FSUSB
    per discussion with Tero Kristo
  - Likely dependent on the bootloader version
    - fails with 2012.07-00136-g755de79
  - http://marc.info/?l=linux-arm-kernel&m=136432340618226&w=2

* 4460pandaes: chip not entering retention in dynamic idle
  - Presumably 4430es2panda also fails this
  - Suspend-to-RAM enters full chip retention

* 3730 Beagle XM: does not serial wake from off-idle suspend when console
  UART doesn't clock-gate ("debug ignore_loglevel")
  - Cause unknown
  - Not yet part of the automated test suite
  - Re-tested at v3.7; still failing:
    http://www.pwsan.com/omap/transcripts/20121211-3730beaglexm-3.7-pm-offmode-fail-debug.txt

Other:

* 4430es2panda: omap_hwmod: l3_instr: _wait_target_disable failed
  - Unknown cause; could be due to the lack of hierarchical enable/disable
    in hwmod code
  - Jon Hunter and Santosh Shilimkar report this does not appear with
    the same X-loader/bootloader on his 4430ES2.3 Panda, so could be
    ES-level dependent


Failing tests: reported by others 
---------------------------------

- MUSB broken after v3.9-rc6
  - due to commit 92702df3570e1ccfa050e135e50c450502251b79
  - discussion here: http://marc.info/?l=linux-omap&m=136544098331552&w=2
  - patch pending upstream:
    http://marc.info/?l=linux-omap&m=136562302329307&w=2

vmlinux object size
(delta in bytes from test_v3.9-rc6 
(31880c37c11e28cb81c70757e38392b42e695dc6)):
   text     data      bss    total  kernel
  +5067        0        0    +5067  n800_multi_omap2xxx
   +975        0        0     +975  n800_only_a
  +1135        0        0    +1135  omap1_defconfig
  +1119        0        0    +1119  omap1_defconfig_1510innovator_only
  +1135        0        0    +1135  omap1_defconfig_5912osk_only
  +1251        0        0    +1251  omap2plus_defconfig
  +1271       -8        0    +1263  omap2plus_defconfig_cpupm
  +1255      +24        0    +1279  omap2plus_defconfig_no_pm
  +1255       -8        0    +1247  omap2plus_defconfig_omap2_4_only
  +1359        0        0    +1359  omap2plus_defconfig_omap3_4_only
  +2064       +8      -56    +2016  rmk_omap3430_ldp_allnoconfig
   +703        0        0     +703  rmk_omap3430_ldp_oldconfig
  +2064       +8      -56    +2016  rmk_omap4430_sdp_allnoconfig
  +1743      -16        0    +1727  rmk_omap4430_sdp_oldconfig

Boot-time memory difference
(delta in bytes from test_v3.9-rc6 
(31880c37c11e28cb81c70757e38392b42e695dc6))
  avail  rsrvd   high  freed  board          kconfig
    -8k     8k      .      .  2420n800       n800_only_a


