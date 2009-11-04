From: "Aguirre Rodriguez, Sergio Alberto" <saaguirre@ti.com>
Subject: [RFC][PATCH] ARM: omap3430sdp: Enable Linux Regulator framework
Date: Wed, 4 Nov 2009 10:26:07 -0600
Message-ID: <A24693684029E5489D1D202277BE89444D53106F@dlee02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:38916 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756505AbZKDQYV convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 4 Nov 2009 11:24:21 -0500
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>
Cc: Tony Lindgren <tony@atomide.com>, "Syed Mohammed, Khasim" <khasim@ti.com>

From: Sergio Aguirre <saaguirre@ti.com>

Some drivers have dependencies on this, and therefore should be
enabled.

Signed-off-by: Sergio Aguirre <saaguirre@ti.com>
---
 arch/arm/configs/omap_3430sdp_defconfig |    9 ++++++++-
 1 files changed, 8 insertions(+), 1 deletions(-)

diff --git a/arch/arm/configs/omap_3430sdp_defconfig b/arch/arm/configs/omap_3430sdp_defconfig
index 8a4a7e2..5a305f0 100644
--- a/arch/arm/configs/omap_3430sdp_defconfig
+++ b/arch/arm/configs/omap_3430sdp_defconfig
@@ -1703,7 +1703,14 @@ CONFIG_RTC_DRV_TWL4030=y
 # on-CPU RTC drivers
 #
 # CONFIG_DMADEVICES is not set
-# CONFIG_REGULATOR is not set
+CONFIG_REGULATOR=y
+# CONFIG_REGULATOR_DEBUG is not set
+# CONFIG_REGULATOR_FIXED_VOLTAGE is not set
+# CONFIG_REGULATOR_VIRTUAL_CONSUMER is not set
+# CONFIG_REGULATOR_USERSPACE_CONSUMER is not set
+# CONFIG_REGULATOR_BQ24022 is not set
+# CONFIG_REGULATOR_MAX1586 is not set
+CONFIG_REGULATOR_TWL4030=y
 # CONFIG_UIO is not set
 # CONFIG_STAGING is not set
 
-- 
1.6.4.4
