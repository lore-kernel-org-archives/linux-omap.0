From: hvaibhav@ti.com
Subject: [PATCH 1/3-V1] AM35xx: Introduce am35xx.h file
Date: Mon, 11 Jan 2010 11:36:19 +0530
Message-ID: <1263189981-717-2-git-send-email-hvaibhav@ti.com>
References: <hvaibhav@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:50788 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751347Ab0AKGG2 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 11 Jan 2010 01:06:28 -0500
In-Reply-To: <hvaibhav@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: tony@atomide.com, khilman@deeprootsystems.com, Vaibhav Hiremath <hvaibhav@ti.com>, Sriramakrishnan <srk@ti.com>

From: Vaibhav Hiremath <hvaibhav@ti.com>

Add base address definations for new AM35xx IPSS modules, like
VPFE, USBOTG, CPGMAC.

Please note that the OMAP34xx IVA2 memory space is being used for
AM35xx IPSS modules.

Signed-off-by: Vaibhav Hiremath <hvaibhav@ti.com>
Signed-off-by: Sriramakrishnan <srk@ti.com>
---
 arch/arm/mach-omap2/board-am3517evm.c     |    1 +
 arch/arm/mach-omap2/include/mach/am35xx.h |   26 ++++++++++++++++++++++++++
 2 files changed, 27 insertions(+), 0 deletions(-)
 create mode 100644 arch/arm/mach-omap2/include/mach/am35xx.h

diff --git a/arch/arm/mach-omap2/board-am3517evm.c b/arch/arm/mach-omap2/board-am3517evm.c
index b4e6eca..8cce7d1 100644
--- a/arch/arm/mach-omap2/board-am3517evm.c
+++ b/arch/arm/mach-omap2/board-am3517evm.c
@@ -22,6 +22,7 @@
 #include <linux/gpio.h>

 #include <mach/hardware.h>
+#include <mach/am35xx.h>
 #include <asm/mach-types.h>
 #include <asm/mach/arch.h>
 #include <asm/mach/map.h>
diff --git a/arch/arm/mach-omap2/include/mach/am35xx.h b/arch/arm/mach-omap2/include/mach/am35xx.h
new file mode 100644
index 0000000..a705f94
--- /dev/null
+++ b/arch/arm/mach-omap2/include/mach/am35xx.h
@@ -0,0 +1,26 @@
+/*:
+ * Address mappings and base address for AM35XX specific interconnects
+ * and peripherals.
+ *
+ * Copyright (C) 2009 Texas Instruments
+ *
+ * Author: Sriramakrishnan <srk@ti.com>
+ *	   Vaibhav Hiremath <hvaibhav@ti.com>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+#ifndef __ASM_ARCH_AM35XX_H
+#define __ASM_ARCH_AM35XX_H
+
+/*
+ * Base addresses
+ *	Note: OMAP3430 IVA2 memory space is being used for AM35xx IPSS modules
+ */
+#define AM35XX_IPSS_EMAC_BASE		0x5C000000
+#define AM35XX_IPSS_USBOTGSS_BASE	0x5C040000
+#define AM35XX_IPSS_HECC_BASE		0x5C050000
+#define AM35XX_IPSS_VPFE_BASE		0x5C060000
+
+#endif /*  __ASM_ARCH_AM35XX_H */
--
1.6.2.4

