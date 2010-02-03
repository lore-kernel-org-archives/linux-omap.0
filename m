From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 2/9] omap: Remove old unused defines for OMAP_32KSYNCT_BASE
Date: Tue, 02 Feb 2010 18:25:59 -0800
Message-ID: <20100203022559.26347.77654.stgit@baageli.muru.com>
References: <20100203022318.26347.34734.stgit@baageli.muru.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-ewr.mailhop.org ([204.13.248.71]:61358 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932331Ab0BCCZe (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 2 Feb 2010 21:25:34 -0500
In-Reply-To: <20100203022318.26347.34734.stgit@baageli.muru.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org
Cc: linux-omap@vger.kernel.org

Remove old unused defines for OMAP_32KSYNCT_BASE

Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 arch/arm/plat-omap/omap_device.c |   10 ----------
 1 files changed, 0 insertions(+), 10 deletions(-)

diff --git a/arch/arm/plat-omap/omap_device.c b/arch/arm/plat-omap/omap_device.c
index 1e5648d..2ed7201 100644
--- a/arch/arm/plat-omap/omap_device.c
+++ b/arch/arm/plat-omap/omap_device.c
@@ -89,16 +89,6 @@
 #define USE_WAKEUP_LAT			0
 #define IGNORE_WAKEUP_LAT		1
 
-/* XXX this should be moved into a separate file */
-#if defined(CONFIG_ARCH_OMAP2420)
-# define OMAP_32KSYNCT_BASE		0x48004000
-#elif defined(CONFIG_ARCH_OMAP2430)
-# define OMAP_32KSYNCT_BASE		0x49020000
-#elif defined(CONFIG_ARCH_OMAP3430)
-# define OMAP_32KSYNCT_BASE		0x48320000
-#else
-# error Unknown OMAP device
-#endif
 
 /* Private functions */
 

