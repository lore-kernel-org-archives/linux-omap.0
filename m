From: Nishanth Menon <nm@ti.com>
Subject: [PATCH 08/13] OMAP3: PM: Deny MPU idle while saving secure RAM
Date: Thu, 18 Nov 2010 19:54:53 -0600
Message-ID: <1290131698-6194-9-git-send-email-nm@ti.com>
References: <1290131698-6194-1-git-send-email-nm@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:38896 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756417Ab0KSBzC (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 18 Nov 2010 20:55:02 -0500
In-Reply-To: <1290131698-6194-1-git-send-email-nm@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap <linux-omap@vger.kernel.org>
Cc: Kevin <khilman@deeprootsystems.com>, Jean Pihet <jean.pihet@newoldbits.com>, Vishwanath Sripathy <vishwanath.bs@ti.com>, Tony <tony@atomide.com>

From: Eduardo Valentin <eduardo.valentin@nokia.com>

Deny MPU idle before save secure ram and allow it after save secure RAM.
We want to deny MPU going to low power state because, there is a short
time window where a wakeup event would happen around the time the MPU
is going to idle. Since the first thing ROM code does after WFI is to
read INTCPS register, we could reach a situation where the INTCPS is
in idle, but the read is sent to it. That would produce a data abord
during the save of secure ram, which will hang the system. we need
to prevent clock transitions as well during this timeframe.

[nm@ti.com: rebased to 2.6.37-rc2, used omap2_clkdm_deny_idle for
clock prevention]
Signed-off-by: Nishanth Menon <nm@ti.com>
Signed-off-by: Eduardo Valentin <eduardo.valentin@nokia.com>
---
 arch/arm/mach-omap2/pm34xx.c |    4 ++++
 1 files changed, 4 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap2/pm34xx.c b/arch/arm/mach-omap2/pm34xx.c
index 7877f74..f520b38 100644
--- a/arch/arm/mach-omap2/pm34xx.c
+++ b/arch/arm/mach-omap2/pm34xx.c
@@ -194,15 +194,19 @@ int __init omap3_secure_copy_data_set(struct omap3_secure_copy_data *data)
 static void omap3_save_secure_ram_context(u32 target_mpu_state)
 {
 	if (!secure_ram_saved && omap_type() != OMAP2_DEVICE_TYPE_GP) {
+		struct clockdomain *clkd = mpu_pwrdm->pwrdm_clkdms[0];
+
 		/*
 		 * MPU next state must be set to POWER_ON temporarily,
 		 * otherwise the WFI executed inside the ROM code
 		 * will hang the system.
 		 */
 		pwrdm_set_next_pwrst(mpu_pwrdm, PWRDM_POWER_ON);
+		omap2_clkdm_deny_idle(clkd);
 		secure_ram_save_status = _omap_save_secure_sram((u32 *)
 				(omap3_secure_ram_storage));
 		pwrdm_set_next_pwrst(mpu_pwrdm, target_mpu_state);
+		omap2_clkdm_allow_idle(clkd);
 		if (!secure_copy_data.save_every_cycle)
 			secure_ram_saved = 1;
 	}
-- 
1.6.3.3

