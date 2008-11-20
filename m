From: "Stanley.Miao" <stanley.miao@windriver.com>
Subject: [PATCH] OMAP: set appropriate platform data for touchscreen.
Date: Thu, 20 Nov 2008 22:02:43 +0800
Message-ID: <1227189763-28029-1-git-send-email-stanley.miao@windriver.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail.windriver.com ([147.11.1.11]:54555 "EHLO mail.wrs.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754188AbYKTN4i (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 20 Nov 2008 08:56:38 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: david-b@pacbell.net

Set appropriate platform data for touchscreen and make it work correctly.

Signed-off-by: Stanley.Miao <stanley.miao@windriver.com>
---
 arch/arm/mach-omap2/board-3430sdp.c |    8 ++++++++
 arch/arm/mach-omap2/board-ldp.c     |    8 ++++++++
 2 files changed, 16 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap2/board-3430sdp.c b/arch/arm/mach-omap2/board-3430sdp.c
index b7d2e92..42f92be 100644
--- a/arch/arm/mach-omap2/board-3430sdp.c
+++ b/arch/arm/mach-omap2/board-3430sdp.c
@@ -213,9 +213,17 @@ static int ads7846_vaux_control(int vaux_cntrl)
 }
 
 static struct ads7846_platform_data tsc2046_config __initdata = {
+	.x_max		    = 0x0fff,
+	.y_max		    = 0x0fff,
+	.x_plate_ohms	    = 180,
+	.pressure_max	    = 255,
+	.debounce_max	    = 10,
+	.debounce_tol	    = 10,
+	.debounce_rep	    = 1,
 	.get_pendown_state	= ads7846_get_pendown_state,
 	.keep_vref_on		= 1,
 	.vaux_control		= ads7846_vaux_control,
+	.settle_delay_usecs = 150,
 };
 
 
diff --git a/arch/arm/mach-omap2/board-ldp.c b/arch/arm/mach-omap2/board-ldp.c
index a59e4eb..f17d507 100644
--- a/arch/arm/mach-omap2/board-ldp.c
+++ b/arch/arm/mach-omap2/board-ldp.c
@@ -277,9 +277,17 @@ static int ads7846_vaux_control(int vaux_cntrl)
 }
 
 static struct ads7846_platform_data tsc2046_config __initdata = {
+	.x_max			= 0x0fff,
+	.y_max			= 0x0fff,
+	.x_plate_ohms		= 180,
+	.pressure_max		= 255,
+	.debounce_max		= 10,
+	.debounce_tol		= 10,
+	.debounce_rep		= 1,
 	.get_pendown_state	= ads7846_get_pendown_state,
 	.keep_vref_on		= 1,
 	.vaux_control		= ads7846_vaux_control,
+	.settle_delay_usecs	= 150,
 };
 
 
-- 
1.5.6.3

