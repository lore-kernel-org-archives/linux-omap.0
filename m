From: Paul Walmsley <paul@pwsan.com>
Subject: OMAP baseline test results for v3.18-rc2
Date: Mon, 27 Oct 2014 18:57:35 +0000 (UTC)
Message-ID: <alpine.DEB.2.02.1410271856120.27694@utopia.booyaka.com>
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


Here are some basic OMAP test results for Linux v3.18-rc2.
Logs and other details at:

    http://www.pwsan.com/omap/testlogs/test_v3.18-rc2/20141027002021/


Test summary
------------

Build: uImage:
    Pass ( 3/ 3): omap1_defconfig, omap1_defconfig_1510innovator_only,
		  omap1_defconfig_5912osk_only

Build: uImage+dtb:
    Pass (13/13): omap2plus_defconfig_am33xx_only/am335x-bone,
		  omap2plus_defconfig/omap4-panda,
		  omap2plus_defconfig/omap4-panda-es,
		  omap2plus_defconfig/omap4-var-som,
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

Boot to userspace:
    FAIL ( 1/17): 2430sdp
    skip ( 4/17): 5912osk, 2420n800, 3517evm, 4430es2panda
    Pass (12/17): am335xbonelt, am335xbone, 4460pandaes, 4460varsomom,
		  37xxevm, 3530es3beagle, 3530es31beagle, 3730beaglexm,
		  3730es12beaglexm, cmt3517, 5430es2uevm, 5430es2sbct54

PM: chip retention via suspend:
    FAIL ( 5/11): am335xbonelt, 4460varsomom, 2430sdp, 5430es2uevm,
		  5430es2sbct54
    Pass ( 6/11): 4460pandaes, 37xxevm, 3530es3beagle, 3530es31beagle,
		  3730beaglexm, 3730es12beaglexm

PM: chip retention via dynamic idle:
    FAIL ( 6/11): am335xbonelt, 4460pandaes, 4460varsomom, 2430sdp,
		  5430es2uevm, 5430es2sbct54
    Pass ( 5/11): 37xxevm, 3530es3beagle, 3530es31beagle, 3730beaglexm,
		  3730es12beaglexm

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


vmlinux object size
(delta in bytes from test_v3.18-rc1 (f114040e3ea6e07372334ade75d1ee0775c355e1)):
   text     data      bss    total  kernel
  +1615     +216        0    +1831  omap1_defconfig
  +1575     +224        0    +1799  omap1_defconfig_1510innovator_only
  +1607     +192        0    +1799  omap1_defconfig_5912osk_only
 +11826     +256        0   +12082  multi_v7_defconfig
 +13779     +976        0   +14755  omap2plus_defconfig
 +12995     +976        0   +13971  omap2plus_defconfig_2430sdp_only
 +13651     +944        0   +14595  omap2plus_defconfig_am33xx_only
 +13651     +912      +64   +14627  omap2plus_defconfig_am43xx_only
 +13715     +936        0   +14651  omap2plus_defconfig_cpupm
 +13651     +944      +64   +14659  omap2plus_defconfig_dra7xx_only
  +1759     +128        0    +1887  omap2plus_defconfig_n800_multi_omap2xxx
  +1759     +128        0    +1887  omap2plus_defconfig_n800_only_a
 +13715     +976        0   +14691  omap2plus_defconfig_no_pm
 +13719     +912      +64   +14695  omap2plus_defconfig_omap2_4_only
 +13651     +904      +64   +14619  omap2plus_defconfig_omap3_4_only
 +13651     +936      +64   +14651  omap2plus_defconfig_omap5_only
  +1996      +64     -316    +1744  rmk_omap3430_ldp_allnoconfig
  +1917     +128        0    +2045  rmk_omap3430_ldp_oldconfig
  +1980      +64     -300    +1744  rmk_omap4430_sdp_allnoconfig
  +2087     +152        0    +2239  rmk_omap4430_sdp_oldconfig

Boot-time memory difference
(delta in bytes from test_v3.18-rc1 (f114040e3ea6e07372334ade75d1ee0775c355e1))
  avail  rsrvd   high  freed  board          kconfig
    -8k     8k      .      .  2430sdp        omap2plus_defconfig
    -8k     8k      .    -4k  3530es31beagle omap2plus_defconfig
    -8k     8k      .    -4k  3530es3beagle  omap2plus_defconfig
    -8k     8k      .    -4k  3730beaglexm   omap2plus_defconfig
    -8k     8k      .    -4k  3730es12beaglexmomap2plus_defconfig
    -8k     8k      .    -4k  37xxevm        omap2plus_defconfig
   -12k    12k      .    -4k  4460pandaes    omap2plus_defconfig
   -12k    12k      .    -4k  4460varsomom   omap2plus_defconfig
   -12k    12k      .    -4k  5430es2sbct54  omap2plus_defconfig
    -8k     8k      .    -4k  5430es2uevm    omap2plus_defconfig
   -16k    16k      .     4k  am335xbone     omap2plus_defconfig_am33xx_only
