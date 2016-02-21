From: Paul Walmsley <paul@pwsan.com>
Subject: OMAP baseline test results for v4.5-rc5
Date: Sun, 21 Feb 2016 04:46:29 +0000 (UTC)
Message-ID: <alpine.DEB.2.02.1602210445470.3418@utopia.booyaka.com>
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


Here are some basic OMAP test results for Linux v4.5-rc5.
Logs and other details at:

    http://www.pwsan.com/omap/testlogs/test_v4.5-rc5/20160220201503/


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
    FAIL ( 1/18): cmt3517

PM: chip retention via suspend:
    FAIL ( 7/11): am335xbonelt, 4430es2panda, 4460pandaes,
		  4460varsomom, 37xxevm, 2430sdp, 5430es2uevm
    Pass ( 4/11): 3530es3beagle, 3530es31beagle, 3730beaglexm,
		  3730es12beaglexm

PM: chip retention via dynamic idle:
    FAIL ( 9/11): am335xbonelt, 4430es2panda, 4460pandaes,
		  4460varsomom, 37xxevm, 3530es3beagle, 3530es31beagle,
		  2430sdp, 5430es2uevm
    Pass ( 2/11): 3730beaglexm, 3730es12beaglexm

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
    (none)

Obsolete Kconfig symbols:
    FAIL ( 3/21): omap1_defconfig, omap2plus_defconfig,
		  multi_v7_defconfig


vmlinux object size
(delta in bytes from test_v4.5-rc4 (18558cae0272f8fd9647e69d3fec1565a7949865)):
   text     data      bss    total  kernel
   +896      +64        0     +960  omap1_defconfig
   +896      +64        0     +960  omap1_defconfig_1510innovator_only
   +888      +96        0     +984  omap1_defconfig_5912osk_only
  +1588     +256        0    +1844  multi_v7_defconfig
 +38696     +224        0   +38920  omap2plus_defconfig
  +1100     +192        0    +1292  omap2plus_defconfig_2430sdp_only
 +38632     +224        0   +38856  omap2plus_defconfig_am33xx_only
 +38696     +224        0   +38920  omap2plus_defconfig_am43xx_only
 +38696     +224        0   +38920  omap2plus_defconfig_cpupm
 +38632     +224        0   +38856  omap2plus_defconfig_dra7xx_only
   +988     +160        0    +1148  omap2plus_defconfig_n800_multi_omap2xxx
   +860     +160        0    +1020  omap2plus_defconfig_n800_only_a
 +35952     +224        0   +36176  omap2plus_defconfig_no_pm
 +38632     +192        0   +38824  omap2plus_defconfig_omap2_4_only
 +42728     +192        0   +42920  omap2plus_defconfig_omap3_4_only
 +38632     +192        0   +38824  omap2plus_defconfig_omap5_only
 +38440     +224        0   +38664  omap2plus_defconfig_ti81xx_only
   +464      +64      -92     +436  rmk_omap3430_ldp_allnoconfig
   +740     +160        0     +900  rmk_omap3430_ldp_oldconfig
   +448      +64     -108     +404  rmk_omap4430_sdp_allnoconfig
   +764     +136        0     +900  rmk_omap4430_sdp_oldconfig

Boot-time memory difference
(delta in bytes from test_v4.5-rc4 (18558cae0272f8fd9647e69d3fec1565a7949865))
  avail  rsrvd   high  freed  board          kconfig
  (no differences)
