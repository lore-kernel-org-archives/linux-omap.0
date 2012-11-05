From: Nishanth Menon <nm@ti.com>
Subject: [PATCH 2/6] ARM: OMAP: voltage: remove duplicate header definitions
Date: Mon, 5 Nov 2012 09:02:10 -0600
Message-ID: <1352127734-30103-4-git-send-email-nm@ti.com>
References: <1352127734-30103-1-git-send-email-nm@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-pm-owner@vger.kernel.org>
In-Reply-To: <1352127734-30103-1-git-send-email-nm@ti.com>
Sender: linux-pm-owner@vger.kernel.org
To: linux-omap <linux-omap@vger.kernel.org>
Cc: Rafael <rjw@sisk.pl>, Kevin Hilman <khilman@ti.com>, Anton Vorontsov <cbouatmailru@gmail.com>, linux-pm <linux-pm@vger.kernel.org>, Nishanth Menon <nm@ti.com>
List-Id: linux-omap@vger.kernel.org

remove duplicate definitions which are already present
in linux/platform_data/voltage-omap.h

Acked-by: Jean Pihet <j-pihet@ti.com>
Signed-off-by: Nishanth Menon <nm@ti.com>
---
 arch/arm/mach-omap2/voltage.h |    3 ---
 1 file changed, 3 deletions(-)

diff --git a/arch/arm/mach-omap2/voltage.h b/arch/arm/mach-omap2/voltage.h
index 7283b7e..af9d469 100644
--- a/arch/arm/mach-omap2/voltage.h
+++ b/arch/arm/mach-omap2/voltage.h
@@ -142,7 +142,6 @@ extern void omap3xxx_voltagedomains_init(void);
 extern void am33xx_voltagedomains_init(void);
 extern void omap44xx_voltagedomains_init(void);
 
-struct voltagedomain *voltdm_lookup(const char *name);
 void voltdm_init(struct voltagedomain **voltdm_list);
 int voltdm_add_pwrdm(struct voltagedomain *voltdm, struct powerdomain *pwrdm);
 int voltdm_for_each(int (*fn)(struct voltagedomain *voltdm, void *user),
@@ -150,7 +149,5 @@ int voltdm_for_each(int (*fn)(struct voltagedomain *voltdm, void *user),
 int voltdm_for_each_pwrdm(struct voltagedomain *voltdm,
 			  int (*fn)(struct voltagedomain *voltdm,
 				    struct powerdomain *pwrdm));
-int voltdm_scale(struct voltagedomain *voltdm, unsigned long target_volt);
 void voltdm_reset(struct voltagedomain *voltdm);
-unsigned long voltdm_get_voltage(struct voltagedomain *voltdm);
 #endif
-- 
1.7.9.5

