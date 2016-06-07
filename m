From: Ben Dooks <ben.dooks@codethink.co.uk>
Subject: [PATCH] clk: ti: fapll: fix address space warnings
Date: Tue,  7 Jun 2016 15:05:37 +0100
Message-ID: <1465308337-18047-1-git-send-email-ben.dooks@codethink.co.uk>
Return-path: <linux-clk-owner@vger.kernel.org>
Sender: linux-clk-owner@vger.kernel.org
To: linux-kernel@lists.codethink.co.uk
Cc: Ben Dooks <ben.dooks@codethink.co.uk>, Tero Kristo <t-kristo@ti.com>, Michael Turquette <mturquette@baylibre.com>, Stephen Boyd <sboyd@codeaurora.org>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-clk@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

Fix the following warnings from casting "void __iomem *" pointers
to u32 when using sparse:

drivers/clk/ti/fapll.c:583:13: warning: cast removes address space of expression
drivers/clk/ti/fapll.c:623:21: warning: cast removes address space of expression

Signed-off-by: Ben Dooks <ben.dooks@codethink.co.uk>
---
Cc: Tero Kristo <t-kristo@ti.com>
Cc: Michael Turquette <mturquette@baylibre.com>
Cc: Stephen Boyd <sboyd@codeaurora.org>
Cc: linux-omap@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org
Cc: linux-clk@vger.kernel.org
---
 drivers/clk/ti/fapll.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/clk/ti/fapll.c b/drivers/clk/ti/fapll.c
index 66a0d0e..d765f4a 100644
--- a/drivers/clk/ti/fapll.c
+++ b/drivers/clk/ti/fapll.c
@@ -43,14 +43,14 @@
 #define to_synth(_hw)		container_of(_hw, struct fapll_synth, hw)
 
 /* The bypass bit is inverted on the ddr_pll.. */
-#define fapll_is_ddr_pll(va)	(((u32)(va) & 0xffff) == 0x0440)
+#define fapll_is_ddr_pll(va)	(((u32 __force)(va) & 0xffff) == 0x0440)
 
 /*
  * The audio_pll_clk1 input is hard wired to the 27MHz bypass clock,
  * and the audio_pll_clk1 synthesizer is hardwared to 32KiHz output.
  */
-#define is_ddr_pll_clk1(va)	(((u32)(va) & 0xffff) == 0x044c)
-#define is_audio_pll_clk1(va)	(((u32)(va) & 0xffff) == 0x04a8)
+#define is_ddr_pll_clk1(va)	(((u32 __force)(va) & 0xffff) == 0x044c)
+#define is_audio_pll_clk1(va)	(((u32 __force)(va) & 0xffff) == 0x04a8)
 
 /* Synthesizer divider register */
 #define SYNTH_LDMDIV1		BIT(8)
-- 
2.8.1

