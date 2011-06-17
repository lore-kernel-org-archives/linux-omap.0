From: Daniel Mack <zonque@gmail.com>
Subject: [PATCH] ARM: OMAP: Overo: remove duplicate call to overo_ads7846_init()
Date: Fri, 17 Jun 2011 18:17:12 +0200
Message-ID: <1308327432-31177-1-git-send-email-zonque@gmail.com>
References: <87r56sbg3b.fsf@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail.bugwerft.de ([212.112.241.193]:44397 "EHLO
	mail.bugwerft.de" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1756923Ab1FQQRS (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 17 Jun 2011 12:17:18 -0400
In-Reply-To: <87r56sbg3b.fsf@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org
Cc: linux-omap@vger.kernel.org, tony@atomide.com, Daniel Mack <zonque@gmail.com>

overo_ads7846_init() is already called from overo_spi_init(), and
calling it twice is not only unnecessary but causes a warning as
"reg-fixed-voltage.1" is already added to the device tree.

Signed-off-by: Daniel Mack <zonque@gmail.com>
---
 arch/arm/mach-omap2/board-overo.c |    1 -
 1 files changed, 0 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-omap2/board-overo.c b/arch/arm/mach-omap2/board-overo.c
index 175e1ab..110475f 100644
--- a/arch/arm/mach-omap2/board-overo.c
+++ b/arch/arm/mach-omap2/board-overo.c
@@ -568,7 +568,6 @@ static void __init overo_init(void)
 	usb_musb_init(NULL);
 	usbhs_init(&usbhs_bdata);
 	overo_spi_init();
-	overo_ads7846_init();
 	overo_init_smsc911x();
 	overo_display_init();
 	overo_init_led();
-- 
1.7.5.1

