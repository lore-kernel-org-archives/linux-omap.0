From: Tero Kristo <t-kristo@ti.com>
Subject: [PATCHv6 05/14] ARM: OMAP4: voltage: add support for VOLTSETUP_x_OFF register
Date: Thu, 31 May 2012 16:55:41 +0300
Message-ID: <1338472550-20743-6-git-send-email-t-kristo@ti.com>
References: <1338472550-20743-1-git-send-email-t-kristo@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:53679 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758035Ab2EaN4L (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 31 May 2012 09:56:11 -0400
In-Reply-To: <1338472550-20743-1-git-send-email-t-kristo@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, khilman@ti.com
Cc: linux-arm-kernel@lists.infradead.org

OMAP4 has two VOLTSETUP registers. One is controlling retention and
sleep voltage setup times, the other one off mode setup times. Both
of these need to be setup for stable behavior of the device.
The code setting up the new register will be added in the next
patch.

Signed-off-by: Tero Kristo <t-kristo@ti.com>
---
 arch/arm/mach-omap2/voltage.h                 |    2 ++
 arch/arm/mach-omap2/voltagedomains44xx_data.c |    3 +++
 2 files changed, 5 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap2/voltage.h b/arch/arm/mach-omap2/voltage.h
index 5381b35..d2d5b2b 100644
--- a/arch/arm/mach-omap2/voltage.h
+++ b/arch/arm/mach-omap2/voltage.h
@@ -38,12 +38,14 @@ struct powerdomain;
  * data
  * @voltsetup_mask: SETUP_TIME* bitmask in the PRM_VOLTSETUP* register
  * @voltsetup_reg: register offset of PRM_VOLTSETUP from PRM base
+ * @voltsetup_off_reg: register offset of PRM_VOLTSETUP_OFF from PRM base
  *
  * XXX What about VOLTOFFSET/VOLTCTRL?
  */
 struct omap_vfsm_instance {
 	u32 voltsetup_mask;
 	u8 voltsetup_reg;
+	u8 voltsetup_off_reg;
 };
 
 /**
diff --git a/arch/arm/mach-omap2/voltagedomains44xx_data.c b/arch/arm/mach-omap2/voltagedomains44xx_data.c
index a2d7d9c..7da35a6 100644
--- a/arch/arm/mach-omap2/voltagedomains44xx_data.c
+++ b/arch/arm/mach-omap2/voltagedomains44xx_data.c
@@ -34,14 +34,17 @@
 
 static const struct omap_vfsm_instance omap4_vdd_mpu_vfsm = {
 	.voltsetup_reg = OMAP4_PRM_VOLTSETUP_MPU_RET_SLEEP_OFFSET,
+	.voltsetup_off_reg = OMAP4_PRM_VOLTSETUP_MPU_OFF_OFFSET,
 };
 
 static const struct omap_vfsm_instance omap4_vdd_iva_vfsm = {
 	.voltsetup_reg = OMAP4_PRM_VOLTSETUP_IVA_RET_SLEEP_OFFSET,
+	.voltsetup_off_reg = OMAP4_PRM_VOLTSETUP_IVA_OFF_OFFSET,
 };
 
 static const struct omap_vfsm_instance omap4_vdd_core_vfsm = {
 	.voltsetup_reg = OMAP4_PRM_VOLTSETUP_CORE_RET_SLEEP_OFFSET,
+	.voltsetup_off_reg = OMAP4_PRM_VOLTSETUP_CORE_OFF_OFFSET,
 };
 
 static struct voltagedomain omap4_voltdm_mpu = {
-- 
1.7.4.1

