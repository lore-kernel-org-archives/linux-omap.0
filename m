From: Roel Kluin <roel.kluin@gmail.com>
Subject: [PATCH] OMAP3: add missing parentheses
Date: Wed, 23 Dec 2009 02:42:49 +0100
Message-ID: <4B317599.30809@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1753390AbZLWBk3@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, Andrew Morton <akpm@linux-foundation.org>, LKML <linux-kernel@vger.kernel.org>
List-Id: linux-omap@vger.kernel.org

not(!) has a higher precedence than bit and(&).

Signed-off-by: Roel Kluin <roel.kluin@gmail.com>
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
