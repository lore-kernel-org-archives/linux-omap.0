From: Felipe Balbi <balbi@ti.com>
Subject: [PATCH 06/15] arm: omap: pass Retu ID via platform_data
Date: Tue, 15 Feb 2011 10:45:53 +0200
Message-ID: <1297759562-25682-7-git-send-email-balbi@ti.com>
References: <1297759562-25682-1-git-send-email-balbi@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog117.obsmtp.com ([74.125.149.242]:52620 "EHLO
	na3sys009aog117.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752559Ab1BOIqp (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Tue, 15 Feb 2011 03:46:45 -0500
Received: by mail-yx0-f174.google.com with SMTP id 3so2579333yxt.33
        for <linux-omap@vger.kernel.org>; Tue, 15 Feb 2011 00:46:44 -0800 (PST)
In-Reply-To: <1297759562-25682-1-git-send-email-balbi@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Linux OMAP Mailing List <linux-omap@vger.kernel.org>, Felipe Balbi <balbi@ti.com>

Instead of hardcoding on the driver, pass
that via platform_data instead.

Signed-off-by: Felipe Balbi <balbi@ti.com>
---
 arch/arm/mach-omap1/board-nokia770.c   |    1 +
 arch/arm/mach-omap2/board-n8x0.c       |    1 +
 arch/arm/plat-omap/include/plat/cbus.h |    1 +
 3 files changed, 3 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap1/board-nokia770.c b/arch/arm/mach-omap1/board-nokia770.c
index d939370..f2a92b5 100644
--- a/arch/arm/mach-omap1/board-nokia770.c
+++ b/arch/arm/mach-omap1/board-nokia770.c
@@ -126,6 +126,7 @@ static struct resource retu_resource[] = {
 static struct cbus_retu_platform_data nokia770_retu_data = {
 	.irq_base	= CBUS_RETU_IRQ_BASE,
 	.irq_end	= CBUS_RETU_IRQ_END,
+	.devid		= CBUS_RETU_DEVICE_ID,
 };
 
 static struct platform_device retu_device = {
diff --git a/arch/arm/mach-omap2/board-n8x0.c b/arch/arm/mach-omap2/board-n8x0.c
index 1e4bfb2..e00c0fa 100644
--- a/arch/arm/mach-omap2/board-n8x0.c
+++ b/arch/arm/mach-omap2/board-n8x0.c
@@ -223,6 +223,7 @@ static struct resource retu_resource[] = {
 static struct cbus_retu_platform_data n8x0_retu_data = {
 	.irq_base	= CBUS_RETU_IRQ_BASE,
 	.irq_end	= CBUS_RETU_IRQ_END,
+	.devid		= CBUS_RETU_DEVICE_ID,
 };
 
 static struct platform_device retu_device = {
diff --git a/arch/arm/plat-omap/include/plat/cbus.h b/arch/arm/plat-omap/include/plat/cbus.h
index e7ace57..563b1c2 100644
--- a/arch/arm/plat-omap/include/plat/cbus.h
+++ b/arch/arm/plat-omap/include/plat/cbus.h
@@ -34,6 +34,7 @@ struct cbus_host_platform_data {
 struct cbus_retu_platform_data {
 	int	irq_base;
 	int	irq_end;
+	int	devid;
 };
 
 #endif /* __PLAT_CBUS_H */
-- 
1.7.4.rc2

