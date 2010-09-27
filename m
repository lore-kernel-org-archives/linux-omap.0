From: "Govindraj.R" <govindraj.raja@ti.com>
Subject: [PATCH 09/13 v3] OMAP3: PM: Add prepare idle and resume idle call
     for uart4
Date: Mon, 27 Sep 2010 20:20:32 +0530 (IST)
Message-ID: <43763.10.24.255.17.1285599032.squirrel@dbdmail.itg.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-serial-owner@vger.kernel.org>
Sender: linux-serial-owner@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org, linux-serial@vger.kernel.org, Kevin Hilman <khilman@deeprootsystems.com>, Tony Lindgren <tony@atomide.com>
List-Id: linux-omap@vger.kernel.org

Add prepare idle and resume idle call for uart4 used by 3630.

Cc: Kevin Hilman <khilman@deeprootsystems.com>
Signed-off-by: Govindraj.R <govindraj.raja@ti.com>
---
 arch/arm/mach-omap2/pm34xx.c |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap2/pm34xx.c b/arch/arm/mach-omap2/pm34xx.c
index 043faaa..60baffa 100644
--- a/arch/arm/mach-omap2/pm34xx.c
+++ b/arch/arm/mach-omap2/pm34xx.c
@@ -388,6 +388,7 @@ void omap_sram_idle(void)
 	/* PER */
 	if (per_next_state < PWRDM_POWER_ON) {
 		omap_uart_prepare_idle(2);
+		omap_uart_prepare_idle(3);
 		omap2_gpio_prepare_for_idle(per_next_state);
 		if (per_next_state == PWRDM_POWER_OFF)
 				omap3_per_save_context();
@@ -459,6 +460,7 @@ void omap_sram_idle(void)
 		if (per_prev_state == PWRDM_POWER_OFF)
 			omap3_per_restore_context();
 		omap_uart_resume_idle(2);
+		omap_uart_resume_idle(3);
 	}

 	/* Disable IO-PAD and IO-CHAIN wakeup */
-- 
1.6.3.3


