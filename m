From: Vignesh R <vigneshr@ti.com>
Subject: [PATCH 4/5] clk: ti: DRA7: Add tbclk data for ehrpwm
Date: Mon, 1 Jun 2015 17:23:33 +0530
Message-ID: <1433159614-437-5-git-send-email-vigneshr@ti.com>
References: <1433159614-437-1-git-send-email-vigneshr@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1433159614-437-1-git-send-email-vigneshr@ti.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Paul Walmsley <paul@pwsan.com>, Tero Kristo <t-kristo@ti.com>, Thierry Reding <thierry.reding@gmail.com>, Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, Benoit Cousson <bcousson@baylibre.com>, Tony Lindgren <tony@atomide.com>, Russell King <linux@arm.linux.org.uk>, Mike Turquette <mturquette@linaro.org>, Stephen Boyd <sboyd@codeaurora.org>
Cc: linux-pwm@vger.kernel.org, Vignesh R <vigneshr@ti.com>, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

tbclk is needed by ehrpwm to generate pwm waveforms. Hence, register
the required clock information.

Signed-off-by: Vignesh R <vigneshr@ti.com>
---
 drivers/clk/ti/clk-7xx.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/clk/ti/clk-7xx.c b/drivers/clk/ti/clk-7xx.c
index 5d2217ae4478..366be43d15fe 100644
--- a/drivers/clk/ti/clk-7xx.c
+++ b/drivers/clk/ti/clk-7xx.c
@@ -304,6 +304,9 @@ static struct ti_dt_clk dra7xx_clks[] = {
 	DT_CLK("4882a000.timer", "timer_sys_ck", "timer_sys_clk_div"),
 	DT_CLK("4882c000.timer", "timer_sys_ck", "timer_sys_clk_div"),
 	DT_CLK("4882e000.timer", "timer_sys_ck", "timer_sys_clk_div"),
+	DT_CLK("4843e200.ehrpwm", "tbclk", "ehrpwm0_tbclk"),
+	DT_CLK("48440200.ehrpwm", "tbclk", "ehrpwm1_tbclk"),
+	DT_CLK("48442200.ehrpwm", "tbclk", "ehrpwm2_tbclk"),
 	DT_CLK(NULL, "sys_clkin", "sys_clkin1"),
 	{ .node_name = NULL },
 };
-- 
2.4.1
