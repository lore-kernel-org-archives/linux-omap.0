From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 10/17] staging: tidspbridge: Prepare for irqs.h removal
Date: Mon, 10 Sep 2012 22:31:06 -0700
Message-ID: <20120911053106.29637.33453.stgit@muffinssi.local>
References: <20120911052934.29637.9190.stgit@muffinssi.local>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-04-ewr.mailhop.org ([204.13.248.74]:13927 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1754131Ab2IKFbI (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 11 Sep 2012 01:31:08 -0400
In-Reply-To: <20120911052934.29637.9190.stgit@muffinssi.local>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Omar Ramirez Luna <omar.ramirez@ti.com>, linux-omap@vger.kernel.org

Let's define some things locally to avoid breaking build
when irqs.h is removed.

This is needed for the ARM common zImage support.

Cc: Omar Ramirez Luna <omar.ramirez@ti.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 drivers/staging/tidspbridge/core/dsp-clock.c  |    2 ++
 drivers/staging/tidspbridge/core/tiomap3430.c |    4 ++--
 drivers/staging/tidspbridge/core/wdt.c        |    3 ++-
 3 files changed, 6 insertions(+), 3 deletions(-)

diff --git a/drivers/staging/tidspbridge/core/dsp-clock.c b/drivers/staging/tidspbridge/core/dsp-clock.c
index c7df34e..7eac01e 100644
--- a/drivers/staging/tidspbridge/core/dsp-clock.c
+++ b/drivers/staging/tidspbridge/core/dsp-clock.c
@@ -16,6 +16,8 @@
  * WARRANTIES OF MERCHANTIBILITY AND FITNESS FOR A PARTICULAR PURPOSE.
  */
 
+#define L4_34XX_BASE		0x48000000
+
 #include <linux/types.h>
 
 /*  ----------------------------------- Host OS */
diff --git a/drivers/staging/tidspbridge/core/tiomap3430.c b/drivers/staging/tidspbridge/core/tiomap3430.c
index f9609ce..40dc73e 100644
--- a/drivers/staging/tidspbridge/core/tiomap3430.c
+++ b/drivers/staging/tidspbridge/core/tiomap3430.c
@@ -415,10 +415,10 @@ static int bridge_brd_start(struct bridge_dev_context *dev_ctxt,
 		/* Assert RST1 i.e only the RST only for DSP megacell */
 		if (!status) {
 			/*
-			 * XXX: ioremapping  MUST be removed once ctrl
+			 * XXX: OMAP343X_CTRL_BASE ioremapping  MUST be removed once ctrl
 			 * function is made available.
 			 */
-			void __iomem *ctrl = ioremap(OMAP343X_CTRL_BASE, SZ_4K);
+			void __iomem *ctrl = ioremap(0x48002000, SZ_4K);
 			if (!ctrl)
 				return -ENOMEM;
 
diff --git a/drivers/staging/tidspbridge/core/wdt.c b/drivers/staging/tidspbridge/core/wdt.c
index 870f934..1ed1474 100644
--- a/drivers/staging/tidspbridge/core/wdt.c
+++ b/drivers/staging/tidspbridge/core/wdt.c
@@ -25,7 +25,8 @@
 #include <dspbridge/host_os.h>
 
 
-#define OMAP34XX_WDT3_BASE 		(L4_PER_34XX_BASE + 0x30000)
+#define OMAP34XX_WDT3_BASE 		(0x49000000 + 0x30000)
+#define INT_34XX_WDT3_IRQ 		36
 
 static struct dsp_wdt_setting dsp_wdt;
 

