From: "Govindraj.R" <govindraj.raja@ti.com>
Subject: [PATCH 1/7] OMAP2+ : hwmod_data: update uart hwmod data.
Date: Mon, 28 Feb 2011 20:09:12 +0530
Message-ID: <1298903958-6496-2-git-send-email-govindraj.raja@ti.com>
References: <1298903958-6496-1-git-send-email-govindraj.raja@ti.com>
Return-path: <linux-serial-owner@vger.kernel.org>
In-Reply-To: <1298903958-6496-1-git-send-email-govindraj.raja@ti.com>
Sender: linux-serial-owner@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-serial@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: "Govindraj.R" <govindraj.raja@ti.com>, Tony Lindgren <tony@atomide.com>, Benoit Cousson <b-cousson@ti.com>, Kevin Hilman <khilman@ti.com>, Paul Walmsley <paul@pwsan.com>, Rajendra Nayak <rnayak@ti.com>
List-Id: linux-omap@vger.kernel.org

Add HWMOD_SWSUP_SIDLE flag to uart*_hwmod data. With addition of this flag the
hwmod framework will take care of updating sysc reg with no_idle mode while
enabling clocks and to force_idle mode while disabling clocks.

Signed-off-by: Govindraj.R <govindraj.raja@ti.com>
---
 arch/arm/mach-omap2/omap_hwmod_2420_data.c |    3 +++
 arch/arm/mach-omap2/omap_hwmod_2430_data.c |    3 +++
 arch/arm/mach-omap2/omap_hwmod_3xxx_data.c |    4 ++++
 arch/arm/mach-omap2/omap_hwmod_44xx_data.c |    4 ++++
 4 files changed, 14 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap2/omap_hwmod_2420_data.c b/arch/arm/mach-omap2/omap_hwmod_2420_data.c
