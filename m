From: Andrii Tseglytskyi <andrii.tseglytskyi@ti.com>
Subject: [PATCH v2 1/3] PM / AVS: SmartReflex: disable errgen before vpbound disable
Date: Thu, 30 May 2013 13:08:34 +0300
Message-ID: <1369908516-26573-2-git-send-email-andrii.tseglytskyi@ti.com>
References: <1369908516-26573-1-git-send-email-andrii.tseglytskyi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-pm-owner@vger.kernel.org>
In-Reply-To: <1369908516-26573-1-git-send-email-andrii.tseglytskyi@ti.com>
Sender: linux-pm-owner@vger.kernel.org
To: khilman@linaro.org, j-keerthy@ti.com
Cc: linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, linux-pm@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

From: Nishanth Menon <nm@ti.com>

vpboundsintr_en is available inside the IP block as an re-sycned
version and one which is not. Due to this, there is an 1 sysclk
cycle window where the SR_SInterruptz signal could be asserted low.
IF, intr_en is cleared on the exact same cycle as the irqclr, an
additional pulse is generated which indicates for VP that
an additional adjustment of voltage is required.

This results in VP doing two voltage adjustments for the SRERR
(based on configuration, upto 4 steps), instead of the needed
1 step.
Due to the unexpected pulse from AVS which breaks the AVS-VP
communication protocol, VP also ends up in a stuck condition by
entering a state where VP module remains non-responsive
to any futher AVS adjustment events. This creates the symptom
called "TRANXDONE Timeout" scenario.

By disabling errgen prior to disable of intr_en, this situation
can be avoided.

Signed-off-by: Vincent Bour <v-bour@ti.com>
Signed-off-by: Leonardo Affortunati <l-affortunati@ti.com>
Signed-off-by: Nishanth Menon <nm@ti.com>
Signed-off-by: Andrii.Tseglytskyi <andrii.tseglytskyi@ti.com>
---
 drivers/power/avs/smartreflex.c |   11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/drivers/power/avs/smartreflex.c b/drivers/power/avs/smartreflex.c
index 6b2238b..f34d34d 100644
--- a/drivers/power/avs/smartreflex.c
+++ b/drivers/power/avs/smartreflex.c
@@ -449,12 +449,17 @@ int sr_disable_errgen(struct voltagedomain *voltdm)
 		return -EINVAL;
 	}
 
-	/* Disable the interrupts of ERROR module */
-	sr_modify_reg(sr, errconfig_offs, vpboundint_en | vpboundint_st, 0);
-
 	/* Disable the Sensor and errorgen */
 	sr_modify_reg(sr, SRCONFIG, SRCONFIG_SENENABLE | SRCONFIG_ERRGEN_EN, 0);
 
+	/*
+	 * Disable the interrupts of ERROR module
+	 * NOTE: modify is a read, modify,write - an implicit OCP barrier
+	 * which is required is present here - sequencing is critical
+	 * at this point (after errgen is disabled, vpboundint disable)
+	 */
+	sr_modify_reg(sr, errconfig_offs, vpboundint_en | vpboundint_st, 0);
+
 	return 0;
 }
 
-- 
1.7.9.5

