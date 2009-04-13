From: Steve Sakoman <sakoman@gmail.com>
Subject: [PATCH] ARM: OMAP: Fix merge errors in board-overo.c
Date: Sun, 12 Apr 2009 21:43:14 -0700
Message-ID: <5e088bd90904122143ud805e3vdc937f5263fd6be5@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from wf-out-1314.google.com ([209.85.200.174]:3207 "EHLO
	wf-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752495AbZDMEnP (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 13 Apr 2009 00:43:15 -0400
Received: by wf-out-1314.google.com with SMTP id 29so1931293wff.4
        for <linux-omap@vger.kernel.org>; Sun, 12 Apr 2009 21:43:14 -0700 (PDT)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

One line was omitted when moving definitions from board-overo.h to
board-overo.c, and a duplicate overo_init_smsc911x call was added to
overo_init.

The former results in a compiler error.

Signed-off-by: Steve Sakoman <steve@sakoman.com>
---
 arch/arm/mach-omap2/board-overo.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-omap2/board-overo.c
b/arch/arm/mach-omap2/board-overo.c
index f357de9..3a9c519 100644
--- a/arch/arm/mach-omap2/board-overo.c
+++ b/arch/arm/mach-omap2/board-overo.c
@@ -52,6 +52,7 @@

 #define OVERO_GPIO_BT_XGATE	15
 #define OVERO_GPIO_W2W_NRESET	16
+#define OVERO_GPIO_PENDOWN	114
 #define OVERO_GPIO_BT_NRESET	164
 #define OVERO_GPIO_USBH_CPEN	168
 #define OVERO_GPIO_USBH_NRESET	183
@@ -397,7 +398,6 @@ static void __init overo_init(void)
 	usb_musb_init();
 	usb_ehci_init();
 	overo_flash_init();
-	overo_init_smsc911x();
 	overo_ads7846_init();
 	overo_init_smsc911x();

-- 
1.5.6.3
