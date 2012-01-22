From: Paul Walmsley <paul@pwsan.com>
Subject: [PATCH 1/3] ARM: OMAP: PRM: fix missing plat/irqs.h build breakage
Date: Sun, 22 Jan 2012 04:02:31 -0700
Message-ID: <20120122110229.6508.90255.stgit@dusk>
References: <20120122105942.6508.82335.stgit@dusk>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:46336 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751804Ab2AVLDV (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sun, 22 Jan 2012 06:03:21 -0500
In-Reply-To: <20120122105942.6508.82335.stgit@dusk>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: Tero Kristo <t-kristo@ti.com>, Kevin Hilman <khilman@ti.com>

Commit 22f51371f8c35869ed850f46aa76b6cc2b502110 ("ARM: OMAP3: pm: use
prcm chain handler") breaks the build on a 2420-only config, due to
a missing include for plat/irqs.h:

  CC      arch/arm/mach-omap2/prm2xxx_3xxx.o
arch/arm/mach-omap2/prm2xxx_3xxx.c:41:11: error: 'INT_34XX_PRCM_MPU_IRQ' undeclared here (not in a function)

Fix by explicitly including it.

Signed-off-by: Paul Walmsley <paul@pwsan.com>
Cc: Tero Kristo <t-kristo@ti.com>
Cc: Kevin Hilman <khilman@ti.com>
---
 arch/arm/mach-omap2/prm2xxx_3xxx.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap2/prm2xxx_3xxx.c b/arch/arm/mach-omap2/prm2xxx_3xxx.c
index c1c4d86..9ce7654 100644
--- a/arch/arm/mach-omap2/prm2xxx_3xxx.c
+++ b/arch/arm/mach-omap2/prm2xxx_3xxx.c
@@ -19,6 +19,7 @@
 #include "common.h"
 #include <plat/cpu.h>
 #include <plat/prcm.h>
+#include <plat/irqs.h>
 
 #include "vp.h"
 


