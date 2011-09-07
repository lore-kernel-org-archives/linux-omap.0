From: Vikram Pandita <vikram.pandita@ti.com>
Subject: [PATCH 2/2] usb: musb: omap2+: save and restore OTG_INTERFSEL
Date: Tue, 6 Sep 2011 17:49:33 -0700
Message-ID: <1315356573-1057-3-git-send-email-vikram.pandita@ti.com>
References: <1315356573-1057-1-git-send-email-vikram.pandita@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:36530 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752028Ab1IGAtx (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 6 Sep 2011 20:49:53 -0400
In-Reply-To: <1315356573-1057-1-git-send-email-vikram.pandita@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: balbi@ti.com
Cc: linux-usb@vger.kernel.org, linux-omap@vger.kernel.org, Hema HK <hemahk@ti.com>, Kishon Vijay Abraham I <kishon@ti.com>

From: Hema HK <hemahk@ti.com>

we need to save and restore OTG_INTERFSEL register
else we will be unable to function on resume after
OFF mode.

Change-Id: I6c29c69596d5f47e00cf74ab0e32bb44ef71dda9
Reported-by: Devaraj Rangasamy <dev@ti.com>
Signed-off-by: Hema HK <hemahk@ti.com>
Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
---
 drivers/usb/musb/musb_core.h |    1 +
 drivers/usb/musb/omap2430.c  |    6 ++++++
 2 files changed, 7 insertions(+), 0 deletions(-)

diff --git a/drivers/usb/musb/musb_core.h b/drivers/usb/musb/musb_core.h
index b3c065a..3259a6b 100644
--- a/drivers/usb/musb/musb_core.h
+++ b/drivers/usb/musb/musb_core.h
@@ -311,6 +311,7 @@ struct musb_context_registers {
 	u8 index, testmode;
 
 	u8 devctl, busctl, misc;
+	u32 otg_interfsel;
 
 	struct musb_csr_regs index_regs[MUSB_C_NUM_EPS];
 };
diff --git a/drivers/usb/musb/omap2430.c b/drivers/usb/musb/omap2430.c
index ba85f27..78eb13a 100644
--- a/drivers/usb/musb/omap2430.c
+++ b/drivers/usb/musb/omap2430.c
@@ -491,6 +491,9 @@ static int omap2430_runtime_suspend(struct device *dev)
 	struct omap2430_glue		*glue = dev_get_drvdata(dev);
 	struct musb			*musb = glue_to_musb(glue);
 
+	musb->context.otg_interfsel = musb_readl(musb->mregs,
+						OTG_INTERFSEL);
+
 	omap2430_low_level_exit(musb);
 	otg_set_suspend(musb->xceiv, 1);
 
@@ -503,6 +506,9 @@ static int omap2430_runtime_resume(struct device *dev)
 	struct musb			*musb = glue_to_musb(glue);
 
 	omap2430_low_level_init(musb);
+	musb_writel(musb->mregs, OTG_INTERFSEL,
+					musb->context.otg_interfsel);
+
 	otg_set_suspend(musb->xceiv, 0);
 
 	return 0;
-- 
1.7.4.1

