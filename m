From: Nishanth Menon <nm@ti.com>
Subject: [PATCH 06/15] bus: omap_l3_noc: make error reporting and handling
 common.
Date: Mon, 14 Apr 2014 11:25:17 -0500
Message-ID: <1397492726-17203-8-git-send-email-nm@ti.com>
References: <1397492726-17203-1-git-send-email-nm@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1397492726-17203-1-git-send-email-nm@ti.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Tony Lindgren <tony@atomide.com>, Santosh Shilimkar <santosh.shilimkar@ti.com>, Sricharan R <r.sricharan@ti.com>
Cc: Nishanth Menon <nm@ti.com>, devicetree@vger.kernel.org, Rajendra Nayak <rnayak@ti.com>, Sekhar Nori <nsekhar@ti.com>, linux-kernel@vger.kernel.org, Peter Ujfalusi <peter.ujfalusi@ti.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

The logic between handling CUSTOM_ERROR and STANDARD_ERROR
is just the reporting style.

So make it generic, simplify and standardize the reporting
with both master and target information printed to log.

While at it, fix a minor formatting error.

Signed-off-by: Nishanth Menon <nm@ti.com>
---
 drivers/bus/omap_l3_noc.c |   47 ++++++++++++++++++++++++++++-----------------
 1 file changed, 29 insertions(+), 18 deletions(-)

diff --git a/drivers/bus/omap_l3_noc.c b/drivers/bus/omap_l3_noc.c
index 0ef8b75..0f0417a 100644
--- a/drivers/bus/omap_l3_noc.c
+++ b/drivers/bus/omap_l3_noc.c
@@ -58,6 +58,8 @@ static irqreturn_t l3_interrupt_handler(int irq, void *_l3)
 	void __iomem *l3_targ_stderr, *l3_targ_slvofslsb, *l3_targ_mstaddr;
 	char *target_name, *master_name = "UN IDENTIFIED";
 	struct l3_target_data *l3_targ_inst;
+	char *err_description;
+	char err_string[30] = { 0 };
 
 	/* Get the Type of interrupt */
 	inttype = irq == l3->app_irq ? L3_APPLICATION_ERROR : L3_DEBUG_ERROR;
@@ -73,6 +75,8 @@ static irqreturn_t l3_interrupt_handler(int irq, void *_l3)
 
 		/* Get the corresponding error and analyse */
 		if (err_reg) {
+			bool std_err = true;
+
 			/* Identify the source from control status register */
 			err_src = __ffs(err_reg);
 			l3_targ_inst = &l3_targ[i][err_src];
@@ -89,35 +93,42 @@ static irqreturn_t l3_interrupt_handler(int irq, void *_l3)
 			std_err_main = readl_relaxed(l3_targ_stderr);
 			masterid = readl_relaxed(l3_targ_mstaddr);
 
+			for (k = 0; k < NUM_OF_L3_MASTERS; k++) {
+				if (masterid == l3_masters[k].id)
+					master_name = l3_masters[k].name;
+			}
+
 			switch (std_err_main & CUSTOM_ERROR) {
 			case STANDARD_ERROR:
-				WARN(true, "L3 standard error: TARGET:%s at address 0x%x\n",
-					target_name,
-					readl_relaxed(l3_targ_slvofslsb));
-				/* clear the std error log*/
-				clear = std_err_main | CLEAR_STDERR_LOG;
-				writel_relaxed(clear, l3_targ_stderr);
+				err_description = "Standard";
+				snprintf(err_string, sizeof(err_string),
+					 ": At Address: 0x%08X",
+					 readl_relaxed(l3_targ_slvofslsb));
 				break;
 
 			case CUSTOM_ERROR:
-				for (k = 0; k < NUM_OF_L3_MASTERS; k++) {
-					if (masterid == l3_masters[k].id)
-						master_name =
-							l3_masters[k].name;
-				}
-				WARN(true, "L3 custom error: MASTER:%s TARGET:%s\n",
-					master_name, target_name);
-				/* clear the std error log*/
-				clear = std_err_main | CLEAR_STDERR_LOG;
-				writel_relaxed(clear, l3_targ_stderr);
+				err_description = "Custom";
 				break;
 
 			default:
+				std_err = false;
 				/* Nothing to be handled here as of now */
 				break;
 			}
-		/* Error found so break the for loop */
-		break;
+
+			if (std_err) {
+				WARN(true,
+				     "L3 %s Error: MASTER %s TARGET %s %s\n",
+				     err_description,
+				     master_name, target_name,
+				     err_string);
+				/* clear the std error log*/
+				clear = std_err_main | CLEAR_STDERR_LOG;
+				writel_relaxed(clear, l3_targ_stderr);
+			}
+
+			/* Error found so break the for loop */
+			break;
 		}
 	}
 	return IRQ_HANDLED;
-- 
1.7.9.5
