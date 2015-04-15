From: Tero Kristo <t-kristo@ti.com>
Subject: [RFC PATCH 17/35] ARM: OMAP3: control: remove code from __init section
Date: Wed, 15 Apr 2015 15:53:04 +0300
Message-ID: <1429102402-5276-18-git-send-email-t-kristo@ti.com>
References: <1429102402-5276-1-git-send-email-t-kristo@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:47050 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755394AbbDOMxB (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 15 Apr 2015 08:53:01 -0400
In-Reply-To: <1429102402-5276-1-git-send-email-t-kristo@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tony@atomide.com, paul@pwsan.com, linux-omap@vger.kernel.org

Needed by hwmod module boot.

Signed-off-by: Tero Kristo <t-kristo@ti.com>
---
 arch/arm/mach-omap2/control.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/mach-omap2/control.c b/arch/arm/mach-omap2/control.c
index da041b4..b0d5e47 100644
--- a/arch/arm/mach-omap2/control.c
+++ b/arch/arm/mach-omap2/control.c
@@ -602,7 +602,7 @@ static void __init omap3_ctrl_setup_d2d_padconf(void)
  * Initializes system control module. This sets up the sysconfig autoidle,
  * and sets up modem and iva2 so that they can be idled properly.
  */
-void __init omap3_ctrl_init(void)
+void omap3_ctrl_init(void)
 {
 	omap_ctrl_writel(OMAP3430_AUTOIDLE_MASK, OMAP2_CONTROL_SYSCONFIG);
 
-- 
1.7.9.5

