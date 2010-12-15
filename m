From: Benoit Cousson <b-cousson@ti.com>
Subject: [PATCH v2 2/7] OMAP4: hwmod data: Add SYSS_HAS_RESET_STATUS flag
Date: Wed, 15 Dec 2010 14:51:38 +0100
Message-ID: <1292421103-19282-3-git-send-email-b-cousson@ti.com>
References: <1292421103-19282-1-git-send-email-b-cousson@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:33490 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753948Ab0LONx2 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 15 Dec 2010 08:53:28 -0500
In-Reply-To: <1292421103-19282-1-git-send-email-b-cousson@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: paul@pwsan.com
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, khilman@deeprootsystems.com, Benoit Cousson <b-cousson@ti.com>, Rajendra Nayak <rnayak@ti.com>, "Govindraj.R" <govindraj.raja@ti.com>

Update the data for GPIO, UART, WD_TIMER and I2C in order to
support the new reset status flag introduce in the following
commit:
commit 2cb068149c365f1c2b10f2ece6786139527dcc16
OMAP: hwmod: Fix softreset status check for some new OMAP4 IPs

Without this flag properly set, the reset is done, but the hwmod
core code will not wait for the reset completion to continue its
excecution.

Signed-off-by: Benoit Cousson <b-cousson@ti.com>
Tested-by: Charulatha V <charu@ti.com>
Signed-off-by: Paul Walmsley <paul@pwsan.com>
Cc: Rajendra Nayak <rnayak@ti.com>
Cc: Govindraj.R <govindraj.raja@ti.com>
Cc: Kevin Hilman <khilman@deeprootsystems.com>
---
 arch/arm/mach-omap2/omap_hwmod_44xx_data.c |   12 +++++++-----
 1 files changed, 7 insertions(+), 5 deletions(-)

diff --git a/arch/arm/mach-omap2/omap_hwmod_44xx_data.c b/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
index 872d360..00a670d 100644
--- a/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
+++ b/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
@@ -521,8 +521,9 @@ static struct omap_hwmod_class_sysconfig omap44xx_gpio_sysc = {
 	.rev_offs	= 0x0000,
 	.sysc_offs	= 0x0010,
 	.syss_offs	= 0x0114,
-	.sysc_flags	= (SYSC_HAS_ENAWAKEUP | SYSC_HAS_SIDLEMODE |
-			   SYSC_HAS_SOFTRESET | SYSC_HAS_AUTOIDLE),
+	.sysc_flags	= (SYSC_HAS_AUTOIDLE | SYSC_HAS_ENAWAKEUP |
+			   SYSC_HAS_SIDLEMODE | SYSC_HAS_SOFTRESET |
+			   SYSS_HAS_RESET_STATUS),
 	.idlemodes	= (SIDLE_FORCE | SIDLE_NO | SIDLE_SMART),
 	.sysc_fields	= &omap_hwmod_sysc_type1,
 };
@@ -855,7 +856,7 @@ static struct omap_hwmod_class_sysconfig omap44xx_i2c_sysc = {
 	.syss_offs	= 0x0090,
 	.sysc_flags	= (SYSC_HAS_AUTOIDLE | SYSC_HAS_CLOCKACTIVITY |
 			   SYSC_HAS_ENAWAKEUP | SYSC_HAS_SIDLEMODE |
-			   SYSC_HAS_SOFTRESET),
+			   SYSC_HAS_SOFTRESET | SYSS_HAS_RESET_STATUS),
 	.idlemodes	= (SIDLE_FORCE | SIDLE_NO | SIDLE_SMART),
 	.sysc_fields	= &omap_hwmod_sysc_type1,
 };
@@ -1127,7 +1128,8 @@ static struct omap_hwmod_class_sysconfig omap44xx_uart_sysc = {
 	.sysc_offs	= 0x0054,
 	.syss_offs	= 0x0058,
 	.sysc_flags	= (SYSC_HAS_AUTOIDLE | SYSC_HAS_ENAWAKEUP |
-			   SYSC_HAS_SIDLEMODE | SYSC_HAS_SOFTRESET),
+			   SYSC_HAS_SIDLEMODE | SYSC_HAS_SOFTRESET |
+			   SYSS_HAS_RESET_STATUS),
 	.idlemodes	= (SIDLE_FORCE | SIDLE_NO | SIDLE_SMART),
 	.sysc_fields	= &omap_hwmod_sysc_type1,
 };
@@ -1357,7 +1359,7 @@ static struct omap_hwmod_class_sysconfig omap44xx_wd_timer_sysc = {
 	.sysc_offs	= 0x0010,
 	.syss_offs	= 0x0014,
 	.sysc_flags	= (SYSC_HAS_EMUFREE | SYSC_HAS_SIDLEMODE |
-			   SYSC_HAS_SOFTRESET),
+			   SYSC_HAS_SOFTRESET | SYSS_HAS_RESET_STATUS),
 	.idlemodes	= (SIDLE_FORCE | SIDLE_NO | SIDLE_SMART),
 	.sysc_fields	= &omap_hwmod_sysc_type1,
 };
-- 
1.7.0.4

