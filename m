From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: [PATCH 14/31] ARM: amba: netx: get rid of NO_IRQ initializers
Date: Fri, 20 Jan 2012 09:27:08 +0000
Message-ID: <E1RoAkW-0005FD-UH@rmk-PC.arm.linux.org.uk>
References: <20120120092207.GD1068@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <linux-mmc-owner@vger.kernel.org>
In-Reply-To: <20120120092207.GD1068@n2100.arm.linux.org.uk>
Content-Disposition: inline
Sender: linux-mmc-owner@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org, devicetree-discuss@lists.ozlabs.org, linux-mmc@vger.kernel.org, linux-omap@vger.kernel.org, linux-samsung-soc@vger.kernel.org, STEricsson <STEricsson_nomadik_linux@list.st.com>
List-Id: linux-omap@vger.kernel.org

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 arch/arm/mach-netx/fb.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-netx/fb.c b/arch/arm/mach-netx/fb.c
index b991323..eda856c 100644
--- a/arch/arm/mach-netx/fb.c
+++ b/arch/arm/mach-netx/fb.c
@@ -102,7 +102,7 @@ static struct amba_device fb_device = {
 		.end	= 0x00104fff,
 		.flags	= IORESOURCE_MEM,
 	},
-	.irq		= { NETX_IRQ_LCD, NO_IRQ },
+	.irq		= { NETX_IRQ_LCD },
 };
 
 int netx_fb_init(struct clcd_board *board, struct clcd_panel *panel)
-- 
1.7.4.4

