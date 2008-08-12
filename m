From: "arun c" <arunedarath@mistralsolutions.com>
Subject: [PATCH 2/2] OMAP2EVM: twl4030 keypad Kconfig dependency fix
Date: Tue, 12 Aug 2008 14:30:28 +0530
Message-ID: <c656a4d20808120200y105ca331g7cfa82c5d5c1740b@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from ti-out-0910.google.com ([209.85.142.188]:34923 "EHLO
	ti-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751892AbYHLJAa (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 12 Aug 2008 05:00:30 -0400
Received: by ti-out-0910.google.com with SMTP id b6so1249415tic.23
        for <linux-omap@vger.kernel.org>; Tue, 12 Aug 2008 02:00:28 -0700 (PDT)
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

OMAP2EVM keypad is controlled by twl4030

Signed-off-by: Arun C <arunedarath@mistralsolutions.com>
---
 drivers/input/keyboard/Kconfig |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/input/keyboard/Kconfig b/drivers/input/keyboard/Kconfig
index cf86a7b..e4d0436 100644
--- a/drivers/input/keyboard/Kconfig
+++ b/drivers/input/keyboard/Kconfig
@@ -261,7 +261,7 @@ config KEYBOARD_OMAP

 config KEYBOARD_TWL4030
 	tristate "TI TWL4030 keypad support"
-	depends on TWL4030_CORE && (MACH_OMAP_2430SDP || MACH_OMAP_3430SDP
|| MACH_OMAP3EVM)
+	depends on TWL4030_CORE && (MACH_OMAP_2430SDP || MACH_OMAP2EVM ||
MACH_OMAP_3430SDP || MACH_OMAP3EVM)
 	help
 	  Say Y here if you want to use the OMAP TWL4030 keypad.

-- 
1.5.3.4
