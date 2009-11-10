From: Vikram Pandita <vikram.pandita@ti.com>
Subject: [PATCH v2 4/8] omap: zoom2: update defconfig for LL_DEBUG_NONE
Date: Tue, 10 Nov 2009 16:47:25 -0600
Message-ID: <1257893249-15467-5-git-send-email-vikram.pandita@ti.com>
References: <1257893249-15467-1-git-send-email-vikram.pandita@ti.com>
 <1257893249-15467-2-git-send-email-vikram.pandita@ti.com>
 <1257893249-15467-3-git-send-email-vikram.pandita@ti.com>
 <1257893249-15467-4-git-send-email-vikram.pandita@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:41457 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758320AbZKJWsF (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 10 Nov 2009 17:48:05 -0500
Received: from dlep36.itg.ti.com ([157.170.170.91])
	by devils.ext.ti.com (8.13.7/8.13.7) with ESMTP id nAAMmAOg019756
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-omap@vger.kernel.org>; Tue, 10 Nov 2009 16:48:10 -0600
In-Reply-To: <1257893249-15467-4-git-send-email-vikram.pandita@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Vikram Pandita <vikram.pandita@ti.com>

Update DEBUG_LL for zoom2 board as CONFIG_OMAP_LL_DEBUG_NONE

Signed-off-by: Vikram Pandita <vikram.pandita@ti.com>
---
 arch/arm/configs/omap_zoom2_defconfig |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/arch/arm/configs/omap_zoom2_defconfig b/arch/arm/configs/omap_zoom2_defconfig
index f1739fa..2eec53b 100644
--- a/arch/arm/configs/omap_zoom2_defconfig
+++ b/arch/arm/configs/omap_zoom2_defconfig
@@ -202,7 +202,8 @@ CONFIG_OMAP_32K_TIMER_HZ=128
 CONFIG_OMAP_DM_TIMER=y
 # CONFIG_OMAP_LL_DEBUG_UART1 is not set
 # CONFIG_OMAP_LL_DEBUG_UART2 is not set
-CONFIG_OMAP_LL_DEBUG_UART3=y
+# CONFIG_OMAP_LL_DEBUG_UART3 is not set
+CONFIG_OMAP_LL_DEBUG_NONE=y
 CONFIG_ARCH_OMAP34XX=y
 CONFIG_ARCH_OMAP3430=y
 
-- 
1.6.5.1.69.g36942

