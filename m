From: Nishanth Menon <nm@ti.com>
Subject: [RFC PATCH 2/6] ARM: OMAP: voltage: remove duplicate header definitions
Date: Tue, 23 Oct 2012 16:43:57 -0500
Message-ID: <1351028641-20832-3-git-send-email-nm@ti.com>
References: <1351028641-20832-1-git-send-email-nm@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:45502 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754226Ab2JWVoH (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 23 Oct 2012 17:44:07 -0400
Received: from dlelxv30.itg.ti.com ([172.17.2.17])
	by bear.ext.ti.com (8.13.7/8.13.7) with ESMTP id q9NLi6hS026725
	for <linux-omap@vger.kernel.org>; Tue, 23 Oct 2012 16:44:06 -0500
Received: from DFLE72.ent.ti.com (dfle72.ent.ti.com [128.247.5.109])
	by dlelxv30.itg.ti.com (8.13.8/8.13.8) with ESMTP id q9NLi6cW028643
	for <linux-omap@vger.kernel.org>; Tue, 23 Oct 2012 16:44:06 -0500
In-Reply-To: <1351028641-20832-1-git-send-email-nm@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: l-o <linux-omap@vger.kernel.org>
Cc: Kevin Hilman <khilman@ti.com>, Jean Pihet <j-pihet@ti.com>, J Keerthy <j-keerthy@ti.com>, Nishanth Menon <nm@ti.com>

Remove duplicate definitions which are already present
in linux/platform_data/voltage-omap.h

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

