From: Hari Kanigeri <h-kanigeri2@ti.com>
Subject: [PATCH 7/7] omap:clocks44x-add dummy clock for mailbox
Date: Wed, 13 Oct 2010 20:33:23 -0500
Message-ID: <1287020003-19667-8-git-send-email-h-kanigeri2@ti.com>
References: <1287020003-19667-1-git-send-email-h-kanigeri2@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:39473 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753806Ab0JNBdu (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 13 Oct 2010 21:33:50 -0400
In-Reply-To: <1287020003-19667-1-git-send-email-h-kanigeri2@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Hiroshi Doyu <Hiroshi.DOYU@nokia.com>, linux omap <linux-omap@vger.kernel.org>
Cc: Tony Lindgren <tony@atomide.com>, Ohad Ben-Cohen <ohad@wizery.com>, Hari Kanigeri <h-kanigeri2@ti.com>

In omap4, there is no explicit configuration register to enable mailbox clocks.
Defining dummy clock for mailbox clock module to keep the mailbox driver
backward compatible with previous omaps.

Signed-off-by: Hari Kanigeri <h-kanigeri2@ti.com>
---
 arch/arm/mach-omap2/clock44xx_data.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap2/clock44xx_data.c b/arch/arm/mach-omap2/clock44xx_data.c
index e10db7a..421ae7f 100644
--- a/arch/arm/mach-omap2/clock44xx_data.c
+++ b/arch/arm/mach-omap2/clock44xx_data.c
@@ -2687,6 +2687,7 @@ static struct omap_clk omap44xx_clks[] = {
 	CLK(NULL,	"uart3_ick",			&dummy_ck,	CK_443X),
 	CLK(NULL,	"uart4_ick",			&dummy_ck,	CK_443X),
 	CLK("omap_wdt",	"ick",				&dummy_ck,	CK_443X),
+	CLK(NULL,	"mailboxes_ick",		&dummy_ck,	CK_443X),
 };
 
 int __init omap4xxx_clk_init(void)
-- 
1.7.0

