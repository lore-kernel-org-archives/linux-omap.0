From: Bill Pemberton <wfp5p@virginia.edu>
Subject: [PATCH 253/493] hwspinlock: remove use of __devinit
Date: Mon, 19 Nov 2012 13:23:22 -0500
Message-ID: <1353349642-3677-253-git-send-email-wfp5p@virginia.edu>
References: <1353349642-3677-1-git-send-email-wfp5p@virginia.edu>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from viridian.itc.Virginia.EDU ([128.143.12.139]:41863 "EHLO
	viridian.itc.virginia.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754621Ab2KSSnD (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 19 Nov 2012 13:43:03 -0500
In-Reply-To: <1353349642-3677-1-git-send-email-wfp5p@virginia.edu>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: gregkh@linuxfoundation.org
Cc: Ohad Ben-Cohen <ohad@wizery.com>, Srinidhi Kasagar <srinidhi.kasagar@stericsson.com>, Linus Walleij <linus.walleij@linaro.org>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

CONFIG_HOTPLUG is going away as an option so __devinit is no longer
needed.

Signed-off-by: Bill Pemberton <wfp5p@virginia.edu>
Cc: Ohad Ben-Cohen <ohad@wizery.com> 
Cc: Srinidhi Kasagar <srinidhi.kasagar@stericsson.com> 
Cc: Linus Walleij <linus.walleij@linaro.org> 
Cc: linux-omap@vger.kernel.org 
Cc: linux-arm-kernel@lists.infradead.org 
---
 drivers/hwspinlock/omap_hwspinlock.c | 2 +-
 drivers/hwspinlock/u8500_hsem.c      | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/hwspinlock/omap_hwspinlock.c b/drivers/hwspinlock/omap_hwspinlock.c
index 28640b8..f21b2ed 100644
--- a/drivers/hwspinlock/omap_hwspinlock.c
+++ b/drivers/hwspinlock/omap_hwspinlock.c
@@ -78,7 +78,7 @@ static const struct hwspinlock_ops omap_hwspinlock_ops = {
 	.relax = omap_hwspinlock_relax,
 };
 
-static int __devinit omap_hwspinlock_probe(struct platform_device *pdev)
+static int omap_hwspinlock_probe(struct platform_device *pdev)
 {
 	struct hwspinlock_pdata *pdata = pdev->dev.platform_data;
 	struct hwspinlock_device *bank;
diff --git a/drivers/hwspinlock/u8500_hsem.c b/drivers/hwspinlock/u8500_hsem.c
index 4039810..5a5b3f2 100644
--- a/drivers/hwspinlock/u8500_hsem.c
+++ b/drivers/hwspinlock/u8500_hsem.c
@@ -91,7 +91,7 @@ static const struct hwspinlock_ops u8500_hwspinlock_ops = {
 	.relax		= u8500_hsem_relax,
 };
 
-static int __devinit u8500_hsem_probe(struct platform_device *pdev)
+static int u8500_hsem_probe(struct platform_device *pdev)
 {
 	struct hwspinlock_pdata *pdata = pdev->dev.platform_data;
 	struct hwspinlock_device *bank;
-- 
1.8.0

