From: Paul Walmsley <paul@pwsan.com>
Subject: OMAP baseline test results for v3.18-rc5
Date: Thu, 20 Nov 2014 03:29:17 +0000 (UTC)
Message-ID: <alpine.DEB.2.02.1411200322120.9204@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([74.50.51.50]:58401 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754327AbaKTD3T (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 19 Nov 2014 22:29:19 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org, kernel-build-reports@lists.linaro.org


Here are some basic OMAP test results for Linux v3.18-rc5.
Logs and other details at:

    http://www.pwsan.com/omap/testlogs/test_v3.18-rc5/20141119185802/


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
    skip ( 2/17): 5912osk, 3517evm
    Pass (14/17): am335xbonelt, am335xbone, 4430es2panda, 4460pandaes,
		  4460varsomom, 37xxevm, 3530es3beagle, 3530es31beagle,
		  3730beaglexm, 3730es12beaglexm, cmt3517, 5430es2uevm,
		  5430es2sbct54, 2420n800

PM: chip retention via suspend:
    FAIL ( 6/12): am335xbonelt, 4430es2panda, 4460varsomom, 2430sdp,
		  5430es2uevm, 5430es2sbct54
    Pass ( 6/12): 4460pandaes, 37xxevm, 3530es3beagle, 3530es31beagle,
		  3730beaglexm, 3730es12beaglexm

PM: chip retention via dynamic idle:
    FAIL ( 7/12): am335xbonelt, 4430es2panda, 4460pandaes,
		  4460varsomom, 2430sdp, 5430es2uevm, 5430es2sbct54
    Pass ( 5/12): 37xxevm, 3530es3beagle, 3530es31beagle, 3730beaglexm,
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
(delta in bytes from test_v3.18-rc4 (206c5f60a3d902bc4b56dab2de3e88de5eb06108)):
   text     data      bss    total  kernel
   +736      -40        0     +696  omap1_defconfig
   +736      +24        0     +760  omap1_defconfig_1510innovator_only
   +736      -32        0     +704  omap1_defconfig_5912osk_only
 +37585   +30632        0   +68217  multi_v7_defconfig
-313260    -8928   -38696  -360884  omap2plus_defconfig
-288752    -8672   -38600  -336024  omap2plus_defconfig_2430sdp_only
-303324    -9000   -38696  -351020  omap2plus_defconfig_am33xx_only
-307484    -8936   -38696  -355116  omap2plus_defconfig_am43xx_only
-309164    -8912   -38696  -356772  omap2plus_defconfig_cpupm
-303324    -8936   -38696  -350956  omap2plus_defconfig_dra7xx_only
 -10219     -152      -64   -10435  omap2plus_defconfig_n800_multi_omap2xxx
  -6123     -152      -64    -6339  omap2plus_defconfig_n800_only_a
-309132    -8904   -38696  -356732  omap2plus_defconfig_no_pm
-317356    -8912   -38696  -364964  omap2plus_defconfig_omap2_4_only
-307420    -8936   -38696  -355052  omap2plus_defconfig_omap3_4_only
-307484    -8944   -38696  -355124  omap2plus_defconfig_omap5_only
   +692       +8     -104     +596  rmk_omap3430_ldp_allnoconfig
   +968       -8        0     +960  rmk_omap3430_ldp_oldconfig
   +724      +12     -136     +600  rmk_omap4430_sdp_allnoconfig
   +644       -8        0     +636  rmk_omap4430_sdp_oldconfig

Boot-time memory difference
(delta in bytes from test_v3.18-rc4 (206c5f60a3d902bc4b56dab2de3e88de5eb06108))
  avail  rsrvd   high  freed  board          kconfig
      .      .      .     4k  2420n800       omap2plus_defconfig_n800_only_a
   352k  -352k      .      .  2430sdp        omap2plus_defconfig
   352k  -352k      .    -4k  3530es31beagle omap2plus_defconfig
   352k  -352k      .    -4k  3530es3beagle  omap2plus_defconfig
   352k  -352k      .    -4k  3730beaglexm   omap2plus_defconfig
   352k  -352k      .    -4k  3730es12beaglexmomap2plus_defconfig
   348k  -348k      .    -4k  37xxevm        omap2plus_defconfig
   352k  -352k      .    -4k  4460pandaes    omap2plus_defconfig
   352k  -352k      .    -4k  4460varsomom   omap2plus_defconfig
   352k  -352k      .    -4k  5430es2sbct54  omap2plus_defconfig
   348k  -348k      .    -4k  5430es2uevm    omap2plus_defconfig
   340k  -340k      .    -4k  am335xbone     omap2plus_defconfig_am33xx_only
    -4k     4k      .      .  am335xbonelt   omap2plus_defconfig
   348k  -348k      .    -4k  cmt3517        omap2plus_defconfig

A 4430ES2 Panda is back in the tests.  This one is slightly newer than the 
older one; it's an ES2.2 rather than an ES2.0.  The old one may come back 
in if it turns out to be easy to determine what happened to it - I'd say 
it's kind of unlikely at this point.  The boot-time memory diff doesn't 
show up due a limitation of the reporting scripts here.

The huge memory diff comes from IPv6 support being built as a module.

  
