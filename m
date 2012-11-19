From: "Mark A. Greer" <mgreer@animalcreek.com>
Subject: [PATCH v4 5/8] crypto: omap-sham: Remove cpu_is/omap_type check from driver
Date: Mon, 19 Nov 2012 11:54:58 -0700
Message-ID: <1353351301-6453-6-git-send-email-mgreer@animalcreek.com>
References: <1353351301-6453-1-git-send-email-mgreer@animalcreek.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail20.dotsterhost.com ([66.11.232.73]:47668 "EHLO
	mail20.dotsterhost.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754258Ab2KSS4D (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 19 Nov 2012 13:56:03 -0500
In-Reply-To: <1353351301-6453-1-git-send-email-mgreer@animalcreek.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: linux-crypto@vger.kernel.org, herbert@gondor.apana.org.au, davem@davemloft.net, dmitry.kasatkin@intel.com, rmk+kernel@arm.linux.org.uk, paul@pwsan.com, khilman@deeprootsystems.com, "Mark A. Greer" <mgreer@animalcreek.com>

From: "Mark A. Greer" <mgreer@animalcreek.com>

The omap-sham driver should not check the CPU class or the
type of OMAP device its on.  The platform code should do
that instead.

CC: Paul Walmsley <paul@pwsan.com>
CC: Dmitry Kasatkin <dmitry.kasatkin@intel.com>
Signed-off-by: Mark A. Greer <mgreer@animalcreek.com>
---
 drivers/crypto/omap-sham.c | 8 --------
 1 file changed, 8 deletions(-)

diff --git a/drivers/crypto/omap-sham.c b/drivers/crypto/omap-sham.c
index a3fd6fc..f50387c 100644
--- a/drivers/crypto/omap-sham.c
+++ b/drivers/crypto/omap-sham.c
@@ -37,7 +37,6 @@
 #include <crypto/hash.h>
 #include <crypto/internal/hash.h>
 
-#include <plat/cpu.h>
 #include <plat/dma.h>
 #include <mach/irqs.h>
 
@@ -1289,13 +1288,6 @@ static int __init omap_sham_mod_init(void)
 {
 	pr_info("loading %s driver\n", "omap-sham");
 
-	if (!cpu_class_is_omap2() ||
-		(omap_type() != OMAP2_DEVICE_TYPE_SEC &&
-			omap_type() != OMAP2_DEVICE_TYPE_EMU)) {
-		pr_err("Unsupported cpu\n");
-		return -ENODEV;
-	}
-
 	return platform_driver_register(&omap_sham_driver);
 }
 
-- 
1.7.12

