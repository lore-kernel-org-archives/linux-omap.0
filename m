From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: [PATCH 12/13] OMAP: hwmod data: add class for DSP hwmods
Date: Wed, 23 Jun 2010 16:42:42 -0700
Message-ID: <1277336563-24988-13-git-send-email-khilman@deeprootsystems.com>
References: <1277336563-24988-1-git-send-email-khilman@deeprootsystems.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-px0-f174.google.com ([209.85.212.174]:42006 "EHLO
	mail-px0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754133Ab0FWXnJ (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 23 Jun 2010 19:43:09 -0400
Received: by mail-px0-f174.google.com with SMTP id 7so469497pxi.19
        for <linux-omap@vger.kernel.org>; Wed, 23 Jun 2010 16:43:09 -0700 (PDT)
In-Reply-To: <1277336563-24988-1-git-send-email-khilman@deeprootsystems.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: paul@pwsan.com

Add a new hwmod class for DSP devices.  To be used when hwmods
are created for DSP on OMAP3 (a.k.a. IVA2.)

Cc: Paul Walmsley <paul@pwsan.com>
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