index f323c6b..48392f3 100644
--- a/arch/arm/mach-omap2/omap_hwmod_2420_data.c
+++ b/arch/arm/mach-omap2/omap_hwmod_2420_data.c
@@ -434,6 +434,7 @@ static struct omap_hwmod_ocp_if *omap2420_uart1_slaves[] = {
 
 static struct omap_hwmod omap2420_uart1_hwmod = {
 	.name		= "uart1",
+	.flags		= HWMOD_SWSUP_SIDLE,
 	.mpu_irqs	= uart1_mpu_irqs,
 	.mpu_irqs_cnt	= ARRAY_SIZE(uart1_mpu_irqs),
 	.sdma_reqs	= uart1_sdma_reqs,
@@ -471,6 +472,7 @@ static struct omap_hwmod_ocp_if *omap2420_uart2_slaves[] = {
 
 static struct omap_hwmod omap2420_uart2_hwmod = {
 	.name		= "uart2",
+	.flags		= HWMOD_SWSUP_SIDLE,
 	.mpu_irqs	= uart2_mpu_irqs,
 	.mpu_irqs_cnt	= ARRAY_SIZE(uart2_mpu_irqs),
 	.sdma_reqs	= uart2_sdma_reqs,
@@ -508,6 +510,7 @@ static struct omap_hwmod_ocp_if *omap2420_uart3_slaves[] = {
 
 static struct omap_hwmod omap2420_uart3_hwmod = {
 	.name		= "uart3",
+	.flags		= HWMOD_SWSUP_SIDLE,
 	.mpu_irqs	= uart3_mpu_irqs,
 	.mpu_irqs_cnt	= ARRAY_SIZE(uart3_mpu_irqs),
 	.sdma_reqs	= uart3_sdma_reqs,
diff --git a/arch/arm/mach-omap2/omap_hwmod_2430_data.c b/arch/arm/mach-omap2/omap_hwmod_2430_data.c
index de0015d..ab58a20 100644
--- a/arch/arm/mach-omap2/omap_hwmod_2430_data.c
+++ b/arch/arm/mach-omap2/omap_hwmod_2430_data.c
@@ -490,6 +490,7 @@ static struct omap_hwmod_ocp_if *omap2430_uart1_slaves[] = {
 
 static struct omap_hwmod omap2430_uart1_hwmod = {
 	.name		= "uart1",
+	.flags		= HWMOD_SWSUP_SIDLE,
 	.mpu_irqs	= uart1_mpu_irqs,
 	.mpu_irqs_cnt	= ARRAY_SIZE(uart1_mpu_irqs),
 	.sdma_reqs	= uart1_sdma_reqs,
@@ -527,6 +528,7 @@ static struct omap_hwmod_ocp_if *omap2430_uart2_slaves[] = {
 
 static struct omap_hwmod omap2430_uart2_hwmod = {
 	.name		= "uart2",
+	.flags		= HWMOD_SWSUP_SIDLE,
 	.mpu_irqs	= uart2_mpu_irqs,
 	.mpu_irqs_cnt	= ARRAY_SIZE(uart2_mpu_irqs),
 	.sdma_reqs	= uart2_sdma_reqs,
@@ -564,6 +566,7 @@ static struct omap_hwmod_ocp_if *omap2430_uart3_slaves[] = {
 
 static struct omap_hwmod omap2430_uart3_hwmod = {
 	.name		= "uart3",
+	.flags		= HWMOD_SWSUP_SIDLE,
 	.mpu_irqs	= uart3_mpu_irqs,
 	.mpu_irqs_cnt	= ARRAY_SIZE(uart3_mpu_irqs),
 	.sdma_reqs	= uart3_sdma_reqs,
diff --git a/arch/arm/mach-omap2/omap_hwmod_3xxx_data.c b/arch/arm/mach-omap2/omap_hwmod_3xxx_data.c
index e9d0012..79c39d4 100644
--- a/arch/arm/mach-omap2/omap_hwmod_3xxx_data.c
+++ b/arch/arm/mach-omap2/omap_hwmod_3xxx_data.c
@@ -626,6 +626,7 @@ static struct omap_hwmod_ocp_if *omap3xxx_uart1_slaves[] = {
 
 static struct omap_hwmod omap3xxx_uart1_hwmod = {
 	.name		= "uart1",
+	.flags		= HWMOD_SWSUP_SIDLE,
 	.mpu_irqs	= uart1_mpu_irqs,
 	.mpu_irqs_cnt	= ARRAY_SIZE(uart1_mpu_irqs),
 	.sdma_reqs	= uart1_sdma_reqs,
@@ -663,6 +664,7 @@ static struct omap_hwmod_ocp_if *omap3xxx_uart2_slaves[] = {
 
 static struct omap_hwmod omap3xxx_uart2_hwmod = {
 	.name		= "uart2",
+	.flags		= HWMOD_SWSUP_SIDLE,
 	.mpu_irqs	= uart2_mpu_irqs,
 	.mpu_irqs_cnt	= ARRAY_SIZE(uart2_mpu_irqs),
 	.sdma_reqs	= uart2_sdma_reqs,
@@ -700,6 +702,7 @@ static struct omap_hwmod_ocp_if *omap3xxx_uart3_slaves[] = {
 
 static struct omap_hwmod omap3xxx_uart3_hwmod = {
 	.name		= "uart3",
+	.flags		= HWMOD_SWSUP_SIDLE,
 	.mpu_irqs	= uart3_mpu_irqs,
 	.mpu_irqs_cnt	= ARRAY_SIZE(uart3_mpu_irqs),
 	.sdma_reqs	= uart3_sdma_reqs,
@@ -737,6 +740,7 @@ static struct omap_hwmod_ocp_if *omap3xxx_uart4_slaves[] = {
 
 static struct omap_hwmod omap3xxx_uart4_hwmod = {
 	.name		= "uart4",
+	.flags		= HWMOD_SWSUP_SIDLE,
 	.mpu_irqs	= uart4_mpu_irqs,
 	.mpu_irqs_cnt	= ARRAY_SIZE(uart4_mpu_irqs),
 	.sdma_reqs	= uart4_sdma_reqs,
diff --git a/arch/arm/mach-omap2/omap_hwmod_44xx_data.c b/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
index 79a8601..13c2df1 100644
--- a/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
+++ b/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
@@ -4587,6 +4587,7 @@ static struct omap_hwmod_ocp_if *omap44xx_uart1_slaves[] = {
 
 static struct omap_hwmod omap44xx_uart1_hwmod = {
 	.name		= "uart1",
+	.flags		= HWMOD_SWSUP_SIDLE,
 	.class		= &omap44xx_uart_hwmod_class,
 	.mpu_irqs	= omap44xx_uart1_irqs,
 	.mpu_irqs_cnt	= ARRAY_SIZE(omap44xx_uart1_irqs),
@@ -4639,6 +4640,7 @@ static struct omap_hwmod_ocp_if *omap44xx_uart2_slaves[] = {
 
 static struct omap_hwmod omap44xx_uart2_hwmod = {
 	.name		= "uart2",
+	.flags		= HWMOD_SWSUP_SIDLE,
 	.class		= &omap44xx_uart_hwmod_class,
 	.mpu_irqs	= omap44xx_uart2_irqs,
 	.mpu_irqs_cnt	= ARRAY_SIZE(omap44xx_uart2_irqs),
@@ -4691,6 +4693,7 @@ static struct omap_hwmod_ocp_if *omap44xx_uart3_slaves[] = {
 
 static struct omap_hwmod omap44xx_uart3_hwmod = {
 	.name		= "uart3",
+	.flags		= HWMOD_SWSUP_SIDLE,
 	.class		= &omap44xx_uart_hwmod_class,
 	.flags		= (HWMOD_INIT_NO_IDLE | HWMOD_INIT_NO_RESET),
 	.mpu_irqs	= omap44xx_uart3_irqs,
@@ -4744,6 +4747,7 @@ static struct omap_hwmod_ocp_if *omap44xx_uart4_slaves[] = {
 
 static struct omap_hwmod omap44xx_uart4_hwmod = {
 	.name		= "uart4",
+	.flags		= HWMOD_SWSUP_SIDLE,
 	.class		= &omap44xx_uart_hwmod_class,
 	.mpu_irqs	= omap44xx_uart4_irqs,
 	.mpu_irqs_cnt	= ARRAY_SIZE(omap44xx_uart4_irqs),
-- 
1.7.1

