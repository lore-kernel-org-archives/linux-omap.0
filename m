From: Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH 1/5] clk: at91: Use of_clk_get_parent_count() instead of open coding
Date: Fri, 29 May 2015 11:25:45 +0200
Message-ID: <1432891549-23295-2-git-send-email-geert+renesas@glider.be>
References: <1432891549-23295-1-git-send-email-geert+renesas@glider.be>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from xavier.telenet-ops.be ([195.130.132.52]:52362 "EHLO
	xavier.telenet-ops.be" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755692AbbE2J0K (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 29 May 2015 05:26:10 -0400
In-Reply-To: <1432891549-23295-1-git-send-email-geert+renesas@glider.be>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Boris Brezillon <boris.brezillon@free-electrons.com>, Maxime Coquelin <maxime.coquelin@st.com>, Patrice Chotard <patrice.chotard@st.com>, Tero Kristo <t-kristo@ti.com>, Mike Turquette <mturquette@linaro.org>, Stephen Boyd <sboyd@codeaurora.org>, Russell King <linux@arm.linux.org.uk>
Cc: linux-clk@vger.kernel.org, kernel@stlinux.com, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Geert Uytterhoeven <geert+renesas@glider.be>

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 drivers/clk/at91/clk-main.c         | 2 +-
 drivers/clk/at91/clk-master.c       | 2 +-
 drivers/clk/at91/clk-programmable.c | 2 +-
 drivers/clk/at91/clk-slow.c         | 4 ++--
 drivers/clk/at91/clk-smd.c          | 2 +-
 drivers/clk/at91/clk-usb.c          | 2 +-
 6 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/clk/at91/clk-main.c b/drivers/clk/at91/clk-main.c
index 59fa3cc96c9eb341..c2400456a0447118 100644
--- a/drivers/clk/at91/clk-main.c
+++ b/drivers/clk/at91/clk-main.c
@@ -614,7 +614,7 @@ void __init of_at91sam9x5_clk_main_setup(struct device_node *np,
 	const char *name = np->name;
 	int i;
 
-	num_parents = of_count_phandle_with_args(np, "clocks", "#clock-cells");
+	num_parents = of_clk_get_parent_count(np);
 	if (num_parents <= 0 || num_parents > 2)
 		return;
 
diff --git a/drivers/clk/at91/clk-master.c b/drivers/clk/at91/clk-master.c
index c1af80bcdf2082c8..f98eafe9b12dc92d 100644
--- a/drivers/clk/at91/clk-master.c
+++ b/drivers/clk/at91/clk-master.c
@@ -224,7 +224,7 @@ of_at91_clk_master_setup(struct device_node *np, struct at91_pmc *pmc,
 	const char *name = np->name;
 	struct clk_master_characteristics *characteristics;
 
-	num_parents = of_count_phandle_with_args(np, "clocks", "#clock-cells");
+	num_parents = of_clk_get_parent_count(np);
 	if (num_parents <= 0 || num_parents > MASTER_SOURCE_MAX)
 		return;
 
diff --git a/drivers/clk/at91/clk-programmable.c b/drivers/clk/at91/clk-programmable.c
index 86c8a073dcc32a20..8c86c0f7847a55a0 100644
--- a/drivers/clk/at91/clk-programmable.c
+++ b/drivers/clk/at91/clk-programmable.c
@@ -237,7 +237,7 @@ of_at91_clk_prog_setup(struct device_node *np, struct at91_pmc *pmc,
 	const char *name;
 	struct device_node *progclknp;
 
-	num_parents = of_count_phandle_with_args(np, "clocks", "#clock-cells");
+	num_parents = of_clk_get_parent_count(np);
 	if (num_parents <= 0 || num_parents > PROG_SOURCE_MAX)
 		return;
 
diff --git a/drivers/clk/at91/clk-slow.c b/drivers/clk/at91/clk-slow.c
index 2f13bd5246b5563e..98a84a865fe1cf1b 100644
--- a/drivers/clk/at91/clk-slow.c
+++ b/drivers/clk/at91/clk-slow.c
@@ -373,7 +373,7 @@ void __init of_at91sam9x5_clk_slow_setup(struct device_node *np,
 	const char *name = np->name;
 	int i;
 
-	num_parents = of_count_phandle_with_args(np, "clocks", "#clock-cells");
+	num_parents = of_clk_get_parent_count(np);
 	if (num_parents <= 0 || num_parents > 2)
 		return;
 
@@ -451,7 +451,7 @@ void __init of_at91sam9260_clk_slow_setup(struct device_node *np,
 	const char *name = np->name;
 	int i;
 
-	num_parents = of_count_phandle_with_args(np, "clocks", "#clock-cells");
+	num_parents = of_clk_get_parent_count(np);
 	if (num_parents != 2)
 		return;
 
diff --git a/drivers/clk/at91/clk-smd.c b/drivers/clk/at91/clk-smd.c
index 144d47ecfe63c6eb..3817ea865ca258ec 100644
--- a/drivers/clk/at91/clk-smd.c
+++ b/drivers/clk/at91/clk-smd.c
@@ -150,7 +150,7 @@ void __init of_at91sam9x5_clk_smd_setup(struct device_node *np,
 	const char *parent_names[SMD_SOURCE_MAX];
 	const char *name = np->name;
 
-	num_parents = of_count_phandle_with_args(np, "clocks", "#clock-cells");
+	num_parents = of_clk_get_parent_count(np);
 	if (num_parents <= 0 || num_parents > SMD_SOURCE_MAX)
 		return;
 
diff --git a/drivers/clk/at91/clk-usb.c b/drivers/clk/at91/clk-usb.c
index 0b7c3e8840bae0eb..b0cbd2b1ff595702 100644
--- a/drivers/clk/at91/clk-usb.c
+++ b/drivers/clk/at91/clk-usb.c
@@ -378,7 +378,7 @@ void __init of_at91sam9x5_clk_usb_setup(struct device_node *np,
 	const char *parent_names[USB_SOURCE_MAX];
 	const char *name = np->name;
 
-	num_parents = of_count_phandle_with_args(np, "clocks", "#clock-cells");
+	num_parents = of_clk_get_parent_count(np);
 	if (num_parents <= 0 || num_parents > USB_SOURCE_MAX)
 		return;
 
-- 
1.9.1

