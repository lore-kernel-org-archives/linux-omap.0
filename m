From: Tero Kristo <t-kristo@ti.com>
Subject: [PATCHv5 04/14] arm: omap: voltage: add definition for pmic startup / shutdown times
Date: Tue, 21 Feb 2012 16:04:48 +0200
Message-ID: <1329833098-19900-5-git-send-email-t-kristo@ti.com>
References: <1329833098-19900-1-git-send-email-t-kristo@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:51351 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755400Ab2BUOF4 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 21 Feb 2012 09:05:56 -0500
In-Reply-To: <1329833098-19900-1-git-send-email-t-kristo@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, khilman@ti.com
Cc: linux-arm-kernel@lists.infradead.org

This is applied when PMIC is entering or leaving a sleep mode.

Signed-off-by: Tero Kristo <t-kristo@ti.com>
---
 arch/arm/mach-omap2/voltage.h |    4 ++++
 1 files changed, 4 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap2/voltage.h b/arch/arm/mach-omap2/voltage.h
index 940a0d6..54b959c 100644
--- a/arch/arm/mach-omap2/voltage.h
+++ b/arch/arm/mach-omap2/voltage.h
@@ -145,6 +145,8 @@ struct omap_volt_data {
  * @i2c_slave_addr: I2C slave address of PMIC
  * @volt_reg_addr: voltage configuration register address
  * @cmd_reg_addr: command (on, on-LP, ret, off) configuration register address
+ * @startup_time: PMIC startup time, only valid for core domain
+ * @shutdown_time: PMIC shutdown time, only valid for core domain
  * @i2c_high_speed: whether VC uses I2C high-speed mode to PMIC
  * @i2c_mcode: master code value for I2C high-speed preamble transmission
  * @vsel_to_uv:	PMIC API to convert vsel value to actual voltage in uV.
@@ -162,6 +164,8 @@ struct omap_voltdm_pmic {
 	u8 vp_vstepmax;
 	u32 vddmin;
 	u32 vddmax;
+	u32 startup_time;
+	u32 shutdown_time;
 	u8 vp_timeout_us;
 	bool i2c_high_speed;
 	u8 i2c_mcode;
-- 
1.7.4.1

