From: Andrii Tseglytskyi <andrii.tseglytskyi@ti.com>
Subject: [PATCH v1 1/2] PM / AVS: SmartReflex: fix interrupt disable sequence
Date: Fri, 12 Jul 2013 16:52:02 +0300
Message-ID: <1373637123-1152-2-git-send-email-andrii.tseglytskyi@ti.com>
References: <1373637123-1152-1-git-send-email-andrii.tseglytskyi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1373637123-1152-1-git-send-email-andrii.tseglytskyi@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: khilman@linaro.org
Cc: linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, linux-pm@vger.kernel.org, Nishanth Menon <nm@ti.com>, Andrii Tseglytskyi <andrii.tseglytskyi@ti.com>
List-Id: linux-omap@vger.kernel.org

From: Nishanth Menon <nm@ti.com>

With the current interrupt disable sequence, we disable IRQENABLE
followed by clearing of IRQSTATUS. With this sequence, we see, at
times CORE domain does not hit OFF mode during cold boot because
SR modules(Core/IVA/MPU domains) are stuck 'in transition'. This
is due to IP Generic behavior around how swakeup is controlled
towards PRCM.

The right sequence we have is write to IRQSTATUS register
to clear the interrupt, then write to IRQENABLE_CLR register to
disable the interrupt to ensure that no pending interrupts exist
in the system on disable of SmartReflex AVS block.

Reported-by: Honda Kenji <x0092217@ti.com>
Reported-by: Maki Tanaka <m-tanaka1@ti.com>
Signed-off-by: Nishanth Menon <nm@ti.com>
Signed-off-by: Andrii Tseglytskyi <andrii.tseglytskyi@ti.com>
---
 drivers/power/avs/smartreflex.c |    8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/power/avs/smartreflex.c b/drivers/power/avs/smartreflex.c
index 6b2238b..5b2b703 100644
--- a/drivers/power/avs/smartreflex.c
+++ b/drivers/power/avs/smartreflex.c
@@ -295,12 +295,12 @@ static void sr_v2_disable(struct omap_sr *sr)
 	else
 		sr_modify_reg(sr, ERRCONFIG_V2, ERRCONFIG_VPBOUNDINTEN_V2,
 				0x0);
-	sr_write_reg(sr, IRQENABLE_CLR, (IRQENABLE_MCUACCUMINT |
-			IRQENABLE_MCUVALIDINT |
-			IRQENABLE_MCUBOUNDSINT));
 	sr_write_reg(sr, IRQSTATUS, (IRQSTATUS_MCUACCUMINT |
 			IRQSTATUS_MCVALIDINT |
 			IRQSTATUS_MCBOUNDSINT));
+	sr_write_reg(sr, IRQENABLE_CLR, (IRQENABLE_MCUACCUMINT |
+			IRQENABLE_MCUVALIDINT |
+			IRQENABLE_MCUBOUNDSINT));
 
 	/*
 	 * Wait for SR to be disabled.
@@ -315,8 +315,8 @@ static void sr_v2_disable(struct omap_sr *sr)
 			__func__);
 
 	/* Disable MCUDisableAcknowledge interrupt & clear pending interrupt */
-	sr_write_reg(sr, IRQENABLE_CLR, IRQENABLE_MCUDISABLEACKINT);
 	sr_write_reg(sr, IRQSTATUS, IRQSTATUS_MCUDISABLEACKINT);
+	sr_write_reg(sr, IRQENABLE_CLR, IRQENABLE_MCUDISABLEACKINT);
 }
 
 static struct omap_sr_nvalue_table *sr_retrieve_nvalue_row(
-- 
1.7.9.5
