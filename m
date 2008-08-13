From: "Hunter, Jon" <jon-hunter@ti.com>
Subject: [PATCH] OMAP5912: Fix omap5912 osk alsa driver [1/2]
Date: Tue, 12 Aug 2008 22:07:27 -0500
Message-ID: <7B4574D56E4ADF438756313E9A172A870D5F0E58@dlee01.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:36462 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752788AbYHMDHe convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 12 Aug 2008 23:07:34 -0400
Received: from dlep34.itg.ti.com ([157.170.170.115])
	by bear.ext.ti.com (8.13.7/8.13.7) with ESMTP id m7D37SXI004956
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-omap@vger.kernel.org>; Tue, 12 Aug 2008 22:07:33 -0500
Received: from dlep20.itg.ti.com (localhost [127.0.0.1])
	by dlep34.itg.ti.com (8.13.7/8.13.7) with ESMTP id m7D37SKv019260
	for <linux-omap@vger.kernel.org>; Tue, 12 Aug 2008 22:07:28 -0500 (CDT)
Received: from dlee73.ent.ti.com (localhost [127.0.0.1])
	by dlep20.itg.ti.com (8.12.11/8.12.11) with ESMTP id m7D37Sd1002590
	for <linux-omap@vger.kernel.org>; Tue, 12 Aug 2008 22:07:28 -0500 (CDT)
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

Move OMAP_MCBSP_READ and OMAP_MCBSP_WRITE macro definitions from arch/arm/plat-omap/mcbsp.c to include/asm-arm/arch-omap/mcbsp.h.


Signed-off-by: Jon Hunter <jon-hunter@ti.com>
---
 arch/arm/plat-omap/mcbsp.c        |    5 -----
 include/asm-arm/arch-omap/mcbsp.h |    8 ++++++++
 2 files changed, 8 insertions(+), 5 deletions(-)

diff --git a/arch/arm/plat-omap/mcbsp.c b/arch/arm/plat-omap/mcbsp.c
index 70944a5..214136e 100644
--- a/arch/arm/plat-omap/mcbsp.c
+++ b/arch/arm/plat-omap/mcbsp.c
@@ -46,11 +46,6 @@ int omap_mcbsp_read(u32 io_base, u16 reg)
                return __raw_readl(io_base + reg);
 }

-#define OMAP_MCBSP_READ(base, reg) \
-                       omap_mcbsp_read(base, OMAP_MCBSP_REG_##reg)
-#define OMAP_MCBSP_WRITE(base, reg, val) \
-                       omap_mcbsp_write(base, OMAP_MCBSP_REG_##reg, val)
-
 #define omap_mcbsp_check_valid_id(id)  (id < omap_mcbsp_count)
 #define id_to_mcbsp_ptr(id)            mcbsp_ptr[id];

diff --git a/include/asm-arm/arch-omap/mcbsp.h b/include/asm-arm/arch-omap/mcbsp.h
index 8fa89c2..cf39ef1 100644
--- a/include/asm-arm/arch-omap/mcbsp.h
+++ b/include/asm-arm/arch-omap/mcbsp.h
@@ -50,6 +50,14 @@
 #define OMAP34XX_MCBSP4_BASE   0x49026000
 #define OMAP34XX_MCBSP5_BASE   0x48096000

+void omap_mcbsp_write(u32 io_base, u16 reg, u32 val);
+int omap_mcbsp_read(u32 io_base, u16 reg);
+
+#define OMAP_MCBSP_READ(base, reg) \
+                       omap_mcbsp_read(base, OMAP_MCBSP_REG_##reg)
+#define OMAP_MCBSP_WRITE(base, reg, val) \
+                       omap_mcbsp_write(base, OMAP_MCBSP_REG_##reg, val)
+
 #if defined(CONFIG_ARCH_OMAP15XX) || defined(CONFIG_ARCH_OMAP16XX) || defined(CONFIG_ARCH_OMAP730)

 #define OMAP_MCBSP_REG_DRR2    0x00
--
1.4.4.4
