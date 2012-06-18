From: Konstantin Baydarov <kbaidarov@dev.rtsoft.ru>
Subject: [RFC PATCH v2 04/11] OMAP2+: use control module mfd driver in omap_type
Date: Mon, 18 Jun 2012 15:32:22 +0400
Message-ID: <4FDF11C6.6000400@dev.rtsoft.ru>
References: <1337934361-1606-1-git-send-email-eduardo.valentin@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail.dev.rtsoft.ru ([213.79.90.226]:48618 "HELO
	mail.dev.rtsoft.ru" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1751246Ab2FRLcZ (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 18 Jun 2012 07:32:25 -0400
In-Reply-To: <1337934361-1606-1-git-send-email-eduardo.valentin@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: b-cousson@ti.com, kishon@ti.com, kbaidarov@dev.rtsoft.ru, santosh.shilimkar@ti.com, tony@atomide.com, paul@pwsan.com
Cc: balbi@ti.com, amit.kucheria@linaro.org, linux-pm@lists.linux-foundation.org, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, amit.kachhap@linaro.org, Eduardo Valentin <eduardo.valentin@ti.com>

OMAP system control module can be probed early, then
omap_type is safe to use its APIs.

TODO: add support for other omap versions

Signed-off-by: Konstantin Baydarov <kbaidarov@dev.rtsoft.ru>

---
 arch/arm/mach-omap2/id.c |    5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

Index: linux-2.6/arch/arm/mach-omap2/id.c
===================================================================
--- linux-2.6.orig/arch/arm/mach-omap2/id.c
+++ linux-2.6/arch/arm/mach-omap2/id.c
@@ -18,6 +18,7 @@
 #include <linux/kernel.h>
 #include <linux/init.h>
 #include <linux/io.h>
+#include <linux/mfd/omap_control.h>
 
 #include <asm/cputype.h>
 
@@ -38,6 +39,8 @@ unsigned int omap_rev(void)
 }
 EXPORT_SYMBOL(omap_rev);
 
+u32 omap_control_readl(u16 offset);
+
 int omap_type(void)
 {
 	u32 val = 0;
@@ -49,7 +52,7 @@ int omap_type(void)
 	} else if (cpu_is_omap34xx()) {
 		val = omap_ctrl_readl(OMAP343X_CONTROL_STATUS);
 	} else if (cpu_is_omap44xx()) {
-		val = omap_ctrl_readl(OMAP4_CTRL_MODULE_CORE_STATUS);
+		val = omap_control_readl(OMAP4_CTRL_MODULE_CORE_STATUS);
 	} else {
 		pr_err("Cannot detect omap type!\n");
 		goto out;
