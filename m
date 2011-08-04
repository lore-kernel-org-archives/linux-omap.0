From: David Wagner <david.wagner@free-electrons.com>
Subject: [PATCH 1/2] Macro for getting the BASEADDRESS field in omap's gpmc configuration
Date: Thu,  4 Aug 2011 17:06:34 +0200
Message-ID: <1312470395-19672-1-git-send-email-david.wagner@free-electrons.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail.free-electrons.com ([88.190.12.23]:44769 "EHLO
	mail.free-electrons.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751510Ab1HDPEK (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 4 Aug 2011 11:04:10 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: David Wagner <david.wagner@free-electrons.com>, LKML <inux-kernel@vger.kernel.org>, linux-omap <linux-omap@vger.kernel.org>, Russell King <linux@arm.linux.org.uk>

BASEADDRESS is located in the 6 lower bits of the CONFIG7 register.
See OMAP 35x Technical Reference Manual, p. 1169.

Signed-off-by: David Wagner <david.wagner@free-electrons.com>
---
 arch/arm/plat-omap/include/plat/gpmc.h |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/arch/arm/plat-omap/include/plat/gpmc.h b/arch/arm/plat-omap/include/plat/gpmc.h
index 1527929..154456d 100644
--- a/arch/arm/plat-omap/include/plat/gpmc.h
+++ b/arch/arm/plat-omap/include/plat/gpmc.h
@@ -72,6 +72,7 @@
 #define GPMC_CONFIG1_FCLK_DIV3          (GPMC_CONFIG1_FCLK_DIV(2))
 #define GPMC_CONFIG1_FCLK_DIV4          (GPMC_CONFIG1_FCLK_DIV(3))
 #define GPMC_CONFIG7_CSVALID		(1 << 6)
+#define GPMC_CONFIG7_BASEADDRESS(val)	(val & 0x3F)
 
 #define GPMC_DEVICETYPE_NOR		0
 #define GPMC_DEVICETYPE_NAND		2
-- 
1.7.0.4

