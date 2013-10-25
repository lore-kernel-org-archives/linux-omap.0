From: Tero Kristo <t-kristo@ti.com>
Subject: [PATCHv9 00/43] ARM: TI SoC clock DT conversion
Date: Fri, 25 Oct 2013 18:56:54 +0300
Message-ID: <1382716658-6964-1-git-send-email-t-kristo@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:53311 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753309Ab3JYP6k (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 25 Oct 2013 11:58:40 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, paul@pwsan.com, tony@atomide.com, nm@ti.com, bcousson@baylibre.com, rnayak@ti.com, mturquette@linaro.org
Cc: linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org

Hi all,

Version 9 contains following major changes:
- Clock nodes changed to use offsets instead of direct memory addresses
  * of_iomap() no longer called by individual clock drivers
  * "prcm-driver" provides regmap for accessing the registers based on
    the offsets
  * added support for regmaps to generic clock code
  * added support for regmaps to clock code under mach-omap2
- Devicetree layout changed to be hierarchical: ocp->ip->clocks/clockdomains
  * allows above mentioned offsets to be used
- Clock init mechanism changed completely, called now from prm_common.c,
  see patch #38. This patch contains some rather nasty looking hackery so
  if anybody has any idea how to make it cleaner, comments appreciated.
  Otherwise it can be cleaned later once strict hwmod dependencies are
  cleared and we don't need to do the early init hacks anymore.
- ti,mux-gate-clock type was killed, instead added support for
  ti,composite-clock (see patch #08 for base + components in patches
  #09 + #11 + #13)

Some minor changes also done:
- changed ti,autoidle-low to ti,invert-autoidle-bit
- ordering of patches changed to reflect merge locations
  (drivers/clk, arch/arm/boot/dts, arch/arm/mach-omap2)
- maybe some others, too much code to track.... should have covered
  most of the major comments from Paul though

Dependencies (included in the test branch):
- regmap: debugfs: Fix a boot time crash with early regmap init
- ARM: dts: OMAP5: Add mailbox dt node
- ARM: OMAP5/DRA7: realtime_counter: Configure CNTFRQ register(v4)
- clk: of: helper for determining number of parent clocks

Testing done:
- omap3-beagle: boot + suspend/resume (ret + off)
- omap4-panda-es: boot + suspend/resume
- omap5-uevm: boot
- dra7-evm: boot
- am335x-bone: boot

Test branches available:

tree: https://github.com/t-kristo/linux-pm.git

DTS data branch: 3.12-rc6-dt-clks-for-benoit
CLK driver branch: 3.12-rc6-dt-clks-for-mike
Misc OMAP stuff branch: 3.12-rc6-dt-clks-for-tony
Fully functioning test branch: 3.12-rc6-dt-clks-v9

-Tero

