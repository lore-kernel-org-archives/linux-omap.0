From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: [PATCH 2/2] OMAP3: omap3evm: undo ehci change to board-omap3evm.c
Date: Thu, 25 Jun 2009 14:50:16 -0700
Message-ID: <1245966616-26804-3-git-send-email-khilman@deeprootsystems.com>
References: <1245966616-26804-1-git-send-email-khilman@deeprootsystems.com>
 <1245966616-26804-2-git-send-email-khilman@deeprootsystems.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-pz0-f189.google.com ([209.85.222.189]:34852 "EHLO
	mail-pz0-f189.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752818AbZFYVuV (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 25 Jun 2009 17:50:21 -0400
Received: by mail-pz0-f189.google.com with SMTP id 27so1605018pzk.33
        for <linux-omap@vger.kernel.org>; Thu, 25 Jun 2009 14:50:24 -0700 (PDT)
In-Reply-To: <1245966616-26804-2-git-send-email-khilman@deeprootsystems.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

Call to omap3evm_flash_init() mistakenly added by EHCI patch.

Signed-off-by: Kevin Hilman <khilman@deeprootsystems.com>
---
 arch/arm/mach-omap2/board-omap3evm.c |    1 -
 1 files changed, 0 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-omap2/board-omap3evm.c b/arch/arm/mach-omap2/board-omap3evm.c
index 1b7a797..595beac 100644
--- a/arch/arm/mach-omap2/board-omap3evm.c
+++ b/arch/arm/mach-omap2/board-omap3evm.c
@@ -309,7 +309,6 @@ static void __init omap3_evm_init(void)
 	omap_serial_init();
 	usb_musb_init();
 	usb_ehci_init(EHCI_HCD_OMAP_MODE_PHY, true, true, 57, 61);
-	omap3evm_flash_init();
 	ads7846_dev_init();
 }
 
-- 
1.6.3.2

