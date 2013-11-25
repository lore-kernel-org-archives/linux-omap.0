From: Paul Walmsley <paul@pwsan.com>
Subject: OMAP baseline test results for v3.13-rc1 (toolchain Debian
 4.7.2-5)
Date: Mon, 25 Nov 2013 07:41:31 +0000 (UTC)
Message-ID: <alpine.DEB.2.02.1311250731410.1364@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([74.50.51.50]:35095 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751778Ab3KYHlc (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 25 Nov 2013 02:41:32 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org, kernel-build-reports@lists.linaro.org


Here are some basic OMAP test results for Linux v3.13-rc1.
Logs and other details at:

    http://www.pwsan.com/omap/testlogs/test_v3.13-rc1/20131124230250/


Test summary
------------

Build: uImage+dtb:
    Pass ( 3/ 3): omap2plus_defconfig_am33xx_only/am335x-bone,
		  omap2plus_defconfig/omap4-panda,
		  omap2plus_defconfig/omap4-panda-es

Build: zImage:
    Pass ( 2/ 2): omap2plus_defconfig, omap2plus_defconfig_am33xx_only

Build: uImage:
    Pass (14/14): omap1_defconfig, omap1_defconfig_1510innovator_only,
		  omap1_defconfig_5912osk_only, omap2plus_defconfig,
		  omap2plus_defconfig_2430sdp_only,
		  omap2plus_defconfig_cpupm, omap2plus_defconfig_no_pm,
		  omap2plus_defconfig_n800_only_a,
		  omap2plus_defconfig_n800_multi_omap2xxx,
		  omap2plus_defconfig_omap2_4_only,
		  omap2plus_defconfig_omap3_4_only,
		  rmk_omap3430_ldp_allnoconfig,
		  rmk_omap3430_ldp_oldconfig,
		  rmk_omap4430_sdp_allnoconfig

Boot to userspace:
    FAIL ( 1/11): 37xxevm
    skip ( 1/ 1): 5912osk
    Pass (10/11): 2430sdp, 3517evm, 3530es3beagle, 3730beaglexm,
		  4430es2panda, 4460pandaes, am335xbone, am335xbonelt,
		  cmt3517, 4460varsomom

PM: chip retention via suspend:
    FAIL ( 4/ 7): 2430sdp, 37xxevm, 4430es2panda, 4460varsomom
    Pass ( 3/ 7): 3530es3beagle, 3730beaglexm, 4460pandaes

PM: chip retention via dynamic idle:
    FAIL ( 5/ 7): 2430sdp, 37xxevm, 4430es2panda, 4460pandaes,
		  4460varsomom
    Pass ( 2/ 7): 3530es3beagle, 3730beaglexm

PM: chip off except CORE via suspend:
    Pass ( 1/ 1): 3730beaglexm

PM: chip off except CORE via dynamic idle:
    Pass ( 1/ 1): 3730beaglexm

PM: chip off via suspend:
    FAIL ( 4/ 5): 37xxevm, 4430es2panda, 4460pandaes, 4460varsomom
    Pass ( 1/ 5): 3530es3beagle

PM: chip off via dynamic idle:
    FAIL ( 4/ 5): 37xxevm, 4430es2panda, 4460pandaes, 4460varsomom
    Pass ( 1/ 5): 3530es3beagle


vmlinux object size
(delta in bytes from test_v3.12 (5e01dc7b26d9f24f39abace5da98ccbd6a5ceb52)):
   text     data      bss    total  kernel
-351659     +384    +4216  -347059  omap1_defconfig
-354695     +296    +4216  -350183  omap1_defconfig_1510innovator_only
-354491     +360    +4216  -349915  omap1_defconfig_5912osk_only
-276029    -5584    +5008  -276605  omap2plus_defconfig
-292693    +9808    +4656  -278229  omap2plus_defconfig_2430sdp_only
-273194    -5512    +5008  -273698  omap2plus_defconfig_cpupm
 +88436   +10392    +4368  +103196  omap2plus_defconfig_n800_multi_omap2xxx
 +88404   +10408    +4368  +103180  omap2plus_defconfig_n800_only_a
-273765    -4704    +5008  -273461  omap2plus_defconfig_no_pm
-263629   +13912    +4944  -244773  omap2plus_defconfig_omap2_4_only
-270645    -5584    +5008  -271221  omap2plus_defconfig_omap3_4_only
-119620   -10124    +2856  -126888  rmk_omap3430_ldp_allnoconfig
 +49719    +3928    +4352   +57999  rmk_omap3430_ldp_oldconfig
-115704    +1788    +5608  -108308  rmk_omap4430_sdp_allnoconfig
+4738404  +250480  +443152  +5432036  rmk_omap4430_sdp_oldnoconfig

Re-enabled rmk_omap4430_sdp_oldnoconfig.

A significant portion of the size delta is due to switch in the toolchain 
used for the testbed, to the Emdebian gcc 4.7.  See also the message with 
the subject line "OMAP baseline test results for v3.13-rc1 (toolchain 
CodeSourcery 2010.09-50)" for the results with the previous compiler used.


Boot-time memory difference
(delta in bytes from test_v3.12 (5e01dc7b26d9f24f39abace5da98ccbd6a5ceb52))
  avail  rsrvd   high  freed  board          kconfig
  -104k   104k      .     4k  2420n800       omap2plus_defconfig_n800_only_a
   276k  -276k      .    -8k  2430sdp        omap2plus_defconfig
   276k  -276k      .    -8k  3517evm        omap2plus_defconfig
   276k  -276k      .    -8k  3530es3beagle  omap2plus_defconfig
   276k  -276k      .    -8k  3730beaglexm   omap2plus_defconfig
 -227908k -33212k      .  -392k  37xxevm        omap2plus_defconfig
   272k  -272k      .    -8k  4430es2panda   omap2plus_defconfig
   268k  -268k      .    -8k  4460pandaes    omap2plus_defconfig
   272k  -272k      .    -8k  4460varsomom   omap2plus_defconfig
   312k  -312k      .     4k  am335xbone     omap2plus_defconfig_am33xx_only
   268k  -268k      .    -8k  am335xbonelt   omap2plus_defconfig_am33xx_only


