From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 01/19] omap3: Fix compile for Touch Book early_param
Date: Thu, 11 Mar 2010 15:48:05 -0800
Message-ID: <20100311234805.4500.75071.stgit@baageli.muru.com>
References: <20100311234404.4500.82861.stgit@baageli.muru.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:52889 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753121Ab0CKXqn (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 11 Mar 2010 18:46:43 -0500
In-Reply-To: <20100311234404.4500.82861.stgit@baageli.muru.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org
Cc: linux-omap@vger.kernel.org

Commit 2b0d8c251b8876d530a6bf671eb5425838fa698a changed ARM to use
the common early_param code. Fix compile for Touch Book accordingly.

Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 arch/arm/mach-omap2/board-omap3touchbook.c |   10 +++++-----
 1 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/arch/arm/mach-omap2/board-omap3touchbook.c b/arch/arm/mach-omap2/board-omap3touchbook.c
index 3943d0f..2a5bf5c 100644
--- a/arch/arm/mach-omap2/board-omap3touchbook.c
+++ b/arch/arm/mach-omap2/board-omap3touchbook.c
@@ -518,14 +518,14 @@ static void omap3_touchbook_poweroff(void)
 	gpio_direction_output(TB_KILL_POWER_GPIO, 0);
 }
 
-static void __init early_touchbook_revision(char **p)
+static int __init early_touchbook_revision(char *p)
 {
-	if (!*p)
-		return;
+	if (!p)
+		return 0;
 
-	strict_strtoul(*p, 10, &touchbook_revision);
+	return strict_strtoul(p, 10, &touchbook_revision);
 }
-__early_param("tbr=", early_touchbook_revision);
+early_param("tbr", early_touchbook_revision);
 
 static struct omap_musb_board_data musb_board_data = {
 	.interface_type		= MUSB_INTERFACE_ULPI,

