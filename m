From: "Stanley.Miao" <stanley.miao@windriver.com>
Subject: [PATCHv2 2/3] OMAP: set appropriate platform data for touchscreen.
Date: Fri, 21 Nov 2008 15:51:09 +0800
Message-ID: <1227253870-4407-3-git-send-email-stanley.miao@windriver.com>
References: <1227253870-4407-1-git-send-email-stanley.miao@windriver.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail.windriver.com ([147.11.1.11]:51053 "EHLO mail.wrs.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752152AbYKUHo5 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 21 Nov 2008 02:44:57 -0500
Received: from ALA-MAIL03.corp.ad.wrs.com (ala-mail03 [147.11.57.144])
	by mail.wrs.com (8.13.6/8.13.6) with ESMTP id mAL7ivg0021178
	for <linux-omap@vger.kernel.org>; Thu, 20 Nov 2008 23:44:57 -0800 (PST)
In-Reply-To: <1227253870-4407-1-git-send-email-stanley.miao@windriver.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

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

