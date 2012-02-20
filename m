From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH] ARM: OMAP: Fix build error when mmc_omap is built as module
Date: Mon, 20 Feb 2012 10:06:31 -0800
Message-ID: <20120220180631.GM18185@atomide.com>
References: <20120220075322.GA22675@n2100.arm.linux.org.uk>
 <20120220175532.GL18185@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:37069 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751727Ab2BTSGf (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 20 Feb 2012 13:06:35 -0500
Content-Disposition: inline
In-Reply-To: <20120220175532.GL18185@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>, Ohad Ben-Cohen <ohad@wizery.com>
Cc: linux-omap@vger.kernel.org

Otherwise we get the following error:

arch/arm/mach-omap2/built-in.o: In function `n8x0_mmc_callback':
twl-common.c:(.text+0x108a0): undefined reference to
`omap_mmc_notify_cover_event'

Fix this by warning about unusable MMC cover events.

The long term fix needs to change the MMC drivers to
register board specific callbacks directly with PMIC.

Reported-by: Russell King <rmk+kernel@arm.linux.org.uk>
Signed-off-by: Tony Lindgren <tony@atomide.com>

--- a/arch/arm/mach-omap2/board-n8x0.c
+++ b/arch/arm/mach-omap2/board-n8x0.c
@@ -371,7 +371,11 @@ static void n8x0_mmc_callback(void *data, u8 card_mask)
 	else
 		*openp = 0;
 
+#ifdef CONFIG_MMC_OMAP
 	omap_mmc_notify_cover_event(mmc_device, index, *openp);
+#else
+	pr_warn("MMC: notify cover event not available\n");
+#endif
 }
 
 static int n8x0_mmc_late_init(struct device *dev)
