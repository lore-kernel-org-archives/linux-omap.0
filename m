From: Nishanth Menon <nm@ti.com>
Subject: [PATCH V3 09/20] bus: omap_l3_noc: Add support for discountinous flag
 mux input numbers
Date: Mon, 28 Apr 2014 10:14:49 -0500
Message-ID: <1398698101-25513-10-git-send-email-nm@ti.com>
References: <1397492726-17203-1-git-send-email-nm@ti.com>
 <1398698101-25513-1-git-send-email-nm@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1398698101-25513-1-git-send-email-nm@ti.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Tony Lindgren <tony@atomide.com>, Santosh Shilimkar <santosh.shilimkar@ti.com>, Sricharan R <r.sricharan@ti.com>, Sekhar Nori <nsekhar@ti.com>, Rajendra Nayak <rnayak@ti.com>
Cc: nm@ti.com, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, Peter Ujfalusi <peter.ujfalusi@ti.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

From: Rajendra Nayak <rnayak@ti.com>

On DRA7, unlike on OMAP4 and OMAP5, the flag mux input numbers used
to indicate the source of errors are not continous. Have a way in the
driver to catch these and WARN the user of the flag mux input thats
either undocumented or wrong.

In the similar vein, Timeout errors in AM43x can't be cleared per h/w
team, neither does it have a STDERRLOG_MAIN to clear the error.

Further, the mux bit offset might not even be indexed into our array
of known mux input description, in which case we'd have a abort.

So, define a static range check for bit description and any definition
which has target_name set to NULL (the ones that are not populated or
ones that are specifically marked in the case of discontinous input
numbers), can handle the same gracefully. Upon occurance of error from
such sources, mask it. Otherwise, we'd have an infinite interrupt
source without any means to clear it.

NOTE: follow on patch ensures that these masked bits are ignored.

[nm@ti.com: rebase, squash and improve]
Signed-off-by: Rajendra Nayak <rnayak@ti.com>
Signed-off-by: Afzal Mohammed <afzal@ti.com>
Signed-off-by: Nishanth Menon <nm@ti.com>
Acked-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
Acked-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
Tested-by: Darren Etheridge <detheridge@ti.com>
---
V3: changed readl/writel to relaxed version

NOTE: follow on fix for error mask handling not squashed as required
data structure changes are yet to be introduced and doing it at this
point makes the code very ugly.

 drivers/bus/omap_l3_noc.c |   31 +++++++++++++++++++++++++++++++
 drivers/bus/omap_l3_noc.h |   11 ++++++++---
 2 files changed, 39 insertions(+), 3 deletions(-)

diff --git a/drivers/bus/omap_l3_noc.c b/drivers/bus/omap_l3_noc.c
index 343f002..7743e86 100644
--- a/drivers/bus/omap_l3_noc.c
+++ b/drivers/bus/omap_l3_noc.c
@@ -75,10 +75,41 @@ static irqreturn_t l3_interrupt_handler(int irq, void *_l3)
 		if (err_reg) {
 			/* Identify the source from control status register */
 			err_src = __ffs(err_reg);
+
+			/* We DONOT expect err_src to go out of bounds */
+			BUG_ON(err_src > MAX_CLKDM_TARGETS);
+
 			l3_targ_inst = &l3_targ[i][err_src];
 			target_name = l3_targ_inst->name;
 			l3_targ_base = base + l3_targ_inst->offset;
 
+			/*
+			 * If we do not know of a register offset to decode
+			 * and clear, then mask.
+			 */
+			if (target_name == L3_TARGET_NOT_SUPPORTED) {
+				u32 mask_val;
+				void __iomem *mask_reg;
+
+				/*
+				 * Certain plaforms may have "undocumented"
+				 * status pending on boot.. So dont generate
+				 * a severe warning here.
+				 */
+				dev_err(l3->dev,
+					"L3 %s error: target %d mod:%d %s\n",
+					inttype ? "debug" : "application",
+					err_src, i, "(unclearable)");
+
+				mask_reg = base + l3_flagmux[i] +
+					   L3_FLAGMUX_MASK0 + (inttype << 3);
+				mask_val = readl_relaxed(mask_reg);
+				mask_val &= ~(1 << err_src);
+				writel_relaxed(mask_val, mask_reg);
+
+				break;
+			}
+
 			/* Read the stderrlog_main_source from clk domain */
 			l3_targ_stderr = l3_targ_base + L3_TARG_STDERRLOG_MAIN;
 			l3_targ_slvofslsb = l3_targ_base +
diff --git a/drivers/bus/omap_l3_noc.h b/drivers/bus/omap_l3_noc.h
index ae28784..66caece 100644
--- a/drivers/bus/omap_l3_noc.h
+++ b/drivers/bus/omap_l3_noc.h
@@ -30,6 +30,11 @@
 #define L3_TARG_STDERRLOG_SLVOFSLSB	0x5c
 #define L3_TARG_STDERRLOG_MSTADDR	0x68
 #define L3_FLAGMUX_REGERR0		0xc
+#define L3_FLAGMUX_MASK0		0x8
+
+#define L3_TARGET_NOT_SUPPORTED		NULL
+
+#define MAX_CLKDM_TARGETS		31
 
 #define NUM_OF_L3_MASTERS	(sizeof(l3_masters)/sizeof(l3_masters[0]))
 
@@ -61,7 +66,7 @@ static u32 l3_flagmux[L3_MODULES] = {
 	0X0200
 };
 
-static struct l3_target_data l3_target_inst_data_clk1[] = {
+static struct l3_target_data l3_target_inst_data_clk1[MAX_CLKDM_TARGETS] = {
 	{0x100,	"DMM1",},
 	{0x200,	"DMM2",},
 	{0x300,	"ABE",},
@@ -71,7 +76,7 @@ static struct l3_target_data l3_target_inst_data_clk1[] = {
 	{0x900,	"L4WAKEUP",},
 };
 
-static struct l3_target_data l3_target_inst_data_clk2[] = {
+static struct l3_target_data l3_target_inst_data_clk2[MAX_CLKDM_TARGETS] = {
 	{0x500,	"CORTEXM3",},
 	{0x300,	"DSS",},
 	{0x100,	"GPMC",},
@@ -95,7 +100,7 @@ static struct l3_target_data l3_target_inst_data_clk2[] = {
 	{0x1700, "LLI",},
 };
 
-static struct l3_target_data l3_target_inst_data_clk3[] = {
+static struct l3_target_data l3_target_inst_data_clk3[MAX_CLKDM_TARGETS] = {
 	{0x0100, "EMUSS",},
 	{0x0300, "DEBUG SOURCE",},
 	{0x0,	"HOST CLK3",},
-- 
1.7.9.5
