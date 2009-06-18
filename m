From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: [PATCH 2/2] OMAP3: SRAM size fix for HS/EMU devices
Date: Wed, 17 Jun 2009 17:00:06 -0700
Message-ID: <1245283206-6568-2-git-send-email-khilman@deeprootsystems.com>
References: <1245283206-6568-1-git-send-email-khilman@deeprootsystems.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-px0-f189.google.com ([209.85.216.189]:47227 "EHLO
	mail-px0-f189.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752039AbZFRAAI (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 17 Jun 2009 20:00:08 -0400
Received: by pxi27 with SMTP id 27so686372pxi.33
        for <linux-omap@vger.kernel.org>; Wed, 17 Jun 2009 17:00:11 -0700 (PDT)
In-Reply-To: <1245283206-6568-1-git-send-email-khilman@deeprootsystems.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

From: Tero Kristo <tero.kristo@nokia.com>

SRAM size fix for HS/EMU devices

Signed-off-by: Tero Kristo <tero.kristo@nokia.com>
Signed-off-by: Kevin Hilman <khilman@deeprootsystems.com>
Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 arch/arm/plat-omap/sram.c |    6 +++++-
 1 files changed, 5 insertions(+), 1 deletions(-)
 mode change 100644 => 100755 arch/arm/plat-omap/sram.c

diff --git a/arch/arm/plat-omap/sram.c b/arch/arm/plat-omap/sram.c
old mode 100644
new mode 100755
index 65006df..80bf3b1
--- a/arch/arm/plat-omap/sram.c
+++ b/arch/arm/plat-omap/sram.c
@@ -133,7 +133,11 @@ void __init omap_detect_sram(void)
 			if (cpu_is_omap34xx()) {
 				omap_sram_base = OMAP3_SRAM_PUB_VA;
 				omap_sram_start = OMAP3_SRAM_PUB_PA;
-				omap_sram_size = 0x8000; /* 32K */
+				if ((omap_type() == OMAP2_DEVICE_TYPE_EMU) ||
+				    (omap_type() == OMAP2_DEVICE_TYPE_SEC)) {
+					omap_sram_size = 0x7000; /* 28K */
+				else
+					omap_sram_size = 0x8000; /* 32K */
 			} else {
 				omap_sram_base = OMAP2_SRAM_PUB_VA;
 				omap_sram_start = OMAP2_SRAM_PUB_PA;
-- 
1.6.3.2

