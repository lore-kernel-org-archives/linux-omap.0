From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 3/3] ARM: omap2plus_defconfig: Add NOR flash support
Date: Mon, 19 Jan 2015 10:15:58 -0800
Message-ID: <1421691358-14661-4-git-send-email-tony@atomide.com>
References: <1421691358-14661-1-git-send-email-tony@atomide.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-03-ewr.mailhop.org ([204.13.248.66]:34064 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751677AbbASSTg (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 19 Jan 2015 13:19:36 -0500
In-Reply-To: <1421691358-14661-1-git-send-email-tony@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org

Some omaps have NOR flash as the rootfs but we're missing
physmap and physmap_of to properly support it.

Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 arch/arm/configs/omap2plus_defconfig | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/configs/omap2plus_defconfig b/arch/arm/configs/omap2plus_defconfig
index 3ac8269..6654b23 100644
--- a/arch/arm/configs/omap2plus_defconfig
+++ b/arch/arm/configs/omap2plus_defconfig
@@ -108,6 +108,8 @@ CONFIG_MTD_BLOCK=y
 CONFIG_MTD_OOPS=y
 CONFIG_MTD_CFI=y
 CONFIG_MTD_CFI_INTELEXT=y
+CONFIG_MTD_PHYSMAP=y
+CONFIG_MTD_PHYSMAP_OF=y
 CONFIG_MTD_NAND=y
 CONFIG_MTD_NAND_ECC_BCH=y
 CONFIG_MTD_NAND_OMAP2=y
-- 
2.1.4

