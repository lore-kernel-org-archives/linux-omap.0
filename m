From: Vaibhav Bedia <vaibhav.bedia@gmail.com>
Subject: [PATCH 1/1] ARM: OMAP5: Fix reboot handling
Date: Sun, 16 Feb 2014 18:15:44 -0500
Message-ID: <1392592544-7884-1-git-send-email-vaibhav.bedia@gmail.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-yh0-f44.google.com ([209.85.213.44]:63438 "EHLO
	mail-yh0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751197AbaBPXPx (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sun, 16 Feb 2014 18:15:53 -0500
Received: by mail-yh0-f44.google.com with SMTP id f73so13688614yha.31
        for <linux-omap@vger.kernel.org>; Sun, 16 Feb 2014 15:15:52 -0800 (PST)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tony@atomide.com, rnayak@ti.com, paul@pwsan.com
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Vaibhav Bedia <vaibhav.bedia@gmail.com>

Use the correct register offset for issuing the
reset command in OMAP5. Since dev_inst is set dynamically
OMAP4 should not be affected by this change.

Signed-off-by: Vaibhav Bedia <vaibhav.bedia@gmail.com>
---
Applies on top of v3.14-rc3

 arch/arm/mach-omap2/prminst44xx.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-omap2/prminst44xx.c b/arch/arm/mach-omap2/prminst44xx.c
index 6334b96..280f3c5 100644
--- a/arch/arm/mach-omap2/prminst44xx.c
+++ b/arch/arm/mach-omap2/prminst44xx.c
@@ -183,11 +183,11 @@ void omap4_prminst_global_warm_sw_reset(void)
 					OMAP4_PRM_RSTCTRL_OFFSET);
 	v |= OMAP4430_RST_GLOBAL_WARM_SW_MASK;
 	omap4_prminst_write_inst_reg(v, OMAP4430_PRM_PARTITION,
-				 OMAP4430_PRM_DEVICE_INST,
+				 dev_inst,
 				 OMAP4_PRM_RSTCTRL_OFFSET);
 
 	/* OCP barrier */
 	v = omap4_prminst_read_inst_reg(OMAP4430_PRM_PARTITION,
-				    OMAP4430_PRM_DEVICE_INST,
+				    dev_inst,
 				    OMAP4_PRM_RSTCTRL_OFFSET);
 }
-- 
1.8.1.2

