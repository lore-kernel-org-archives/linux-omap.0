From: Joachim Eastwood <manabian@gmail.com>
Subject: [PATCH] ARM: dts: Correct offset in OMAP4_WKUP_IOPAD macro
Date: Sat, 19 Apr 2014 18:14:16 +0200
Message-ID: <1397924056-6462-1-git-send-email-manabian@gmail.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-lb0-f174.google.com ([209.85.217.174]:33703 "EHLO
	mail-lb0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751453AbaDSQO0 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sat, 19 Apr 2014 12:14:26 -0400
Received: by mail-lb0-f174.google.com with SMTP id u14so2113155lbd.19
        for <linux-omap@vger.kernel.org>; Sat, 19 Apr 2014 09:14:25 -0700 (PDT)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tony@atomide.com
Cc: linux-omap@vger.kernel.org, Joachim Eastwood <manabian@gmail.com>

This was introduced in 43a348ea53eb5fd79 but hasn't caused
any harm since it don't have any users yet.

Signed-off-by: Joachim Eastwood <manabian@gmail.com>
---
Hello,

This one had me puzzled for a while. Wondering why USB
suddenly disappeared and suspecting by convert script.

 -JE

 include/dt-bindings/pinctrl/omap.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/dt-bindings/pinctrl/omap.h b/include/dt-bindings/pinctrl/omap.h
index b04528cd033c..251d1bd17e35 100644
--- a/include/dt-bindings/pinctrl/omap.h
+++ b/include/dt-bindings/pinctrl/omap.h
@@ -63,7 +63,7 @@
 #define OMAP3_WKUP_IOPAD(pa, val)	OMAP_IOPAD_OFFSET((pa), 0x2a00) (val)
 #define AM33XX_IOPAD(pa, val)		OMAP_IOPAD_OFFSET((pa), 0x0800) (val)
 #define OMAP4_CORE_IOPAD(pa, val)	OMAP_IOPAD_OFFSET((pa), 0x0040) (val)
-#define OMAP4_WKUP_IOPAD(pa, val)	OMAP_IOPAD_OFFSET((pa), 0xe040) (val)
+#define OMAP4_WKUP_IOPAD(pa, val)	OMAP_IOPAD_OFFSET((pa), 0x0040) (val)
 #define AM4372_IOPAD(pa, val)		OMAP_IOPAD_OFFSET((pa), 0x0800) (val)
 #define OMAP5_CORE_IOPAD(pa, val)	OMAP_IOPAD_OFFSET((pa), 0x2840) (val)
 #define OMAP5_WKUP_IOPAD(pa, val)	OMAP_IOPAD_OFFSET((pa), 0xc840) (val)
-- 
1.8.0

