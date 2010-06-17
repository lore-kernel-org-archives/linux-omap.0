From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: [PATCH 02/12] OMAP: hwmod: add class for DSP hwmods
Date: Wed, 16 Jun 2010 17:17:03 -0700
Message-ID: <1276733833-18510-3-git-send-email-khilman@deeprootsystems.com>
References: <1276733833-18510-1-git-send-email-khilman@deeprootsystems.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-pw0-f46.google.com ([209.85.160.46]:49651 "EHLO
	mail-pw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755745Ab0FQART (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 16 Jun 2010 20:17:19 -0400
Received: by mail-pw0-f46.google.com with SMTP id 1so3974097pwi.19
        for <linux-omap@vger.kernel.org>; Wed, 16 Jun 2010 17:17:19 -0700 (PDT)
In-Reply-To: <1276733833-18510-1-git-send-email-khilman@deeprootsystems.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: nm@ti.com, thara@ti.com, b-cousson@ti.com

Add a new hwmod class for DSP devices.  To be used when hwmods
are created for DSP on OMAP3 (a.k.a. IVA2.)

Signed-off-by: Kevin Hilman <khilman@deeprootsystems.com>
---
 arch/arm/mach-omap2/omap_hwmod_common_data.c |    3 +++
 arch/arm/mach-omap2/omap_hwmod_common_data.h |    1 +
 2 files changed, 4 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap2/omap_hwmod_common_data.c b/arch/arm/mach-omap2/omap_hwmod_common_data.c
index 1e80b91..09f1e98 100644
--- a/arch/arm/mach-omap2/omap_hwmod_common_data.c
+++ b/arch/arm/mach-omap2/omap_hwmod_common_data.c
@@ -66,3 +66,6 @@ struct omap_hwmod_class mpu_hwmod_class = {
 	.name = "mpu"
 };
 
+struct omap_hwmod_class dsp_hwmod_class = {
+	.name = "dsp"
+};
diff --git a/arch/arm/mach-omap2/omap_hwmod_common_data.h b/arch/arm/mach-omap2/omap_hwmod_common_data.h
index 3645a28..d03ebfa 100644
--- a/arch/arm/mach-omap2/omap_hwmod_common_data.h
+++ b/arch/arm/mach-omap2/omap_hwmod_common_data.h
@@ -20,5 +20,6 @@
 extern struct omap_hwmod_class l3_hwmod_class;
 extern struct omap_hwmod_class l4_hwmod_class;
 extern struct omap_hwmod_class mpu_hwmod_class;
+extern struct omap_hwmod_class dsp_hwmod_class;
 
 #endif
-- 
1.7.0.2

