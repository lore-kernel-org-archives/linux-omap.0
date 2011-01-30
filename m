From: Stefan Weil <weil@mail.berlios.de>
Subject: [PATCH] arm: Fix possible memory leak
Date: Sun, 30 Jan 2011 20:26:27 +0100
Message-ID: <1296415587-4524-1-git-send-email-weil@mail.berlios.de>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Stefan Weil <weil@mail.berlios.de>, Russell King <linux@arm.linux.org.uk>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

sr_info was allocated and needs a kfree before returning.

This error was reported by cppcheck:
arch/arm/mach-omap2/smartreflex.c:837: error: Memory leak: sr_info

To: Tony Lindgren <tony@atomide.com>
Cc: Russell King <linux@arm.linux.org.uk>
Cc: linux-omap@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org
Cc: linux-kernel@vger.kernel.org
Signed-off-by: Stefan Weil <weil@mail.berlios.de>
---
 arch/arm/mach-omap2/smartreflex.c |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-omap2/smartreflex.c b/arch/arm/mach-omap2/smartreflex.c
index af39d17..07324607 100644
--- a/arch/arm/mach-omap2/smartreflex.c
+++ b/arch/arm/mach-omap2/smartreflex.c
@@ -832,7 +832,8 @@ static int __init omap_sr_probe(struct platform_device *pdev)

 	if (!pdata) {
 		dev_err(&pdev->dev, "%s: platform data missing\n", __func__);
-		return -EINVAL;
+		ret = -EINVAL;
+		goto err_free_devinfo;
 	}

 	mem = platform_get_resource(pdev, IORESOURCE_MEM, 0);
--
1.7.2.3
