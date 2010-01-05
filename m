From: Paul Walmsley <paul@pwsan.com>
Subject: [PATCH] OMAP1 clock: remove __initdata from struct clk_functions to
 prevent crash
Date: Mon, 4 Jan 2010 20:00:01 -0700 (MST)
Message-ID: <alpine.DEB.2.00.1001041958240.30892@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:58214 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754207Ab0AEDAC (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 4 Jan 2010 22:00:02 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: darkstar6262@gmail.com


From: Cory Maccarrone <darkstar6262@gmail.com>

Commit 52650505fbf3a6ab851c801f54e73e76c55ab8da added an __initdata
decoration to the structure containing the clk_enable and clk_disable
functions.  Once init data was freed, these pointers went to null, and
the next enable or disable call caused the kernel to crash.  This
change removes this decoration.

Signed-off-by: Cory Maccarrone <darkstar6262@gmail.com>
[paul@pwsan.com: patch manually split and commit message edited]
Signed-off-by: Paul Walmsley <paul@pwsan.com>

[Queued for the next 2.6.33-rc clock fixes]

---
 arch/arm/mach-omap1/clock_data.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-omap1/clock_data.c b/arch/arm/mach-omap1/clock_data.c
index 31fba07..8a85bbb 100644
--- a/arch/arm/mach-omap1/clock_data.c
+++ b/arch/arm/mach-omap1/clock_data.c
@@ -674,7 +674,7 @@ static struct omap_clk omap_clks[] = {
  * init
  */
 
-static struct clk_functions omap1_clk_functions __initdata = {
+static struct clk_functions omap1_clk_functions = {
 	.clk_enable		= omap1_clk_enable,
 	.clk_disable		= omap1_clk_disable,
 	.clk_round_rate		= omap1_clk_round_rate,
-- 
1.6.6.rc2.5.g49666


