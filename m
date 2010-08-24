From: "C.A, Subramaniam" <subramaniam.ca@ti.com>
Subject: [PATCH]omap: i2c: Avoid compilation error in case the header is
 included multiple times
Date: Tue, 24 Aug 2010 22:44:30 +0530
Message-ID: <B85A65D85D7EB246BE421B3FB0FBB59301E835183B@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:47569 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751928Ab0HXROo convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 24 Aug 2010 13:14:44 -0400
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>
Cc: "Gadiyar, Anand" <gadiyar@ti.com>, "tony@atomide.com" <tony@atomide.com>

>From e3c3ee9317850b2b26e02680a0c976d3c75febab Mon Sep 17 00:00:00 2001
From: Subramaniam C.A <subramaniam.ca@ti.com>
Date: Tue, 24 Aug 2010 12:02:28 -0500
Subject: [PATCH] omap: i2c: Avoid compilation error in case the header is included multiple times.

Added defines to avoid compilation error.

Signed-off-by: Subramaniam C.A <subramaniam.ca@ti.com>
---
 arch/arm/plat-omap/include/plat/i2c.h |    4 ++++
 1 files changed, 4 insertions(+), 0 deletions(-)

diff --git a/arch/arm/plat-omap/include/plat/i2c.h b/arch/arm/plat-omap/include/plat/i2c.h
index 9e085f1..5d67273 100644
--- a/arch/arm/plat-omap/include/plat/i2c.h
+++ b/arch/arm/plat-omap/include/plat/i2c.h
@@ -18,6 +18,8 @@
  * 02110-1301 USA
  *
  */
+#ifndef __ASM__ARCH_OMAP_I2C_H
+#define __ASM__ARCH_OMAP_I2C_H

 #include <linux/i2c.h>

@@ -57,3 +59,5 @@ struct omap_i2c_dev_attr {

 void __init omap1_i2c_mux_pins(int bus_id);
 void __init omap2_i2c_mux_pins(int bus_id);
+
+#endif /* __ASM__ARCH_OMAP_I2C_H */
--
1.7.0.4

BR
Subbu
