From: Vasiliy Kulikov <segoon@openwall.com>
Subject: [PATCH] arm: mach-omap2: potential NULL dereference
Date: Mon, 17 Jan 2011 13:08:42 +0300
Message-ID: <1295258922-31242-1-git-send-email-segoon@openwall.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-ew0-f46.google.com ([209.85.215.46]:34325 "EHLO
	mail-ew0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751903Ab1AQKIr (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 17 Jan 2011 05:08:47 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: kernel-janitors@vger.kernel.org
Cc: Tony Lindgren <tony@atomide.com>, Russell King <linux@arm.linux.org.uk>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org

kzalloc() may fail, if so return -ENOMEM.

Signed-off-by: Vasiliy Kulikov <segoon@openwall.com>
---
 Cannot compile this driver, so it is not tested at all.

 arch/arm/mach-omap2/smartreflex.c |    3 +++
 1 files changed, 3 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap2/smartreflex.c b/arch/arm/mach-omap2/smartreflex.c
index 77ecebf..871bca9 100644
--- a/arch/arm/mach-omap2/smartreflex.c
+++ b/arch/arm/mach-omap2/smartreflex.c
@@ -260,7 +260,10 @@ static int sr_late_init(struct omap_sr *sr_info)
 	if (sr_class->class_type == SR_CLASS2 &&
 		sr_class->notify_flags && sr_info->irq) {
 
+		ret = -ENOMEM;
 		name = kzalloc(SMARTREFLEX_NAME_LEN + 1, GFP_KERNEL);
+		if (name == NULL)
+			goto error;
 		strcpy(name, "sr_");
 		strcat(name, sr_info->voltdm->name);
 		ret = request_irq(sr_info->irq, sr_interrupt,
-- 
1.7.0.4

