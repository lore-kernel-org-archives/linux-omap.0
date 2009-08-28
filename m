From: Thara Gopinath <thara@ti.com>
Subject: [PATCH V2] OMAP3: PM: Fix for MPU power domain MEM BANK position
Date: Fri, 28 Aug 2009 12:54:57 +0530
Message-ID: <1251444297-13577-1-git-send-email-thara@ti.com>
References: <A24693684029E5489D1D202277BE89444BE28394@dlee02.ent.ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:58408 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752002AbZH1HZD (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 28 Aug 2009 03:25:03 -0400
Received: from dbdp31.itg.ti.com ([172.24.170.98])
	by arroyo.ext.ti.com (8.13.7/8.13.7) with ESMTP id n7S7Owvg016271
	for <linux-omap@vger.kernel.org>; Fri, 28 Aug 2009 02:25:04 -0500
In-Reply-To: <A24693684029E5489D1D202277BE89444BE28394@dlee02.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Thara Gopinath <thara@ti.com>

MPU power domain bank 0 bits are displayed in position of bank 1
in PWRSTS and PREPWRSTS registers. So read them from correct
position

Signed-off-by: Thara Gopinath <thara@ti.com>
---
Patch refresh issue.

 arch/arm/mach-omap2/powerdomain.c |   19 +++++++++++++++++++
 1 files changed, 19 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap2/powerdomain.c b/arch/arm/mach-omap2/powerdomain.c
index 2594cbf..6c5fee9 100644
--- a/arch/arm/mach-omap2/powerdomain.c
+++ b/arch/arm/mach-omap2/powerdomain.c
@@ -971,6 +971,16 @@ int pwrdm_read_mem_pwrst(struct powerdomain *pwrdm, u8 bank)
 		return -EEXIST;
 
 	/*
+	 * In 3430, for MPU domain bank 0 status bits
+	 * are displayed in the position of bank1 status bits
+	 * in PWST  . So the hack. Think of a cleaner
+	 * way of doing this
+	 */
+	if (cpu_is_omap34xx())
+		if (!strcmp("mpu_pwrdm", pwrdm->name))
+			bank = 1;
+
+	/*
 	 * The register bit names below may not correspond to the
 	 * actual names of the bits in each powerdomain's register,
 	 * but the type of value returned is the same for each
@@ -1018,6 +1028,15 @@ int pwrdm_read_prev_mem_pwrst(struct powerdomain *pwrdm, u8 bank)
 		return -EEXIST;
 
 	/*
+	 * In 3430, for MPU domain bank 0 status bits
+	 * are displayed in the position of bank1 status bits
+	 * in PREPWST  . So the hack. Think of a cleaner
+	 * way of doing this
+	 */
+	if (cpu_is_omap34xx())
+		if (!strcmp("mpu_pwrdm", pwrdm->name))
+			bank = 1;
+	/*
 	 * The register bit names below may not correspond to the
 	 * actual names of the bits in each powerdomain's register,
 	 * but the type of value returned is the same for each
-- 
1.5.4.7

