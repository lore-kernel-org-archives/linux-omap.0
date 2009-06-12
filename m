From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: [PATCH 1/2] OMAP2/3: SoC IDs: add omap_type() for determining GP/EMU/HS
Date: Fri, 12 Jun 2009 15:11:32 -0700
Message-ID: <1244844693-24126-2-git-send-email-khilman@ti.deeprootsystems.com>
References: <1244844693-24126-1-git-send-email-khilman@ti.deeprootsystems.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-pz0-f187.google.com ([209.85.222.187]:36154 "EHLO
	mail-pz0-f187.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934215AbZFLWLf (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 12 Jun 2009 18:11:35 -0400
Received: by mail-pz0-f187.google.com with SMTP id 17so811108pzk.33
        for <linux-omap@vger.kernel.org>; Fri, 12 Jun 2009 15:11:38 -0700 (PDT)
In-Reply-To: <1244844693-24126-1-git-send-email-khilman@ti.deeprootsystems.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Kevin Hilman <khilman@ti.deeprootsystems.com>

The omap_type() function is added and returns the DEVICETYPE field of
the CONTROL_STATUS register.  The result can be used for conditional
code based on whether device is GP, EMU or HS.

Signed-off-by: Kevin Hilman <khilman@ti.deeprootsystems.com>
---
 arch/arm/mach-omap2/id.c |   22 ++++++++++++++++++++++
 1 files changed, 22 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap2/id.c b/arch/arm/mach-omap2/id.c
index 458990e..a98201c 100644
--- a/arch/arm/mach-omap2/id.c
+++ b/arch/arm/mach-omap2/id.c
@@ -48,6 +48,28 @@ int omap_chip_is(struct omap_chip_id oci)
 }
 EXPORT_SYMBOL(omap_chip_is);
 
+int omap_type(void)
+{
+	u32 val = 0;
+
+	if (cpu_is_omap24xx())
+		val = omap_ctrl_readl(OMAP24XX_CONTROL_STATUS);
+	else if (cpu_is_omap34xx())
+		val = omap_ctrl_readl(OMAP343X_CONTROL_STATUS);
+	else {
+		pr_err("Cannot detect omap type!\n");
+		goto out;
+	}
+
+	val &= OMAP2_DEVICETYPE_MASK;
+	val >>= 8;
+
+out:
+	return val;
+}
+EXPORT_SYMBOL(omap_type);
+
+
 /*----------------------------------------------------------------------------*/
 
 #define OMAP_TAP_IDCODE		0x0204
-- 
1.6.2.2

