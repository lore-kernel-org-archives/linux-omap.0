From: Janusz Krzysztofik <jkrzyszt@tis.icnet.pl>
Subject: [PATCH v3 0.1/5(7)] OMAP: add missing FIQ_START definition required for arch/arm/plat-omap/fiq.c compilation
Date: Thu, 15 Apr 2010 04:23:04 +0200
Message-ID: <201004150423.06202.jkrzyszt@tis.icnet.pl>
References: <201004150419.05038.jkrzyszt@tis.icnet.pl>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from d1.icnet.pl ([212.160.220.21]:37736 "EHLO d1.icnet.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755493Ab0DOCZJ (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 14 Apr 2010 22:25:09 -0400
In-Reply-To: <201004150419.05038.jkrzyszt@tis.icnet.pl>
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Tony Lindgren <tony@atomide.com>, e3-hacking@earth.li

Several ARM platforms/machines that use FIQ define their value of FIQ_START. 
Since FIQ is not implemented for OMAP yet, this definition is missing from 
OMAP header files.

Put an arbitrary value for FIQ_START into plat/irqs.h for OMAP. Even if not 
used by the WiP FIQ handler for Amstrad Delta, this is required for 
successfull compilation of arch/arm/plat-omap/fiq.c that provides several 
usefull functions.

Even if prepended in front of the Amstrad Delta FIQ patch set, can be applied 
alone in advance as well, possibly as a fix.

Created and tested against linux-2.6.34-rc4.

Signed-off-by: Janusz Krzysztofik <jkrzyszt@tis.icnet.pl>
---

 arch/arm/plat-omap/include/plat/irqs.h |    4 ++++
 1 file changed, 4 insertions(+)

--- git.orig/arch/arm/plat-omap/include/plat/irqs.h	2010-04-14 03:07:16.000000000 +0200
+++ git/arch/arm/plat-omap/include/plat/irqs.h	2010-04-14 22:28:05.000000000 +0200
@@ -430,4 +430,8 @@ void omap3_intc_resume_idle(void);
 
 #include <mach/hardware.h>
 
+#ifdef CONFIG_FIQ
+#define FIQ_START		1024
+#endif
+
 #endif
