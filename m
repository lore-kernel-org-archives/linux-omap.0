From: Tero Kristo <t-kristo@ti.com>
Subject: [PATCHv13 00/40] ARM: TI SoC clock DT conversion
Date: Thu, 9 Jan 2014 16:00:11 +0200
Message-ID: <1389276051-1326-1-git-send-email-t-kristo@ti.com>
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
To: linux-omap@vger.kernel.org, paul@pwsan.com, tony@atomide.com, nm@ti.com, rnayak@ti.com, bcousson@baylibre.com, mturquette@linaro.org
Cc: devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

Hi,

So, bad luck number release for this, as v12 wasn't sufficient still.

Changes compared to previous version:
- Dropped any changes to generic clock drivers, as it seems impossible
  to agree anything in short term, this means the patch set shrank in
  size from 49 patches to 40 (first 9 patches were dropped).
- Copy pasted implementation for clk-divider and clk-mux from drivers/clk
  to drivers/clk/ti, and made the modifications needed to the TI version
  of the clock drivers only (based on discussions with Mike, this is fine)
- Changed name of clk_ll_ops to ti_clk_ll_ops so that this doesn't conflict
  with any generic implementation we might have at some point, migrating
  this to the generic version should be easy enough also.
- Fixed trace_clk_div_div_ck for omap4, this node was broken in previous
  versions and resulted into an orphan clock node
- Fixed compile problem for omap5 only build reported by Felipe
- Fixed a couple of sparse warnings
- changed the mach-omap2/clock.c to use readl_relaxed / writel_relaxed
  instead of __raw_readl / __raw_writel

Testing done:
- omap3-beagle: boot / suspend-resume (RET) / suspend-resume (OFF)
- omap4-panda-es: boot / suspend-resume (RET)
- omap5-uevm: boot
- am335x-bone: boot
- dra7-evm: boot

Maintainer friendly branches also available:

tree: https://github.com/t-kristo/linux-pm.git

clk driver only (Mike): clk-next-dt-clks-v13
DTS data only (Benoit): dts_for_3.14-dt-clks-v13
full-branch (Tony/Paul): 3.13-rc7-dt-clks-v13

-Tero
