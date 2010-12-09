From: Benoit Cousson <b-cousson@ti.com>
Subject: [PATCH 3/5] OMAP4: hwmod data: Fix missing address in DMM and EMIF_FW
Date: Fri, 10 Dec 2010 00:33:33 +0100
Message-ID: <1291937615-18571-4-git-send-email-b-cousson@ti.com>
References: <1291937615-18571-1-git-send-email-b-cousson@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:52346 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755248Ab0LIXed (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 9 Dec 2010 18:34:33 -0500
In-Reply-To: <1291937615-18571-1-git-send-email-b-cousson@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: paul@pwsan.com, khilman@deeprootsystems.com
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Benoit Cousson <b-cousson@ti.com>

The DMM is a piece of interconnect that need to be configured properly
for the tiler functionnality. It thus exposes some configuration registers
that were missing previously.

Signed-off-by: Benoit Cousson <b-cousson@ti.com>
Cc: Paul Walmsley <paul@pwsan.com>
---
 arch/arm/mach-omap2/omap_hwmod_44xx_data.c |   26 +++++++++++++++++++++++---
 1 files changed, 23 insertions(+), 3 deletions(-)

diff --git a/arch/arm/mach-omap2/omap_hwmod_44xx_data.c b/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
index 1e3a94e..7dccba3 100644
--- a/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
+++ b/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
@@ -68,7 +68,15 @@ static struct omap_hwmod_ocp_if omap44xx_l3_main_1__dmm = {
 	.master		= &omap44xx_l3_main_1_hwmod,
 	.slave		= &omap44xx_dmm_hwmod,
 	.clk		= "l3_div_ck",
-	.user		= OCP_USER_MPU | OCP_USER_SDMA,
+	.user		= OCP_USER_SDMA,
+};
+
+static struct omap_hwmod_addr_space omap44xx_dmm_addrs[] = {
+	{
+		.pa_start	= 0x4e000000,
+		.pa_end		= 0x4e0007ff,
+		.flags		= ADDR_TYPE_RT
+	},
 };
 
 /* mpu -> dmm */
@@ -76,7 +84,9 @@ static struct omap_hwmod_ocp_if omap44xx_mpu__dmm = {
 	.master		= &omap44xx_mpu_hwmod,
 	.slave		= &omap44xx_dmm_hwmod,
 	.clk		= "l3_div_ck",
-	.user		= OCP_USER_MPU | OCP_USER_SDMA,
+	.addr		= omap44xx_dmm_addrs,
+	.addr_cnt	= ARRAY_SIZE(omap44xx_dmm_addrs),
+	.user		= OCP_USER_MPU,
 };
 
 /* dmm slave ports */
@@ -116,12 +126,22 @@ static struct omap_hwmod_ocp_if omap44xx_dmm__emif_fw = {
 	.user		= OCP_USER_MPU | OCP_USER_SDMA,
 };
 
+static struct omap_hwmod_addr_space omap44xx_emif_fw_addrs[] = {
+	{
+		.pa_start	= 0x4a20c000,
+		.pa_end		= 0x4a20c0ff,
+		.flags		= ADDR_TYPE_RT
+	},
+};
+
 /* l4_cfg -> emif_fw */
 static struct omap_hwmod_ocp_if omap44xx_l4_cfg__emif_fw = {
 	.master		= &omap44xx_l4_cfg_hwmod,
 	.slave		= &omap44xx_emif_fw_hwmod,
 	.clk		= "l4_div_ck",
-	.user		= OCP_USER_MPU | OCP_USER_SDMA,
+	.addr		= omap44xx_emif_fw_addrs,
+	.addr_cnt	= ARRAY_SIZE(omap44xx_emif_fw_addrs),
+	.user		= OCP_USER_MPU,
 };
 
 /* emif_fw slave ports */
-- 
1.7.0.4

