From: Felipe Balbi <balbi@ti.com>
Subject: [PATCH 2/2] arm: omap1: remove unused variables
Date: Tue, 19 Oct 2010 10:30:55 +0300
Message-ID: <1287473455-25773-3-git-send-email-balbi@ti.com>
References: <1287473455-25773-1-git-send-email-balbi@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:33059 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758069Ab0JSHbS (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 19 Oct 2010 03:31:18 -0400
In-Reply-To: <1287473455-25773-1-git-send-email-balbi@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Linux OMAP Mailing List <linux-omap@vger.kernel.org>, linux-arm-kernel@lists.infradead.org, Felipe Balbi <balbi@ti.com>

Get rid of the following warnings:

arch/arm/mach-omap1/pm_bus.c: In function 'omap1_pm_runtime_resume':
arch/arm/mach-omap1/pm_bus.c:51: warning: unused variable 'ret'
arch/arm/mach-omap1/mailbox.c: In function 'omap1_mbox_probe':
arch/arm/mach-omap1/mailbox.c:148: warning: unused variable 'i'

Signed-off-by: Felipe Balbi <balbi@ti.com>
---
 arch/arm/mach-omap1/mailbox.c |    1 -
 arch/arm/mach-omap1/pm_bus.c  |    1 -
 2 files changed, 0 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-omap1/mailbox.c b/arch/arm/mach-omap1/mailbox.c
index 1a85a42..1add133 100644
--- a/arch/arm/mach-omap1/mailbox.c
+++ b/arch/arm/mach-omap1/mailbox.c
@@ -145,7 +145,6 @@ static int __devinit omap1_mbox_probe(struct platform_device *pdev)
 {
 	struct resource *mem;
 	int ret;
-	int i;
 	struct omap_mbox **list;
 
 	list = omap1_mboxes;
diff --git a/arch/arm/mach-omap1/pm_bus.c b/arch/arm/mach-omap1/pm_bus.c
index 8b66392..f97c6e9 100644
--- a/arch/arm/mach-omap1/pm_bus.c
+++ b/arch/arm/mach-omap1/pm_bus.c
@@ -48,7 +48,6 @@ static int omap1_pm_runtime_suspend(struct device *dev)
 
 static int omap1_pm_runtime_resume(struct device *dev)
 {
-	int ret = 0;
 	struct clk *iclk, *fclk;
 
 	dev_dbg(dev, "%s\n", __func__);
-- 
1.7.3.rc0.35.g8ac8c

