From: Paul Walmsley <paul@pwsan.com>
Subject: OMAP baseline test results for v4.2-rc1
Date: Fri, 10 Jul 2015 21:17:47 +0000 (UTC)
Message-ID: <alpine.DEB.2.02.1507102116430.16508@utopia.booyaka.com>
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


Here are some basic OMAP test results for Linux v4.2-rc1.
Logs and other details at:

    http://www.pwsan.com/omap/testlogs/test_v4.2-rc1/20150705171039/


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
(delta in bytes from test_v4.1 (b953c0d234bc72e8489d3bf51a276c5c4ec85345)):
   text     data      bss    total  kernel
 +49744   -60136   +10456      +64  omap1_defconfig
 +48684   -60136   +10456     -996  omap1_defconfig_1510innovator_only
 +49752   -56296   +10520    +3976  omap1_defconfig_5912osk_only
-319515   +45664    +8640  -265211  multi_v7_defconfig
 +94414    -8216    +4992   +91190  omap2plus_defconfig
 +85692    +4432    +4856   +94980  omap2plus_defconfig_2430sdp_only
+106074    +5320    +4928  +116322  omap2plus_defconfig_am33xx_only
+101982    +5448    +4992  +112422  omap2plus_defconfig_am43xx_only
 +94414    -8216    +4928   +91126  omap2plus_defconfig_cpupm
+103166    +6472    +4928  +114566  omap2plus_defconfig_dra7xx_only
 +37781    +3952    +4736   +46469  omap2plus_defconfig_n800_multi_omap2xxx
 +12695    +3928    +4200   +20823  omap2plus_defconfig_n800_only_a
 +92086    -7392    +5056   +89750  omap2plus_defconfig_no_pm
+106498    +6504    +4864  +117866  omap2plus_defconfig_omap2_4_only
 +97350   -12312    +4928   +89966  omap2plus_defconfig_omap3_4_only
+106318    +5544    +4928  +116790  omap2plus_defconfig_omap5_only
 +15848    -5024    +4620   +15444  rmk_omap3430_ldp_allnoconfig
 +56411    +6708    +4300   +67419  rmk_omap3430_ldp_oldconfig
 +21408    +3628    +7076   +32112  rmk_omap4430_sdp_allnoconfig
 +93312    +3680   +11408  +108400  rmk_omap4430_sdp_oldconfig

Boot-time memory difference
(delta in bytes from test_v4.1 (b953c0d234bc72e8489d3bf51a276c5c4ec85345))
  avail  rsrvd   high  freed  board          kconfig
   -20k    20k      .      .  2420n800       omap2plus_defconfig_n800_only_a
   -92k    92k      .      .  2430sdp        omap2plus_defconfig
   -92k    92k      .    -8k  3530es31beagle omap2plus_defconfig
   -92k    92k      .    -8k  3530es3beagle  omap2plus_defconfig
   -92k    92k      .    -8k  3730beaglexm   omap2plus_defconfig
   -92k    92k      .    -8k  3730es12beaglexmomap2plus_defconfig
   -92k    92k      .    -8k  37xxevm        omap2plus_defconfig
   -92k    92k      .    -8k  4430es2panda   omap2plus_defconfig
   -96k    96k      .    -8k  4460pandaes    omap2plus_defconfig
   -92k    92k      .    -8k  4460varsomom   omap2plus_defconfig
   -96k    96k      .    -8k  5430es2uevm    omap2plus_defconfig
  -120k   120k      .    -4k  am335xbone     omap2plus_defconfig_am33xx_only
   -96k    96k      .    -8k  am335xbonelt   omap2plus_defconfig
