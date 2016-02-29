From: Paul Walmsley <paul@pwsan.com>
Subject: OMAP baseline test results for v4.5-rc6
Date: Mon, 29 Feb 2016 01:32:03 +0000 (UTC)
Message-ID: <alpine.DEB.2.02.1602290131070.15643@utopia.booyaka.com>
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


Here are some basic OMAP test results for Linux v4.5-rc6.
Logs and other details at:

    http://www.pwsan.com/omap/testlogs/test_v4.5-rc6/20160228162516/


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
(delta in bytes from test_v4.5-rc5 (81f70ba233d5f660e1ea5fe23260ee323af5d53a)):
   text     data      bss    total  kernel
  +1756     +128      +32    +1916  omap1_defconfig
  +1756     +128      +32    +1916  omap1_defconfig_1510innovator_only
  +1764     +128      +32    +1924  omap1_defconfig_5912osk_only
  +1860     +160     +256    +2276  multi_v7_defconfig
  +2240     +192        0    +2432  omap2plus_defconfig
  +1792     +192      +32    +2016  omap2plus_defconfig_2430sdp_only
  +2168     +192        0    +2360  omap2plus_defconfig_am33xx_only
  +2168     +192        0    +2360  omap2plus_defconfig_am43xx_only
  +2176     +192        0    +2368  omap2plus_defconfig_cpupm
  +2168     +192        0    +2360  omap2plus_defconfig_dra7xx_only
   +688     +192        0     +880  omap2plus_defconfig_n800_multi_omap2xxx
  +1196     +128      +32    +1356  omap2plus_defconfig_n800_only_a
  +2164     +192        0    +2356  omap2plus_defconfig_no_pm
  +2092     +192        0    +2284  omap2plus_defconfig_omap2_4_only
  +2252     +192        0    +2444  omap2plus_defconfig_omap3_4_only
  +2168     +192        0    +2360  omap2plus_defconfig_omap5_only
  +1772     +192        0    +1964  omap2plus_defconfig_ti81xx_only
   +632        0     -128     +504  rmk_omap3430_ldp_allnoconfig
  +1720        0        0    +1720  rmk_omap3430_ldp_oldconfig
   +536        0     -128     +408  rmk_omap4430_sdp_allnoconfig
  +1544        0        0    +1544  rmk_omap4430_sdp_oldconfig

Boot-time memory difference
(delta in bytes from test_v4.5-rc5 (81f70ba233d5f660e1ea5fe23260ee323af5d53a))
  avail  rsrvd   high  freed  board          kconfig
  (no differences)
