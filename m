From: Nishanth Menon <nm@ti.com>
Subject: [PATCH 3/6] ARM: OMAP: voltage: move voltdm_reset to platform_data header
Date: Mon, 5 Nov 2012 09:02:11 -0600
Message-ID: <1352127734-30103-5-git-send-email-nm@ti.com>
References: <1352127734-30103-1-git-send-email-nm@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:35047 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932625Ab2KEPCk (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 5 Nov 2012 10:02:40 -0500
In-Reply-To: <1352127734-30103-1-git-send-email-nm@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap <linux-omap@vger.kernel.org>
Cc: Rafael <rjw@sisk.pl>, Kevin Hilman <khilman@ti.com>, Anton Vorontsov <cbouatmailru@gmail.com>, linux-pm <linux-pm@vger.kernel.org>, Nishanth Menon <nm@ti.com>

Move voltdm_reset to include/linux/platform_data/voltage-omap.h

Acked-by: Jean Pihet <j-pihet@ti.com>
Signed-off-by: Nishanth Menon <nm@ti.com>
---
 arch/arm/mach-omap2/voltage.h              |    1 -
 include/linux/platform_data/voltage-omap.h |    1 +
 2 files changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/mach-omap2/voltage.h b/arch/arm/mach-omap2/voltage.h
index af9d469..0665f21 100644
--- a/arch/arm/mach-omap2/voltage.h
+++ b/arch/arm/mach-omap2/voltage.h
@@ -149,5 +149,4 @@ int voltdm_for_each(int (*fn)(struct voltagedomain *voltdm, void *user),
 int voltdm_for_each_pwrdm(struct voltagedomain *voltdm,
 			  int (*fn)(struct voltagedomain *voltdm,
 				    struct powerdomain *pwrdm));
-void voltdm_reset(struct voltagedomain *voltdm);
 #endif
diff --git a/include/linux/platform_data/voltage-omap.h b/include/linux/platform_data/voltage-omap.h
index 5be4d5d..4eb3d43 100644
--- a/include/linux/platform_data/voltage-omap.h
+++ b/include/linux/platform_data/voltage-omap.h
@@ -36,4 +36,5 @@ int voltdm_scale(struct voltagedomain *voltdm, unsigned long target_volt);
 unsigned long voltdm_get_voltage(struct voltagedomain *voltdm);
 struct omap_volt_data *omap_voltage_get_voltdata(struct voltagedomain *voltdm,
 		unsigned long volt);
+void voltdm_reset(struct voltagedomain *voltdm);
 #endif
-- 
1.7.9.5

