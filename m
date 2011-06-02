From: Kevin Hilman <khilman-l0cyMroinI0@public.gmane.org>
Subject: [PATCH v4 01/18] I2C: OMAP2+: Set hwmod flags to only allow 16-bit accesses to i2c
Date: Wed,  1 Jun 2011 17:19:27 -0700
Message-ID: <1306973984-15165-2-git-send-email-khilman@ti.com>
References: <1306973984-15165-1-git-send-email-khilman@ti.com>
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1306973984-15165-1-git-send-email-khilman-l0cyMroinI0@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Ben Dooks <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: Andy Green <andy.green-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: linux-omap@vger.kernel.org

From: Andy Green <andy-/Zus8d0mwwtBDgjK7y7TUQ@public.gmane.org>

Peter Maydell noticed when running under QEMU he was getting
errors reporting 32-bit access to I2C peripheral unit registers
that are documented to be 8 or 16-bit only[1][2]

The I2C driver is blameless as it wraps its accesses in a
function using __raw_writew and __raw_readw, it turned out it
is the hwmod stuff.

However the hwmod code already has a flag to force a
perhipheral unit to only be accessed using 16-bit operations.

This patch applies the 16-bit only flag to the 2430,
OMAP3xxx and OMAP44xx hwmod structs.  2420 was already
correctly marked up as 16-bit.

The 2430 change will need testing by TI as arranged
in the comments to the previous patch version.

When the 16-bit flag is or-ed with other flags, it is placed
first as requested in comments.

[1] OMAP4430 Technical reference manual section 23.1.6.2
[2] OMAP3530 Techincal reference manual section 18.6

Cc: patches-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org
Cc: Ben Dooks <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>
Reported-by: Peter Maydell <peter.maydell-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Signed-off-by: Andy Green <andy.green-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Signed-off-by: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Signed-off-by: Kevin Hilman <khilman-l0cyMroinI0@public.gmane.org>
---
 arch/arm/mach-omap2/omap_hwmod_2430_data.c |    2 ++
 arch/arm/mach-omap2/omap_hwmod_3xxx_data.c |    3 +++
 arch/arm/mach-omap2/omap_hwmod_44xx_data.c |    8 ++++----
 3 files changed, 9 insertions(+), 4 deletions(-)

