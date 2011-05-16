From: Tarun Kanti DebBarma <tarun.kanti@ti.com>
Subject: [RFC PATCH 06/10] OMAP: GPIO: Use USHRT_MAX for rev offset instead of -1
Date: Mon, 16 May 2011 17:11:40 +0530
Message-ID: <1305546104-1511-7-git-send-email-tarun.kanti@ti.com>
References: <1305546104-1511-1-git-send-email-tarun.kanti@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:48336 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753309Ab1EPLlx (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 16 May 2011 07:41:53 -0400
In-Reply-To: <1305546104-1511-1-git-send-email-tarun.kanti@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Charulatha V <charu@ti.com>, Santosh Shilimkar <santosh.shilimkar@ti.com>, Kevin Hilman <khilman@ti.com>, Tony Lindgren <tony@atomide.com>

From: Charulatha V <charu@ti.com>

Use USHRT_MAX for revision offset instead of -1 if revision register
is not available for a given SoC since rev offset is a u16 value.

Signed-off-by: Charulatha V <charu@ti.com>
Cc: Santosh Shilimkar <santosh.shilimkar@ti.com>
Cc: Kevin Hilman <khilman@ti.com>
Cc: Tony Lindgren <tony@atomide.com>
---
 arch/arm/mach-omap1/gpio15xx.c |    2 +-
 arch/arm/mach-omap1/gpio16xx.c |    2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-omap1/gpio15xx.c b/arch/arm/mach-omap1/gpio15xx.c
index 7a15f69..f18a4a9 100644
--- a/arch/arm/mach-omap1/gpio15xx.c
+++ b/arch/arm/mach-omap1/gpio15xx.c
@@ -77,7 +77,7 @@ static struct __initdata resource omap15xx_gpio_resources[] = {
 };
 
 static struct omap_gpio_reg_offs omap15xx_gpio_regs = {
-	.revision	= -1,
+	.revision	= USHRT_MAX,
 	.direction	= OMAP1510_GPIO_DIR_CONTROL,
 	.datain		= OMAP1510_GPIO_DATA_INPUT,
 	.dataout	= OMAP1510_GPIO_DATA_OUTPUT,
diff --git a/arch/arm/mach-omap1/gpio16xx.c b/arch/arm/mach-omap1/gpio16xx.c
index 43718ec..d886b88 100644
--- a/arch/arm/mach-omap1/gpio16xx.c
+++ b/arch/arm/mach-omap1/gpio16xx.c
@@ -38,7 +38,7 @@ static struct __initdata resource omap16xx_mpu_gpio_resources[] = {
 };
 
 static struct omap_gpio_reg_offs omap16xx_mpuio_regs = {
-	.revision       = -1,
+	.revision       = USHRT_MAX,
 	.direction	= OMAP_MPUIO_IO_CNTL,
 	.datain		= OMAP_MPUIO_INPUT_LATCH,
 	.dataout	= OMAP_MPUIO_OUTPUT,
-- 
1.7.1
