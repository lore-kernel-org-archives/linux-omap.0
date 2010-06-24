From: Paul Walmsley <paul@pwsan.com>
Subject: [PATCH] OMAP: hwmod: Fix the missing braces
Date: Wed, 23 Jun 2010 18:24:47 -0600
Message-ID: <20100624002438.12347.60529.stgit@localhost.localdomain>
References: <20100624002249.12347.37548.stgit@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:33473 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751520Ab0FXAZo (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 23 Jun 2010 20:25:44 -0400
In-Reply-To: <20100624002249.12347.37548.stgit@localhost.localdomain>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: Benoit Cousson <b-cousson@ti.com>, Sergei Shtylyov <sshtylyov@mvista.com>, Anand Gadiyar <gadiyar@ti.com>

From: Benoit Cousson <b-cousson@ti.com>

As reported by Sergei, a couple of braces were missing after
the WARN removal patch.

[07/22] OMAP: hwmod: Replace WARN by pr_warning if clock lookup failed

https://patchwork.kernel.org/patch/100756/

Signed-off-by: Benoit Cousson <b-cousson@ti.com>
[paul@pwsan.com: fixed patch description per Anand's E-mail]
Signed-off-by: Paul Walmsley <paul@pwsan.com>
Cc: Sergei Shtylyov <sshtylyov@mvista.com>
Cc: Anand Gadiyar <gadiyar@ti.com>
---
 arch/arm/mach-omap2/omap_hwmod.c |    9 ++++++---
 1 files changed, 6 insertions(+), 3 deletions(-)

diff --git a/arch/arm/mach-omap2/omap_hwmod.c b/arch/arm/mach-omap2/omap_hwmod.c
index 95c9a5f..b7a4133 100644
--- a/arch/arm/mach-omap2/omap_hwmod.c
+++ b/arch/arm/mach-omap2/omap_hwmod.c
@@ -409,10 +409,11 @@ static int _init_main_clk(struct omap_hwmod *oh)
 		return 0;
 
 	oh->_clk = omap_clk_get_by_name(oh->main_clk);
-	if (!oh->_clk)
+	if (!oh->_clk) {
 		pr_warning("omap_hwmod: %s: cannot clk_get main_clk %s\n",
 			   oh->name, oh->main_clk);
 		return -EINVAL;
+	}
 
 	if (!oh->_clk->clkdm)
 		pr_warning("omap_hwmod: %s: missing clockdomain for %s.\n",
@@ -444,10 +445,11 @@ static int _init_interface_clks(struct omap_hwmod *oh)
 			continue;
 
 		c = omap_clk_get_by_name(os->clk);
-		if (!c)
+		if (!c) {
 			pr_warning("omap_hwmod: %s: cannot clk_get interface_clk %s\n",
 				   oh->name, os->clk);
 			ret = -EINVAL;
+		}
 		os->_clk = c;
 	}
 
@@ -470,10 +472,11 @@ static int _init_opt_clks(struct omap_hwmod *oh)
 
 	for (i = oh->opt_clks_cnt, oc = oh->opt_clks; i > 0; i--, oc++) {
 		c = omap_clk_get_by_name(oc->clk);
-		if (!c)
+		if (!c) {
 			pr_warning("omap_hwmod: %s: cannot clk_get opt_clk %s\n",
 				   oh->name, oc->clk);
 			ret = -EINVAL;
+		}
 		oc->_clk = c;
 	}
 


