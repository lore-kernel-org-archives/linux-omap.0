From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 1/5] Fix undefined reference to omap2_i2c_mux_pins
Date: Sat, 04 Dec 2010 13:29:44 -0800
Message-ID: <20101204212944.25978.26642.stgit@baageli.muru.com>
References: <20101204212904.25978.22090.stgit@baageli.muru.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-ewr.mailhop.org ([204.13.248.71]:40685 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755811Ab0LDV3s (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sat, 4 Dec 2010 16:29:48 -0500
In-Reply-To: <20101204212904.25978.22090.stgit@baageli.muru.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org
Cc: linux-omap@vger.kernel.org

In some cases we can get error function `omap2_i2c_add_bus':
arch/arm/plat-omap/i2c.c:136: undefined reference to `omap2_i2c_mux_pins'
arch/arm/plat-omap/i2c.c:141: undefined reference to `omap_hwmod_lookup'
arch/arm/plat-omap/i2c.c:157: undefined reference to `omap_device_build'

Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 arch/arm/plat-omap/i2c.c |    7 +++++++
 1 files changed, 7 insertions(+), 0 deletions(-)

diff --git a/arch/arm/plat-omap/i2c.c b/arch/arm/plat-omap/i2c.c
index a5bff9c..21fc937 100644
--- a/arch/arm/plat-omap/i2c.c
+++ b/arch/arm/plat-omap/i2c.c
@@ -125,6 +125,7 @@ static struct omap_device_pm_latency omap_i2c_latency[] = {
 	},
 };
 
+#ifdef CONFIG_ARCH_OMAP2PLUS
 static inline int omap2_i2c_add_bus(int bus_id)
 {
 	int l;
@@ -161,6 +162,12 @@ static inline int omap2_i2c_add_bus(int bus_id)
 
 	return PTR_ERR(od);
 }
+#else
+static inline int omap2_i2c_add_bus(int bus_id)
+{
+	return 0;
+}
+#endif
 
 static int __init omap_i2c_add_bus(int bus_id)
 {

