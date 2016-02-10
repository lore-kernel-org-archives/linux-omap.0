From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH] ARM: OMAP3: Fix imprecise external abort for off mode on 36xx
Date: Wed, 10 Feb 2016 13:35:07 -0800
Message-ID: <1455140107-3328-1-git-send-email-tony@atomide.com>
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
Cc: Nishanth Menon <nm@ti.com>, Tero Kristo <t-kristo@ti.com>, Grygorii Strashko <grygorii.strashko@ti.com>, Richard Woodruff <r-woodruff2@ti.com>, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

With CONFIG_DEBUG_RODATA enabled I started noticing imprecise external
aborts on a dm3730 when hitting off idle. These don't seem to happen
on 34xx.

Pretty much changing anything in the code made these go away, like
changing .config options. At first I though it might be an alignment
issue in the 36xx specific assembly code in sleep34xx.S, or something
related to the recent rodata fixes. But that does not seem to be
the case. It seems to be a timing issue instead.

Adding few extra nop instructions after the wfi seems to fix the
issue. When adding 5 nops, the errors showed up less often. With
add ed 6 nops, I don't seem to get them at all any longer.

Cc: Grygorii Strashko <grygorii.strashko@ti.com>
Cc: Nishanth Menon <nm@ti.com>
Cc: Richard Woodruff <r-woodruff2@ti.com>
Cc: Tero Kristo <t-kristo@ti.com>
Signed-off-by: Tony Lindgren <tony@atomide.com>
---

Anybody else seen this issue before?

---
 arch/arm/mach-omap2/sleep34xx.S | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/arm/mach-omap2/sleep34xx.S b/arch/arm/mach-omap2/sleep34xx.S
index 1b9f052..0fbaa08 100644
--- a/arch/arm/mach-omap2/sleep34xx.S
+++ b/arch/arm/mach-omap2/sleep34xx.S
@@ -264,6 +264,12 @@ ENTRY(omap3_do_wfi)
 	nop
 	nop
 	nop
+	nop
+	nop
+	nop
+	nop
+	nop
+	nop
 
 /*
  * This function implements the erratum ID i581 WA:
-- 
2.7.0
