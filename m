From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 09/12] omap3: add missing parentheses
Date: Wed, 06 Jan 2010 16:20:21 -0800
Message-ID: <20100107002021.21352.68495.stgit@baageli.muru.com>
References: <20100107001728.21352.38471.stgit@baageli.muru.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:56366 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755909Ab0AGAUT (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 6 Jan 2010 19:20:19 -0500
In-Reply-To: <20100107001728.21352.38471.stgit@baageli.muru.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org
Cc: linux-omap@vger.kernel.org, Roel Kluin <roel.kluin@gmail.com>

From: Roel Kluin <roel.kluin@gmail.com>

not(!) has a higher precedence than bit and(&).

Signed-off-by: Roel Kluin <roel.kluin@gmail.com>
Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 arch/arm/plat-omap/include/plat/control.h |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/arm/plat-omap/include/plat/control.h b/arch/arm/plat-omap/include/plat/control.h
index 2ae8843..a745d62 100644
--- a/arch/arm/plat-omap/include/plat/control.h
+++ b/arch/arm/plat-omap/include/plat/control.h
@@ -147,7 +147,7 @@
 #define OMAP343X_CONTROL_IVA2_BOOTADDR	(OMAP2_CONTROL_GENERAL + 0x0190)
 #define OMAP343X_CONTROL_IVA2_BOOTMOD	(OMAP2_CONTROL_GENERAL + 0x0194)
 #define OMAP343X_CONTROL_DEBOBS(i)	(OMAP2_CONTROL_GENERAL + 0x01B0 \
-					+ ((i) >> 1) * 4 + (!(i) & 1) * 2)
+					+ ((i) >> 1) * 4 + (!((i) & 1)) * 2)
 #define OMAP343X_CONTROL_PROG_IO0	(OMAP2_CONTROL_GENERAL + 0x01D4)
 #define OMAP343X_CONTROL_PROG_IO1	(OMAP2_CONTROL_GENERAL + 0x01D8)
 #define OMAP343X_CONTROL_DSS_DPLL_SPREADING	(OMAP2_CONTROL_GENERAL + 0x01E0)

