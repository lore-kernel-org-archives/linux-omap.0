From: Tero Kristo <t-kristo@ti.com>
Subject: [RESEND PATCHv2 00/28] clk: ti: hwmod clock type support
Date: Mon, 13 Jun 2016 22:04:34 +0300
Message-ID: <1465844702-12200-1-git-send-email-t-kristo@ti.com>
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
To: linux-omap@vger.kernel.org, linux-clk@vger.kernel.org, sboyd@codeaurora.org, mturquette@baylibre.com, tony@atomide.com
Cc: linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

Hi,

Resending the series as it didn't get that much attention last time.
This has just been rebased on top of 4.7-rc1, no other changes.

This series adds support for hwmod module clocks, which are currently
directly handled by hwmod core. This addresses following issues:

 * one step closer of removing hwmod core / data from kernel
 * unblock Tony's interconnect driver work (this is also required
   for removing hwmod codebase)
 * add proper clock support for the hardware modules currently handled
   by hwmod core; use counting for clocks, ability to share clocks
   between multiple modules, etc.
 * add helper clock APIs for removing most of the clock aliases under
   drivers/clk/ti/clk-xyz.c files

Test branch available:
tree: https://github.com/t-kristo/linux-pm.git
branch: 4.7-rc1-hwmod-clks

Testing done:

boot: am335x-evm, am335x-evmsk, am3517-evm, am37x-evm, am437x-sk,
am437x-gp-evm, am57xx-evm, omap3-beagle-xm, am335x-boneblack, am335x-bone,
dra7xx-evm, omap3-n900, omap5-uevm, omap4-panda, omap3430-sdp,
omap4-sdp-es23plus

suspend-resume: omap3-beagle, omap4-panda-es

-Tero
