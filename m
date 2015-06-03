From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 02/12] ARM: OMAP2+: Fix scrm compatible for dm814x
Date: Wed,  3 Jun 2015 09:23:11 -0700
Message-ID: <1433348601-8966-3-git-send-email-tony@atomide.com>
References: <1433348601-8966-1-git-send-email-tony@atomide.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from pmta2.delivery5.ore.mailhop.org ([54.186.218.12]:13042 "HELO
	pmta2.delivery5.ore.mailhop.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1756031AbbFCQXr (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 3 Jun 2015 12:23:47 -0400
In-Reply-To: <1433348601-8966-1-git-send-email-tony@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org, Matthijs van Duin <matthijsvanduin@gmail.com>

Fix scrm compatible for dm814x.

Cc: Matthijs van Duin <matthijsvanduin@gmail.com>
Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 arch/arm/mach-omap2/control.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/mach-omap2/control.c b/arch/arm/mach-omap2/control.c
index af95a62..364925c 100644
--- a/arch/arm/mach-omap2/control.c
+++ b/arch/arm/mach-omap2/control.c
@@ -649,6 +649,7 @@ static const struct of_device_id omap_scrm_dt_match_table[] = {
 	{ .compatible = "ti,am4-scm", .data = &ctrl_data },
 	{ .compatible = "ti,omap2-scm", .data = &omap2_ctrl_data },
 	{ .compatible = "ti,omap3-scm", .data = &omap2_ctrl_data },
+	{ .compatible = "ti,dm814-scm", .data = &ctrl_data },
 	{ .compatible = "ti,dm816-scrm", .data = &ctrl_data },
 	{ .compatible = "ti,omap4-scm-core", .data = &ctrl_data },
 	{ .compatible = "ti,omap5-scm-core", .data = &ctrl_data },
-- 
2.1.4

