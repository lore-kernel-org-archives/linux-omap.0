From: Ilkka Koskinen <ilkka.koskinen@nokia.com>
Subject: [PATCH] mfd: twl5031: Rename sih modules
Date: Thu, 20 May 2010 13:04:20 +0300
Message-ID: <1274349860-1736-1-git-send-email-ilkka.koskinen@nokia.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org, sameo@linux.intel.com
Cc: linux-omap@vger.kernel.org, ilkka.koskinen@nokia.com
List-Id: linux-omap@vger.kernel.org

Fix the names of twl5031 specific sih modules to match
the documentation.

Signed-off-by: Ilkka Koskinen <ilkka.koskinen@nokia.com>
---
 drivers/mfd/twl4030-irq.c |   11 ++++++-----
 1 files changed, 6 insertions(+), 5 deletions(-)

diff --git a/drivers/mfd/twl4030-irq.c b/drivers/mfd/twl4030-irq.c
index 202bdd5..097f24d 100644
--- a/drivers/mfd/twl4030-irq.c
+++ b/drivers/mfd/twl4030-irq.c
@@ -232,10 +232,11 @@ static const struct sih sih_modules_twl5031[8] = {
 	},
 	[6] = {
 		/*
-		 * ACI doesn't use the same SIH organization.
-		 * For example, it supports only one interrupt line
+		 * ECI/DBI doesn't use the same SIH organization.
+		 * For example, it supports only one interrupt output line.
+		 * That is, the interrupts are seen on both INT1 and INT2 lines.
 		 */
-		.name		= "aci",
+		.name		= "eci_dbi",
 		.module		= TWL5031_MODULE_ACCESSORY,
 		.bits		= 9,
 		.bytes_ixr	= 2,
@@ -247,8 +248,8 @@ static const struct sih sih_modules_twl5031[8] = {
 
 	},
 	[7] = {
-		/* Accessory */
-		.name		= "acc",
+		/* Audio accessory */
+		.name		= "audio",
 		.module		= TWL5031_MODULE_ACCESSORY,
 		.control_offset	= TWL5031_ACCSIHCTRL,
 		.bits		= 2,
-- 
1.6.0.4
