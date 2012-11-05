From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: [PATCH] ARM: OMAP4: PM: fix regulator name for VDD_MPU
Date: Mon,  5 Nov 2012 15:49:11 -0800
Message-ID: <1352159351-15380-1-git-send-email-khilman@deeprootsystems.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-da0-f46.google.com ([209.85.210.46]:33211 "EHLO
	mail-da0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752164Ab2KEXtO (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 5 Nov 2012 18:49:14 -0500
Received: by mail-da0-f46.google.com with SMTP id n41so2903142dak.19
        for <linux-omap@vger.kernel.org>; Mon, 05 Nov 2012 15:49:13 -0800 (PST)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>, linux-omap@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org

From: Kevin Hilman <khilman@ti.com>

commit 24d7b40a (ARM: OMAP2+: PM: MPU DVFS: use generic CPU device for
MPU-SS) updated the regulator name used for the MPU regulator, but only
updated OMAP3, not OMAP4.  Fix the OMAP4 name as well, otherwise CPUfreq
fails to find the MPU regulator.

Signed-off-by: Kevin Hilman <khilman@ti.com>
---
Applies to v3.7-rc4

 arch/arm/mach-omap2/twl-common.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/mach-omap2/twl-common.c b/arch/arm/mach-omap2/twl-common.c
index 635e109..44c4205 100644
--- a/arch/arm/mach-omap2/twl-common.c
+++ b/arch/arm/mach-omap2/twl-common.c
@@ -366,7 +366,7 @@ static struct regulator_init_data omap4_clk32kg_idata = {
 };
 
 static struct regulator_consumer_supply omap4_vdd1_supply[] = {
-	REGULATOR_SUPPLY("vcc", "mpu.0"),
+	REGULATOR_SUPPLY("vcc", "cpu0"),
 };
 
 static struct regulator_consumer_supply omap4_vdd2_supply[] = {
-- 
1.8.0

