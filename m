From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: [PATCH 13/31] ARM: amba: nomadik: get rid of NO_IRQ initializers
Date: Fri, 20 Jan 2012 09:26:48 +0000
Message-ID: <E1RoAkC-0005F9-GQ@rmk-PC.arm.linux.org.uk>
References: <20120120092207.GD1068@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <linux-mmc-owner@vger.kernel.org>
In-Reply-To: <20120120092207.GD1068@n2100.arm.linux.org.uk>
Content-Disposition: inline
Sender: linux-mmc-owner@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org, devicetree-discuss@lists.ozlabs.org, linux-mmc@vger.kernel.org, linux-omap@vger.kernel.org, linux-samsung-soc@vger.kernel.org, STEricsson <STEricsson_nomadik_linux@list.st.com>
Cc: Alessandro Rubini <rubini@unipv.it>, Linus Walleij <linus.walleij@stericsson.com>
List-Id: linux-omap@vger.kernel.org

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 arch/arm/mach-nomadik/board-nhk8815.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-nomadik/board-nhk8815.c b/arch/arm/mach-nomadik/board-nhk8815.c
index 7c878bf..721e51c 100644
--- a/arch/arm/mach-nomadik/board-nhk8815.c
+++ b/arch/arm/mach-nomadik/board-nhk8815.c
@@ -191,13 +191,13 @@ static void __init nhk8815_onenand_init(void)
 static struct amba_device uart0_device = {
 	.dev = { .init_name = "uart0" },
 	__MEM_4K_RESOURCE(NOMADIK_UART0_BASE),
-	.irq = {IRQ_UART0, NO_IRQ},
+	.irq = {IRQ_UART0},
 };
 
 static struct amba_device uart1_device = {
 	.dev = { .init_name = "uart1" },
 	__MEM_4K_RESOURCE(NOMADIK_UART1_BASE),
-	.irq = {IRQ_UART1, NO_IRQ},
+	.irq = {IRQ_UART1},
 };
 
 static struct amba_device *amba_devs[] __initdata = {
-- 
1.7.4.4

