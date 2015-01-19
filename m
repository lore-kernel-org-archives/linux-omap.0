From: Sjoerd Simons <sjoerd.simons@collabora.co.uk>
Subject: [PATCH v2] ARM: omap2plus_defconfig: Enable OHCI & EHCI HCD support
Date: Mon, 19 Jan 2015 22:28:36 +0100
Message-ID: <1421702916-19018-1-git-send-email-sjoerd.simons@collabora.co.uk>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bhuna.collabora.co.uk ([93.93.135.160]:59923 "EHLO
	bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751225AbbASV2k (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 19 Jan 2015 16:28:40 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Felipe Balbi <balbi@ti.com>, Arnd Bergmann <arnd@arndb.de>, linux-arm-kernel@lists.infradead.org, Javier Martinez Canillas <javier.martinez@collabora.co.uk>, linux-omap@vger.kernel.org

Enable CONFIG_USB_EHCI_HCD and CONFIG_USB_OHCI_HCD to get USB supports
with omap2plus_defconfig.

Signed-off-by: Sjoerd Simons <sjoerd.simons@collabora.co.uk>
---
Changes in v2: Enable as modules rather then builtin

 arch/arm/configs/omap2plus_defconfig | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/configs/omap2plus_defconfig b/arch/arm/configs/omap2plus_defconfig
index c2c3a85..f4009a2 100644
--- a/arch/arm/configs/omap2plus_defconfig
+++ b/arch/arm/configs/omap2plus_defconfig
@@ -159,6 +159,8 @@ CONFIG_USB_NET_SMSC95XX=y
 CONFIG_USB_ALI_M5632=y
 CONFIG_USB_AN2720=y
 CONFIG_USB_EPSON2888=y
+CONFIG_USB_EHCI_HCD=m
+CONFIG_USB_OHCI_HCD=m
 CONFIG_USB_KC2190=y
 CONFIG_LIBERTAS=m
 CONFIG_LIBERTAS_USB=m
-- 
2.1.4

