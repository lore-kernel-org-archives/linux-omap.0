From: Paul Walmsley <paul@pwsan.com>
Subject: OMAP baseline test results for v4.4-rc1
Date: Sun, 10 Jan 2016 04:24:24 +0000 (UTC)
Message-ID: <alpine.DEB.2.02.1601100423580.21890@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: linux-omap@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org, kernel-build-reports@lists.linaro.org
List-Id: linux-omap@vger.kernel.org


Here are some basic OMAP test results for Linux v4.4-rc1.
Logs and other details at:

    http://www.pwsan.com/omap/testlogs/test_v4.4-rc1/20151219210752/


Test summary
------------

Build: uImage:
    Pass ( 3/ 3): omap1_defconfig, omap1_defconfig_1510innovator_only,
		  omap1_defconfig_5912osk_only

Build: uImage+dtb:
    Pass (13/13): omap2plus_defconfig_am33xx_only/am335x-bone,
		  omap2plus_defconfig/omap4-panda,
		  omap2plus_defconfig/omap4-panda-es,
		  omap2plus_defconfig/omap4-var-stk-om44,
		  omap2plus_defconfig/omap3-evm-37xx,
		  omap2plus_defconfig_n800_only_a/omap2420-n800,
		  omap2plus_defconfig/omap2430-sdp,
		  omap2plus_defconfig/am3517-evm,
		  omap2plus_defconfig/omap3-beagle,
		  omap2plus_defconfig/omap3-beagle-xm,
		  omap2plus_defconfig/omap3-sbc-t3517,
		  omap2plus_defconfig/omap5-uevm,
		  omap2plus_defconfig/omap5-sbc-t54

Build: zImage:
    Pass (17/17): omap2plus_defconfig, omap2plus_defconfig_am33xx_only,
		  omap2plus_defconfig_n800_only_a,
		  omap2plus_defconfig_n800_multi_omap2xxx,
		  omap2plus_defconfig_2430sdp_only,
		  omap2plus_defconfig_cpupm, omap2plus_defconfig_no_pm,
		  omap2plus_defconfig_omap2_4_only,
		  omap2plus_defconfig_omap3_4_only,
		  omap2plus_defconfig_omap5_only,
		  omap2plus_defconfig_dra7xx_only,
		  omap2plus_defconfig_am43xx_only,
		  rmk_omap3430_ldp_oldconfig,
		  rmk_omap3430_ldp_allnoconfig,
		  rmk_omap4430_sdp_oldconfig,
		  rmk_omap4430_sdp_allnoconfig, multi_v7_defconfig

Build warnings from toolchain: uImage:
    FAIL ( 3/ 3): omap1_defconfig, omap1_defconfig_1510innovator_only,
		  omap1_defconfig_5912osk_only

Build warnings from toolchain: uImage+dtb:
    (none)

Build warnings from toolchain: zImage:
    FAIL (13/17): omap2plus_defconfig, omap2plus_defconfig_am33xx_only,
		  omap2plus_defconfig_2430sdp_only,
		  omap2plus_defconfig_cpupm, omap2plus_defconfig_no_pm,
		  omap2plus_defconfig_omap2_4_only,
		  omap2plus_defconfig_omap3_4_only,
		  omap2plus_defconfig_omap5_only,
		  omap2plus_defconfig_dra7xx_only,
		  omap2plus_defconfig_am43xx_only,
		  rmk_omap3430_ldp_allnoconfig,
		  rmk_omap4430_sdp_allnoconfig, multi_v7_defconfig

Boot to userspace:
    FAIL ( 1/18): 2430sdp
    skip ( 3/18): 5912osk, 3517evm, 5430es2sbct54
    Pass (14/18): 2420n800, am335xbonelt, am335xbone, 4430es2panda,
		  4460pandaes, 4460varsomom, 37xxevm, 3530es3beagle,
		  3530es31beagle, 3730beaglexm, 3730es12beaglexm,
		  cmt3517, 5430es2uevm, 2420n800

Kernel warnings during boot to userspace:
    FAIL ( 2/18): 4430es2panda, cmt3517

PM: chip retention via suspend:
    FAIL ( 7/11): am335xbonelt, 4430es2panda, 4460varsomom, 37xxevm,
		  3730es12beaglexm, 2430sdp, 5430es2uevm
    Pass ( 4/11): 4460pandaes, 3530es3beagle, 3530es31beagle,
		  3730beaglexm

