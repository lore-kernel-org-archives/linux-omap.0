From: Paul Walmsley <paul@pwsan.com>
Subject: OMAP baseline test results for v4.3-rc2
Date: Sun, 27 Sep 2015 02:18:06 +0000 (UTC)
Message-ID: <alpine.DEB.2.02.1509270217330.7947@utopia.booyaka.com>
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


Here are some basic OMAP test results for Linux v4.3-rc2.
Logs and other details at:

    http://www.pwsan.com/omap/testlogs/test_v4.3-rc2/20150920195237/


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
(delta in bytes from test_v4.3-rc1 (6ff33f3902c3b1c5d0db6b1e2c70b6d76fba357f)):
   text     data      bss    total  kernel
  +3398        0        0    +3398  omap1_defconfig
  +3422        0        0    +3422  omap1_defconfig_1510innovator_only
  +3406        0        0    +3406  omap1_defconfig_5912osk_only
  +3110      -72        0    +3038  multi_v7_defconfig
  -3238        0        0    -3238  omap2plus_defconfig
   -542        0        0     -542  omap2plus_defconfig_2430sdp_only
  -3334        0        0    -3334  omap2plus_defconfig_am33xx_only
  -3246        0        0    -3246  omap2plus_defconfig_am43xx_only
  -7334        0        0    -7334  omap2plus_defconfig_cpupm
  -7342        0        0    -7342  omap2plus_defconfig_dra7xx_only
   +874        0        0     +874  omap2plus_defconfig_n800_multi_omap2xxx
  +1046        0        0    +1046  omap2plus_defconfig_n800_only_a
  -7234        0        0    -7234  omap2plus_defconfig_no_pm
  -3242        0        0    -3242  omap2plus_defconfig_omap2_4_only
  -7278        0        0    -7278  omap2plus_defconfig_omap3_4_only
  -3246        0        0    -3246  omap2plus_defconfig_omap5_only
  +2860        0     +300    +3160  rmk_omap3430_ldp_allnoconfig
  +5370      -32        0    +5338  rmk_omap3430_ldp_oldconfig
  +3004        0     +252    +3256  rmk_omap4430_sdp_allnoconfig
  +5798        0        0    +5798  rmk_omap4430_sdp_oldconfig

Boot-time memory difference
(delta in bytes from test_v4.3-rc1 (6ff33f3902c3b1c5d0db6b1e2c70b6d76fba357f))
  avail  rsrvd   high  freed  board          kconfig
      .      .      .    -4k  2420n800       omap2plus_defconfig_n800_only_a
     4k    -4k      .      .  2430sdp        omap2plus_defconfig
      .      .      .     4k  3530es31beagle omap2plus_defconfig
      .      .      .     4k  3530es3beagle  omap2plus_defconfig
      .      .      .     4k  3730beaglexm   omap2plus_defconfig
      .      .      .     4k  3730es12beaglexmomap2plus_defconfig
      .      .      .     4k  37xxevm        omap2plus_defconfig
     8k    -8k      .    -4k  am335xbone     omap2plus_defconfig_am33xx_only
      .      .      .     4k  am335xbonelt   omap2plus_defconfig