diff --git a/arch/arm/mach-omap2/omap_hwmod_2430_data.c b/arch/arm/mach-omap2/omap_hwmod_2430_data.c
index 9682dd5..0c272be 100644
--- a/arch/arm/mach-omap2/omap_hwmod_2430_data.c
+++ b/arch/arm/mach-omap2/omap_hwmod_2430_data.c
@@ -1547,6 +1547,7 @@ static struct omap_hwmod_ocp_if *omap2430_i2c1_slaves[] = {
 
 static struct omap_hwmod omap2430_i2c1_hwmod = {
 	.name		= "i2c1",
+	.flags		= HWMOD_16BIT_REG,
 	.mpu_irqs	= i2c1_mpu_irqs,
 	.mpu_irqs_cnt	= ARRAY_SIZE(i2c1_mpu_irqs),
 	.sdma_reqs	= i2c1_sdma_reqs,
@@ -1593,6 +1594,7 @@ static struct omap_hwmod_ocp_if *omap2430_i2c2_slaves[] = {
 
 static struct omap_hwmod omap2430_i2c2_hwmod = {
 	.name		= "i2c2",
+	.flags		= HWMOD_16BIT_REG,
 	.mpu_irqs	= i2c2_mpu_irqs,
 	.mpu_irqs_cnt	= ARRAY_SIZE(i2c2_mpu_irqs),
 	.sdma_reqs	= i2c2_sdma_reqs,
diff --git a/arch/arm/mach-omap2/omap_hwmod_3xxx_data.c b/arch/arm/mach-omap2/omap_hwmod_3xxx_data.c
index 909a84d..78efb59 100644
--- a/arch/arm/mach-omap2/omap_hwmod_3xxx_data.c
+++ b/arch/arm/mach-omap2/omap_hwmod_3xxx_data.c
@@ -1891,6 +1891,7 @@ static struct omap_hwmod_ocp_if *omap3xxx_i2c1_slaves[] = {
 
 static struct omap_hwmod omap3xxx_i2c1_hwmod = {
 	.name		= "i2c1",
+	.flags		= HWMOD_16BIT_REG,
 	.mpu_irqs	= i2c1_mpu_irqs,
 	.mpu_irqs_cnt	= ARRAY_SIZE(i2c1_mpu_irqs),
 	.sdma_reqs	= i2c1_sdma_reqs,
@@ -1933,6 +1934,7 @@ static struct omap_hwmod_ocp_if *omap3xxx_i2c2_slaves[] = {
 
 static struct omap_hwmod omap3xxx_i2c2_hwmod = {
 	.name		= "i2c2",
+	.flags		= HWMOD_16BIT_REG,
 	.mpu_irqs	= i2c2_mpu_irqs,
 	.mpu_irqs_cnt	= ARRAY_SIZE(i2c2_mpu_irqs),
 	.sdma_reqs	= i2c2_sdma_reqs,
@@ -1975,6 +1977,7 @@ static struct omap_hwmod_ocp_if *omap3xxx_i2c3_slaves[] = {
 
 static struct omap_hwmod omap3xxx_i2c3_hwmod = {
 	.name		= "i2c3",
+	.flags		= HWMOD_16BIT_REG,
 	.mpu_irqs	= i2c3_mpu_irqs,
 	.mpu_irqs_cnt	= ARRAY_SIZE(i2c3_mpu_irqs),
 	.sdma_reqs	= i2c3_sdma_reqs,
diff --git a/arch/arm/mach-omap2/omap_hwmod_44xx_data.c b/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
index abc548a..5662097 100644
--- a/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
+++ b/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
@@ -2164,7 +2164,7 @@ static struct omap_hwmod_ocp_if *omap44xx_i2c1_slaves[] = {
 static struct omap_hwmod omap44xx_i2c1_hwmod = {
 	.name		= "i2c1",
 	.class		= &omap44xx_i2c_hwmod_class,
-	.flags		= HWMOD_INIT_NO_RESET,
+	.flags		= HWMOD_16BIT_REG | HWMOD_INIT_NO_RESET,
 	.mpu_irqs	= omap44xx_i2c1_irqs,
 	.mpu_irqs_cnt	= ARRAY_SIZE(omap44xx_i2c1_irqs),
 	.sdma_reqs	= omap44xx_i2c1_sdma_reqs,
@@ -2217,7 +2217,7 @@ static struct omap_hwmod_ocp_if *omap44xx_i2c2_slaves[] = {
 static struct omap_hwmod omap44xx_i2c2_hwmod = {
 	.name		= "i2c2",
 	.class		= &omap44xx_i2c_hwmod_class,
-	.flags		= HWMOD_INIT_NO_RESET,
+	.flags		= HWMOD_16BIT_REG | HWMOD_INIT_NO_RESET,
 	.mpu_irqs	= omap44xx_i2c2_irqs,
 	.mpu_irqs_cnt	= ARRAY_SIZE(omap44xx_i2c2_irqs),
 	.sdma_reqs	= omap44xx_i2c2_sdma_reqs,
@@ -2270,7 +2270,7 @@ static struct omap_hwmod_ocp_if *omap44xx_i2c3_slaves[] = {
 static struct omap_hwmod omap44xx_i2c3_hwmod = {
 	.name		= "i2c3",
 	.class		= &omap44xx_i2c_hwmod_class,
-	.flags		= HWMOD_INIT_NO_RESET,
+	.flags		= HWMOD_16BIT_REG | HWMOD_INIT_NO_RESET,
 	.mpu_irqs	= omap44xx_i2c3_irqs,
 	.mpu_irqs_cnt	= ARRAY_SIZE(omap44xx_i2c3_irqs),
 	.sdma_reqs	= omap44xx_i2c3_sdma_reqs,
@@ -2323,7 +2323,7 @@ static struct omap_hwmod_ocp_if *omap44xx_i2c4_slaves[] = {
 static struct omap_hwmod omap44xx_i2c4_hwmod = {
 	.name		= "i2c4",
 	.class		= &omap44xx_i2c_hwmod_class,
-	.flags		= HWMOD_INIT_NO_RESET,
+	.flags		= HWMOD_16BIT_REG | HWMOD_INIT_NO_RESET,
 	.mpu_irqs	= omap44xx_i2c4_irqs,
 	.mpu_irqs_cnt	= ARRAY_SIZE(omap44xx_i2c4_irqs),
 	.sdma_reqs	= omap44xx_i2c4_sdma_reqs,
-- 
1.7.4
