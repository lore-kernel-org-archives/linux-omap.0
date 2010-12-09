From: tom.leiming@gmail.com
Subject: [PATCH] arm: omap4: panda: fix initialize musb
Date: Fri, 10 Dec 2010 01:02:50 +0800
Message-ID: <1291914170-25415-1-git-send-email-tom.leiming@gmail.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-pv0-f174.google.com ([74.125.83.174]:57489 "EHLO
	mail-pv0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753944Ab0LIRDD (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 9 Dec 2010 12:03:03 -0500
Received: by pva4 with SMTP id 4so557828pva.19
        for <linux-omap@vger.kernel.org>; Thu, 09 Dec 2010 09:03:02 -0800 (PST)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tony@atomide.com, balbi@ti.com
Cc: linux-omap@vger.kernel.org, Ming Lei <tom.leiming@gmail.com>

From: Ming Lei <tom.leiming@gmail.com>

Obviously we should only initialize musb once.

Signed-off-by: Ming Lei <tom.leiming@gmail.com>
---
 arch/arm/mach-omap2/board-omap4panda.c |    3 ---
 1 files changed, 0 insertions(+), 3 deletions(-)

diff --git a/arch/arm/mach-omap2/board-omap4panda.c b/arch/arm/mach-omap2/board-omap4panda.c
index 22599fc..85371be 100644
--- a/arch/arm/mach-omap2/board-omap4panda.c
+++ b/arch/arm/mach-omap2/board-omap4panda.c
@@ -393,9 +393,6 @@ static void __init omap4_panda_init(void)
 	usb_nop_xceiv_register();
 	omap4_ehci_init();
 	usb_musb_init(&musb_board_data);
-	/* FIXME: allow multi-omap to boot until musb is updated for omap4 */
-	if (!cpu_is_omap44xx())
-		usb_musb_init(&musb_board_data);
 }
 
 static void __init omap4_panda_map_io(void)
-- 
1.7.3

