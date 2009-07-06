From: Ajay Kumar Gupta <ajay.gupta@ti.com>
Subject: [PATCH] musb: fix CONFIGDATA register read issue
Date: Mon,  6 Jul 2009 11:03:28 +0530
Message-ID: <1246858408-24953-1-git-send-email-ajay.gupta@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:37555 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750861AbZGFFdl (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 6 Jul 2009 01:33:41 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-usb@vger.kernel.org
Cc: linux-omap@vger.kernel.org, david-b@pacbell.net, felipe.balbi@nokia.com, Ajay Kumar Gupta <ajay.gupta@ti.com>, Anand Gadiyar <gadiyar@ti.com>

INDEX register has to be set to '0' before reading
CONFIGDATA register which is only present in TI musb
platforms.

Currently the default register access mode is set to
FLAT_MODE thus INDEX register is not getting set
properly with musb_ep_select() which is just a nop
operation in FLAT_MODE.This invalid register read is
causing module reinset failure.

Fixing the issue by moving INDEX register write part to
musb_read_configdata() function itself.

Signed-off-by: Vikram Pandita <vikram.pandita at ti.com>
Signed-off-by: Anand Gadiyar <gadiyar@ti.com>
Signed-off-by: Ajay Kumar Gupta <ajay.gupta@ti.com>
---
Based on a previous patch from Anand at,
http://marc.info/?l=linux-omap&m=122051303604377&w=2

Another version of this fix by Vikram is at,
http://linux.omap.com/pipermail/linux-omap-open-source/2007-November/012084.html

 drivers/usb/musb/musb_core.c |    1 -
 drivers/usb/musb/musb_regs.h |    1 +
 2 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/usb/musb/musb_core.c b/drivers/usb/musb/musb_core.c
index 554a414..3ec68a1 100644
--- a/drivers/usb/musb/musb_core.c
+++ b/drivers/usb/musb/musb_core.c
@@ -1326,7 +1326,6 @@ static int __init musb_core_init(u16 musb_type, struct musb *musb)
 	int		i;
 
 	/* log core options (read using indexed model) */
-	musb_ep_select(mbase, 0);
 	reg = musb_read_configdata(mbase);
 
 	strcpy(aInfo, (reg & MUSB_CONFIGDATA_UTMIDW) ? "UTMI-16" : "UTMI-8");
diff --git a/drivers/usb/musb/musb_regs.h b/drivers/usb/musb/musb_regs.h
index de3b2f1..fbfd3fd 100644
--- a/drivers/usb/musb/musb_regs.h
+++ b/drivers/usb/musb/musb_regs.h
@@ -323,6 +323,7 @@ static inline void  musb_write_rxfifoadd(void __iomem *mbase, u16 c_off)
 
 static inline u8 musb_read_configdata(void __iomem *mbase)
 {
+	musb_writeb(mbase, MUSB_INDEX, 0);
 	return musb_readb(mbase, 0x10 + MUSB_CONFIGDATA);
 }
 
-- 
1.6.2.4

