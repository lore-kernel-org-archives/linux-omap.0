From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 02/16] omap: mux: Renumber package defines to make room for
	older 24xx packages
Date: Wed, 30 Jun 2010 15:06:35 +0300
Message-ID: <20100630120635.2637.4819.stgit@baageli.muru.com>
References: <20100630120226.2637.31198.stgit@baageli.muru.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-ewr.mailhop.org ([204.13.248.71]:57083 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755689Ab0F3MGY (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 30 Jun 2010 08:06:24 -0400
In-Reply-To: <20100630120226.2637.31198.stgit@baageli.muru.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org
Cc: linux-omap@vger.kernel.org

Only POP and SIP are known to exist for 2420, 2430 seems to only have
SIP package available.

Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 arch/arm/mach-omap2/mux.h |   10 ++++++----
 1 files changed, 6 insertions(+), 4 deletions(-)

diff --git a/arch/arm/mach-omap2/mux.h b/arch/arm/mach-omap2/mux.h
index 480abc5..46315f2 100644
--- a/arch/arm/mach-omap2/mux.h
+++ b/arch/arm/mach-omap2/mux.h
@@ -56,10 +56,12 @@
 
 /* Flags for omap_mux_init */
 #define OMAP_PACKAGE_MASK		0xffff
-#define OMAP_PACKAGE_CBP		4		/* 515-pin 0.40 0.50 */
-#define OMAP_PACKAGE_CUS		3		/* 423-pin 0.65 */
-#define OMAP_PACKAGE_CBB		2		/* 515-pin 0.40 0.50 */
-#define OMAP_PACKAGE_CBC		1		/* 515-pin 0.50 0.65 */
+#define OMAP_PACKAGE_CBP		6		/* 515-pin 0.40 0.50 */
+#define OMAP_PACKAGE_CUS		5		/* 423-pin 0.65 */
+#define OMAP_PACKAGE_CBB		4		/* 515-pin 0.40 0.50 */
+#define OMAP_PACKAGE_CBC		3		/* 515-pin 0.50 0.65 */
+#define OMAP_PACKAGE_ZAC		2		/* 24xx 447-pin POP */
+#define OMAP_PACKAGE_ZAF		1		/* 2420 447-pin SIP */
 
 
 #define OMAP_MUX_NR_MODES	8			/* Available modes */

