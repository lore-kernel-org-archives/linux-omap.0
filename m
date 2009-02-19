From: Felipe Balbi <me@felipebalbi.com>
Subject: [PATCH 4/5] input: lm8323: prefix led name
Date: Thu, 19 Feb 2009 14:29:42 +0200
Message-ID: <1235046583-29696-5-git-send-email-me@felipebalbi.com>
References: <1235046583-29696-1-git-send-email-me@felipebalbi.com>
 <1235046583-29696-2-git-send-email-me@felipebalbi.com>
 <1235046583-29696-3-git-send-email-me@felipebalbi.com>
 <1235046583-29696-4-git-send-email-me@felipebalbi.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from ns1.siteground211.com ([209.62.36.12]:55997 "EHLO
	serv01.siteground211.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752500AbZBSMaD (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 19 Feb 2009 07:30:03 -0500
In-Reply-To: <1235046583-29696-4-git-send-email-me@felipebalbi.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: tony@atomide.com, Felipe Balbi <felipe.balbi@nokia.com>

From: Felipe Balbi <felipe.balbi@nokia.com>

Prefix led name with machine name to avoid sysfs name
conflicts. It's minor and impossible to happen on n810
by now, but still let's try to keep good practices
while coding.

Signed-off-by: Felipe Balbi <felipe.balbi@nokia.com>
---
 arch/arm/mach-omap2/board-n800.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-omap2/board-n800.c b/arch/arm/mach-omap2/board-n800.c
index fe6e5c9..6e34d80 100644
--- a/arch/arm/mach-omap2/board-n800.c
+++ b/arch/arm/mach-omap2/board-n800.c
@@ -119,8 +119,8 @@ static struct lm8323_platform_data lm8323_pdata = {
 	.active_time	= 500,
 
 	.name		= "Internal keyboard",
-	.pwm1_name	= "keyboard",
-	.pwm2_name	= "cover",
+	.pwm1_name	= "n810::keyboard",
+	.pwm2_name	= "n810::cover",
 };
 #endif
 
-- 
1.6.1.3

