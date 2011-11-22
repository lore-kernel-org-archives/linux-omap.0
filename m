From: Mike Turquette <mturquette@ti.com>
Subject: [PATCH v3 1/5] clk: Kconfig: add entry for HAVE_CLK_PREPARE
Date: Mon, 21 Nov 2011 17:40:43 -0800
Message-ID: <1321926047-14211-2-git-send-email-mturquette@linaro.org>
References: <1321926047-14211-1-git-send-email-mturquette@linaro.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1321926047-14211-1-git-send-email-mturquette@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux@arm.linux.org.uk
Cc: linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, jeremy.kerr@canonical.com, broonie@opensource.wolfsonmicro.com, tglx@linutronix.de, linus.walleij@stericsson.com, amit.kucheria@linaro.org, dsaxena@linaro.org, patches@linaro.org, linaro-dev@lists.linaro.org, aul@pwsan.com, grant.likely@secretlab.ca, sboyd@quicinc.com, shawn.guo@freescale.com, skannan@quicinc.com, magnus.damm@gmail.com, arnd.bergmann@linaro.org, eric.miao@linaro.org, richard.zhao@linaro.org, mturquette@ti.com, Mike Turquette <mturquette@linaro.org>
List-Id: linux-omap@vger.kernel.org

The common clk framework provides clk_prepare and clk_unprepare
implementations.  Create an entry for HAVE_CLK_PREPARE so that
GENERIC_CLK can select it.

Signed-off-by: Mike Turquette <mturquette@linaro.org>
---
 drivers/clk/Kconfig |    3 +++
 1 files changed, 3 insertions(+), 0 deletions(-)

diff --git a/drivers/clk/Kconfig b/drivers/clk/Kconfig
index 3530927..7a9899bd 100644
--- a/drivers/clk/Kconfig
+++ b/drivers/clk/Kconfig
@@ -5,3 +5,6 @@ config CLKDEV_LOOKUP
 
 config HAVE_MACH_CLKDEV
 	bool
+
+config HAVE_CLK_PREPARE
+	bool
-- 
1.7.4.1