PM: chip retention via dynamic idle:
    FAIL ( 9/11): am335xbonelt, 4430es2panda, 4460varsomom, 37xxevm,
		  3530es3beagle, 3530es31beagle, 3730es12beaglexm,
		  2430sdp, 5430es2uevm
    Pass ( 2/11): 4460pandaes, 3730beaglexm

PM: chip off (except CORE, due to errata) via suspend:
    Pass ( 1/ 1): 3730beaglexm

PM: chip off (except CORE, due to errata) via dynamic idle:
    Pass ( 1/ 1): 3730beaglexm

PM: chip off via suspend:
    FAIL ( 3/ 4): 37xxevm, 3530es3beagle, 3730es12beaglexm
    Pass ( 1/ 4): 3530es31beagle

PM: chip off via dynamic idle:
    FAIL ( 4/ 4): 37xxevm, 3530es3beagle, 3530es31beagle,
		  3730es12beaglexm

Kernel warnings during PM test:
    FAIL ( 1/18): 4430es2panda

Obsolete Kconfig symbols:
    FAIL ( 3/20): omap1_defconfig, omap2plus_defconfig,
		  multi_v7_defconfig


vmlinux object size
(delta in bytes from test_v4.3 (6a13feb9c82803e2b815eca72fa7a9f5561d7861)):
   text     data      bss    total  kernel
 +20795     +440        0   +21235  omap1_defconfig
 +20981    +2200      +32   +23213  omap1_defconfig_1510innovator_only
 +26133    +2304      +32   +28469  omap1_defconfig_5912osk_only
+260890   +38768     +384  +300042  multi_v7_defconfig
 +63373    +6128      +56   +69557  omap2plus_defconfig
 +65843    +6128      +40   +72011  omap2plus_defconfig_2430sdp_only
 +70053    +6456     +120   +76629  omap2plus_defconfig_am33xx_only
 +74386    +6680     +120   +81186  omap2plus_defconfig_am43xx_only
 +63373    +6192      +56   +69621  omap2plus_defconfig_cpupm
 +69710    +6640     +184   +76534  omap2plus_defconfig_dra7xx_only
 +18888    +1424     +220   +20532  omap2plus_defconfig_n800_multi_omap2xxx
 +17032    +1344       -4   +18372  omap2plus_defconfig_n800_only_a
 +63311    +6064      +56   +69431  omap2plus_defconfig_no_pm
 +74578    +6648      +56   +81282  omap2plus_defconfig_omap2_4_only
 +68686    +6648     +120   +75454  omap2plus_defconfig_omap3_4_only
 +74658    +6808      +56   +81522  omap2plus_defconfig_omap5_only
  +6100     +476     -696    +5880  rmk_omap3430_ldp_allnoconfig
  +7668    +2224      -88    +9804  rmk_omap3430_ldp_oldconfig
  +8352     +668    -1400    +7620  rmk_omap4430_sdp_allnoconfig
 +15875    +2232      -64   +18043  rmk_omap4430_sdp_oldconfig

Boot-time memory difference
(delta in bytes from test_v4.3 (6a13feb9c82803e2b815eca72fa7a9f5561d7861))
  avail  rsrvd   high  freed  board          kconfig
   -20k    20k      .      .  2420n800       omap2plus_defconfig_n800_only_a
   -68k    68k      .      .  2430sdp        omap2plus_defconfig
   -68k    68k      .     4k  3530es31beagle omap2plus_defconfig
   -68k    68k      .     4k  3530es3beagle  omap2plus_defconfig
   -68k    68k      .     4k  3730beaglexm   omap2plus_defconfig
   -68k    68k      .     4k  3730es12beaglexmomap2plus_defconfig
   -68k    68k      .     4k  37xxevm        omap2plus_defconfig
   -68k    68k      .     4k  4430es2panda   omap2plus_defconfig
   -60k    60k -8192k     4k  4460pandaes    omap2plus_defconfig
   -60k    60k -8192k     4k  4460varsomom   omap2plus_defconfig
   -68k    68k -8192k     4k  5430es2uevm    omap2plus_defconfig
   -68k    68k      .      .  am335xbone     omap2plus_defconfig_am33xx_only
   -68k    68k      .     4k  am335xbonelt   omap2plus_defconfig
