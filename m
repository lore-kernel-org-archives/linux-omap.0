From: Paul Walmsley <paul@pwsan.com>
Subject: OMAP baseline test results for v4.1-rc5
Date: Sat, 30 May 2015 15:50:09 +0000 (UTC)
Message-ID: <alpine.DEB.2.02.1505301534250.26925@utopia.booyaka.com>
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


Here are some basic OMAP test results for Linux v4.1-rc5.
Logs and other details at:

    http://www.pwsan.com/omap/testlogs/test_v4.1-rc5/20150529162206/


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
    FAIL ( 2/17): 2430sdp, 5430es2sbct54
    skip ( 2/17): 5912osk, 3517evm
    Pass (13/17): am335xbonelt, am335xbone, 4430es2panda, 4460pandaes,
		  4460varsomom, 37xxevm, 3530es3beagle, 3530es31beagle,
		  3730beaglexm, 3730es12beaglexm, cmt3517, 5430es2uevm,
		  2420n800

Kernel warnings during boot to userspace:
    FAIL ( 2/17): 4430es2panda, cmt3517

PM: chip retention via suspend:
    FAIL ( 6/12): am335xbonelt, 4430es2panda, 4460varsomom, 2430sdp,
		  5430es2uevm, 5430es2sbct54
    Pass ( 6/12): 4460pandaes, 37xxevm, 3530es3beagle, 3530es31beagle,
		  3730beaglexm, 3730es12beaglexm

PM: chip retention via dynamic idle:
    FAIL ( 6/12): am335xbonelt, 4430es2panda, 4460varsomom, 2430sdp,
		  5430es2uevm, 5430es2sbct54
    Pass ( 6/12): 4460pandaes, 37xxevm, 3530es3beagle, 3530es31beagle,
		  3730beaglexm, 3730es12beaglexm

PM: chip off (except CORE, due to errata) via suspend:
    Pass ( 1/ 1): 3730beaglexm

PM: chip off (except CORE, due to errata) via dynamic idle:
    Pass ( 1/ 1): 3730beaglexm

PM: chip off via suspend:
    Pass ( 4/ 4): 37xxevm, 3530es3beagle, 3530es31beagle,
		  3730es12beaglexm

PM: chip off via dynamic idle:
    Pass ( 4/ 4): 37xxevm, 3530es3beagle, 3530es31beagle,
		  3730es12beaglexm

Kernel warnings during PM test:
    FAIL ( 1/17): 4430es2panda

Obsolete Kconfig symbols:
    FAIL ( 1/20): multi_v7_defconfig


vmlinux object size
(delta in bytes from test_v4.1-rc4 (e26081808edadfd257c6c9d81014e3b25e9a6118)):
   text     data      bss    total  kernel
  +1658        0        0    +1658  omap1_defconfig
  +1658        0        0    +1658  omap1_defconfig_1510innovator_only
  +1658        0        0    +1658  omap1_defconfig_5912osk_only
 +28262   +52928        0   +81190  multi_v7_defconfig
  +2678        0        0    +2678  omap2plus_defconfig
  +2130        0       -8    +2122  omap2plus_defconfig_2430sdp_only
  +2550      +64        0    +2614  omap2plus_defconfig_am33xx_only
  +2550        0        0    +2550  omap2plus_defconfig_am43xx_only
  +2678        0        0    +2678  omap2plus_defconfig_cpupm
  +2614        0        0    +2614  omap2plus_defconfig_dra7xx_only
  +1226        0        0    +1226  omap2plus_defconfig_n800_multi_omap2xxx
  +1230        0        0    +1230  omap2plus_defconfig_n800_only_a
  +2042        0        0    +2042  omap2plus_defconfig_no_pm
  +2614        0        0    +2614  omap2plus_defconfig_omap2_4_only
  +2554        0        0    +2554  omap2plus_defconfig_omap3_4_only
  +2550        0        0    +2550  omap2plus_defconfig_omap5_only
   +632        0      -80     +552  rmk_omap3430_ldp_allnoconfig
  +2078        0        0    +2078  rmk_omap3430_ldp_oldconfig
   +664        0      -80     +584  rmk_omap4430_sdp_allnoconfig
  +2978        0        0    +2978  rmk_omap4430_sdp_oldconfig

Boot-time memory difference
(delta in bytes from test_v4.1-rc4 (e26081808edadfd257c6c9d81014e3b25e9a6118))
  avail  rsrvd   high  freed  board          kconfig
    -8k     8k      .     4k  am335xbone     omap2plus_defconfig_am33xx_only


Thanks to help from Tony, Suman, Nishanth, and Tero, some of the earlier 
test failures in the v4.1-rc series have been tracked down.  The 4460 
VAR-SOM-OM was booting with an older DT file since the point in time last 
year when the DT file was renamed; this has now been fixed.  Most of the 
other failures were due to timeout problems after commit 
cc4a5fe972ad7834e8662b49b3a5fdb597e9e15e ("arm: config: 
omap2plus_defconfig: switch over to LZMA compression") which pushed the 
time interval from the point at which the "Starting kernel" message is 
emitted to the point at which the kernel starts to log serial output to 
the console over 5 seconds on many OMAP3 and earlier platforms.  From my 
point of view this commit is a mistake.  Anyone integrating a kernel into 
a consumer device will need to be sure to disable LZMA compression if 
reasonable boot times are desired.  This is not something that the vast 
majority of integrators will be aware of.

The 5430es2sbct54 is still not booting to userspace; this is on the list 
here to bisect.
