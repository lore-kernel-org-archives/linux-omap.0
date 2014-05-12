From: Joachim Eastwood <manabian@gmail.com>
Subject: [PATCH] ARM: dts: Change IOPAD macro's for OMAP4/5
Date: Mon, 12 May 2014 20:16:27 +0200
Message-ID: <1399918587-20170-1-git-send-email-manabian@gmail.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-la0-f52.google.com ([209.85.215.52]:60096 "EHLO
	mail-la0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751616AbaELSQs (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 12 May 2014 14:16:48 -0400
Received: by mail-la0-f52.google.com with SMTP id gl10so2171565lab.25
        for <linux-omap@vger.kernel.org>; Mon, 12 May 2014 11:16:47 -0700 (PDT)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tony@atomide.com
Cc: linux-omap@vger.kernel.org, Joachim Eastwood <manabian@gmail.com>

The OMAP4/5 TRMs primarily list address offsets from the padconf
physical address (which is not driver base address) and not
always the absolute physical address for padconf registers like
some other OMAP TRMs. So create a new macro to use this offset
and to avoid confusion between different OMAP parts.

Signed-off-by: Joachim Eastwood <manabian@gmail.com>
---
 include/dt-bindings/pinctrl/omap.h | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

diff --git a/include/dt-bindings/pinctrl/omap.h b/include/dt-bindings/pinctrl/omap.h
index b04528cd033c..827e80964a35 100644
--- a/include/dt-bindings/pinctrl/omap.h
+++ b/include/dt-bindings/pinctrl/omap.h
@@ -62,12 +62,17 @@
 #define OMAP3630_CORE2_IOPAD(pa, val)	OMAP_IOPAD_OFFSET((pa), 0x25a0) (val)
 #define OMAP3_WKUP_IOPAD(pa, val)	OMAP_IOPAD_OFFSET((pa), 0x2a00) (val)
 #define AM33XX_IOPAD(pa, val)		OMAP_IOPAD_OFFSET((pa), 0x0800) (val)
-#define OMAP4_CORE_IOPAD(pa, val)	OMAP_IOPAD_OFFSET((pa), 0x0040) (val)
-#define OMAP4_WKUP_IOPAD(pa, val)	OMAP_IOPAD_OFFSET((pa), 0xe040) (val)
 #define AM4372_IOPAD(pa, val)		OMAP_IOPAD_OFFSET((pa), 0x0800) (val)
-#define OMAP5_CORE_IOPAD(pa, val)	OMAP_IOPAD_OFFSET((pa), 0x2840) (val)
-#define OMAP5_WKUP_IOPAD(pa, val)	OMAP_IOPAD_OFFSET((pa), 0xc840) (val)
 #define DRA7XX_CORE_IOPAD(pa, val)	OMAP_IOPAD_OFFSET((pa), 0x3400) (val)
 
+/*
+ * Macros to allow using the offset from the padconf physical address
+ * instead  of the offset from padconf base.
+ */
+#define OMAP_PADCONF_OFFSET(offset, base_offset)	((offset) - (base_offset))
+
+#define OMAP4_IOPAD(offset, val)	OMAP_PADCONF_OFFSET((offset), 0x0040) (val)
+#define OMAP5_IOPAD(offset, val)	OMAP_PADCONF_OFFSET((offset), 0x0040) (val)
+
 #endif
 
-- 
1.8.0

