From: Stefan Weil <weil@mail.berlios.de>
Subject: [PATCH 19/23] arm: Fix possible null pointer read access
Date: Sun, 30 Jan 2011 20:29:38 +0100
Message-ID: <1296415778-4638-1-git-send-email-weil@mail.berlios.de>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Stefan Weil <weil@mail.berlios.de>, Russell King <linux@arm.linux.org.uk>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

These errors were found by cppcheck:
arch/arm/mach-omap2/smartreflex.c:784: error: Possible null pointer dereference: sr_info
arch/arm/mach-omap2/smartreflex.c:799: error: Possible null pointer dereference: sr_info

Both conditional statements are executed when sr_info == NULL,
so accessing sr_info->voltdm would fail.

Cc: Russell King <linux@arm.linux.org.uk>
Cc: linux-omap@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org
Cc: linux-kernel@vger.kernel.org
Signed-off-by: Stefan Weil <weil@mail.berlios.de>
---
 arch/arm/mach-omap2/smartreflex.c |    6 ++----
 1 files changed, 2 insertions(+), 4 deletions(-)

diff --git a/arch/arm/mach-omap2/smartreflex.c b/arch/arm/mach-omap2/smartreflex.c
index 77ecebf..af39d17 100644
--- a/arch/arm/mach-omap2/smartreflex.c
+++ b/arch/arm/mach-omap2/smartreflex.c
@@ -780,8 +780,7 @@ static int omap_sr_autocomp_show(void *data, u64 *val)
 	struct omap_sr *sr_info = (struct omap_sr *) data;

 	if (!sr_info) {
-		pr_warning("%s: omap_sr struct for sr_%s not found\n",
-			__func__, sr_info->voltdm->name);
+		pr_warning("%s: omap_sr struct not found\n", __func__);
 		return -EINVAL;
 	}

@@ -795,8 +794,7 @@ static int omap_sr_autocomp_store(void *data, u64 val)
 	struct omap_sr *sr_info = (struct omap_sr *) data;

 	if (!sr_info) {
-		pr_warning("%s: omap_sr struct for sr_%s not found\n",
-			__func__, sr_info->voltdm->name);
+		pr_warning("%s: omap_sr struct not found\n", __func__);
 		return -EINVAL;
 	}

--
1.7.2.3
