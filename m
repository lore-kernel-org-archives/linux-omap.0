From: Paul Walmsley <paul@pwsan.com>
Subject: OMAP baseline test results for v4.5-rc1
Date: Tue, 26 Jan 2016 07:16:28 +0000 (UTC)
Message-ID: <alpine.DEB.2.02.1601260714350.4443@utopia.booyaka.com>
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


Here are some basic OMAP test results for Linux v4.5-rc1.
Logs and other details at:

    http://www.pwsan.com/omap/testlogs/test_v4.5-rc1/20160125130134/


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
(delta in bytes from test_v4.4 (afd2ff9b7e1b367172f18ba7f693dfb62bdcb2dc)):
   text     data      bss    total  kernel
 +62177     +840    +3080   +66097  omap1_defconfig
 +63185     +840    +3048   +67073  omap1_defconfig_1510innovator_only
 +19728     +616    +3048   +23392  omap1_defconfig_5912osk_only
+587090  +106000    +4536  +697626  multi_v7_defconfig
+164152   +24212    +4600  +192964  omap2plus_defconfig
+154881   +21064    +4264  +180209  omap2plus_defconfig_2430sdp_only
+163876   +22484    +4472  +190832  omap2plus_defconfig_am33xx_only
+163900   +22292    +4536  +190728  omap2plus_defconfig_am43xx_only
+164984   +24412    +4600  +193996  omap2plus_defconfig_cpupm
+164120   +22428    +4472  +191020  omap2plus_defconfig_dra7xx_only
 +66222    +1464    +4224   +71910  omap2plus_defconfig_n800_multi_omap2xxx
 +59183     +264    +4168   +63615  omap2plus_defconfig_n800_only_a
+163124   +24028    +4472  +191624  omap2plus_defconfig_no_pm
+163912   +22324    +4536  +190772  omap2plus_defconfig_omap2_4_only
+163964   +22836    +4536  +191336  omap2plus_defconfig_omap3_4_only
+163968   +22388    +4536  +190892  omap2plus_defconfig_omap5_only
 +42252    +1512    +4444   +48208  rmk_omap3430_ldp_allnoconfig
 +72856    +1888    +3120   +77864  rmk_omap3430_ldp_oldconfig
 +42476     -280    +4044   +46240  rmk_omap4430_sdp_allnoconfig
+216371    +3912    +3456  +223739  rmk_omap4430_sdp_oldconfig

Boot-time memory difference
(delta in bytes from test_v4.4 (afd2ff9b7e1b367172f18ba7f693dfb62bdcb2dc))
  avail  rsrvd   high  freed  board          kconfig
   -60k    60k      .      .  2420n800       omap2plus_defconfig_n800_only_a
  -188k   188k      .      .  2430sdp        omap2plus_defconfig
  -192k   192k      .     4k  3530es31beagle omap2plus_defconfig
  -192k   192k      .     4k  3530es3beagle  omap2plus_defconfig
  -192k   192k      .     4k  3730beaglexm   omap2plus_defconfig
  -188k   188k      .     4k  37xxevm        omap2plus_defconfig
  -188k   188k      .     4k  4430es2panda   omap2plus_defconfig
  -188k   188k      .     4k  4460pandaes    omap2plus_defconfig
  -188k   188k      .     4k  4460varsomom   omap2plus_defconfig
  -192k   192k      .     4k  5430es2uevm    omap2plus_defconfig
  -188k   188k      .     4k  am335xbone     omap2plus_defconfig_am33xx_only
  -192k   192k      .     4k  am335xbonelt   omap2plus_defconfig
  -192k   192k      .     4k  am437xsk       omap2plus_defconfig
