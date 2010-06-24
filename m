From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: [PATCH v2 11/13] OMAP: hwmod data: add class for IVA hwmods
Date: Thu, 24 Jun 2010 16:44:42 -0700
Message-ID: <1277423084-25528-12-git-send-email-khilman@deeprootsystems.com>
References: <1277423084-25528-1-git-send-email-khilman@deeprootsystems.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-pw0-f46.google.com ([209.85.160.46]:57989 "EHLO
	mail-pw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754106Ab0FXXpJ (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 24 Jun 2010 19:45:09 -0400
Received: by mail-pw0-f46.google.com with SMTP id 8so2080998pwj.19
        for <linux-omap@vger.kernel.org>; Thu, 24 Jun 2010 16:45:09 -0700 (PDT)
In-Reply-To: <1277423084-25528-1-git-send-email-khilman@deeprootsystems.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: paul@pwsan.com

Add a new hwmod class for IVA devices.  To be used when hwmods
are created for IVA2 on OMAP3.

Cc: Paul Walmsley <paul@pwsan.com>
Signed-off-by: Kevin Hilman <khilman@deeprootsystems.com>
---
 arch/arm/mach-omap2/omap_hwmod_common_data.c |    3 +++
 arch/arm/mach-omap2/omap_hwmod_common_data.h |    1 +
 2 files changed, 4 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap2/omap_hwmod_common_data.c b/arch/arm/mach-omap2/omap_hwmod_common_data.c
index 1e80b91..08a1342 100644
--- a/arch/arm/mach-omap2/omap_hwmod_common_data.c
+++ b/arch/arm/mach-omap2/omap_hwmod_common_data.c
@@ -66,3 +66,6 @@ struct omap_hwmod_class mpu_hwmod_class = {
 	.name = "mpu"
 };
 
+struct omap_hwmod_class iva_hwmod_class = {
+	.name = "iva"
+};
diff --git a/arch/arm/mach-omap2/omap_hwmod_common_data.h b/arch/arm/mach-omap2/omap_hwmod_common_data.h
index 3645a28..c34e98b 100644
--- a/arch/arm/mach-omap2/omap_hwmod_common_data.h
+++ b/arch/arm/mach-omap2/omap_hwmod_common_data.h
@@ -20,5 +20,6 @@
 extern struct omap_hwmod_class l3_hwmod_class;
 extern struct omap_hwmod_class l4_hwmod_class;
 extern struct omap_hwmod_class mpu_hwmod_class;
+extern struct omap_hwmod_class iva_hwmod_class;
 
 #endif
-- 
1.7.0.2

