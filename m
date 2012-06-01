From: <jgq516@gmail.com>
Subject: [PATCHv3 2/3] OMAP: avoid build wdt platform device if with dt support
Date: Fri, 1 Jun 2012 12:44:15 +0800
Message-ID: <1338525856-4359-3-git-send-email-jgq516@gmail.com>
References: <1338525856-4359-1-git-send-email-jgq516@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail.windriver.com ([147.11.1.11]:47833 "EHLO
	mail.windriver.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758895Ab2FADwT (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 31 May 2012 23:52:19 -0400
In-Reply-To: <1338525856-4359-1-git-send-email-jgq516@gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: grant.likely@secretlab.ca, rob.herring@calxeda.com, rob@landley.net, linux@arm.linux.org.uk, b-cousson@ti.com, rnayak@ti.com, tony@atomide.com, wim@iguana.be, jon-hunter@ti.com
Cc: devicetree-discuss@lists.ozlabs.org, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, linux-watchdog@vger.kernel.org

From: Xiao Jiang <jgq516@gmail.com>

If provided dt support, then skip add wdt platform device as usual.

Signed-off-by: Xiao Jiang <jgq516@gmail.com>
Reviewed-by: Jon Hunter <jon-hunter@ti.com>
---
 arch/arm/mach-omap2/devices.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-omap2/devices.c b/arch/arm/mach-omap2/devices.c
index 7b4b932..527c004 100644
--- a/arch/arm/mach-omap2/devices.c
+++ b/arch/arm/mach-omap2/devices.c
@@ -772,7 +772,7 @@ static int __init omap_init_wdt(void)
 	char *oh_name = "wd_timer2";
 	char *dev_name = "omap_wdt";
 
-	if (!cpu_class_is_omap2())
+	if (!cpu_class_is_omap2() || of_have_populated_dt())
 		return 0;
 
 	oh = omap_hwmod_lookup(oh_name);
-- 
1.7.3

