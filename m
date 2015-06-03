From: Vignesh R <vigneshr@ti.com>
Subject: [PATCH v2 4/5] clk: ti: DRA7: Add tbclk data for ehrpwm
Date: Wed, 3 Jun 2015 17:21:23 +0530
Message-ID: <1433332284-10766-5-git-send-email-vigneshr@ti.com>
References: <1433332284-10766-1-git-send-email-vigneshr@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1433332284-10766-1-git-send-email-vigneshr@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>, Tero Kristo <t-kristo@ti.com>, Thierry Reding <thierry.reding@gmail.com>, Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, Benoit Cousson <bcousson@baylibre.com>, Tony Lindgren <tony@atomide.com>, Russell King <linux@arm.linux.org.uk>, Mike Turquette <mturquette@linaro.org>, Stephen Boyd <sboyd@codeaurora.org>
Cc: linux-pwm@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-clk@vger.kernel.org, Vignesh R <vigneshr@ti.com>
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
