From: Thomas Pedersen <thomas@cozybit.com>
Subject: [PATCH] ARM: OMAP2+: enable EHCI by default
Date: Wed,  4 Dec 2013 17:08:15 -0800
Message-ID: <1386205695-26191-1-git-send-email-thomas@cozybit.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-pb0-f42.google.com ([209.85.160.42]:52398 "EHLO
	mail-pb0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753140Ab3LEBIV (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 4 Dec 2013 20:08:21 -0500
Received: by mail-pb0-f42.google.com with SMTP id uo5so24818843pbc.29
        for <linux-omap@vger.kernel.org>; Wed, 04 Dec 2013 17:08:20 -0800 (PST)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: linux@arm.linux.org.uk, tony@atomide.com, Thomas Pedersen <thomas@cozybit.com>

This is needed for the pandaboard (ES) kernel to detect
the ethernet device during boot. Useful for NFS root etc.

Signed-off-by: Thomas Pedersen <thomas@cozybit.com>
---
 arch/arm/configs/omap2plus_defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/configs/omap2plus_defconfig b/arch/arm/configs/omap2plus_defconfig
index bfa80a1..a236a2b 100644
--- a/arch/arm/configs/omap2plus_defconfig
+++ b/arch/arm/configs/omap2plus_defconfig
@@ -212,6 +212,7 @@ CONFIG_SND_OMAP_SOC_OMAP_TWL4030=m
 CONFIG_SND_OMAP_SOC_OMAP_ABE_TWL6040=m
 CONFIG_SND_OMAP_SOC_OMAP3_PANDORA=m
 CONFIG_USB=y
+CONFIG_USB_EHCI_HCD=y
 CONFIG_USB_DEBUG=y
 CONFIG_USB_ANNOUNCE_NEW_DEVICES=y
 CONFIG_USB_MON=y
-- 
1.8.4.3

