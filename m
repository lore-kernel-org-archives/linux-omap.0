From: Suman Anna <s-anna@ti.com>
Subject: [PATCH 1/5] MAINTAINERS: Add ti-sysc files under the OMAP2+ entry
Date: Tue, 25 Jun 2019 18:33:11 -0500
Message-ID: <20190625233315.22301-2-s-anna@ti.com>
References: <20190625233315.22301-1-s-anna@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190625233315.22301-1-s-anna@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Tero Kristo <t-kristo@ti.com>, Roger Quadros <rogerq@ti.com>, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, Suman Anna <s-anna@ti.com>
List-Id: linux-omap@vger.kernel.org

Add the ti-sysc source files under the OMAP2+ entry so that
the get_maintainer script also generates the linux-omap
list to be cc'd for all patches touching these files.

Signed-off-by: Suman Anna <s-anna@ti.com>
---
 MAINTAINERS | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index d0ed735994a5..d45c456bc051 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -11526,6 +11526,7 @@ S:	Maintained
 F:	arch/arm/mach-omap2/
 F:	arch/arm/plat-omap/
 F:	arch/arm/configs/omap2plus_defconfig
+F:	drivers/bus/ti-sysc.c
 F:	drivers/i2c/busses/i2c-omap.c
 F:	drivers/irqchip/irq-omap-intc.c
 F:	drivers/mfd/*omap*.c
@@ -11546,6 +11547,7 @@ F:	drivers/regulator/tps65910-regulator.c
 F:	drivers/regulator/twl-regulator.c
 F:	drivers/regulator/twl6030-regulator.c
 F:	include/linux/platform_data/i2c-omap.h
+F:	include/linux/platform_data/ti-sysc.h
 
 ONION OMEGA2+ BOARD
 M:	Harvey Hunt <harveyhuntnexus@gmail.com>
-- 
2.21.0
