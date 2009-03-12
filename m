From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: [PATCH 35/86] [ARM] omap: omap24xxcam: use short connection IDs for omap2 clocks
Date: Thu, 12 Mar 2009 11:27:45 -0700
Message-ID: <1236882516-29403-36-git-send-email-khilman@deeprootsystems.com>
References: <1236882516-29403-1-git-send-email-khilman@deeprootsystems.com>
 <1236882516-29403-2-git-send-email-khilman@deeprootsystems.com>
 <1236882516-29403-3-git-send-email-khilman@deeprootsystems.com>
 <1236882516-29403-4-git-send-email-khilman@deeprootsystems.com>
 <1236882516-29403-5-git-send-email-khilman@deeprootsystems.com>
 <1236882516-29403-6-git-send-email-khilman@deeprootsystems.com>
 <1236882516-29403-7-git-send-email-khilman@deeprootsystems.com>
 <1236882516-29403-8-git-send-email-khilman@deeprootsystems.com>
 <1236882516-29403-9-git-send-email-khilman@deeprootsystems.com>
 <1236882516-29403-10-git-send-email-khilman@deeprootsystems.com>
 <1236882516-29403-11-git-send-email-khilman@deeprootsystems.com>
 <1236882516-29403-12-git-send-email-khilman@deeprootsystems.com>
 <1236882516-29403-13-git-send-email-khilman@deeprootsystems.com>
 <1236882516-29403-14-git-send-email-khilman@deeprootsystems.com>
 <1236882516-29403-15-git-send-email-khilman@deeprootsystems.com>
 <1236882516-29403-16-git-send-email-khilman@deeprootsystems.com>
 <1236882516-29403-17-git-send-email-khilman@deeprootsystems.com>
 <1236882516-29403-18-git-send-email-khilman@deeprootsystems.com>
 <1236882516-29403-19-git-send-email-khilman@deeprootsystems.com>
 <1236882516-29403-20-git-send-email-khilman@deeprootsystems.com>
 <1236882516-29403-21-git-send-email-khilman@deeprootsystems.com>
 <1236882516-29403-22-git-send-email-khilman@deeprootsystems.com>
 <1236882516-29403-23-git-send-email-khilman@deeprootsystems.com>
 <1236882516-29403-24-git-send-email-khilman@deeprootsystems.com>
 <1236882516-29403-25-git-send-email-khilman@deeprootsystems.com>
 <1236882516-29403-26-git-send-email-khilman@deeprootsystems.com>
 <1236882516-29403-27-git-send-email-khilman@deeprootsystems.com>
 <1236882516-29403-28-git-send-email-khilman@deeprootsystems.com>
 <1236882516-29403-29-git-send-email-khilman@deeprootsystems.com>
 <1236882516-29403-30-git-send-email-khilman@deeprootsystems.com>
 <1236882516-29403-31-git-send-email-khilman@deeprootsystems.com>
 <1236882516-29403-32-git-send-email-khilman@deeprootsystems.com>
 <1236882516-29403-33-git-send-email-khilman@deeprootsystems.com>
 <1236882516-29403-34-git-send-email-khilman@deeprootsystems.com>
 <1236882516-29403-35-git-send-email-khilman@deeprootsystems.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from ag-out-0708.google.com ([72.14.246.250]:55744 "EHLO
	ag-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756600AbZCLSbU (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 12 Mar 2009 14:31:20 -0400
Received: by ag-out-0708.google.com with SMTP id 26so1107479agb.10
        for <linux-omap@vger.kernel.org>; Thu, 12 Mar 2009 11:31:19 -0700 (PDT)
In-Reply-To: <1236882516-29403-35-git-send-email-khilman@deeprootsystems.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

From: Russell King <rmk@dyn-67.arm.linux.org.uk>

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 arch/arm/mach-omap2/clock24xx.c   |    4 ++--
 drivers/media/video/omap24xxcam.c |    8 ++++----
 2 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/arch/arm/mach-omap2/clock24xx.c b/arch/arm/mach-omap2/clock24xx.c
index 1e9ac83..d190b6a 100644
--- a/arch/arm/mach-omap2/clock24xx.c
+++ b/arch/arm/mach-omap2/clock24xx.c
@@ -169,8 +169,8 @@ static struct omap_clk omap24xx_clks[] = {
 	CLK(NULL,	"wdt1_ick",	&wdt1_ick,	CK_243X | CK_242X),
 	CLK(NULL,	"omapctrl_ick",	&omapctrl_ick,	CK_243X | CK_242X),
 	CLK(NULL,	"icr_ick",	&icr_ick,	CK_243X),
-	CLK(NULL,	"cam_fck",	&cam_fck,	CK_243X | CK_242X),
-	CLK(NULL,	"cam_ick",	&cam_ick,	CK_243X | CK_242X),
+	CLK("omap24xxcam", "fck",	&cam_fck,	CK_243X | CK_242X),
+	CLK("omap24xxcam", "ick",	&cam_ick,	CK_243X | CK_242X),
 	CLK(NULL,	"mailboxes_ick", &mailboxes_ick,	CK_243X | CK_242X),
 	CLK(NULL,	"wdt4_ick",	&wdt4_ick,	CK_243X | CK_242X),
 	CLK(NULL,	"wdt4_fck",	&wdt4_fck,	CK_243X | CK_242X),
diff --git a/drivers/media/video/omap24xxcam.c b/drivers/media/video/omap24xxcam.c
index 73eb656..805faae 100644
--- a/drivers/media/video/omap24xxcam.c
+++ b/drivers/media/video/omap24xxcam.c
@@ -80,17 +80,17 @@ static int omap24xxcam_clock_get(struct omap24xxcam_device *cam)
 {
 	int rval = 0;
 
-	cam->fck = clk_get(cam->dev, "cam_fck");
+	cam->fck = clk_get(cam->dev, "fck");
 	if (IS_ERR(cam->fck)) {
-		dev_err(cam->dev, "can't get cam_fck");
+		dev_err(cam->dev, "can't get camera fck");
 		rval = PTR_ERR(cam->fck);
 		omap24xxcam_clock_put(cam);
 		return rval;
 	}
 
-	cam->ick = clk_get(cam->dev, "cam_ick");
+	cam->ick = clk_get(cam->dev, "ick");
 	if (IS_ERR(cam->ick)) {
-		dev_err(cam->dev, "can't get cam_ick");
+		dev_err(cam->dev, "can't get camera ick");
 		rval = PTR_ERR(cam->ick);
 		omap24xxcam_clock_put(cam);
 	}
-- 
1.6.1.2

