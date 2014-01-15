From: Paul Walmsley <paul@pwsan.com>
Subject: OMAP baseline test results for v3.13-rc6
Date: Wed, 15 Jan 2014 19:44:52 +0000 (UTC)
Message-ID: <alpine.DEB.2.02.1401151940370.20720@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([74.50.51.50]:54911 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750856AbaAOTox (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 15 Jan 2014 14:44:53 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org, kernel-build-reports@lists.linaro.org


Here are some basic OMAP test results for Linux v3.13-rc6.
Logs and other details at:

    http://www.pwsan.com/omap/testlogs/test_v3.13-rc6/20131229233555/


Test summary
------------

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

Build: uImage+dtb:
    Pass ( 3/ 3): omap2plus_defconfig_am33xx_only/am335x-bone,
		  omap2plus_defconfig/omap4-panda,
		  omap2plus_defconfig/omap4-panda-es

Boot to userspace:
    skip ( 2/ 2): 5912osk, 4460varsomom
    Pass (10/10): 2430sdp, 3517evm, 3530es3beagle, 3730beaglexm,
		  37xxevm, 4430es2panda, 4460pandaes, am335xbone,
		  am335xbonelt, cmt3517

PM: chip retention via suspend:
    FAIL ( 4/ 7): 2430sdp, 4430es2panda, 4460pandaes, 4460varsomom
    Pass ( 3/ 7): 3530es3beagle, 3730beaglexm, 37xxevm

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
(delta in bytes from test_v3.13-rc5 
(413541dd66d51f791a0b169d9b9014e4f56be13c)):
   text     data      bss    total  kernel
   +140        0        0     +140  omap1_defconfig
   +140        0        0     +140  omap1_defconfig_1510innovator_only
   +140        0        0     +140  omap1_defconfig_5912osk_only
   +352        0        0     +352  omap2plus_defconfig
   +276        0        0     +276  omap2plus_defconfig_2430sdp_only
   +496        0        0     +496  omap2plus_defconfig_cpupm
   +172        0        0     +172  omap2plus_defconfig_n800_multi_omap2xxx
   +140        0        0     +140  omap2plus_defconfig_n800_only_a
  +4448        0        0    +4448  omap2plus_defconfig_no_pm
   +332       +8        0     +340  omap2plus_defconfig_omap2_4_only
   +288        0        0     +288  omap2plus_defconfig_omap3_4_only
   +256      +32      -32     +256  rmk_omap3430_ldp_allnoconfig
   +160      +64        0     +224  rmk_omap3430_ldp_oldconfig
   +140        0        0     +140  rmk_omap4430_sdp_allnoconfig
   +256        0        0     +256  rmk_omap4430_sdp_oldnoconfig

Boot-time memory difference
(delta in bytes from test_v3.13-rc5 (413541dd66d51f791a0b169d9b9014e4f56be13c))
  avail  rsrvd   high  freed  board          kconfig
 -1007736k -39816k -269312k  -384k  4460varsomom   omap2plus_defconfig


The winter holidays seemed to be a good time for testbed disruptions here.  
The 2430SDP lost its ability to communicate over Ethernet, so that's been 
switched to serial booting.  And the 4460 VAR-SOM-OM decided it was going 
to modulate its serial console TXD line with a 60 Hz ersatz triangle wave, 
strong enough to confuse the serial port it was hooked up to, so that 
board is offline until I can track down what the problem is.
