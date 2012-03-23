From: mathieu.poirier@linaro.org
Subject: [PATCH 4/9] ARM: omap2+: fix building without i2c
Date: Fri, 23 Mar 2012 11:13:51 -0600
Message-ID: <1332522836-29517-5-git-send-email-mathieu.poirier@linaro.org>
References: <1332522836-29517-1-git-send-email-mathieu.poirier@linaro.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1332522836-29517-1-git-send-email-mathieu.poirier@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: tony@atomide.com
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, arnd@arndb.de
List-Id: linux-omap@vger.kernel.org

From: Arnd Bergmann <arnd@arndb.de>

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
index a5409ce..d74c76f 100644
--- a/arch/arm/mach-omap2/omap_hwmod_2420_data.c
+++ b/arch/arm/mach-omap2/omap_hwmod_2420_data.c
@@ -1038,7 +1038,7 @@ static struct omap_hwmod_class i2c_class = {
 	.name		= "i2c",
 	.sysc		= &i2c_sysc,
 	.rev		= OMAP_I2C_IP_VERSION_1,
-	.reset		= &omap_i2c_reset,
+	.reset		= omap_i2c_reset,
 };
 
 static struct omap_i2c_dev_attr i2c_dev_attr = {
diff --git a/arch/arm/mach-omap2/omap_hwmod_2430_data.c b/arch/arm/mach-omap2/omap_hwmod_2430_data.c
index c4f56cb..69c91b3 100644
--- a/arch/arm/mach-omap2/omap_hwmod_2430_data.c
+++ b/arch/arm/mach-omap2/omap_hwmod_2430_data.c
@@ -1088,7 +1088,7 @@ static struct omap_hwmod_class i2c_class = {
 	.name		= "i2c",
 	.sysc		= &i2c_sysc,
 	.rev		= OMAP_I2C_IP_VERSION_1,
-	.reset		= &omap_i2c_reset,
+	.reset		= omap_i2c_reset,
 };
 
 static struct omap_i2c_dev_attr i2c_dev_attr = {
diff --git a/arch/arm/mach-omap2/omap_hwmod_3xxx_data.c b/arch/arm/mach-omap2/omap_hwmod_3xxx_data.c
index 3c8dd92..d8eb79f 100644
--- a/arch/arm/mach-omap2/omap_hwmod_3xxx_data.c
+++ b/arch/arm/mach-omap2/omap_hwmod_3xxx_data.c
@@ -1367,7 +1367,7 @@ static struct omap_hwmod_class i2c_class = {
 	.name	= "i2c",
 	.sysc	= &i2c_sysc,
 	.rev	= OMAP_I2C_IP_VERSION_1,
-	.reset	= &omap_i2c_reset,
+	.reset	= omap_i2c_reset,
 };
 
 static struct omap_hwmod_dma_info omap3xxx_dss_sdma_chs[] = {
diff --git a/arch/arm/mach-omap2/omap_hwmod_44xx_data.c b/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
index ef0524c..9adf749 100644
--- a/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
+++ b/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
@@ -2258,7 +2258,7 @@ static struct omap_hwmod_class omap44xx_i2c_hwmod_class = {
 	.name	= "i2c",
 	.sysc	= &omap44xx_i2c_sysc,
 	.rev	= OMAP_I2C_IP_VERSION_2,
-	.reset	= &omap_i2c_reset,
+	.reset	= omap_i2c_reset,
 };
 
 static struct omap_i2c_dev_attr i2c_dev_attr = {
-- 
1.7.5.4
