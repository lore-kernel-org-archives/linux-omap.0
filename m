From: Nishanth Menon <nm@ti.com>
Subject: [PATCH 2/2] OMAP2+: TWL: include pm header for init protos
Date: Mon,  3 Jan 2011 12:58:30 -0600
Message-ID: <1294081110-23695-3-git-send-email-nm@ti.com>
References: <1294081110-23695-1-git-send-email-nm@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:51312 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752511Ab1ACS6p (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 3 Jan 2011 13:58:45 -0500
In-Reply-To: <1294081110-23695-1-git-send-email-nm@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony <tony@atomide.com>
Cc: l-o <linux-omap@vger.kernel.org>, l-a <linux-arm-kernel@lists.infradead.org>, Nishanth Menon <nm@ti.com>

twl_init functions are declared in pm.h and used in pm.c
pm.h header defining the protos need to be included to
ensure that omap_twl.c has consistent function definition.
This fixes sparse warning:
arch/arm/mach-omap2/omap_twl.c:237:12: warning: symbol 'omap4_twl_init' was not declared. Should it be static?
arch/arm/mach-omap2/omap_twl.c:256:12: warning: symbol 'omap3_twl_init' was not declared. Should it be static?

Signed-off-by: Nishanth Menon <nm@ti.com>
---
 arch/arm/mach-omap2/omap_twl.c |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap2/omap_twl.c b/arch/arm/mach-omap2/omap_twl.c
index 65ab4e3..00e1d2b 100644
--- a/arch/arm/mach-omap2/omap_twl.c
+++ b/arch/arm/mach-omap2/omap_twl.c
@@ -20,6 +20,8 @@
 
 #include <plat/voltage.h>
 
+#include "pm.h"
+
 #define OMAP3_SRI2C_SLAVE_ADDR		0x12
 #define OMAP3_VDD_MPU_SR_CONTROL_REG	0x00
 #define OMAP3_VDD_CORE_SR_CONTROL_REG	0x01
-- 
1.6.3.3

