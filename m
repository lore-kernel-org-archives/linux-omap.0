From: Paul Walmsley <paul@pwsan.com>
Subject: OMAP baseline test results for v4.1
Date: Fri, 10 Jul 2015 21:16:41 +0000 (UTC)
Message-ID: <alpine.DEB.2.02.1507102113530.16508@utopia.booyaka.com>
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


Here are some basic OMAP test results for Linux v4.1.
Logs and other details at:

    http://www.pwsan.com/omap/testlogs/test_v4.1/20150626170101/


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
    FAIL (14/17): omap2plus_defconfig, omap2plus_defconfig_am33xx_only,
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
		  rmk_omap4430_sdp_oldconfig

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
    FAIL ( 6/11): am335xbonelt, 4430es2panda, 4460varsomom,
		  3730es12beaglexm, 2430sdp, 5430es2uevm
    Pass ( 5/11): 4460pandaes, 37xxevm, 3530es3beagle, 3530es31beagle,
		  3730beaglexm

PM: chip retention via dynamic idle:
    FAIL ( 6/11): am335xbonelt, 4430es2panda, 4460varsomom,
		  3730es12beaglexm, 2430sdp, 5430es2uevm
    Pass ( 5/11): 4460pandaes, 37xxevm, 3530es3beagle, 3530es31beagle,
		  3730beaglexm

PM: chip off (except CORE, due to errata) via suspend:
    Pass ( 1/ 1): 3730beaglexm

PM: chip off (except CORE, due to errata) via dynamic idle:
    Pass ( 1/ 1): 3730beaglexm

PM: chip off via suspend:
    FAIL ( 2/ 4): 37xxevm, 3730es12beaglexm
    Pass ( 2/ 4): 3530es3beagle, 3530es31beagle

PM: chip off via dynamic idle:
    FAIL ( 2/ 4): 37xxevm, 3730es12beaglexm
    Pass ( 2/ 4): 3530es3beagle, 3530es31beagle

Kernel warnings during PM test:
    FAIL ( 1/17): 4430es2panda

Obsolete Kconfig symbols:
    FAIL ( 1/20): multi_v7_defconfig


vmlinux object size
(delta in bytes from test_v4.1-rc8 (0f57d86787d8b1076ea8f9cbdddda2a46d534a27)):
   text     data      bss    total  kernel
      0        0        0        0  omap1_defconfig
      0        0        0        0  omap1_defconfig_1510innovator_only
      0       +8        0       +8  omap1_defconfig_5912osk_only
    -32        0        0      -32  multi_v7_defconfig
    +64        0        0      +64  omap2plus_defconfig
    +32        0        0      +32  omap2plus_defconfig_2430sdp_only
    +64        0        0      +64  omap2plus_defconfig_am33xx_only
    +64        0        0      +64  omap2plus_defconfig_am43xx_only
    +64        0        0      +64  omap2plus_defconfig_cpupm
    +64        0        0      +64  omap2plus_defconfig_dra7xx_only
    -64        0        0      -64  omap2plus_defconfig_n800_multi_omap2xxx
    -32        0        0      -32  omap2plus_defconfig_n800_only_a
   +128        0        0     +128  omap2plus_defconfig_no_pm
   +128        0        0     +128  omap2plus_defconfig_omap2_4_only
   +128        0        0     +128  omap2plus_defconfig_omap3_4_only
   +128        0        0     +128  omap2plus_defconfig_omap5_only
   -104        0       +8      -96  rmk_omap3430_ldp_allnoconfig
    -96        0        0      -96  rmk_omap3430_ldp_oldconfig
   -128        0      +32      -96  rmk_omap4430_sdp_allnoconfig
    -72        0        0      -72  rmk_omap4430_sdp_oldconfig

Boot-time memory difference
(delta in bytes from test_v4.1-rc8 (0f57d86787d8b1076ea8f9cbdddda2a46d534a27))
  avail  rsrvd   high  freed  board          kconfig
 -2042188k -53936k -1301500k      .  5430es2sbct54  omap2plus_defconfig


Looks like something isn't right with the SD boot on 5430es2sbct54, and a 
recent attempt to boot a kernel that mounted root fine from SD in the past 
has failed now.  So skipping further tests until I have the chance to 
figure out what's going on.
