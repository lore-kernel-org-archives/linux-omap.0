From: Paul Walmsley <paul@pwsan.com>
Subject: OMAP baseline test results for v4.5-rc3
Date: Mon, 8 Feb 2016 02:51:06 +0000 (UTC)
Message-ID: <alpine.DEB.2.02.1602080248360.2182@utopia.booyaka.com>
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


Here are some basic OMAP test results for Linux v4.5-rc3.
Logs and other details at:

    http://www.pwsan.com/omap/testlogs/test_v4.5-rc3/20160207175949/


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
    FAIL ( 1/17): multi_v7_defconfig

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
    FAIL ( 3/20): omap1_defconfig, omap2plus_defconfig,
		  multi_v7_defconfig


vmlinux object size
(delta in bytes from test_v4.5-rc2 (36f90b0a2ddd60823fe193a85e60ff1906c2a9b3)):
   text     data      bss    total  kernel
   +797      +64        0     +861  omap1_defconfig
   +761      +64        0     +825  omap1_defconfig_1510innovator_only
   +765      +64        0     +829  omap1_defconfig_5912osk_only
  +7514     +352      +64    +7930  multi_v7_defconfig
  +6486     +416        0    +6902  omap2plus_defconfig
  +6362     +160        0    +6522  omap2plus_defconfig_2430sdp_only
  +2518     +288        0    +2806  omap2plus_defconfig_am33xx_only
  +6610     +288        0    +6898  omap2plus_defconfig_am43xx_only
  +6486     +416        0    +6902  omap2plus_defconfig_cpupm
  +6674     +288        0    +6962  omap2plus_defconfig_dra7xx_only
  +1332     +192        0    +1524  omap2plus_defconfig_n800_multi_omap2xxx
  +1324     +160        0    +1484  omap2plus_defconfig_n800_only_a
  +6678     +416        0    +7094  omap2plus_defconfig_no_pm
  +6614     +256        0    +6870  omap2plus_defconfig_omap2_4_only
  +6546     +384        0    +6930  omap2plus_defconfig_omap3_4_only
  +6610     +256        0    +6866  omap2plus_defconfig_omap5_only
   -204     +224     -148     -128  rmk_omap3430_ldp_allnoconfig
  +4684     +288        0    +4972  rmk_omap3430_ldp_oldconfig
    +20      +64     -276     -192  rmk_omap4430_sdp_allnoconfig
   +396     +160        0     +556  rmk_omap4430_sdp_oldconfig

Boot-time memory difference
(delta in bytes from test_v4.5-rc2 (36f90b0a2ddd60823fe193a85e60ff1906c2a9b3))
  avail  rsrvd   high  freed  board          kconfig
 -1952k  1952k      .   844k  2420n800       omap2plus_defconfig_n800_only_a
 -1784k  1784k      .      .  2430sdp        omap2plus_defconfig
 -1784k  1784k      .   568k  3530es31beagle omap2plus_defconfig
 -1784k  1784k      .   568k  3530es3beagle  omap2plus_defconfig
 -1784k  1784k      .   568k  3730beaglexm   omap2plus_defconfig
 -1784k  1784k      .   568k  3730es12beaglexmomap2plus_defconfig
 -1784k  1784k      .   568k  37xxevm        omap2plus_defconfig
 -1784k  1784k      .   568k  4430es2panda   omap2plus_defconfig
 -1784k  1784k      .   568k  4460pandaes    omap2plus_defconfig
 -1784k  1784k      .   568k  4460varsomom   omap2plus_defconfig
 -1784k  1784k      .   568k  5430es2uevm    omap2plus_defconfig
 -2096k  2096k      .   636k  am335xbone     omap2plus_defconfig_am33xx_only
 -1784k  1784k      .   568k  am335xbonelt   omap2plus_defconfig
 -1784k  1784k      .   568k  am437xsk       omap2plus_defconfig


Troubling.  An extra ~2MB of RAM used on all boards in an -rc series 
release?
