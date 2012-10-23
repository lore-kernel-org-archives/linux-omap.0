From: Nishanth Menon <nm@ti.com>
Subject: [RFC PATCH 3/6] ARM: OMAP: voltage: move voltdm_reset to platform_data header
Date: Tue, 23 Oct 2012 16:43:58 -0500
Message-ID: <1351028641-20832-4-git-send-email-nm@ti.com>
References: <1351028641-20832-1-git-send-email-nm@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:37326 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751222Ab2JWVoH (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 23 Oct 2012 17:44:07 -0400
Received: from dlelxv30.itg.ti.com ([172.17.2.17])
	by arroyo.ext.ti.com (8.13.7/8.13.7) with ESMTP id q9NLi6RF012582
	for <linux-omap@vger.kernel.org>; Tue, 23 Oct 2012 16:44:06 -0500
Received: from DFLE72.ent.ti.com (dfle72.ent.ti.com [128.247.5.109])
	by dlelxv30.itg.ti.com (8.13.8/8.13.8) with ESMTP id q9NLi6mu028655
	for <linux-omap@vger.kernel.org>; Tue, 23 Oct 2012 16:44:06 -0500
In-Reply-To: <1351028641-20832-1-git-send-email-nm@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: l-o <linux-omap@vger.kernel.org>
Cc: Kevin Hilman <khilman@ti.com>, Jean Pihet <j-pihet@ti.com>, J Keerthy <j-keerthy@ti.com>, Nishanth Menon <nm@ti.com>

Move voltdm_reset to include/linux/platform_data/voltage-omap.h
This is an intermediate step to allow usage of the header by smartreflex
driver for usage of the same.

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

