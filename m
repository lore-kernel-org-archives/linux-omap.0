From: Paul Walmsley <paul@pwsan.com>
Subject: [PATCH 1/2] OMAP3: cpuidle: prevent CORE power domain from going to
	RET or OFF when DSS is on
Date: Tue, 01 Mar 2011 15:49:24 -0700
Message-ID: <20110301224918.32613.95176.stgit@twilight.localdomain>
References: <20110301220833.32613.54669.stgit@twilight.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:54714 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755645Ab1CAWu1 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 1 Mar 2011 17:50:27 -0500
In-Reply-To: <20110301220833.32613.54669.stgit@twilight.localdomain>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: Tero Kristo <tero.kristo@nokia.com>

From: Tero Kristo <tero.kristo@nokia.com>

Prevent the CORE power domain from entering RETENTION or OFF when DSS
is on.  Otherwise, the display FIFO(s) may underflow due to the time
needed for the CORE to wake back up, causing tearing and unnecessary
interrupts.

Signed-off-by: Tero Kristo <tero.kristo@nokia.com>
[paul@pwsan.com: wrote commit message]
Signed-off-by: Paul Walmsley <paul@pwsan.com>
---
 arch/arm/mach-omap2/cpuidle34xx.c |   10 ++++++++--
 1 files changed, 8 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-omap2/cpuidle34xx.c b/arch/arm/mach-omap2/cpuidle34xx.c
index 0335cd8..d1b7789 100644
--- a/arch/arm/mach-omap2/cpuidle34xx.c
+++ b/arch/arm/mach-omap2/cpuidle34xx.c
@@ -9,8 +9,9 @@
  * Copyright (C) 2007 Texas Instruments, Inc.
  * Karthik Dasu <karthik-dp@ti.com>
  *
- * Copyright (C) 2006 Nokia Corporation
+ * Copyright (C) 2006, 2011 Nokia Corporation
  * Tony Lindgren <tony@atomide.com>
+ * Tero Kristo <tero.kristo@nokia.com>
  *
  * Copyright (C) 2005 Texas Instruments, Inc.
  * Richard Woodruff <r-woodruff2@ti.com>
@@ -268,6 +269,12 @@ static int omap3_enter_idle_bm(struct cpuidle_device *dev,
 		goto select_state;
 	}
 
+	/* If DSS is active, prevent CORE RET/OFF */
+	dss_state = pwrdm_read_pwrst(dss_pd);
+	if (dss_state == PWRDM_POWER_ON &&
+	    core_next_state != PWRDM_POWER_ON)
+		core_next_state = PWRDM_POWER_INACTIVE;
+
 	/*
 	 * Prevent PER off if CORE is not in retention or off as this
 	 * would disable PER wakeups completely.
@@ -288,7 +295,6 @@ static int omap3_enter_idle_bm(struct cpuidle_device *dev,
 		iva2_state = pwrdm_read_pwrst(iva2_pd);
 		sgx_state = pwrdm_read_pwrst(sgx_pd);
 		usb_state = pwrdm_read_pwrst(usb_pd);
-		dss_state = pwrdm_read_pwrst(dss_pd);
 
 		if (cam_state > PWRDM_POWER_OFF ||
 		    dss_state > PWRDM_POWER_OFF ||


