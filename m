From: Mike Rapoport <mike@compulab.co.il>
Subject: [PATCH 2/3] omap3: cm-t35: use matrix_keyboard
Date: Wed, 11 Nov 2009 13:19:31 +0200
Message-ID: <e79a81510d77fa9bc8df2cedc8ccf391936d7ebd.1257937910.git.mike@compulab.co.il>
References: <cover.1257937910.git.mike@compulab.co.il>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from compulab.co.il ([67.18.134.219]:54096 "EHLO compulab.co.il"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751300AbZKKLZy (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 11 Nov 2009 06:25:54 -0500
Received: from [62.90.235.247] (helo=zimbra-mta.compulab.co.il)
	by compulab.site5.com with esmtp (Exim 4.69)
	(envelope-from <mike@compulab.co.il>)
	id 1N8BKq-00070f-1h
	for linux-omap@vger.kernel.org; Wed, 11 Nov 2009 05:26:00 -0600
Received: from localhost (localhost.localdomain [127.0.0.1])
	by zimbra-mta.compulab.co.il (Postfix) with ESMTP id 508DC9A0359
	for <linux-omap@vger.kernel.org>; Wed, 11 Nov 2009 13:19:34 +0200 (IST)
In-Reply-To: <cover.1257937910.git.mike@compulab.co.il>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Mike Rapoport <mike@compulab.co.il>

Signed-off-by: Mike Rapoport <mike@compulab.co.il>
---
 arch/arm/mach-omap2/board-cm-t35.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-omap2/board-cm-t35.c b/arch/arm/mach-omap2/board-cm-t35.c
index f9290ca..0a46c0e 100644
--- a/arch/arm/mach-omap2/board-cm-t35.c
+++ b/arch/arm/mach-omap2/board-cm-t35.c
@@ -24,6 +24,7 @@
 #include <linux/init.h>
 #include <linux/platform_device.h>
 #include <linux/input.h>
+#include <linux/input/matrix_keypad.h>
 #include <linux/delay.h>
 #include <linux/gpio.h>
 
@@ -39,7 +40,6 @@
 #include <plat/common.h>
 #include <plat/mux.h>
 #include <plat/nand.h>
-#include <plat/keypad.h>
 #include <plat/gpmc.h>
 #include <plat/usb.h>
 
-- 
1.6.0.6

