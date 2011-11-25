From: Tero Kristo <t-kristo@ti.com>
Subject: [PATCHv4 03/15] omap: voltage: add definition for pmic startup / shutdown times
Date: Fri, 25 Nov 2011 17:49:36 +0200
Message-ID: <1322236188-19456-4-git-send-email-t-kristo@ti.com>
References: <1322236188-19456-1-git-send-email-t-kristo@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:47906 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753636Ab1KYPuD (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 25 Nov 2011 10:50:03 -0500
Received: from dlep36.itg.ti.com ([157.170.170.91])
	by comal.ext.ti.com (8.13.7/8.13.7) with ESMTP id pAPFo2l3031687
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-omap@vger.kernel.org>; Fri, 25 Nov 2011 09:50:02 -0600
Received: from dlep26.itg.ti.com (smtp-le.itg.ti.com [157.170.170.27])
	by dlep36.itg.ti.com (8.13.8/8.13.8) with ESMTP id pAPFo2DO020488
	for <linux-omap@vger.kernel.org>; Fri, 25 Nov 2011 09:50:02 -0600 (CST)
Received: from DFLE70.ent.ti.com (localhost [127.0.0.1])
	by dlep26.itg.ti.com (8.13.8/8.13.8) with ESMTP id pAPFo21C017597
	for <linux-omap@vger.kernel.org>; Fri, 25 Nov 2011 09:50:02 -0600 (CST)
In-Reply-To: <1322236188-19456-1-git-send-email-t-kristo@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: khilman@ti.com, nm@ti.com

This is applied when PMIC is entering or leaving a sleep mode.

Signed-off-by: Tero Kristo <t-kristo@ti.com>
---
 arch/arm/mach-omap2/voltage.h |    4 ++++
 1 files changed, 4 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap2/voltage.h b/arch/arm/mach-omap2/voltage.h
index 3afd1fc..01d41d9 100644
--- a/arch/arm/mach-omap2/voltage.h
+++ b/arch/arm/mach-omap2/voltage.h
@@ -136,6 +136,8 @@ struct omap_volt_data {
  * @i2c_slave_addr: I2C slave address of PMIC
  * @volt_reg_addr: voltage configuration register address
  * @cmd_reg_addr: command (on, on-LP, ret, off) configuration register address
+ * @startup_time: PMIC startup time, only valid for core domain
+ * @shutdown_time: PMIC shutdown time, only valid for core domain
  * @i2c_high_speed: whether VC uses I2C high-speed mode to PMIC
  * @i2c_mcode: master code value for I2C high-speed preamble transmission
  * @vsel_to_uv:	PMIC API to convert vsel value to actual voltage in uV.
@@ -153,6 +155,8 @@ struct omap_voltdm_pmic {
 	u8 vp_vstepmax;
 	u32 vp_vddmin;
 	u32 vp_vddmax;
+	u32 startup_time;
+	u32 shutdown_time;
 	u8 vp_timeout_us;
 	bool i2c_high_speed;
 	u8 i2c_mcode;
-- 
1.7.4.1

