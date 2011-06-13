From: Felipe Balbi <balbi@ti.com>
Subject: [PATCH 1/2] cbus: make cbus parent of bus users
Date: Mon, 13 Jun 2011 22:40:57 +0300
Message-ID: <1307994058-25486-2-git-send-email-balbi@ti.com>
References: <1307994058-25486-1-git-send-email-balbi@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog102.obsmtp.com ([74.125.149.69]:48107 "EHLO
	na3sys009aog102.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751188Ab1FMTlK (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Mon, 13 Jun 2011 15:41:10 -0400
Received: by fxm8 with SMTP id 8so3196054fxm.26
        for <linux-omap@vger.kernel.org>; Mon, 13 Jun 2011 12:41:06 -0700 (PDT)
In-Reply-To: <1307994058-25486-1-git-send-email-balbi@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Linux OMAP Mailing List <linux-omap@vger.kernel.org>, Felipe Balbi <balbi@ti.com>

CBUS is the underlying bus device, make
it the parent of the bus users (retu and
tahvo).

Signed-off-by: Felipe Balbi <balbi@ti.com>
---
 arch/arm/mach-omap1/board-nokia770.c |    4 ++++
 arch/arm/mach-omap2/board-n8x0.c     |    4 ++++
 2 files changed, 8 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap1/board-nokia770.c b/arch/arm/mach-omap1/board-nokia770.c
index 5d174a3..676d99f 100644
--- a/arch/arm/mach-omap1/board-nokia770.c
+++ b/arch/arm/mach-omap1/board-nokia770.c
@@ -136,6 +136,7 @@ static struct platform_device retu_device = {
 	.num_resources	= ARRAY_SIZE(retu_resource),
 	.dev		= {
 		.platform_data = &nokia770_retu_data,
+		.parent	= &nokia770_cbus_device.dev,
 	},
 };
 
@@ -151,6 +152,9 @@ static struct platform_device tahvo_device = {
 	.id		= -1,
 	.resource	= tahvo_resource,
 	.num_resources	= ARRAY_SIZE(tahvo_resource),
+	.dev		= {
+		.parent	= &nokia770_cbus_device.dev,
+	},
 };
 
 static struct platform_device tahvo_usb_device = {
diff --git a/arch/arm/mach-omap2/board-n8x0.c b/arch/arm/mach-omap2/board-n8x0.c
index ad06bde..b61ac1d 100644
--- a/arch/arm/mach-omap2/board-n8x0.c
+++ b/arch/arm/mach-omap2/board-n8x0.c
@@ -232,6 +232,7 @@ static struct platform_device retu_device = {
 	.num_resources	= ARRAY_SIZE(retu_resource),
 	.dev		= {
 		.platform_data = &n8x0_retu_data,
+		.parent	= &n8x0_cbus_device.dev,
 	},
 };
 
@@ -247,6 +248,9 @@ static struct platform_device tahvo_device = {
 	.id		= -1,
 	.resource	= tahvo_resource,
 	.num_resources	= ARRAY_SIZE(tahvo_resource),
+	.dev		= {
+		.parent	= &n8x0_cbus_device.dev,
+	},
 };
 
 static struct platform_device tahvo_usb_device = {
-- 
1.7.6.rc1

