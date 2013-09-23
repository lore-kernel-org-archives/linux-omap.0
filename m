From: Paul Walmsley <paul@pwsan.com>
Subject: OMAP baseline test results for v3.12-rc1
Date: Mon, 23 Sep 2013 03:02:08 +0000 (UTC)
Message-ID: <alpine.DEB.2.02.1309230255320.18475@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([74.50.51.50]:55480 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752611Ab3IWDCJ (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sun, 22 Sep 2013 23:02:09 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: kernel-build-reports@lists.linaro.org, linux-arm-kernel@lists.infradead.org


Here are some basic OMAP test results for Linux v3.12-rc1.
Logs and other details at:

    http://www.pwsan.com/omap/testlogs/test_v3.12-rc1/20130922202452/


Test summary
------------

Build: zImage:
    Pass ( 2/ 2): omap2plus_defconfig, omap2plus_defconfig_am33xx_only

Build: uImage+dtb:
    Pass ( 3/ 3): omap2plus_defconfig_am33xx_only/am335x-bone,
		  omap2plus_defconfig/omap4-panda,
		  omap2plus_defconfig/omap4-panda-es

Build: uImage:
    Pass (14/14): omap1_defconfig, omap1_defconfig_1510innovator_only,
		  omap1_defconfig_5912osk_only, omap2plus_defconfig,
		  omap2plus_defconfig_2430sdp_only,
		  omap2plus_defconfig_cpupm, omap2plus_defconfig_no_pm,
		  omap2plus_defconfig_n800_only_a,
		  omap2plus_defconfig_n800_multi_omap2xxx,
		  omap2plus_defconfig_omap2_4_only,
		  omap2plus_defconfig_omap3_4_only,
		  rmk_omap3430_ldp_allnoconfig,
		  rmk_omap3430_ldp_oldconfig,
		  rmk_omap4430_sdp_allnoconfig

Boot to userspace:
    skip ( 1/ 1): 5912osk
    Pass (11/11): 2430sdp, 3517evm, 3530es3beagle, 3730beaglexm,
		  37xxevm, 4430es2panda, 4460pandaes, am335xbone,
		  am335xbonelt, cmt3517, 4460varsomom

PM: chip retention via suspend:
    FAIL ( 3/ 7): 2430sdp, 4430es2panda, 4460varsomom
    Pass ( 4/ 7): 3530es3beagle, 3730beaglexm, 37xxevm, 4460pandaes

PM: chip retention via dynamic idle:
    FAIL ( 4/ 7): 2430sdp, 4430es2panda, 4460pandaes, 4460varsomom
    Pass ( 3/ 7): 3530es3beagle, 3730beaglexm, 37xxevm

PM: chip off except CORE via suspend:
    Pass ( 1/ 1): 3730beaglexm

PM: chip off except CORE via dynamic idle:
    Pass ( 1/ 1): 3730beaglexm

PM: chip off via suspend:
    FAIL ( 3/ 5): 4430es2panda, 4460pandaes, 4460varsomom
    Pass ( 2/ 5): 3530es3beagle, 37xxevm

PM: chip off via dynamic idle:
    FAIL ( 3/ 5): 4430es2panda, 4460pandaes, 4460varsomom
    Pass ( 2/ 5): 3530es3beagle, 37xxevm


vmlinux object size
(delta in bytes from test_v3.11 (6e4664525b1db28f8c4e1130957f70a94c19213e)):
   text     data      bss    total  kernel
 +39515    +1500      +56   +41071  omap1_defconfig
 +37048    +1436      +56   +38540  omap1_defconfig_1510innovator_only
 +38579    +1500      +88   +40167  omap1_defconfig_5912osk_only
+237402   +47344     +760  +285506  omap2plus_defconfig
-245280   -65736    -8488  -319504  omap2plus_defconfig_2430sdp_only
+241222   +47120     +696  +289038  omap2plus_defconfig_cpupm
+3314252  +272060  +5365880  +8952192  omap2plus_defconfig_n800_multi_omap2xxx
+3282652  +234764  +5365840  +8883256  omap2plus_defconfig_n800_only_a
+242382   +49736     +824  +292942  omap2plus_defconfig_no_pm
+305085   +99792    +4408  +409285  omap2plus_defconfig_omap2_4_only
+292422   +98536    +3960  +394918  omap2plus_defconfig_omap3_4_only
 +34044     -452    +2524   +36116  rmk_omap3430_ldp_allnoconfig
 +42173     +412    -1152   +41433  rmk_omap3430_ldp_oldconfig
 +33264    +1892     -732   +34424  rmk_omap4430_sdp_allnoconfig

The large deltas associated with the N800 configs are due to a switchover 
to seedconfig-generated Kconfigs - the name changed.  Something is not 
right with the 2430sdp_only config; that should show a size increase 
similar to the other OMAP2 kconfigs - will look into it.


Boot-time memory difference
(delta in bytes from test_v3.11 (6e4664525b1db28f8c4e1130957f70a94c19213e))
  avail  rsrvd   high  freed  board          kconfig
 16376k -16376k      .      .  2420n800       omap2plus_defconfig_n800_only_a
  -280k   280k      .    12k  2430sdp        omap2plus_defconfig
  -280k   280k      .    12k  3517evm        omap2plus_defconfig
  -280k   280k      .    12k  3530es3beagle  omap2plus_defconfig
  -280k   280k      .    12k  3730beaglexm   omap2plus_defconfig
  -280k   280k      .    12k  37xxevm        omap2plus_defconfig
  -276k   276k      .    12k  4430es2panda   omap2plus_defconfig
  -276k   276k      .    12k  4460pandaes    omap2plus_defconfig
    24k   -24k      .   -32k  am335xbone     omap2plus_defconfig_am33xx_only
  -288k   288k      .    12k  am335xbonelt   omap2plus_defconfig_am33xx_only

The 16MB difference in the N800 boot memory usage is caused by disabling 
CMA in the config here.

Nice job everyone - this is the first -rc1 in a while where it looks like 
there's no need to run around trying to deal with post-merge window boot 
regressions.
