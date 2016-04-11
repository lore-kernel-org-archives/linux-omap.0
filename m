From: Tero Kristo <t-kristo@ti.com>
Subject: [PATCH 00/30] ARM: OMAP2+: hwmod module clock type support
Date: Mon, 11 Apr 2016 11:18:51 +0300
Message-ID: <1460362761-4842-1-git-send-email-t-kristo@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-clk-owner@vger.kernel.org>
Sender: linux-clk-owner@vger.kernel.org
To: linux-omap@vger.kernel.org, tony@atomide.com, paul@pwsan.com, mturquette@baylibre.com, sboyd@codeaurora.org
Cc: linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, linux-clk@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

Hi,

This series transfers the hwmod clkctrl handling from the hwmod core
under clock driver, the data is also transferred from hwmod data to
devicetree. Done for most of the OMAP2+ platforms, except OMAP2 / OMAP3,
where work is still under progress.

Major part of this set is also to add support function ti_clk_get, which
when used, allows us to get rid of number of clock aliases under TI
clock driver.

The ordering on this set is kind of tricky to avoid any boot issues,
and it still currently causes a boot breakage between the DTS data
introduction and removal of hwmod data; this generates duplicate
entries for clocks which is prone to cause issues (both DT and hwmod
have the same entries in place under the hwmod data is removed.) I
didn't quite figure out a good way to avoid this, and could use some
guidance here. Shall we squash the DT + hwmod data patches together?
This avoids the boot breakage but creates pretty large patches. Also,
AMx3xx data needs to be grouped together as part of their data is
re-used commonly by both SoCs.

Another issue with the set is with patch #18 which introduces the
hwmod clock driver itself; the startup / shutdown latencies for
clocks are tricky to handle within a spinlocked region (and really
early boot also where ktime_get doesn't work yet) so I ended up
writing a timeout function which uses alternate implementations
for early vs. late boot. It doesn't look that neat but it works.

Set built on top of the DT warning fix set:

http://comments.gmane.org/gmane.linux.drivers.devicetree/162659

Boot tested on following boards:
am33xx-bone, am33xx-boneblack, am437x-gp-evm, am437x-sk-evm, am57xx-beagle,
omap5-uevm, dra7-evm, dra72x-evm, omap4-panda-es, omap4430-sdp. Also,
omap4 suspend-resume seems to be fine still after this set.

Test branch pushed also:
Tree: https://github.com/t-kristo/linux-pm.git
Branch: 4.6-rc2-hwmod-clks-v1

-Tero

