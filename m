From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: [PATCH 08/31] ARM: amba: get rid of NO_IRQ initializers
Date: Fri, 20 Jan 2012 09:25:06 +0000
Message-ID: <E1RoAiY-0005El-LF@rmk-PC.arm.linux.org.uk>
References: <20120120092207.GD1068@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <linux-mmc-owner@vger.kernel.org>
In-Reply-To: <20120120092207.GD1068@n2100.arm.linux.org.uk>
Content-Disposition: inline
Sender: linux-mmc-owner@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org, devicetree-discuss@lists.ozlabs.org, linux-mmc@vger.kernel.org, linux-omap@vger.kernel.org, linux-samsung-soc@vger.kernel.org, STEricsson <STEricsson_nomadik_linux@list.st.com>
Cc: Hartley Sweeten <hsweeten@visionengravers.com>, Ryan Mallon <rmallon@gmail.com>
List-Id: linux-omap@vger.kernel.org

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 arch/arm/mach-ep93xx/core.c |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/arm/mach-ep93xx/core.c b/arch/arm/mach-ep93xx/core.c
index 24203f9..1a8397a 100644
--- a/arch/arm/mach-ep93xx/core.c
+++ b/arch/arm/mach-ep93xx/core.c
@@ -289,7 +289,7 @@ static struct amba_device uart1_device = {
 		.end	= EP93XX_UART1_PHYS_BASE + 0x0fff,
 		.flags	= IORESOURCE_MEM,
 	},
-	.irq		= { IRQ_EP93XX_UART1, NO_IRQ },
+	.irq		= { IRQ_EP93XX_UART1 },
 	.periphid	= 0x00041010,
 };
 
@@ -303,7 +303,7 @@ static struct amba_device uart2_device = {
 		.end	= EP93XX_UART2_PHYS_BASE + 0x0fff,
 		.flags	= IORESOURCE_MEM,
 	},
-	.irq		= { IRQ_EP93XX_UART2, NO_IRQ },
+	.irq		= { IRQ_EP93XX_UART2 },
 	.periphid	= 0x00041010,
 };
 
@@ -317,7 +317,7 @@ static struct amba_device uart3_device = {
 		.end	= EP93XX_UART3_PHYS_BASE + 0x0fff,
 		.flags	= IORESOURCE_MEM,
 	},
-	.irq		= { IRQ_EP93XX_UART3, NO_IRQ },
+	.irq		= { IRQ_EP93XX_UART3 },
 	.periphid	= 0x00041010,
 };
 
-- 
1.7.4.4

