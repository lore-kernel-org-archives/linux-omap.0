From: Andy Green <andy@warmcat.com>
Subject: [PATCH 3 01/18] OMAP2+: hwmod data: Set hwmod flags to only allow
 16-bit accesses to i2c
Date: Tue, 15 Mar 2011 19:55:55 +0000
Message-ID: <20110315195555.30000.70454.stgit@otae.warmcat.com>
References: <20110315195147.30000.86184.stgit@otae.warmcat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-ww0-f44.google.com ([74.125.82.44]:37340 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750836Ab1COTz7 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 15 Mar 2011 15:55:59 -0400
Received: by wwa36 with SMTP id 36so1206062wwa.1
        for <linux-omap@vger.kernel.org>; Tue, 15 Mar 2011 12:55:58 -0700 (PDT)
In-Reply-To: <20110315195147.30000.86184.stgit@otae.warmcat.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org
Cc: patches@linaro.org, Ben Dooks <ben-linux@fluff.org>, Andy Green <andy.green@linaro.org>, Benoit Cousson <b-cousson@ti.com>, Paul Walmsley <paul@pwsan.com>

Peter Maydell noticed when running under QEMU he was getting
errors reporting 32-bit access to I2C peripheral unit registers
that are documented to be 8 or 16-bit only[1][2]

The I2C driver is blameless as it wraps its accesses in a
function using __raw_writew and __raw_readw, it turned out it
is the hwmod stuff.

However the hwmod code already has a flag to force a
peripheral unit to only be accessed using 16-bit operations.

This patch applies the 16-bit only flag to the 2430,
OMAP3xxx and OMAP44xx hwmod structs.  2420 was already
correctly marked up as 16-bit.

The 2430 change will need testing by TI as arranged
in the comments to the previous patch version.

When the 16-bit flag is or-ed with other flags, it is placed
first as requested in comments.

[1] OMAP4430 Technical reference manual section 23.1.6.2
[2] OMAP3530 Technical reference manual section 18.6

Cc: patches@linaro.org
Cc: Ben Dooks <ben-linux@fluff.org>
Reported-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Andy Green <andy.green@linaro.org>
Acked-by: Benoit Cousson <b-cousson@ti.com>
Acked-by: Paul Walmsley <paul@pwsan.com>
---

 arch/arm/mach-omap2/omap_hwmod_2430_data.c |    2 ++
 arch/arm/mach-omap2/omap_hwmod_3xxx_data.c |    3 +++
 arch/arm/mach-omap2/omap_hwmod_44xx_data.c |    8 ++++----
 3 files changed, 9 insertions(+), 4 deletions(-)

diff --git a/arch/arm/mach-omap2/omap_hwmod_2430_data.c b/arch/arm/mach-omap2/omap_hwmod_2430_data.c
index 8ecfbcd..eeb6348 100644
--- a/arch/arm/mach-omap2/omap_hwmod_2430_data.c
+++ b/arch/arm/mach-omap2/omap_hwmod_2430_data.c
@@ -504,6 +504,7 @@ static struct omap_hwmod_ocp_if *omap2430_i2c1_slaves[] = {
 
 static struct omap_hwmod omap2430_i2c1_hwmod = {
 	.name		= "i2c1",
+	.flags		= HWMOD_16BIT_REG,
 	.mpu_irqs	= i2c1_mpu_irqs,
 	.mpu_irqs_cnt	= ARRAY_SIZE(i2c1_mpu_irqs),
 	.sdma_reqs	= i2c1_sdma_reqs,
@@ -550,6 +551,7 @@ static struct omap_hwmod_ocp_if *omap2430_i2c2_slaves[] = {
 
 static struct omap_hwmod omap2430_i2c2_hwmod = {
 	.name		= "i2c2",
+	.flags		= HWMOD_16BIT_REG,
 	.mpu_irqs	= i2c2_mpu_irqs,
 	.mpu_irqs_cnt	= ARRAY_SIZE(i2c2_mpu_irqs),
 	.sdma_reqs	= i2c2_sdma_reqs,
diff --git a/arch/arm/mach-omap2/omap_hwmod_3xxx_data.c b/arch/arm/mach-omap2/omap_hwmod_3xxx_data.c
index 8d81813..cc94616 100644
--- a/arch/arm/mach-omap2/omap_hwmod_3xxx_data.c
+++ b/arch/arm/mach-omap2/omap_hwmod_3xxx_data.c
@@ -685,6 +685,7 @@ static struct omap_hwmod_ocp_if *omap3xxx_i2c1_slaves[] = {
 
 static struct omap_hwmod omap3xxx_i2c1_hwmod = {
 	.name		= "i2c1",
+	.flags		= HWMOD_16BIT_REG,
 	.mpu_irqs	= i2c1_mpu_irqs,
 	.mpu_irqs_cnt	= ARRAY_SIZE(i2c1_mpu_irqs),
 	.sdma_reqs	= i2c1_sdma_reqs,
@@ -727,6 +728,7 @@ static struct omap_hwmod_ocp_if *omap3xxx_i2c2_slaves[] = {
 
 static struct omap_hwmod omap3xxx_i2c2_hwmod = {
 	.name		= "i2c2",
+	.flags		= HWMOD_16BIT_REG,
 	.mpu_irqs	= i2c2_mpu_irqs,
 	.mpu_irqs_cnt	= ARRAY_SIZE(i2c2_mpu_irqs),
 	.sdma_reqs	= i2c2_sdma_reqs,
@@ -769,6 +771,7 @@ static struct omap_hwmod_ocp_if *omap3xxx_i2c3_slaves[] = {
 
 static struct omap_hwmod omap3xxx_i2c3_hwmod = {
 	.name		= "i2c3",
+	.flags		= HWMOD_16BIT_REG,
 	.mpu_irqs	= i2c3_mpu_irqs,
 	.mpu_irqs_cnt	= ARRAY_SIZE(i2c3_mpu_irqs),
 	.sdma_reqs	= i2c3_sdma_reqs,
diff --git a/arch/arm/mach-omap2/omap_hwmod_44xx_data.c b/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
index c2806bd..f8400a1 100644
--- a/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
+++ b/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
@@ -1150,7 +1150,7 @@ static struct omap_hwmod_ocp_if *omap44xx_i2c1_slaves[] = {
 static struct omap_hwmod omap44xx_i2c1_hwmod = {
 	.name		= "i2c1",
 	.class		= &omap44xx_i2c_hwmod_class,
-	.flags		= HWMOD_INIT_NO_RESET,
+	.flags		= HWMOD_16BIT_REG | HWMOD_INIT_NO_RESET,
 	.mpu_irqs	= omap44xx_i2c1_irqs,
 	.mpu_irqs_cnt	= ARRAY_SIZE(omap44xx_i2c1_irqs),
 	.sdma_reqs	= omap44xx_i2c1_sdma_reqs,
@@ -1203,7 +1203,7 @@ static struct omap_hwmod_ocp_if *omap44xx_i2c2_slaves[] = {
 static struct omap_hwmod omap44xx_i2c2_hwmod = {
 	.name		= "i2c2",
 	.class		= &omap44xx_i2c_hwmod_class,
-	.flags		= HWMOD_INIT_NO_RESET,
+	.flags		= HWMOD_16BIT_REG | HWMOD_INIT_NO_RESET,
 	.mpu_irqs	= omap44xx_i2c2_irqs,
 	.mpu_irqs_cnt	= ARRAY_SIZE(omap44xx_i2c2_irqs),
 	.sdma_reqs	= omap44xx_i2c2_sdma_reqs,
@@ -1256,7 +1256,7 @@ static struct omap_hwmod_ocp_if *omap44xx_i2c3_slaves[] = {
 static struct omap_hwmod omap44xx_i2c3_hwmod = {
 	.name		= "i2c3",
 	.class		= &omap44xx_i2c_hwmod_class,
-	.flags		= HWMOD_INIT_NO_RESET,
+	.flags		= HWMOD_16BIT_REG | HWMOD_INIT_NO_RESET,
 	.mpu_irqs	= omap44xx_i2c3_irqs,
 	.mpu_irqs_cnt	= ARRAY_SIZE(omap44xx_i2c3_irqs),
 	.sdma_reqs	= omap44xx_i2c3_sdma_reqs,
@@ -1309,7 +1309,7 @@ static struct omap_hwmod_ocp_if *omap44xx_i2c4_slaves[] = {
 static struct omap_hwmod omap44xx_i2c4_hwmod = {
 	.name		= "i2c4",
 	.class		= &omap44xx_i2c_hwmod_class,
-	.flags		= HWMOD_INIT_NO_RESET,
+	.flags		= HWMOD_16BIT_REG | HWMOD_INIT_NO_RESET,
 	.mpu_irqs	= omap44xx_i2c4_irqs,
 	.mpu_irqs_cnt	= ARRAY_SIZE(omap44xx_i2c4_irqs),
 	.sdma_reqs	= omap44xx_i2c4_sdma_reqs,

