From: Kevin Hilman <khilman@linaro.org>
Subject: [PATCH] ARM: OMAP2+: SmartReflex: soc.h is needed for omap initcalls
Date: Tue, 12 Feb 2013 14:23:56 -0800
Message-ID: <1360707836-2545-1-git-send-email-khilman@linaro.org>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-pa0-f45.google.com ([209.85.220.45]:64779 "EHLO
	mail-pa0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752035Ab3BLWX7 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 12 Feb 2013 17:23:59 -0500
Received: by mail-pa0-f45.google.com with SMTP id kl14so344691pab.4
        for <linux-omap@vger.kernel.org>; Tue, 12 Feb 2013 14:23:59 -0800 (PST)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

commit aa4f99638b (ARM: OMAP2+: Use omap initcalls) converted
the initcalls here, but did not #include "soc.h" where the omap
inicalls are defined.

To fix, #include <soc.h>

Signed-off-by: Kevin Hilman <khilman@linaro.org>
---
Tony, the patch that broke this was introduced in your
omap-for-v3.9/multiplatform-enable-signed branch, and this problem was
found only when compiling with PM (specifically, SmartReflex) enabled.

 arch/arm/mach-omap2/smartreflex-class3.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/mach-omap2/smartreflex-class3.c b/arch/arm/mach-omap2/smartreflex-class3.c
index 80f3acb..b2dcbd3 100644
--- a/arch/arm/mach-omap2/smartreflex-class3.c
+++ b/arch/arm/mach-omap2/smartreflex-class3.c
@@ -13,6 +13,7 @@
 
 #include <linux/power/smartreflex.h>
 #include "voltage.h"
+#include "soc.h"
 
 static int sr_class3_enable(struct omap_sr *sr)
 {
-- 
1.8.1.2

