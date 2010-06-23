From: Nishanth Menon <nm@ti.com>
Subject: [PATCH 2/5] omap2/3/4: serial: remove initialization sparse warnings
Date: Tue, 22 Jun 2010 23:17:51 -0500
Message-ID: <1277266674-5906-3-git-send-email-nm@ti.com>
References: <1277266674-5906-1-git-send-email-nm@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:39075 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750824Ab0FWESG (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 23 Jun 2010 00:18:06 -0400
In-Reply-To: <1277266674-5906-1-git-send-email-nm@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap <linux-omap@vger.kernel.org>
Cc: Tony Lindgren <tony@atomide.com>, Nishanth Menon <nm@ti.com>, Deepak K <deepak.k@ti.com>, Govindraj R <govindraj.raja@ti.com>, Kevin Hilman <khilman@deeprootsystems.com>, Tero Kristo <tero.kristo@nokia.com>

Initialization of pointer should be done with NULL. Removes sparse
warnings:
arch/arm/mach-omap2/serial.c:566:17: warning: Using plain integer as NULL pointer
arch/arm/mach-omap2/serial.c:567:17: warning: Using plain integer as NULL pointer

Cc: Deepak K <deepak.k@ti.com>
Cc: Govindraj R <govindraj.raja@ti.com>
Cc: Kevin Hilman <khilman@deeprootsystems.com>
Cc: Tero Kristo <tero.kristo@nokia.com>
Cc: Tony Lindgren <tony@atomide.com>

Signed-off-by: Nishanth Menon <nm@ti.com>
---
 arch/arm/mach-omap2/serial.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-omap2/serial.c b/arch/arm/mach-omap2/serial.c
index 804dbb2..9476c1c 100644
--- a/arch/arm/mach-omap2/serial.c
+++ b/arch/arm/mach-omap2/serial.c
@@ -495,8 +495,8 @@ static void omap_uart_idle_init(struct omap_uart_state *uart)
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

