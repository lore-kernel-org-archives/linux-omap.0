From: Benoit Cousson <b-cousson@ti.com>
Subject: [PATCH 2/5] OMAP4: hwmod data: Add SYSS_HAS_RESET_STATUS flag
Date: Fri, 10 Dec 2010 00:33:32 +0100
Message-ID: <1291937615-18571-3-git-send-email-b-cousson@ti.com>
References: <1291937615-18571-1-git-send-email-b-cousson@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:35450 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756234Ab0LIXed (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 9 Dec 2010 18:34:33 -0500
In-Reply-To: <1291937615-18571-1-git-send-email-b-cousson@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: paul@pwsan.com, khilman@deeprootsystems.com
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Benoit Cousson <b-cousson@ti.com>, Rajendra Nayak <rnayak@ti.com>, "Govindraj.R" <govindraj.raja@ti.com>

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
Cc: Paul Walmsley <paul@pwsan.com>
Cc: Rajendra Nayak <rnayak@ti.com>
Cc: Govindraj.R <govindraj.raja@ti.com>
Cc: Kevin Hilman <khilman@deeprootsystems.com>
---
 arch/arm/mach-omap2/omap_hwmod_44xx_data.c |   12 +++++++-----
 1 files changed, 7 insertions(+), 5 deletions(-)

diff --git a/arch/arm/mach-omap2/omap_hwmod_44xx_data.c b/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
index d8ef977..1e3a94e 100644
--- a/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
+++ b/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
@@ -518,8 +518,9 @@ static struct omap_hwmod_class_sysconfig omap44xx_gpio_sysc = {
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
@@ -852,7 +853,7 @@ static struct omap_hwmod_class_sysconfig omap44xx_i2c_sysc = {
 	.syss_offs	= 0x0090,
 	.sysc_flags	= (SYSC_HAS_AUTOIDLE | SYSC_HAS_CLOCKACTIVITY |
 			   SYSC_HAS_ENAWAKEUP | SYSC_HAS_SIDLEMODE |
-			   SYSC_HAS_SOFTRESET),
+			   SYSC_HAS_SOFTRESET | SYSS_HAS_RESET_STATUS),
 	.idlemodes	= (SIDLE_FORCE | SIDLE_NO | SIDLE_SMART),
 	.sysc_fields	= &omap_hwmod_sysc_type1,
 };
@@ -1124,7 +1125,8 @@ static struct omap_hwmod_class_sysconfig omap44xx_uart_sysc = {
 	.sysc_offs	= 0x0054,
 	.syss_offs	= 0x0058,
 	.sysc_flags	= (SYSC_HAS_AUTOIDLE | SYSC_HAS_ENAWAKEUP |
-			   SYSC_HAS_SIDLEMODE | SYSC_HAS_SOFTRESET),
+			   SYSC_HAS_SIDLEMODE | SYSC_HAS_SOFTRESET |
+			   SYSS_HAS_RESET_STATUS),
 	.idlemodes	= (SIDLE_FORCE | SIDLE_NO | SIDLE_SMART),
 	.sysc_fields	= &omap_hwmod_sysc_type1,
 };
@@ -1354,7 +1356,7 @@ static struct omap_hwmod_class_sysconfig omap44xx_wd_timer_sysc = {
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

