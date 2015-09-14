From: Paul Walmsley <paul@pwsan.com>
Subject: OMAP baseline test results for v4.3-rc1
Date: Mon, 14 Sep 2015 00:40:03 +0000 (UTC)
Message-ID: <alpine.DEB.2.02.1509140035120.1998@utopia.booyaka.com>
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


Here are some basic OMAP test results for Linux v4.3-rc1.
Logs and other details at:

    http://www.pwsan.com/omap/testlogs/test_v4.3-rc1/20150913170656/


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
    FAIL ( 5/17): 4430es2panda, 4460pandaes, 4460varsomom, 2430sdp,
		  5430es2uevm
    skip ( 3/17): 5912osk, 3517evm, 5430es2sbct54
    Pass ( 9/17): am335xbonelt, am335xbone, 37xxevm, 3530es3beagle,
		  3530es31beagle, 3730beaglexm, 3730es12beaglexm,
		  cmt3517, 2420n800

Kernel warnings during boot to userspace:
    FAIL ( 4/17): 4430es2panda, 4460pandaes, 4460varsomom, cmt3517

PM: chip retention via suspend:
    FAIL ( 7/11): am335xbonelt, 4430es2panda, 4460pandaes,
		  4460varsomom, 37xxevm, 2430sdp, 5430es2uevm
    Pass ( 4/11): 3530es3beagle, 3530es31beagle, 3730beaglexm,
		  3730es12beaglexm

PM: chip retention via dynamic idle:
    FAIL ( 7/11): am335xbonelt, 4430es2panda, 4460pandaes,
		  4460varsomom, 37xxevm, 2430sdp, 5430es2uevm
    Pass ( 4/11): 3530es3beagle, 3530es31beagle, 3730beaglexm,
		  3730es12beaglexm

PM: chip off (except CORE, due to errata) via suspend:
    Pass ( 1/ 1): 3730beaglexm

PM: chip off (except CORE, due to errata) via dynamic idle:
    Pass ( 1/ 1): 3730beaglexm

PM: chip off via suspend:
    FAIL ( 1/ 4): 37xxevm
    Pass ( 3/ 4): 3530es3beagle, 3530es31beagle, 3730es12beaglexm

PM: chip off via dynamic idle:
    FAIL ( 1/ 4): 37xxevm
    Pass ( 3/ 4): 3530es3beagle, 3530es31beagle, 3730es12beaglexm

Kernel warnings during PM test:
    FAIL ( 3/17): 4430es2panda, 4460pandaes, 4460varsomom

Obsolete Kconfig symbols:
    FAIL ( 2/20): omap2plus_defconfig, multi_v7_defconfig


vmlinux object size
(delta in bytes from test_v4.2 (64291f7db5bd8150a74ad2036f1037e6a0428df2)):
   text     data      bss    total  kernel
+289901   +18816    +2496  +311213  omap1_defconfig
+288849   +18792    +2496  +310137  omap1_defconfig_1510innovator_only
+284789   +18784    +2496  +306069  omap1_defconfig_5912osk_only
+490573    +6536   +14016  +511125  multi_v7_defconfig
+301942   +25296   +39016  +366254  omap2plus_defconfig
+261223   +19984   +38824  +320031  omap2plus_defconfig_2430sdp_only
+296672   +25592   +39016  +361280  omap2plus_defconfig_am33xx_only
+297648   +25976   +38952  +362576  omap2plus_defconfig_am43xx_only
+306038   +25304   +39016  +370358  omap2plus_defconfig_cpupm
+302160   +25656   +39080  +366896  omap2plus_defconfig_dra7xx_only
+287741   +18024    +4520  +310285  omap2plus_defconfig_n800_multi_omap2xxx
+284805   +17672    +4520  +306997  omap2plus_defconfig_n800_only_a
+306078   +26960   +38888  +371926  omap2plus_defconfig_no_pm
+303422   +26128   +39016  +368566  omap2plus_defconfig_omap2_4_only
+300236   +22416   +39016  +361668  omap2plus_defconfig_omap3_4_only
+302176   +25784   +39016  +366976  omap2plus_defconfig_omap5_only
 +35552   +15076    +1248   +51876  rmk_omap3430_ldp_allnoconfig
+313000   +24864    +4700  +342564  rmk_omap3430_ldp_oldconfig
 +39004   +16840     +284   +56128  rmk_omap4430_sdp_allnoconfig
+322935   +23336    +4956  +351227  rmk_omap4430_sdp_oldconfig

Boot-time memory difference
(delta in bytes from test_v4.2 (64291f7db5bd8150a74ad2036f1037e6a0428df2))
  avail  rsrvd   high  freed  board          kconfig
  -304k   304k      .    20k  2420n800       omap2plus_defconfig_n800_only_a
 -1388k   364k      .      .  2430sdp        omap2plus_defconfig
 -1388k   364k      .    16k  3530es31beagle omap2plus_defconfig
 -1388k   364k      .    16k  3530es3beagle  omap2plus_defconfig
 -1388k   364k      .    16k  3730beaglexm   omap2plus_defconfig
 -1388k   364k      .    16k  3730es12beaglexmomap2plus_defconfig
 -1388k   364k      .    16k  37xxevm        omap2plus_defconfig
 -1392k   368k      .  -436k  4430es2panda   omap2plus_defconfig
 -1388k   364k -1024k  -436k  4460pandaes    omap2plus_defconfig
 -1392k   368k -1024k  -436k  4460varsomom   omap2plus_defconfig
 -1392k   368k -1024k  -436k  5430es2uevm    omap2plus_defconfig
  -368k   368k      .    24k  am335xbone     omap2plus_defconfig_am33xx_only
 -1384k   360k      .    16k  am335xbonelt   omap2plus_defconfig


Over a megabyte of additional runtime memory usage.  OMAP4 & 5 boards 
are no longer booting to userspace.
