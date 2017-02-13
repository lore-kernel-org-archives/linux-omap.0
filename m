From: Tero Kristo <t-kristo@ti.com>
Subject: clk: ti: clkctrl clock support
Date: Mon, 13 Feb 2017 15:22:31 +0200
Message-ID: <1486992157-10673-1-git-send-email-t-kristo@ti.com>
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
To: linux-clk@vger.kernel.org, linux-omap@vger.kernel.org, sboyd@codeaurora.org, mturquette@baylibre.com, tony@atomide.com
Cc: linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

Hi,

This series is a derivative of the hwmod clock support framework
(https://www.spinics.net/lists/arm-kernel/msg536742.html.) This
adds support for clkctrl main and optional clocks, which can be
linked initially with hwmod framework, and later with the
interconnect driver functionality. The implementation is based
on the DT bindings patch from Tony:
https://patchwork.kernel.org/patch/9533605/

This series also depends on the TI clock driver cleanup series
posted here: https://www.spinics.net/lists/arm-kernel/msg562362.html

OMAP4 used as a reference platform for the work, patches 4-6 contain
SoC specific patches, out of which 5-6 should not be merged; these
are only provided as a reference and for testing purposes and are
incomplete. Rest of the data can be provided once the code is
approved / merged.

Boot testing done on am335x-evm, am335x-evmsk, am37x-evm, am437x-sk,
am437x-gp-evm, am57xx-evm, omap3-beagle-xm, omap3-beagle, am335x-bone,
am335x-boneblack, craneboard, dra72-evm, dra7xx-evm, omap3-n900,
omap5-uevm, omap4-panda-es, omap4-panda, omap2430-sdp, omap3430-sdp,
omap3-sdp-es23plus. Also, suspend resume testing done on omap4-panda-es.

Fully functional branch available here (with Tony's DT bindings patch
merged in also):

tree: https://github.com/t-kristo/linux-pm.git
branch: 4.10-rc2-clkctrl

-Tero
