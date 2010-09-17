From: "Govindraj.R" <govindraj.raja@ti.com>
Subject: [PATCH 11/11] OMAP: SERIAL: Enable omap-serial driver in Kconfig
Date: Fri, 17 Sep 2010 21:37:57 +0530 (IST)
Message-ID: <14259.10.24.255.18.1284739677.squirrel@dbdmail.itg.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:47120 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755751Ab0IQQIB (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 17 Sep 2010 12:08:01 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org, linux-serial@vger.kernel.org, Kevin Hilman <khilman@deeprootsystems.com>, Tony Lindgren <tony@atomide.com>

Enable omap-serial driver in /mach-omap2/Kconfig and
move 8250 driver selection for zoom boards. With omap-serial
driver addition all omap-uarts can be handled with
omap-serial driver.

With addition of omap-serial driver console parameter
needs be changed in bootargs from ttyS* should be
replaced with ttyO* [O --> OMAP not ZERO]

For example: ttyS0[UART1 on 3430SDP] changes to ttyO0.

But with some boards that do not use omap-uart as console uart.
we need to handle them with 8250 driver. Ex: ZOOM2/3.
For zoom2/3 board we need to use 8250 serial driver and
console parameter will remain ttyS0 which basically uses
a Quad uart placed on the debug board connected through a
gpio line.

Cc: Kevin Hilman <khilman@deeprootsystems.com>
Signed-off-by: Govindraj.R <govindraj.raja@ti.com>
---
 arch/arm/mach-omap2/Kconfig |   11 ++++++++---
 1 files changed, 8 insertions(+), 3 deletions(-)

diff --git a/arch/arm/mach-omap2/Kconfig b/arch/arm/mach-omap2/Kconfig
index b48bacf..19b6c5f 100644
--- a/arch/arm/mach-omap2/Kconfig
+++ b/arch/arm/mach-omap2/Kconfig
@@ -11,9 +11,8 @@ config ARCH_OMAP2PLUS_TYPICAL
 	select PM_RUNTIME
 	select VFP
 	select NEON if ARCH_OMAP3 || ARCH_OMAP4
-	select SERIAL_8250
-	select SERIAL_CORE_CONSOLE
-	select SERIAL_8250_CONSOLE
+	select SERIAL_OMAP
+	select SERIAL_OMAP_CONSOLE
 	select I2C
 	select I2C_OMAP
 	select MFD
@@ -200,12 +199,18 @@ config MACH_OMAP_ZOOM2
 	depends on ARCH_OMAP3
 	default y
 	select OMAP_PACKAGE_CBB
+	select SERIAL_8250
+	select SERIAL_CORE_CONSOLE
+	select SERIAL_8250_CONSOLE

 config MACH_OMAP_ZOOM3
 	bool "OMAP3630 Zoom3 board"
 	depends on ARCH_OMAP3
 	default y
 	select OMAP_PACKAGE_CBP
+	select SERIAL_8250
+	select SERIAL_CORE_CONSOLE
+	select SERIAL_8250_CONSOLE

 config MACH_CM_T35
 	bool "CompuLab CM-T35 module"
-- 
1.6.3.3


