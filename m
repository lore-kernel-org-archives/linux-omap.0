From: Tero Kristo <t-kristo@ti.com>
Subject: [PATCHv4 1/4] omap: voltage: add a stub header file
Date: Thu, 28 Jul 2011 14:48:56 +0300
Message-ID: <1311853739-18984-2-git-send-email-t-kristo@ti.com>
References: <1311853739-18984-1-git-send-email-t-kristo@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:40014 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754366Ab1G1LtO convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 28 Jul 2011 07:49:14 -0400
Received: from dlep36.itg.ti.com ([157.170.170.91])
	by bear.ext.ti.com (8.13.7/8.13.7) with ESMTP id p6SBnDon026459
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-omap@vger.kernel.org>; Thu, 28 Jul 2011 06:49:13 -0500
Received: from dlep26.itg.ti.com (smtp-le.itg.ti.com [157.170.170.27])
	by dlep36.itg.ti.com (8.13.8/8.13.8) with ESMTP id p6SBnDAB015423
	for <linux-omap@vger.kernel.org>; Thu, 28 Jul 2011 06:49:13 -0500 (CDT)
Received: from dnce72.ent.ti.com (localhost [127.0.0.1])
	by dlep26.itg.ti.com (8.13.8/8.13.8) with ESMTP id p6SBnCYq015288
	for <linux-omap@vger.kernel.org>; Thu, 28 Jul 2011 06:49:13 -0500 (CDT)
Content-Class: urn:content-classes:message
In-Reply-To: <1311853739-18984-1-git-send-email-t-kristo@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

Needed as some of the voltage layer functionality is accessed from the
SMPS regulator driver.

Signed-off-by: Tero Kristo <t-kristo@ti.com>
---
 arch/arm/plat-omap/include/plat/voltage.h |   20 ++++++++++++++++++++
 1 files changed, 20 insertions(+), 0 deletions(-)
 create mode 100644 arch/arm/plat-omap/include/plat/voltage.h

diff --git a/arch/arm/plat-omap/include/plat/voltage.h b/arch/arm/plat-omap/include/plat/voltage.h
new file mode 100644
index 0000000..0a6a482
--- /dev/null
+++ b/arch/arm/plat-omap/include/plat/voltage.h
@@ -0,0 +1,20 @@
+/*
+ * OMAP Voltage Management Routines
+ *
+ * Copyright (C) 2011, Texas Instruments, Inc.
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+
+#ifndef __ARCH_ARM_OMAP_VOLTAGE_H
+#define __ARCH_ARM_OMAP_VOLTAGE_H
+
+struct voltagedomain;
+
+struct voltagedomain *voltdm_lookup(const char *name);
+int voltdm_scale(struct voltagedomain *voltdm, unsigned long target_volt);
+unsigned long voltdm_get_voltage(struct voltagedomain *voltdm);
+
+#endif
-- 
1.7.4.1


Texas Instruments Oy, Tekniikantie 12, 02150 Espoo. Y-tunnus: 0115040-6. Kotipaikka: Helsinki
 

