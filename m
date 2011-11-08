From: "Govindraj.R" <govindraj.raja@ti.com>
Subject: [PATCH] OMAP2+: Fix Compilation error on current mainline
Date: Tue, 8 Nov 2011 11:58:18 +0530
Message-ID: <1320733698-23411-1-git-send-email-govindraj.raja@ti.com>
References: <4EB7E50D.40406@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:54498 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751678Ab1KHG2v (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 8 Nov 2011 01:28:51 -0500
In-Reply-To: <4EB7E50D.40406@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Tony Lindgren <tony@atomide.com>, Benoit Cousson <b-cousson@ti.com>, Santosh Shilimkar <santosh.shilimkar@ti.com>, "Govindraj.R" <govindraj.raja@ti.com>

Patch to fix below compilation error on latest mainline commit
b32fc0a0629bf5894b35f33554c118aacfd0d1e2 with omap2plus_defconfig.

arch/arm/mach-omap2/omap_l3_noc.c:250: error: 'THIS_MODULE' undeclared here (not in a function)
make[1]: *** [arch/arm/mach-omap2/omap_l3_noc.o] Error 1

Signed-off-by: Govindraj.R <govindraj.raja@ti.com>
---
 arch/arm/mach-omap2/omap_l3_noc.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap2/omap_l3_noc.c b/arch/arm/mach-omap2/omap_l3_noc.c
index c8b1bef..c2cc196 100644
--- a/arch/arm/mach-omap2/omap_l3_noc.c
+++ b/arch/arm/mach-omap2/omap_l3_noc.c
@@ -26,6 +26,7 @@
 #include <linux/interrupt.h>
 #include <linux/kernel.h>
 #include <linux/slab.h>
+#include <linux/module.h>
 
 #include "omap_l3_noc.h"
 
-- 
1.7.4.1

