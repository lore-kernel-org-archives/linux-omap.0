From: Ladislav Michl <Ladislav.Michl@seznam.cz>
Subject: [RFC] use physmap-flash
Date: Sun, 6 Dec 2009 01:35:27 +0100
Message-ID: <20091206003527.GA13977@localhost.localdomain>
Reply-To: Ladislav Michl <ladis@linux-mips.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.seznam.cz ([77.75.72.43]:58750 "EHLO smtp.seznam.cz"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932864AbZLEXfV (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Sat, 5 Dec 2009 18:35:21 -0500
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Imre Deak <imre.deak@nokia.com>, Brian Swetland <swetland@google.com>, Kevin Hilman <kjh@hilman.org>, "Syed Mohammed, Khasim" <khasim@ti.com>, Paul Mundt <lethal@linux-sh.org>, Dirk Behme <dirk.behme@gmail.com>, Marek Vasut <marek.vasut@gmail.com>

Hi!

and sorry for touching ancient stuff again... Also sorry for long Cc list,
which is not even complete, because some projects seem to be dead now.

So, are there any objections to remove drivers/mtd/maps/omap_nor.c entirely
in favour of physmap-flash?

$ rgrep omapflash arch/arm | sed "s/:.*//" | sort | uniq
arch/arm/mach-omap1/board-fsample.c
arch/arm/mach-omap1/board-h2.c
arch/arm/mach-omap1/board-h3.c
arch/arm/mach-omap1/board-innovator.c
arch/arm/mach-omap1/board-osk.c
arch/arm/mach-omap1/board-palmte.c
arch/arm/mach-omap1/board-palmtt.c
arch/arm/mach-omap1/board-palmz71.c
arch/arm/mach-omap1/board-perseus2.c
arch/arm/mach-omap1/board-sx1.c
arch/arm/mach-omap2/board-2430sdp.c
arch/arm/mach-omap2/board-h4.c

Note that list is missing board-voiceblue.c, which is converted by patch bellow.
Function omap_set_vpp should be probably moved somewhere to plat-omap.
Suggestions?

diff --git a/arch/arm/mach-omap1/board-voiceblue.c b/arch/arm/mach-omap1/board-voiceblue.c
index 35c75c1..30e6d0d 100644
--- a/arch/arm/mach-omap1/board-voiceblue.c
+++ b/arch/arm/mach-omap1/board-voiceblue.c
@@ -22,11 +22,11 @@
 #include <linux/reboot.h>
 #include <linux/serial_8250.h>
 #include <linux/serial_reg.h>
+#include <linux/mtd/physmap.h>
 
 #include <mach/hardware.h>
 #include <asm/mach-types.h>
 #include <asm/mach/arch.h>
-#include <asm/mach/flash.h>
 #include <asm/mach/map.h>
 
 #include <plat/common.h>
@@ -85,9 +85,31 @@ static int __init ext_uart_init(void)
 }
 arch_initcall(ext_uart_init);
 
-static struct flash_platform_data voiceblue_flash_data = {
-	.map_name	= "cfi_probe",
+static void omap_set_vpp(struct map_info *map, int enable)
+{
+	static int count;
+	u32 l;
+
+	if (cpu_class_is_omap1()) {
+		if (enable) {
+			if (count++ == 0) {
+				l = omap_readl(EMIFS_CONFIG);
+				l |= OMAP_EMIFS_CONFIG_WP;
+				omap_writel(l, EMIFS_CONFIG);
+			}
+		} else {
+			if (count && (--count == 0)) {
+				l = omap_readl(EMIFS_CONFIG);
+				l &= ~OMAP_EMIFS_CONFIG_WP;
+				omap_writel(l, EMIFS_CONFIG);
+			}
+		}
+	}
+}
+
+static struct physmap_flash_data voiceblue_flash_data = {
 	.width		= 2,
+	.set_vpp	= omap_set_vpp,
 };
 
 static struct resource voiceblue_flash_resource = {
@@ -97,7 +119,7 @@ static struct resource voiceblue_flash_resource = {
 };
 
 static struct platform_device voiceblue_flash_device = {
-	.name		= "omapflash",
+	.name		= "physmap-flash",
 	.id		= 0,
 	.dev		= {
 		.platform_data	= &voiceblue_flash_data,
