From: Girish S G <girishsg@ti.com>
Subject: [PATCH 2/2] OMAP4: Regulator: Specify system has fully specified constraints
Date: Tue, 21 Jun 2011 19:24:48 -0500
Message-ID: <1308702288-12787-1-git-send-email-girishsg@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:39988 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756939Ab1FUX34 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 21 Jun 2011 19:29:56 -0400
Received: from dlep33.itg.ti.com ([157.170.170.112])
	by comal.ext.ti.com (8.13.7/8.13.7) with ESMTP id p5LNTtvp002101
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-omap@vger.kernel.org>; Tue, 21 Jun 2011 18:29:55 -0500
Received: from dlep26.itg.ti.com (smtp-le.itg.ti.com [157.170.170.27])
	by dlep33.itg.ti.com (8.13.7/8.13.8) with ESMTP id p5LNTtW1010592
	for <linux-omap@vger.kernel.org>; Tue, 21 Jun 2011 18:29:55 -0500 (CDT)
Received: from dlee73.ent.ti.com (localhost [127.0.0.1])
	by dlep26.itg.ti.com (8.13.8/8.13.8) with ESMTP id p5LNTtSB003177
	for <linux-omap@vger.kernel.org>; Tue, 21 Jun 2011 18:29:55 -0500 (CDT)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap <linux-omap@vger.kernel.org>
Cc: Girish S G <girishsg@ti.com>

As of now, the unused regulators are not getting disabled. Only those
regulators are disabled which are properly handled by drivers.

Calling regulator_has_full_constraints() will cause the regulator
core to disable all regulators which have a zero use count and don't
have always_on=true specified during registration.

Signed-off-by: Girish S G <girishsg@ti.com>
---
 arch/arm/mach-omap2/board-4430sdp.c    |    3 +++
 arch/arm/mach-omap2/board-omap4panda.c |    3 +++
 2 files changed, 6 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap2/board-4430sdp.c b/arch/arm/mach-omap2/board-4430sdp.c
index 04b7770..46f6800 100644
--- a/arch/arm/mach-omap2/board-4430sdp.c
+++ b/arch/arm/mach-omap2/board-4430sdp.c
@@ -560,6 +560,9 @@ static struct i2c_board_info __initdata sdp4430_i2c_4_boardinfo[] = {
 };
 static int __init omap4_i2c_init(void)
 {
+	/* This will allow unused regulator to be shutdown */
+	regulator_has_full_constraints();
+
 	omap4_pmic_init("twl6030", &sdp4430_twldata);
 	omap_register_i2c_bus(2, 400, NULL, 0);
 	omap_register_i2c_bus(3, 400, sdp4430_i2c_3_boardinfo,
diff --git a/arch/arm/mach-omap2/board-omap4panda.c b/arch/arm/mach-omap2/board-omap4panda.c
index 3415a5e..c425f9f 100644
--- a/arch/arm/mach-omap2/board-omap4panda.c
+++ b/arch/arm/mach-omap2/board-omap4panda.c
@@ -412,6 +412,9 @@ static struct i2c_board_info __initdata panda_i2c_eeprom[] = {
 
 static int __init omap4_panda_i2c_init(void)
 {
+	/* This will allow unused regulator to be shutdown */
+	regulator_has_full_constraints();
+
 	omap4_pmic_init("twl6030", &omap4_panda_twldata);
 	omap_register_i2c_bus(2, 400, NULL, 0);
 	/*
-- 
1.6.0.4

