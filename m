From: Paul Walmsley <paul@pwsan.com>
Subject: Re: OMAP baseline test results for v3.8
Date: Tue, 5 Mar 2013 16:10:43 +0000 (UTC)
Message-ID: <alpine.DEB.2.00.1303051558001.14763@utopia.booyaka.com>
References: <alpine.DEB.2.00.1303041619500.23192@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([74.50.51.50]:49122 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757503Ab3CEQKo (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 5 Mar 2013 11:10:44 -0500
In-Reply-To: <alpine.DEB.2.00.1303041619500.23192@utopia.booyaka.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org

On Mon, 4 Mar 2013, Paul Walmsley wrote:

> Here are some basic OMAP test results for Linux v3.8.
> Logs and other details at:
> 
>     http://www.pwsan.com/omap/testlogs/test_v3.8/20130218214403/

And here's the bloat data, which I usually try to append to the previous 
report.


Boot-time memory difference
(delta in bytes from test_v3.7 (29594404d7fe73cd80eaa4ee8c43dcc53970c60e))
  avail  rsrvd   high  freed  board          kconfig
   212k  -212k      .   -12k  2420n800       n800_only_a
  -188k   188k      .     8k  2430sdp        omap2plus_defconfig
  -188k   188k      .     8k  3517evm        omap2plus_defconfig
  -188k   188k      .     8k  3530es3beagle  omap2plus_defconfig
 12100k -12100k      .     8k  3730beaglexm   omap2plus_defconfig
  -188k   188k      .     8k  37xxevm        omap2plus_defconfig
 16196k -16196k      .     8k  4430es2panda   omap2plus_defconfig
 32592k -32592k      .     8k  4460pandaes    omap2plus_defconfig
   -88k    88k      .      .  5912osk        omap1_defconfig
 -100768k -30304k      .  -192k  am335xbone     am33xx_only

Some remarkable changes in the 3730 Beagle XM, 4430ES2 Panda, and 4460 
Panda ES runtime memory consumption figures.

The AM33xx delta is spurious and is due to the fact that none of the 
v3.8-rc/v3.8 kernels have booted in my appended device tree scenario for 
AM33xx.  This previously worked with v3.7-rc.


vmlinux object size
(delta in bytes from test_v3.7 (29594404d7fe73cd80eaa4ee8c43dcc53970c60e)):
   text     data      bss    total  kernel
+476081   +12728    +3904  +492713  am33xx_only
-180478    -9360   -30332  -220170  n800_multi_omap2xxx
-178466   -11512   -30300  -220278  n800_only_a
 +89769    +1048     +164   +90981  omap1_defconfig
 +89946    +1632     +132   +91710  omap1_defconfig_1510innovator_only
 +88997    +1464     +164   +90625  omap1_defconfig_5912osk_only
+172883   +22832     +904  +196619  omap2plus_defconfig
+120690   +14080     +112  +134882  omap2plus_defconfig_2430sdp_only
+178467   +23072     +904  +202443  omap2plus_defconfig_cpupm
+172839   +25904     +904  +199647  omap2plus_defconfig_no_pm
+135978   +13672     +776  +150426  omap2plus_defconfig_omap2_4_only
+169593   +45416     +904  +215913  omap2plus_defconfig_omap3_4_only
 +76120   +19916    -3032   +93004  rmk_omap3430_ldp_allnoconfig
+102197   +16132      -48  +118281  rmk_omap3430_ldp_oldconfig
 +76120   +19916    -3032   +93004  rmk_omap4430_sdp_allnoconfig
 +91359    +7040     +196   +98595  rmk_omap4430_sdp_oldconfig

The N800 data can be ignored.  They are colored by the radical changes to 
the Kconfig that are necessary to keep a mainline kernel booting on it, 
due to its bootloader's 2MiB kernel size limit.

In my view, the notable change here is the ~200KB size increase for 
omap2plus_defconfig.  I'd guess that much of this is due to the common 
clock framework conversion.  Even OMAP1 registered a ~90KB size increase.  
By comparison, again for OMAP1: v3.5->v3.6 saw a 52KB size increase, 
v3.6->v3.7 saw a 65KB increase.


- Paul
