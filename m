From: Nishanth Menon <nm@ti.com>
Subject: [PATCH 05/13] OMAP3: PM: optional save secure RAM context every core off cycle
Date: Thu, 18 Nov 2010 19:54:50 -0600
Message-ID: <1290131698-6194-6-git-send-email-nm@ti.com>
References: <1290131698-6194-1-git-send-email-nm@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:55460 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760192Ab0KSBzD (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 18 Nov 2010 20:55:03 -0500
In-Reply-To: <1290131698-6194-1-git-send-email-nm@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap <linux-omap@vger.kernel.org>
Cc: Kevin <khilman@deeprootsystems.com>, Jean Pihet <jean.pihet@newoldbits.com>, Vishwanath Sripathy <vishwanath.bs@ti.com>, Tony <tony@atomide.com>

From: Tero Kristo <tero.kristo@nokia.com>

Some PPAs now supports saving secure RAM context several times.
Now we will save it before every core off cycle.
board files can register with params to allow configuration based
on the PPA used.

[nm@ti.com: converted to struct option for various PPAs in the wild]
Signed-off-by: Nishanth Menon <nm@ti.com>
Signed-off-by: Eduardo Valentin <eduardo.valentin@nokia.com>
Signed-off-by: Tero Kristo <tero.kristo@nokia.com>
---
 arch/arm/mach-omap2/pm.h     |   13 +++++++++++++
 arch/arm/mach-omap2/pm34xx.c |    4 +++-
 2 files changed, 16 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-omap2/pm.h b/arch/arm/mach-omap2/pm.h
index c0af788..39934ec 100644
--- a/arch/arm/mach-omap2/pm.h
+++ b/arch/arm/mach-omap2/pm.h
@@ -90,6 +90,18 @@ extern unsigned int omap34xx_cpu_suspend_sz;
  * @size:	size of copy to be saved - this is based on the PPA used
  *		secure ram size could be configured to various sizes, this is
  *		the size used + 64 byte header required.
+ * @save_every_cycle: While going to OFF mode and coming out of it on HS/EMU
+ *		devices, secure service is provided to enable saving the
+ *		contexts of secure ram and secure status of various drivers
+ *		using secure devices. However, there are many kinds of secure
+ *		conditions in the wild:
+ *		1. Implements its own save and restore using pm hooks
+ *		2. Generic drivers which depend on OMAP PM code to handle the
+ *		   same correspondingly, PPA may or may not allow capability
+ *		   to save in every transition to OFF mode.
+ *		3. PPA may be buggy and does'nt allow multiple saves
+ *		Support of this depends heavily on the PPA used and the security
+ *		driver capability. If in doubt, contact the security team.
  *
  * Different platforms use different security PPAs based on their unique needs.
  * This structure describes the delta behavior expected for these custom
@@ -97,6 +109,7 @@ extern unsigned int omap34xx_cpu_suspend_sz;
  */
 struct omap3_secure_copy_data {
 	u32 size;
+	bool save_every_cycle;
 };
 
 #if defined(CONFIG_PM)
diff --git a/arch/arm/mach-omap2/pm34xx.c b/arch/arm/mach-omap2/pm34xx.c
index ba85e9c..b20ecf5 100644
--- a/arch/arm/mach-omap2/pm34xx.c
+++ b/arch/arm/mach-omap2/pm34xx.c
@@ -57,6 +57,7 @@
 /* Secure ram save size - store the defaults */
 static struct omap3_secure_copy_data secure_copy_data = {
 	.size = 0x803F,
+	.save_every_cycle = false,	/* explicit for readability */
 };
 
 struct power_state {
@@ -199,7 +200,8 @@ static void omap3_save_secure_ram_context(u32 target_mpu_state)
 		secure_ram_save_status = _omap_save_secure_sram((u32 *)
 				__pa(omap3_secure_ram_storage));
 		pwrdm_set_next_pwrst(mpu_pwrdm, target_mpu_state);
-		secure_ram_saved = 1;
+		if (!secure_copy_data.save_every_cycle)
+			secure_ram_saved = 1;
 	}
 }
 
-- 
1.6.3.3

