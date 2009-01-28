From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 6/9] ARM: OMAP: Fix hsmmc init
Date: Wed, 28 Jan 2009 10:29:35 -0800
Message-ID: <20090128182935.21007.41010.stgit@localhost>
References: <20090128181931.21007.73744.stgit@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-bos.mailhop.org ([63.208.196.178]:59982 "EHLO
	mho-01-bos.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751172AbZA1S3i (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 28 Jan 2009 13:29:38 -0500
In-Reply-To: <20090128181931.21007.73744.stgit@localhost>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.arm.linux.org.uk
Cc: linux-omap@vger.kernel.org

It accidentally broke while changing the name for the driver
to not to conflict with the other mmc driver.

Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 arch/arm/plat-omap/devices.c |    8 +++++++-
 1 files changed, 7 insertions(+), 1 deletions(-)

diff --git a/arch/arm/plat-omap/devices.c b/arch/arm/plat-omap/devices.c
index ac15c23..d22529c 100644
--- a/arch/arm/plat-omap/devices.c
+++ b/arch/arm/plat-omap/devices.c
@@ -205,9 +205,15 @@ int __init omap_mmc_add(int id, unsigned long base, unsigned long size,
 {
 	struct platform_device *pdev;
 	struct resource res[OMAP_MMC_NR_RES];
+	char *name;
 	int ret;
 
-	pdev = platform_device_alloc("mmci-omap", id);
+	if (cpu_class_is_omap1() || cpu_is_omap242x())
+		name = "mmci-omap";
+	else
+		name = "mmci-omap-hs";
+
+	pdev = platform_device_alloc(name, id);
 	if (!pdev)
 		return -ENOMEM;
 

