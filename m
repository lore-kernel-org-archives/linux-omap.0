From: Paul Walmsley <paul@pwsan.com>
Subject: [PATCH 18/20] OMAP2+: hwmod/device: update documentation and
 copyright
Date: Fri, 02 Jul 2010 09:29:51 -0600
Message-ID: <20100702152948.6221.19663.stgit@localhost.localdomain>
References: <20100702152703.6221.33529.stgit@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:45319 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758916Ab0GBPbG (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 2 Jul 2010 11:31:06 -0400
In-Reply-To: <20100702152703.6221.33529.stgit@localhost.localdomain>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: Kevin Hilman <khilman@deeprootsystems.com>, =?utf-8?q?Beno=C3=AEt?= Cousson <b-cousson@ti.com>

Update some minor documentation issues and update copyright for
omap_device/omap_hwmod code.

Signed-off-by: Paul Walmsley <paul@pwsan.com>
Cc: Kevin Hilman <khilman@deeprootsystems.com>
Cc: Beno=C3=AEt Cousson <b-cousson@ti.com>
---
 arch/arm/mach-omap2/omap_hwmod.c |   17 ++++++++++++++++-
 arch/arm/plat-omap/omap_device.c |    9 ++++++---
 2 files changed, 22 insertions(+), 4 deletions(-)

diff --git a/arch/arm/mach-omap2/omap_hwmod.c b/arch/arm/mach-omap2/oma=
p_hwmod.c
index b012057..4002774 100644
--- a/arch/arm/mach-omap2/omap_hwmod.c
+++ b/arch/arm/mach-omap2/omap_hwmod.c
@@ -422,7 +422,7 @@ static int _init_main_clk(struct omap_hwmod *oh)
 }
=20
 /**
- * _init_interface_clk - get a struct clk * for the the hwmod's interf=
ace clks
+ * _init_interface_clks - get a struct clk * for the the hwmod's inter=
face clks
  * @oh: struct omap_hwmod *
  *
  * Called from _init_clocks().  Populates the @oh OCP slave interface
@@ -1074,6 +1074,21 @@ void omap_hwmod_writel(u32 v, struct omap_hwmod =
*oh, u16 reg_offs)
 	__raw_writel(v, oh->_mpu_rt_va + reg_offs);
 }
=20
+/**
+ * omap_hwmod_set_slave_idlemode - set the hwmod's OCP slave idlemode
+ * @oh: struct omap_hwmod *
+ * @idlemode: SIDLEMODE field bits (shifted to bit 0)
+ *
+ * Sets the IP block's OCP slave idlemode in hardware, and updates our
+ * local copy.  Intended to be used by drivers that have some erratum
+ * that requires direct manipulation of the SIDLEMODE bits.  Returns
+ * -EINVAL if @oh is null, or passes along the return value from
+ * _set_slave_idlemode().
+ *
+ * XXX Does this function have any current users?  If not, we should
+ * remove it; it is better to let the rest of the hwmod code handle th=
is.
+ * Any users of this function should be scrutinized carefully.
+ */
 int omap_hwmod_set_slave_idlemode(struct omap_hwmod *oh, u8 idlemode)
 {
 	u32 v;
diff --git a/arch/arm/plat-omap/omap_device.c b/arch/arm/plat-omap/omap=
_device.c
index dee4629..ea0d659 100644
--- a/arch/arm/plat-omap/omap_device.c
+++ b/arch/arm/plat-omap/omap_device.c
@@ -1,7 +1,7 @@
 /*
  * omap_device implementation
  *
- * Copyright (C) 2009 Nokia Corporation
+ * Copyright (C) 2009-2010 Nokia Corporation
  * Paul Walmsley, Kevin Hilman
  *
  * Developed in collaboration with (alphabetical order): Benoit
@@ -90,8 +90,11 @@
 #define USE_WAKEUP_LAT			0
 #define IGNORE_WAKEUP_LAT		1
=20
-
-#define OMAP_DEVICE_MAGIC 0xf00dcafe
+/*
+ * OMAP_DEVICE_MAGIC: used to determine whether a struct omap_device
+ * obtained via container_of() is in fact a struct omap_device
+ */
+#define OMAP_DEVICE_MAGIC		 0xf00dcafe
=20
 /* Private functions */
=20


--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
