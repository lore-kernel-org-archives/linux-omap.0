From: Tero Kristo <t-kristo@ti.com>
Subject: [PATCHv3 0/7] clk: ti add support for hwmod clk type
Date: Thu, 30 Jun 2016 17:13:31 +0300
Message-ID: <1467296018-25086-1-git-send-email-t-kristo@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-clk-owner@vger.kernel.org>
Sender: linux-clk-owner@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-clk@vger.kernel.org, tony@atomide.com, paul@pwsan.com, sboyd@codeaurora.org, mturquette@baylibre.com
Cc: linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

Hi,

Changes from v3:
- moved mach-omap2 related patches to their own sets
- moved DT_CLK cleanup patches to their own series (which depends on this)
- added patch #1 to add clkdev helper support, this helps
  getting rid of some 4...5 patches from v2 of the series, and keeping
  the clk_get API uniform
- made ti_clk_get function static, not used outside the file anymore,
  as this will be providing support via tha API added in patch #1 in
  this set

This series can be applied separately, without any dependencies on the
other sets. I will be posting the DT_CLK cleanup set separately if this
series gets approval.

Test results:

  : Board           : Boot WRN version                 
 1: am335x-evm      : PASS   0 4.7.0-rc1-00007-g958a12a
 2: am335x-evmsk    : PASS   0 4.7.0-rc1-00007-g958a12a
 3: am3517-evm      : PASS   1 4.7.0-rc1-00007-g958a12a
 4: am37x-evm       : PASS   0 4.7.0-rc1-00007-g958a12a
 5: am437x-sk       : PASS   0 4.7.0-rc1-00007-g958a12a
 6: am43x-epos-evm  : PASS   0 4.7.0-rc1-00007-g958a12a
 7: am437x-gp-evm   : PASS   0 4.7.0-rc1-00007-g958a12a
 8: am57xx-evm      : PASS   3 4.7.0-rc1-00007-g958a12a
 9: omap3-beagle-xm : PASS   0 4.7.0-rc1-00007-g958a12a
10: omap3-beagle    : PASS   0 4.7.0-rc1-00007-g958a12a
11: am335x-boneblack: PASS   0 4.7.0-rc1-00007-g958a12a
12: am335x-bone     : PASS   0 4.7.0-rc1-00007-g958a12a
13: craneboard      : PASS   1 4.7.0-rc1-00007-g958a12a
14: dra72x-evm      : FAIL   3 4.7.0-rc1-00007-g958a12a
15: dra7xx-evm      : PASS   3 4.7.0-rc1-00007-g958a12a
16: ldp3430         : FAIL   0                         
17: omap3-n900      : PASS   0 4.7.0-rc1-00007-g958a12a
18: omap5-uevm      : PASS   0 4.7.0-rc1-00007-g958a12a
19: omap4-panda-es  : PASS   0 4.7.0-rc1-00007-g958a12a
20: omap4-panda     : PASS   0 4.7.0-rc1-00007-g958a12a
21: omap2430-sdp    : PASS   0 4.7.0-rc1-00007-g958a12a
22: omap3430-sdp    : PASS   0 4.7.0-rc1-00007-g958a12a
23: omap4-sdp-es23plus: PASS   0 4.7.0-rc1-00007-g958a12a
TOTAL = 23 boards, Booted Boards = 21, No Boot boards = 2

The couple of failing boards seem to have hardware issues on the farm, as
they fail with any kernel.

Patches also available here:

tree: https://github.com/t-kristo/linux-pm.git
branch: 4.7-rc1-hwmod-clks-v3

-Tero


