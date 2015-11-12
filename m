From: Luis Henriques <luis.henriques@canonical.com>
Subject: [3.16.y-ckt stable] Patch "clk: ti: fix dual-registration of uart4_ick" has been added to staging queue
Date: Thu, 12 Nov 2015 16:45:25 +0000
Message-ID: <1447346725-29637-1-git-send-email-luis.henriques@canonical.com>
Return-path: <linux-clk-owner@vger.kernel.org>
Sender: linux-clk-owner@vger.kernel.org
To: Ben Dooks <ben.dooks@codethink.co.uk>
Cc: mturquette@baylibre.com, sboyd@codeaurora.org, linux-clk@vger.kernel.org, linux-omap@vger.kernel.org, linux-kernel@lists.codethink.co.uk, Tero Kristo <t-kristo@ti.com>, Luis Henriques <luis.henriques@canonical.com>, kernel-team@lists.ubuntu.com
List-Id: linux-omap@vger.kernel.org

This is a note to let you know that I have just added a patch titled

    clk: ti: fix dual-registration of uart4_ick

to the linux-3.16.y-queue branch of the 3.16.y-ckt extended stable tree 
which can be found at:

    http://kernel.ubuntu.com/git/ubuntu/linux.git/log/?h=linux-3.16.y-queue

This patch is scheduled to be released in version 3.16.7-ckt20.

If you, or anyone else, feels it should not be added to this tree, please 
reply to this email.

For more information about the 3.16.y-ckt tree, see
https://wiki.ubuntu.com/Kernel/Dev/ExtendedStable

Thanks.
-Luis

------

>From 30b9c68b905ec04f247510518022db8faec47292 Mon Sep 17 00:00:00 2001
From: Ben Dooks <ben.dooks@codethink.co.uk>
Date: Tue, 29 Sep 2015 15:01:08 +0100
Subject: clk: ti: fix dual-registration of uart4_ick

commit 19e79687de22f23bcfb5e79cce3daba20af228d1 upstream.

On the OMAP AM3517 platform the uart4_ick gets registered
twice, causing any power management to /dev/ttyO3 to fail
when trying to wake the device up.

This solves the following oops:

[] Unhandled fault: external abort on non-linefetch (0x1028) at 0xfa09e008
[] PC is at serial_omap_pm+0x48/0x15c
[] LR is at _raw_spin_unlock_irqrestore+0x30/0x5c

Fixes: aafd900cab87 ("CLK: TI: add omap3 clock init file")
Cc: mturquette@baylibre.com
Cc: sboyd@codeaurora.org
Cc: linux-clk@vger.kernel.org
Cc: linux-omap@vger.kernel.org
Cc: linux-kernel@lists.codethink.co.uk
Signed-off-by: Ben Dooks <ben.dooks@codethink.co.uk>
Signed-off-by: Tero Kristo <t-kristo@ti.com>
Signed-off-by: Luis Henriques <luis.henriques@canonical.com>
---
 drivers/clk/ti/clk-3xxx.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/clk/ti/clk-3xxx.c b/drivers/clk/ti/clk-3xxx.c
index 0d1750a8aea4..088930c3ee4b 100644
--- a/drivers/clk/ti/clk-3xxx.c
+++ b/drivers/clk/ti/clk-3xxx.c
@@ -170,7 +170,6 @@ static struct ti_dt_clk omap3xxx_clks[] = {
 	DT_CLK(NULL, "gpio2_ick", "gpio2_ick"),
 	DT_CLK(NULL, "wdt3_ick", "wdt3_ick"),
 	DT_CLK(NULL, "uart3_ick", "uart3_ick"),
-	DT_CLK(NULL, "uart4_ick", "uart4_ick"),
 	DT_CLK(NULL, "gpt9_ick", "gpt9_ick"),
 	DT_CLK(NULL, "gpt8_ick", "gpt8_ick"),
 	DT_CLK(NULL, "gpt7_ick", "gpt7_ick"),
@@ -313,6 +312,7 @@ static struct ti_dt_clk am35xx_clks[] = {
 static struct ti_dt_clk omap36xx_clks[] = {
 	DT_CLK(NULL, "omap_192m_alwon_fck", "omap_192m_alwon_fck"),
 	DT_CLK(NULL, "uart4_fck", "uart4_fck"),
+	DT_CLK(NULL, "uart4_ick", "uart4_ick"),
 	{ .node_name = NULL },
 };

