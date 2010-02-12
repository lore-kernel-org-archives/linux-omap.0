From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 18/19] ARM: OMAP4: Add McPDM base address
Date: Thu, 11 Feb 2010 16:51:49 -0800
Message-ID: <20100212005149.24958.48134.stgit@baageli.muru.com>
References: <20100212004844.24958.29506.stgit@baageli.muru.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:53909 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757776Ab0BLAvI (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 11 Feb 2010 19:51:08 -0500
In-Reply-To: <20100212004844.24958.29506.stgit@baageli.muru.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org
Cc: linux-omap@vger.kernel.org, Jorge Eduardo Candelaria <x0107209@ti.com>

From: Jorge Eduardo Candelaria <x0107209@ti.com>

Define McPDM physical and L3 base address for OMAP4

Signed-off-by: Jorge Eduardo Candelaria <x0107209@ti.com>
Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 arch/arm/plat-omap/include/plat/omap44xx.h |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/arch/arm/plat-omap/include/plat/omap44xx.h b/arch/arm/plat-omap/include/plat/omap44xx.h
index ef870de..2068b39 100644
--- a/arch/arm/plat-omap/include/plat/omap44xx.h
+++ b/arch/arm/plat-omap/include/plat/omap44xx.h
@@ -41,6 +41,8 @@
 #define OMAP44XX_SCU_BASE		0x48240000
 #define OMAP44XX_LOCAL_TWD_BASE		0x48240600
 #define OMAP44XX_WKUPGEN_BASE		0x48281000
+#define OMAP44XX_MCPDM_BASE		0x40132000
+#define OMAP44XX_MCPDM_L3_BASE		0x49032000
 
 #define OMAP44XX_MAILBOX_BASE		(L4_44XX_BASE + 0xF4000)
 

