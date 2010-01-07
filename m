From: Paul Walmsley <paul@pwsan.com>
Subject: [PATCH v2 1/5] OMAP1 clock: remove __initdata from struct clk_functions
	to prevent crash
Date: Wed, 06 Jan 2010 18:22:01 -0700
Message-ID: <20100107012159.3551.65260.stgit@localhost.localdomain>
References: <20100107011932.3551.75659.stgit@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:37134 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755903Ab0AGBYR (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 6 Jan 2010 20:24:17 -0500
In-Reply-To: <20100107011932.3551.75659.stgit@localhost.localdomain>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: Cory Maccarrone <darkstar6262@gmail.com>

From: Cory Maccarrone <darkstar6262@gmail.com>

Commit 52650505fbf3a6ab851c801f54e73e76c55ab8da added an __initdata
decoration to the structure containing the clk_enable and clk_disable
functions.  Once init data was freed, these pointers went to null, and
the next enable or disable call caused the kernel to crash.  This
change removes this decoration.

Signed-off-by: Cory Maccarrone <darkstar6262@gmail.com>
[paul@pwsan.com: patch manually split and commit message edited]
Signed-off-by: Paul Walmsley <paul@pwsan.com>
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


