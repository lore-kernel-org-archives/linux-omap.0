From: Nishanth Menon <nm@ti.com>
Subject: [PM][PATCH 3/4] OMAP3: Serial: remove initialization sparse warnings
Date: Thu,  8 Apr 2010 12:54:08 -0500
Message-ID: <1270749249-14041-4-git-send-email-nm@ti.com>
References: <1270749249-14041-1-git-send-email-nm@ti.com>
 <1270749249-14041-2-git-send-email-nm@ti.com>
 <1270749249-14041-3-git-send-email-nm@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:42617 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932978Ab0DHRyX (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 8 Apr 2010 13:54:23 -0400
In-Reply-To: <1270749249-14041-3-git-send-email-nm@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap <linux-omap@vger.kernel.org>
Cc: Nishanth Menon <nm@ti.com>, Govindraj R <govindraj.raja@ti.com>, Kevin Hilman <khilman@deeprootsystems.com>, Tero Kristo <tero.kristo@nokia.com>

Initialization of pointer should be done with NULL. Removes sparse
warnings:
arch/arm/mach-omap2/serial.c:566:17: warning: Using plain integer as NULL pointer
arch/arm/mach-omap2/serial.c:567:17: warning: Using plain integer as NULL pointer

Cc: Govindraj R <govindraj.raja@ti.com>
Cc: Kevin Hilman <khilman@deeprootsystems.com>
Cc: Tero Kristo <tero.kristo@nokia.com>

Signed-off-by: Nishanth Menon <nm@ti.com>
---
 arch/arm/mach-omap2/serial.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-omap2/serial.c b/arch/arm/mach-omap2/serial.c
index 144033f..c7b2326 100644
--- a/arch/arm/mach-omap2/serial.c
+++ b/arch/arm/mach-omap2/serial.c
@@ -563,8 +563,8 @@ static void omap_uart_idle_init(struct omap_uart_state *uart)
 		}
 		uart->wk_mask = wk_mask;
 	} else {
-		uart->wk_en = 0;
-		uart->wk_st = 0;
+		uart->wk_en = NULL;
+		uart->wk_st = NULL;
 		uart->wk_mask = 0;
 		uart->padconf = 0;
 	}
-- 
1.6.3.3

