From: Paul Walmsley <paul@pwsan.com>
Subject: OMAP baseline test results for v4.2-rc8
Date: Sun, 13 Sep 2015 23:05:01 +0000 (UTC)
Message-ID: <alpine.DEB.2.02.1509132304140.1998@utopia.booyaka.com>
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


Here are some basic OMAP test results for Linux v4.2-rc8.
Logs and other details at:

    http://www.pwsan.com/omap/testlogs/test_v4.2-rc8/20150825101923/


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
    (none)

Build warnings from toolchain: uImage+dtb:
    (none)

Build warnings from toolchain: zImage:
    FAIL (10/17): omap2plus_defconfig, omap2plus_defconfig_am33xx_only,
		  omap2plus_defconfig_2430sdp_only,
		  omap2plus_defconfig_cpupm, omap2plus_defconfig_no_pm,
		  omap2plus_defconfig_omap2_4_only,
		  omap2plus_defconfig_omap3_4_only,
		  omap2plus_defconfig_omap5_only,
		  omap2plus_defconfig_dra7xx_only,
		  omap2plus_defconfig_am43xx_only

Boot to userspace:
    FAIL ( 1/17): 2430sdp
    skip ( 3/17): 5912osk, 3517evm, 5430es2sbct54
    Pass (13/17): am335xbonelt, am335xbone, 4430es2panda, 4460pandaes,
		  4460varsomom, 37xxevm, 3530es3beagle, 3530es31beagle,
		  3730beaglexm, 3730es12beaglexm, cmt3517, 5430es2uevm,
		  2420n800

Kernel warnings during boot to userspace:
    FAIL ( 2/17): 4430es2panda, cmt3517

PM: chip retention via suspend:
    FAIL ( 6/11): am335xbonelt, 4430es2panda, 4460varsomom, 37xxevm,
		  2430sdp, 5430es2uevm
    Pass ( 5/11): 4460pandaes, 3530es3beagle, 3530es31beagle,
		  3730beaglexm, 3730es12beaglexm

PM: chip retention via dynamic idle:
    FAIL ( 6/11): am335xbonelt, 4430es2panda, 4460varsomom, 37xxevm,
		  2430sdp, 5430es2uevm
    Pass ( 5/11): 4460pandaes, 3530es3beagle, 3530es31beagle,
		  3730beaglexm, 3730es12beaglexm

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
    FAIL ( 1/17): 4430es2panda

Obsolete Kconfig symbols:
    FAIL ( 1/20): multi_v7_defconfig


vmlinux object size
(delta in bytes from test_v4.2-rc7 (2c6625cd545bdd66acff14f3394865d43920a5c7)):
   text     data      bss    total  kernel
 -12694        0        0   -12694  omap1_defconfig
 -16790        0        0   -16790  omap1_defconfig_1510innovator_only
 -12726      -32        0   -12758  omap1_defconfig_5912osk_only
  -1255        0        0    -1255  multi_v7_defconfig
  -1371      -64        0    -1435  omap2plus_defconfig
  -1443      -32        0    -1475  omap2plus_defconfig_2430sdp_only
  -1459      -64        0    -1523  omap2plus_defconfig_am33xx_only
  -1435      -64        0    -1499  omap2plus_defconfig_am43xx_only
  -1371      -64        0    -1435  omap2plus_defconfig_cpupm
  -1371      -64        0    -1435  omap2plus_defconfig_dra7xx_only
  -1047        0        0    -1047  omap2plus_defconfig_n800_multi_omap2xxx
    -95        0        0      -95  omap2plus_defconfig_n800_only_a
  -1371      -64        0    -1435  omap2plus_defconfig_no_pm
  -1371      -64        0    -1435  omap2plus_defconfig_omap2_4_only
  -1375      -64        0    -1439  omap2plus_defconfig_omap3_4_only
  -1371      -64        0    -1435  omap2plus_defconfig_omap5_only
      0        0        0        0  rmk_omap3430_ldp_allnoconfig
 -12278      -64        0   -12342  rmk_omap3430_ldp_oldconfig
    +68        0      -16      +52  rmk_omap4430_sdp_allnoconfig
 -12199      -56        0   -12255  rmk_omap4430_sdp_oldconfig

Boot-time memory difference
(delta in bytes from test_v4.2-rc7 (2c6625cd545bdd66acff14f3394865d43920a5c7))
  avail  rsrvd   high  freed  board          kconfig
      .      .      .     4k  3530es31beagle omap2plus_defconfig
      .      .      .     4k  3530es3beagle  omap2plus_defconfig
      .      .      .     4k  3730beaglexm   omap2plus_defconfig
      .      .      .     4k  3730es12beaglexmomap2plus_defconfig
      .      .      .     4k  37xxevm        omap2plus_defconfig
      .      .      .     4k  4430es2panda   omap2plus_defconfig
      .      .      .     4k  4460pandaes    omap2plus_defconfig
     4k    -4k      .     4k  4460varsomom   omap2plus_defconfig
      .      .      .     4k  5430es2uevm    omap2plus_defconfig
