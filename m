From: Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH 08/30] ARM: omap2+: fix building without i2c
Date: Sun,  2 Oct 2011 16:45:38 +0200
Message-ID: <1317566760-25681-9-git-send-email-arnd@arndb.de>
References: <1317566760-25681-1-git-send-email-arnd@arndb.de>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1317566760-25681-1-git-send-email-arnd@arndb.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>, "Avinash.H.M" <avinashhm@ti.com>, Paul Walmsley <paul@pwsan.com>
List-Id: linux-omap@vger.kernel.org

A trivial typo causes build breakage when I2C is disabled
and omap_i2c_reset is set to NULL on OMAP:

omap_hwmod_44xx_data.c:2287:11: error: lvalue required as unary '&' operand

Removing the '&' character solves this.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Cc: Avinash.H.M <avinashhm@ti.com>
Cc: Paul Walmsley <paul@pwsan.com>
---
 arch/arm/mach-omap2/omap_hwmod_2420_data.c |    2 +-
 arch/arm/mach-omap2/omap_hwmod_2430_data.c |    2 +-
 arch/arm/mach-omap2/omap_hwmod_3xxx_data.c |    2 +-
 arch/arm/mach-omap2/omap_hwmod_44xx_data.c |    2 +-
 4 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/arm/mach-omap2/omap_hwmod_2420_data.c b/arch/arm/mach-omap2/omap_hwmod_2420_data.c
index a015c69..3aa6c62 100644
--- a/arch/arm/mach-omap2/omap_hwmod_2420_data.c
+++ b/arch/arm/mach-omap2/omap_hwmod_2420_data.c
@@ -1030,7 +1030,7 @@ static struct omap_hwmod_class i2c_class = {
 	.name		= "i2c",
 	.sysc		= &i2c_sysc,
 	.rev		= OMAP_I2C_IP_VERSION_1,
-	.reset		= &omap_i2c_reset,
+	.reset		= omap_i2c_reset,
 };
 
 static struct omap_i2c_dev_attr i2c_dev_attr = {
diff --git a/arch/arm/mach-omap2/omap_hwmod_2430_data.c b/arch/arm/mach-omap2/omap_hwmod_2430_data.c
index 16743c7..d9ab245 100644
--- a/arch/arm/mach-omap2/omap_hwmod_2430_data.c
+++ b/arch/arm/mach-omap2/omap_hwmod_2430_data.c
@@ -1079,7 +1079,7 @@ static struct omap_hwmod_class i2c_class = {
 	.name		= "i2c",
 	.sysc		= &i2c_sysc,
 	.rev		= OMAP_I2C_IP_VERSION_1,
-	.reset		= &omap_i2c_reset,
+	.reset		= omap_i2c_reset,
 };
 
 static struct omap_i2c_dev_attr i2c_dev_attr = {
diff --git a/arch/arm/mach-omap2/omap_hwmod_3xxx_data.c b/arch/arm/mach-omap2/omap_hwmod_3xxx_data.c
index 25bf43b..b0a0113 100644
--- a/arch/arm/mach-omap2/omap_hwmod_3xxx_data.c
+++ b/arch/arm/mach-omap2/omap_hwmod_3xxx_data.c
@@ -1309,7 +1309,7 @@ static struct omap_hwmod_class i2c_class = {
 	.name	= "i2c",
 	.sysc	= &i2c_sysc,
 	.rev	= OMAP_I2C_IP_VERSION_1,
-	.reset	= &omap_i2c_reset,
+	.reset	= omap_i2c_reset,
 };
 
 static struct omap_hwmod_dma_info omap3xxx_dss_sdma_chs[] = {
diff --git a/arch/arm/mach-omap2/omap_hwmod_44xx_data.c b/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
index 6201422..a6d42fc 100644
--- a/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
+++ b/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
@@ -2284,7 +2284,7 @@ static struct omap_hwmod_class omap44xx_i2c_hwmod_class = {
 	.name	= "i2c",
 	.sysc	= &omap44xx_i2c_sysc,
 	.rev	= OMAP_I2C_IP_VERSION_2,
-	.reset	= &omap_i2c_reset,
+	.reset	= omap_i2c_reset,
 };
 
 static struct omap_i2c_dev_attr i2c_dev_attr = {
-- 
1.7.5.4
