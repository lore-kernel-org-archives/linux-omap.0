From: Felipe Balbi <balbi@ti.com>
Subject: [PATCH 04/10] arm: omap: omap2plus_defconfig: enable XHCI
Date: Tue, 18 Nov 2014 12:07:02 -0600
Message-ID: <1416334028-7766-4-git-send-email-balbi@ti.com>
References: <1416334028-7766-1-git-send-email-balbi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:59823 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754105AbaKRSHS (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 18 Nov 2014 13:07:18 -0500
In-Reply-To: <1416334028-7766-1-git-send-email-balbi@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Linux OMAP Mailing List <linux-omap@vger.kernel.org>, Linux ARM Kernel Mailing List <linux-arm-kernel@lists.infradead.org>, Felipe Balbi <balbi@ti.com>

AM437x devices have a DWC3 IP inside of them.

The host side implementation of DWC3 is XHCI
compliant. By enabling XHCI driver, we get
the USB host port on AM437x Starter Kit working
out of the box.

Signed-off-by: Felipe Balbi <balbi@ti.com>
---
 arch/arm/configs/omap2plus_defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/configs/omap2plus_defconfig b/arch/arm/configs/omap2plus_defconfig
index a5abc67..3837a3e 100644
--- a/arch/arm/configs/omap2plus_defconfig
+++ b/arch/arm/configs/omap2plus_defconfig
@@ -292,6 +292,7 @@ CONFIG_USB_ANNOUNCE_NEW_DEVICES=y
 CONFIG_USB_DYNAMIC_MINORS=y
 CONFIG_USB_OTG=y
 CONFIG_USB_MON=y
+CONFIG_USB_XHCI_HCD=m
 CONFIG_USB_WDM=y
 CONFIG_USB_STORAGE=y
 CONFIG_USB_MUSB_HDRC=m
-- 
2.1.0.GIT

