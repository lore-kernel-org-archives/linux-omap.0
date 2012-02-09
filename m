From: Matt Porter <mporter@ti.com>
Subject: [PATCH 1/2] omap: enable davinci_emac in omap2plus_defconfig for
Date: Thu,  9 Feb 2012 15:16:25 -0500
Message-ID: <1328818586-7104-2-git-send-email-mporter@ti.com>
References: <1328818586-7104-1-git-send-email-mporter@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-gx0-f174.google.com ([209.85.161.174]:40908 "EHLO
	mail-gx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757857Ab2BIUQb (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 9 Feb 2012 15:16:31 -0500
Received: by ggnh1 with SMTP id h1so1129905ggn.19
        for <linux-omap@vger.kernel.org>; Thu, 09 Feb 2012 12:16:31 -0800 (PST)
In-Reply-To: <1328818586-7104-1-git-send-email-mporter@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Russell King <linux@arm.linux.org.uk>, Tony Lindgren <tony@atomide.com>
Cc: Linux OMAP List <linux-omap@vger.kernel.org>, Linux ARM Kernel List <linux-arm-kernel@lists.infradead.org>

Enable built-in Ethernet support in the defconfig for all
am35xx parts.

Signed-off-by: Matt Porter <mporter@ti.com>
---
 arch/arm/configs/omap2plus_defconfig |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/arch/arm/configs/omap2plus_defconfig b/arch/arm/configs/omap2plus_defconfig
index d5f00d7..8d49617 100644
--- a/arch/arm/configs/omap2plus_defconfig
+++ b/arch/arm/configs/omap2plus_defconfig
@@ -91,6 +91,7 @@ CONFIG_SMSC_PHY=y
 CONFIG_NET_ETHERNET=y
 CONFIG_SMC91X=y
 CONFIG_SMSC911X=y
+CONFIG_TI_DAVINCI_EMAC=y
 CONFIG_KS8851=y
 CONFIG_KS8851_MLL=y
 CONFIG_LIBERTAS=m
-- 
1.7.5.4

