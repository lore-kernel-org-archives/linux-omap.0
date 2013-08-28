From: Paul Walmsley <paul@pwsan.com>
Subject: OMAP baseline test results for v3.11-rc7
Date: Wed, 28 Aug 2013 10:37:17 +0000 (UTC)
Message-ID: <alpine.DEB.2.02.1308281036110.22040@utopia.booyaka.com>
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
Cc: linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org


Here are some basic OMAP test results for Linux v3.11-rc7.
Logs and other details at:

    http://www.pwsan.com/omap/testlogs/test_v3.11-rc7/20130825195715/


Test summary
------------

Build: uImage:
    Pass (14/14): n800_multi_omap2xxx, n800_only_a, omap1_defconfig,
		  omap1_defconfig_1510innovator_only,
		  omap1_defconfig_5912osk_only, omap2plus_defconfig,
		  omap2plus_defconfig_2430sdp_only,
		  omap2plus_defconfig_cpupm, omap2plus_defconfig_no_pm,
		  omap2plus_defconfig_omap2_4_only,
		  omap2plus_defconfig_omap3_4_only,
		  rmk_omap3430_ldp_allnoconfig,
		  rmk_omap3430_ldp_oldconfig,
		  rmk_omap4430_sdp_allnoconfig

Build: uImage+dtb:
    Pass ( 3/ 3): am33xx_only/am335x-bone,
		  omap2plus_defconfig/omap4-panda,
		  omap2plus_defconfig/omap4-panda-es

Build: zImage:
    Pass ( 1/ 1): omap2plus_defconfig

Boot to userspace:
    skip ( 1/ 1): 5912osk
    Pass (10/10): 2430sdp, 3517evm, 3530es3beagle, 3730beaglexm,
		  37xxevm, 4430es2panda, 4460pandaes, am335xbone,
		  am335xbonelt, cmt3517

PM: chip retention via suspend:
    FAIL ( 3/ 6): 2430sdp, 4430es2panda, 4460pandaes
    Pass ( 3/ 6): 3530es3beagle, 3730beaglexm, 37xxevm

PM: chip retention via dynamic idle:
    FAIL ( 3/ 6): 2430sdp, 4430es2panda, 4460pandaes
    Pass ( 3/ 6): 3530es3beagle, 3730beaglexm, 37xxevm

PM: chip off except CORE via suspend:
    Pass ( 1/ 1): 3730beaglexm

PM: chip off except CORE via dynamic idle:
    Pass ( 1/ 1): 3730beaglexm

PM: chip off via suspend:
    FAIL ( 2/ 4): 4430es2panda, 4460pandaes
    Pass ( 2/ 4): 3530es3beagle, 37xxevm

PM: chip off via dynamic idle:
    FAIL ( 2/ 4): 4430es2panda, 4460pandaes
    Pass ( 2/ 4): 3530es3beagle, 37xxevm


vmlinux object size
(delta in bytes from test_v3.11-rc6 (b36f4be3de1b123d8601de062e7dbfc904f305fb)):
   text     data      bss    total  kernel
    +32       -8        0      +24  n800_multi_omap2xxx
    +32      +16        0      +48  n800_only_a
   +464       -8        0     +456  omap1_defconfig
   +528       -8        0     +520  omap1_defconfig_1510innovator_only
   +496       -8        0     +488  omap1_defconfig_5912osk_only
   +296      +24        0     +320  omap2plus_defconfig
   +232       -8        0     +224  omap2plus_defconfig_2430sdp_only
   +296      +24        0     +320  omap2plus_defconfig_cpupm
   +296       -8        0     +288  omap2plus_defconfig_no_pm
   +296       -8        0     +288  omap2plus_defconfig_omap2_4_only
   +296      +24        0     +320  omap2plus_defconfig_omap3_4_only
   +312       -8      +16     +320  rmk_omap3430_ldp_allnoconfig
    +32        0        0      +32  rmk_omap3430_ldp_oldconfig
   +312      +24      +16     +352  rmk_omap4430_sdp_allnoconfig

Boot-time memory difference
(delta in bytes from test_v3.11-rc6 (b36f4be3de1b123d8601de062e7dbfc904f305fb))
  avail  rsrvd   high  freed  board          kconfig
  (no differences)
