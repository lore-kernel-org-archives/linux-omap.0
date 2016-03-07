From: Paul Walmsley <paul@pwsan.com>
Subject: OMAP baseline test results for v4.5-rc7
Date: Mon, 7 Mar 2016 16:33:38 +0000 (UTC)
Message-ID: <alpine.DEB.2.02.1603071631370.3437@utopia.booyaka.com>
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


Here are some basic OMAP test results for Linux v4.5-rc7.
Logs and other details at:

    http://www.pwsan.com/omap/testlogs/test_v4.5-rc7/20160306184516/


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
    Pass (18/18): omap2plus_defconfig, omap2plus_defconfig_am33xx_only,
		  omap2plus_defconfig_n800_only_a,
		  omap2plus_defconfig_n800_multi_omap2xxx,
		  omap2plus_defconfig_2430sdp_only,
		  omap2plus_defconfig_cpupm, omap2plus_defconfig_no_pm,
		  omap2plus_defconfig_omap2_4_only,
		  omap2plus_defconfig_omap3_4_only,
		  omap2plus_defconfig_omap5_only,
		  omap2plus_defconfig_dra7xx_only,
		  omap2plus_defconfig_am43xx_only,
		  omap2plus_defconfig_ti81xx_only,
		  rmk_omap3430_ldp_oldconfig,
		  rmk_omap3430_ldp_allnoconfig,
		  rmk_omap4430_sdp_oldconfig,
		  rmk_omap4430_sdp_allnoconfig, multi_v7_defconfig

Build warnings from toolchain: uImage:
    (none)

Build warnings from toolchain: uImage+dtb:
    (none)

Build warnings from toolchain: zImage:
    FAIL ( 1/18): multi_v7_defconfig

Boot to userspace:
    FAIL ( 1/18): 2430sdp
    skip ( 3/18): 5912osk, 3517evm, 5430es2sbct54
    Pass (14/18): am335xbonelt, am437xsk, am335xbone, 4430es2panda,
		  4460pandaes, 4460varsomom, 37xxevm, 3530es3beagle,
		  3530es31beagle, 3730beaglexm, 3730es12beaglexm,
		  cmt3517, 5430es2uevm, 2420n800

Kernel warnings during boot to userspace:
    FAIL ( 2/18): 4430es2panda, cmt3517

PM: chip retention via suspend:
    FAIL ( 6/11): am335xbonelt, 4430es2panda, 4460varsomom, 37xxevm,
		  2430sdp, 5430es2uevm
    Pass ( 5/11): 4460pandaes, 3530es3beagle, 3530es31beagle,
		  3730beaglexm, 3730es12beaglexm

PM: chip retention via dynamic idle:
    FAIL ( 8/11): am335xbonelt, 4430es2panda, 4460varsomom, 37xxevm,
		  3530es3beagle, 3530es31beagle, 2430sdp, 5430es2uevm
    Pass ( 3/11): 4460pandaes, 3730beaglexm, 3730es12beaglexm

PM: chip off (except CORE, due to errata) via suspend:
    Pass ( 1/ 1): 3730beaglexm

PM: chip off (except CORE, due to errata) via dynamic idle:
    Pass ( 1/ 1): 3730beaglexm

PM: chip off via suspend:
    FAIL ( 2/ 4): 37xxevm, 3530es3beagle
    Pass ( 2/ 4): 3530es31beagle, 3730es12beaglexm

PM: chip off via dynamic idle:
    FAIL ( 3/ 4): 37xxevm, 3530es3beagle, 3530es31beagle
    Pass ( 1/ 4): 3730es12beaglexm

Kernel warnings during PM test:
    FAIL ( 1/18): 4430es2panda

Obsolete Kconfig symbols:
    FAIL ( 3/21): omap1_defconfig, omap2plus_defconfig,
		  multi_v7_defconfig


vmlinux object size
(delta in bytes from test_v4.5-rc6 (fc77dbd34c5c99bce46d40a2491937c3bcbd10af)):
   text     data      bss    total  kernel
  +1072        0        0    +1072  omap1_defconfig
  +1072        0        0    +1072  omap1_defconfig_1510innovator_only
  +1096        0        0    +1096  omap1_defconfig_5912osk_only
   +766        0        0     +766  multi_v7_defconfig
   -158        0      +64      -94  omap2plus_defconfig
  +4742       +8        0    +4750  omap2plus_defconfig_2430sdp_only
    -90        0      +64      -26  omap2plus_defconfig_am33xx_only
   -154        0      +64      -90  omap2plus_defconfig_am43xx_only
    -94        0      +64      -30  omap2plus_defconfig_cpupm
   -154       +8      +64      -82  omap2plus_defconfig_dra7xx_only
   +402       +8      +32     +442  omap2plus_defconfig_n800_multi_omap2xxx
   +516        0        0     +516  omap2plus_defconfig_n800_only_a
    -86       +8      +64      -14  omap2plus_defconfig_no_pm
    -94        0      +64      -30  omap2plus_defconfig_omap2_4_only
    -90        0      +64      -26  omap2plus_defconfig_omap3_4_only
    -90        0      +64      -26  omap2plus_defconfig_omap5_only
    -26       +8      +64      +46  omap2plus_defconfig_ti81xx_only
   +960        0        0     +960  rmk_omap3430_ldp_allnoconfig
   +536        0        0     +536  rmk_omap3430_ldp_oldconfig
   +960        0        0     +960  rmk_omap4430_sdp_allnoconfig
   +280        0        0     +280  rmk_omap4430_sdp_oldconfig

Boot-time memory difference
(delta in bytes from test_v4.5-rc6 (fc77dbd34c5c99bce46d40a2491937c3bcbd10af))
  avail  rsrvd   high  freed  board          kconfig
  (no differences)
