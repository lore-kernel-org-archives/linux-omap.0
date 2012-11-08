From: Sasha Levin <sasha.levin@oracle.com>
Subject: [PATCH] ARM: OMAP1: use BUG_ON where possible
Date: Thu,  8 Nov 2012 15:23:09 -0500
Message-ID: <1352406191-14303-7-git-send-email-sasha.levin@oracle.com>
References: <1352406191-14303-1-git-send-email-sasha.levin@oracle.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1352406191-14303-1-git-send-email-sasha.levin@oracle.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.infradead.org
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: linux-kernel@vger.kernel.org
Cc: Tony Lindgren <tony@atomide.com>, Sasha Levin <sasha.levin@oracle.com>, linux-omap@vger.kernel.org, Russell King <linux@arm.linux.org.uk>, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

Just use BUG_ON() instead of constructions such as:

	if (...)
		BUG()

A simplified version of the semantic patch that makes this transformation
is as follows: (http://coccinelle.lip6.fr/)

// <smpl>
@@
expression e;
@@
- if (e) BUG();
+ BUG_ON(e);
// </smpl>

Signed-off-by: Sasha Levin <sasha.levin@oracle.com>
---
 arch/arm/mach-omap1/board-fsample.c  |    3 +--
 arch/arm/mach-omap1/board-h2.c       |    3 +--
 arch/arm/mach-omap1/board-h3.c       |    3 +--
 arch/arm/mach-omap1/board-perseus2.c |    3 +--
 4 files changed, 4 insertions(+), 8 deletions(-)

diff --git a/arch/arm/mach-omap1/board-fsample.c b/arch/arm/mach-omap1/board-fsample.c
index 8b5800a..7ca6cc4 100644
--- a/arch/arm/mach-omap1/board-fsample.c
+++ b/arch/arm/mach-omap1/board-fsample.c
@@ -307,8 +307,7 @@ static void __init omap_fsample_init(void)
 
 	fsample_init_smc91x();
 
-	if (gpio_request(FSAMPLE_NAND_RB_GPIO_PIN, "NAND ready") < 0)
-		BUG();
+	BUG_ON(gpio_request(FSAMPLE_NAND_RB_GPIO_PIN, "NAND ready") < 0);
 	gpio_direction_input(FSAMPLE_NAND_RB_GPIO_PIN);
 
 	omap_cfg_reg(L3_1610_FLASH_CS2B_OE);
diff --git a/arch/arm/mach-omap1/board-h2.c b/arch/arm/mach-omap1/board-h2.c
index 9134b64..4953cf7 100644
--- a/arch/arm/mach-omap1/board-h2.c
+++ b/arch/arm/mach-omap1/board-h2.c
@@ -412,8 +412,7 @@ static void __init h2_init(void)
 
 	h2_nand_resource.end = h2_nand_resource.start = OMAP_CS2B_PHYS;
 	h2_nand_resource.end += SZ_4K - 1;
-	if (gpio_request(H2_NAND_RB_GPIO_PIN, "NAND ready") < 0)
-		BUG();
+	BUG_ON(gpio_request(H2_NAND_RB_GPIO_PIN, "NAND ready") < 0);
 	gpio_direction_input(H2_NAND_RB_GPIO_PIN);
 
 	omap_cfg_reg(L3_1610_FLASH_CS2B_OE);
diff --git a/arch/arm/mach-omap1/board-h3.c b/arch/arm/mach-omap1/board-h3.c
index bf213d1..563ba16 100644
--- a/arch/arm/mach-omap1/board-h3.c
+++ b/arch/arm/mach-omap1/board-h3.c
@@ -406,8 +406,7 @@ static void __init h3_init(void)
 
 	nand_resource.end = nand_resource.start = OMAP_CS2B_PHYS;
 	nand_resource.end += SZ_4K - 1;
-	if (gpio_request(H3_NAND_RB_GPIO_PIN, "NAND ready") < 0)
-		BUG();
+	BUG_ON(gpio_request(H3_NAND_RB_GPIO_PIN, "NAND ready") < 0);
 	gpio_direction_input(H3_NAND_RB_GPIO_PIN);
 
 	/* GPIO10 Func_MUX_CTRL reg bit 29:27, Configure V2 to mode1 as GPIO */
diff --git a/arch/arm/mach-omap1/board-perseus2.c b/arch/arm/mach-omap1/board-perseus2.c
index 030bd48..67c2612 100644
--- a/arch/arm/mach-omap1/board-perseus2.c
+++ b/arch/arm/mach-omap1/board-perseus2.c
@@ -275,8 +275,7 @@ static void __init omap_perseus2_init(void)
 
 	perseus2_init_smc91x();
 
-	if (gpio_request(P2_NAND_RB_GPIO_PIN, "NAND ready") < 0)
-		BUG();
+	BUG_ON(gpio_request(P2_NAND_RB_GPIO_PIN, "NAND ready") < 0);
 	gpio_direction_input(P2_NAND_RB_GPIO_PIN);
 
 	omap_cfg_reg(L3_1610_FLASH_CS2B_OE);
-- 
1.7.10.4
