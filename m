From: Nishanth Menon <nm@ti.com>
Subject: [PATCH V3 13/20] bus: omap_l3_noc: make error reporting and handling
 common
Date: Mon, 28 Apr 2014 10:14:53 -0500
Message-ID: <1398698101-25513-14-git-send-email-nm@ti.com>
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

The logic between handling CUSTOM_ERROR and STANDARD_ERROR is just the
reporting style.

So make it generic, simplify and standardize the reporting with both
master and target information printed to log.

Handle the register address difference for master code for standard
error and custom error as well.

While at it, fix a minor indentation error.

Signed-off-by: Nishanth Menon <nm@ti.com>
Acked-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
Acked-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
Tested-by: Darren Etheridge <detheridge@ti.com>
---
V3: no change

 drivers/bus/omap_l3_noc.c |   72 ++++++++++++++++++++++++++++-----------------
 drivers/bus/omap_l3_noc.h |    3 +-
 2 files changed, 47 insertions(+), 28 deletions(-)

diff --git a/drivers/bus/omap_l3_noc.c b/drivers/bus/omap_l3_noc.c
index 8a1926d..42e4114 100644
--- a/drivers/bus/omap_l3_noc.c
+++ b/drivers/bus/omap_l3_noc.c
@@ -62,6 +62,8 @@ static irqreturn_t l3_interrupt_handler(int irq, void *_l3)
 	struct l3_target_data *l3_targ_inst;
 	struct l3_flagmux_data *flag_mux;
 	struct l3_masters_data *master;
+	char *err_description;
+	char err_string[30] = { 0 };
 
 	/* Get the Type of interrupt */
 	inttype = irq == l3->app_irq ? L3_APPLICATION_ERROR : L3_DEBUG_ERROR;
@@ -78,6 +80,8 @@ static irqreturn_t l3_interrupt_handler(int irq, void *_l3)
 
 		/* Get the corresponding error and analyse */
 		if (err_reg) {
+			bool std_err = true;
+
 			/* Identify the source from control status register */
 			err_src = __ffs(err_reg);
 
@@ -123,47 +127,61 @@ static irqreturn_t l3_interrupt_handler(int irq, void *_l3)
 			l3_targ_stderr = l3_targ_base + L3_TARG_STDERRLOG_MAIN;
 			l3_targ_slvofslsb = l3_targ_base +
 					    L3_TARG_STDERRLOG_SLVOFSLSB;
-			l3_targ_mstaddr = l3_targ_base +
-					  L3_TARG_STDERRLOG_MSTADDR;
 
 			std_err_main = readl_relaxed(l3_targ_stderr);
 
-			/* STDERRLOG_MSTADDR Stores the NTTP master address. */
-			masterid = (readl_relaxed(l3_targ_mstaddr) &
-				    l3->mst_addr_mask) >>
-					__ffs(l3->mst_addr_mask);
-
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
+					 ": At Address: 0x%08X ",
+					 readl_relaxed(l3_targ_slvofslsb));
+
+				l3_targ_mstaddr = l3_targ_base +
+						L3_TARG_STDERRLOG_MSTADDR;
 				break;
 
 			case CUSTOM_ERROR:
-				for (k = 0, master = l3->l3_masters;
-				     k < l3->num_masters; k++, master++) {
-					if (masterid == master->id) {
-						master_name = master->name;
-						break;
-					}
-				}
-				WARN(true, "L3 custom error: MASTER:%s TARGET:%s\n",
-					master_name, target_name);
-				/* clear the std error log*/
-				clear = std_err_main | CLEAR_STDERR_LOG;
-				writel_relaxed(clear, l3_targ_stderr);
+				err_description = "Custom";
+
+				l3_targ_mstaddr = l3_targ_base +
+						L3_TARG_STDERRLOG_CINFO_MSTADDR;
 				break;
 
 			default:
+				std_err = false;
 				/* Nothing to be handled here as of now */
 				break;
 			}
-		/* Error found so break the for loop */
-		break;
+
+			if (!std_err)
+				break;
+
+			/* STDERRLOG_MSTADDR Stores the NTTP master address. */
+			masterid = (readl_relaxed(l3_targ_mstaddr) &
+				    l3->mst_addr_mask) >>
+					__ffs(l3->mst_addr_mask);
+
+			for (k = 0, master = l3->l3_masters;
+			     k < l3->num_masters; k++, master++) {
+				if (masterid == master->id) {
+					master_name = master->name;
+					break;
+				}
+			}
+
+			WARN(true,
+			     "%s:L3 %s Error: MASTER %s TARGET %s%s\n",
+			     dev_name(l3->dev),
+			     err_description,
+			     master_name, target_name,
+			     err_string);
+			/* clear the std error log*/
+			clear = std_err_main | CLEAR_STDERR_LOG;
+			writel_relaxed(clear, l3_targ_stderr);
+
+			/* Error found so break the for loop */
+			break;
 		}
 	}
 	return IRQ_HANDLED;
diff --git a/drivers/bus/omap_l3_noc.h b/drivers/bus/omap_l3_noc.h
index ba86924..ea2f51c 100644
--- a/drivers/bus/omap_l3_noc.h
+++ b/drivers/bus/omap_l3_noc.h
@@ -29,8 +29,9 @@
 
 /* L3 TARG register offsets */
 #define L3_TARG_STDERRLOG_MAIN		0x48
+#define L3_TARG_STDERRLOG_MSTADDR	0x50
 #define L3_TARG_STDERRLOG_SLVOFSLSB	0x5c
-#define L3_TARG_STDERRLOG_MSTADDR	0x68
+#define L3_TARG_STDERRLOG_CINFO_MSTADDR	0x68
 #define L3_FLAGMUX_REGERR0		0xc
 #define L3_FLAGMUX_MASK0		0x8
 
-- 
1.7.9.5
