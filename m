From: David Brownell <david-b@pacbell.net>
Subject: [patch 2.6.28-rc2-omap] board-h4 buildfix
Date: Wed, 29 Oct 2008 00:10:09 -0700
Message-ID: <200810290010.09673.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp127.sbc.mail.sp1.yahoo.com ([69.147.65.186]:38697 "HELO
	smtp127.sbc.mail.sp1.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1751701AbYJ2HLX (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Wed, 29 Oct 2008 03:11:23 -0400
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

From: David Brownell <dbrownell@users.sourceforge.net>

Let's build again, like we did last summer!
http://www.chezmaya.com/05/3/lets_twist.htm

(The legacy ov9640 camera sensor code and header is gone.)

Signed-off-by: David Brownell <dbrownell@users.sourceforge.net>
---
 arch/arm/mach-omap2/board-h4.c |    1 -
 1 file changed, 1 deletion(-)

--- a/arch/arm/mach-omap2/board-h4.c
+++ b/arch/arm/mach-omap2/board-h4.c
@@ -48,7 +48,6 @@
 
 #include <asm/io.h>
 
-#include <../drivers/media/video/ov9640.h>
 
 #define H4_FLASH_CS	0
 #define H4_SMC91X_CS	1
