From: hvaibhav@ti.com
Subject: [PATCH 2/3] AM35xx: Introduce am35xx.h file
Date: Mon,  4 Jan 2010 19:21:55 +0530
Message-ID: <1262613116-20185-3-git-send-email-hvaibhav@ti.com>
References: <hvaibhav@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:42884 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753073Ab0ADNwF (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 4 Jan 2010 08:52:05 -0500
In-Reply-To: <hvaibhav@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: tony@atomide.com, Vaibhav Hiremath <hvaibhav@ti.com>, Sriramakrishnan <srk@ti.com>

From: Vaibhav Hiremath <hvaibhav@ti.com>

Add base address definations for new AM35xx IPSS modules, like
VPFE, USBOTG, CPGMAC.

Signed-off-by: Vaibhav Hiremath <hvaibhav@ti.com>
Signed-off-by: Sriramakrishnan <srk@ti.com>
---
 arch/arm/plat-omap/include/plat/am35xx.h   |   25 +++++++++++++++++++++++++
 arch/arm/plat-omap/include/plat/hardware.h |    1 +
 2 files changed, 26 insertions(+), 0 deletions(-)
 create mode 100644 arch/arm/plat-omap/include/plat/am35xx.h

diff --git a/arch/arm/plat-omap/include/plat/am35xx.h b/arch/arm/plat-omap/include/plat/am35xx.h
new file mode 100644
index 0000000..d41bd61
--- /dev/null
+++ b/arch/arm/plat-omap/include/plat/am35xx.h
@@ -0,0 +1,25 @@
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
+ */
+#define AM35XX_IPSS_EMAC_BASE		0x5C000000
+#define AM35XX_IPSS_USBOTGSS_BASE	0x5C040000
+#define AM35XX_IPSS_HECC_BASE		0x5C050000
+#define AM35XX_IPSS_VPFE_BASE		0x5C060000
+
+#endif /*  __ASM_ARCH_AM35XX_H */
diff --git a/arch/arm/plat-omap/include/plat/hardware.h b/arch/arm/plat-omap/include/plat/hardware.h
index d5b26ad..930c3f9 100644
--- a/arch/arm/plat-omap/include/plat/hardware.h
+++ b/arch/arm/plat-omap/include/plat/hardware.h
@@ -285,6 +285,7 @@
 #include <plat/omap16xx.h>
 #include <plat/omap24xx.h>
 #include <plat/omap34xx.h>
+#include <plat/am35xx.h>
 #include <plat/omap44xx.h>

 #endif	/* __ASM_ARCH_OMAP_HARDWARE_H */
--
1.6.2.4

