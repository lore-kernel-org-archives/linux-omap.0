From: Tero Kristo <t-kristo@ti.com>
Subject: [RFC PATCH 35/35] HACK: remove omap3 hwmod external dependencies
Date: Wed, 15 Apr 2015 15:53:22 +0300
Message-ID: <1429102402-5276-36-git-send-email-t-kristo@ti.com>
References: <1429102402-5276-1-git-send-email-t-kristo@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:47091 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755418AbbDOMx3 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 15 Apr 2015 08:53:29 -0400
In-Reply-To: <1429102402-5276-1-git-send-email-t-kristo@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tony@atomide.com, paul@pwsan.com, linux-omap@vger.kernel.org

This is a hack in a sense that this is a temporary trial patch to verify
the module functionality for omap3. The external dependencies should
be removed all at once for all platforms when the support is added for all.

Signed-off-by: Tero Kristo <t-kristo@ti.com>
---
 .../mach-omap2/omap_hwmod_2xxx_3xxx_ipblock_data.c |    2 +-
 .../mach-omap2/omap_hwmod_common_ipblock_data.c    |    2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-omap2/omap_hwmod_2xxx_3xxx_ipblock_data.c b/arch/arm/mach-omap2/omap_hwmod_2xxx_3xxx_ipblock_data.c
index c6c6384..7ba20ee 100644
--- a/arch/arm/mach-omap2/omap_hwmod_2xxx_3xxx_ipblock_data.c
+++ b/arch/arm/mach-omap2/omap_hwmod_2xxx_3xxx_ipblock_data.c
@@ -275,7 +275,7 @@ struct omap_hwmod_class_sysconfig omap2_hdq1w_sysc = {
 struct omap_hwmod_class omap2_hdq1w_class = {
 	.name	= "hdq1w",
 	.sysc	= &omap2_hdq1w_sysc,
-	.reset	= &omap_hdq1w_reset,
+	//.reset	= &omap_hdq1w_reset,
 };
 
 struct omap_hwmod_irq_info omap2_hdq1w_mpu_irqs[] = {
diff --git a/arch/arm/mach-omap2/omap_hwmod_common_ipblock_data.c b/arch/arm/mach-omap2/omap_hwmod_common_ipblock_data.c
index f21664d..cd1c4a7 100644
--- a/arch/arm/mach-omap2/omap_hwmod_common_ipblock_data.c
+++ b/arch/arm/mach-omap2/omap_hwmod_common_ipblock_data.c
@@ -30,7 +30,7 @@ static struct omap_hwmod_class_sysconfig omap2_dss_sysc = {
 struct omap_hwmod_class omap2_dss_hwmod_class = {
 	.name	= "dss",
 	.sysc	= &omap2_dss_sysc,
-	.reset	= omap_dss_reset,
+	//.reset	= omap_dss_reset,
 };
 
 /*
-- 
1.7.9.5

