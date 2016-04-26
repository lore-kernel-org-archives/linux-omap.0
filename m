From: Franklin S Cooper Jr <fcooper@ti.com>
Subject: [PATCH v7 1/9] clk: ti: am335x/am4372: Add tbclk to pwm node
Date: Tue, 26 Apr 2016 17:36:41 -0500
Message-ID: <1461710209-6563-2-git-send-email-fcooper@ti.com>
References: <1461710209-6563-1-git-send-email-fcooper@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1461710209-6563-1-git-send-email-fcooper@ti.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: thierry.reding@gmail.com, robh+dt@kernel.org, tony@atomide.com, paul@pwsan.com, t-kristo@ti.com, linux-pwm@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-clk@vger.kernel.org, vigneshr@ti.com, nsekhar@ti.com
Cc: Franklin S Cooper Jr <fcooper@ti.com>
List-Id: linux-omap@vger.kernel.org

Add tblck to the pwm nodes. This insures that the ehrpwm driver has access
to the time-based clk.

Do not remove similar entries for ehrpwm node. Later patches will switch
from using ehrpwm node name to pwm. But to maintain ABI compatibility we
shouldn't remove the old entries.

Signed-off-by: Franklin S Cooper Jr <fcooper@ti.com>
Acked-by: Stephen Boyd <sboyd@codeaurora.org>
---
 drivers/clk/ti/clk-33xx.c | 3 +++
 drivers/clk/ti/clk-43xx.c | 6 ++++++
 2 files changed, 9 insertions(+)

diff --git a/drivers/clk/ti/clk-33xx.c b/drivers/clk/ti/clk-33xx.c
index ef2ec64..0e47d95 100644
--- a/drivers/clk/ti/clk-33xx.c
+++ b/drivers/clk/ti/clk-33xx.c
@@ -108,6 +108,9 @@ static struct ti_dt_clk am33xx_clks[] = {
 	DT_CLK("48300200.ehrpwm", "tbclk", "ehrpwm0_tbclk"),
 	DT_CLK("48302200.ehrpwm", "tbclk", "ehrpwm1_tbclk"),
 	DT_CLK("48304200.ehrpwm", "tbclk", "ehrpwm2_tbclk"),
+	DT_CLK("48300200.pwm", "tbclk", "ehrpwm0_tbclk"),
+	DT_CLK("48302200.pwm", "tbclk", "ehrpwm1_tbclk"),
+	DT_CLK("48304200.pwm", "tbclk", "ehrpwm2_tbclk"),
 	{ .node_name = NULL },
 };
 
diff --git a/drivers/clk/ti/clk-43xx.c b/drivers/clk/ti/clk-43xx.c
index 097fc90..7255aa8 100644
--- a/drivers/clk/ti/clk-43xx.c
+++ b/drivers/clk/ti/clk-43xx.c
@@ -115,6 +115,12 @@ static struct ti_dt_clk am43xx_clks[] = {
 	DT_CLK("48306200.ehrpwm", "tbclk", "ehrpwm3_tbclk"),
 	DT_CLK("48308200.ehrpwm", "tbclk", "ehrpwm4_tbclk"),
 	DT_CLK("4830a200.ehrpwm", "tbclk", "ehrpwm5_tbclk"),
+	DT_CLK("48300200.pwm", "tbclk", "ehrpwm0_tbclk"),
+	DT_CLK("48302200.pwm", "tbclk", "ehrpwm1_tbclk"),
+	DT_CLK("48304200.pwm", "tbclk", "ehrpwm2_tbclk"),
+	DT_CLK("48306200.pwm", "tbclk", "ehrpwm3_tbclk"),
+	DT_CLK("48308200.pwm", "tbclk", "ehrpwm4_tbclk"),
+	DT_CLK("4830a200.pwm", "tbclk", "ehrpwm5_tbclk"),
 	{ .node_name = NULL },
 };
 
-- 
2.7.0
