From: Nishanth Menon <nm@ti.com>
Subject: [PATCH 03/15] bus: omap_l3_noc: un-obfuscate l3_targ address
 computation
Date: Mon, 14 Apr 2014 11:25:14 -0500
Message-ID: <1397492726-17203-5-git-send-email-nm@ti.com>
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

just simplify derefencing that is equivalent.

Signed-off-by: Nishanth Menon <nm@ti.com>
---
 drivers/bus/omap_l3_noc.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/bus/omap_l3_noc.c b/drivers/bus/omap_l3_noc.c
index 0d346e6..b39ef93 100644
--- a/drivers/bus/omap_l3_noc.c
+++ b/drivers/bus/omap_l3_noc.c
@@ -76,7 +76,7 @@ static irqreturn_t l3_interrupt_handler(int irq, void *_l3)
 			err_src = __ffs(err_reg);
 
 			/* Read the stderrlog_main_source from clk domain */
-			l3_targ_base = base + *(l3_targ[i] + err_src);
+			l3_targ_base = base + l3_targ[i][err_src];
 			l3_targ_stderr = l3_targ_base + L3_TARG_STDERRLOG_MAIN;
 			l3_targ_slvofslsb = l3_targ_base +
 					    L3_TARG_STDERRLOG_SLVOFSLSB;
-- 
1.7.9.5
