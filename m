From: "Mark A. Greer" <mgreer@animalcreek.com>
Subject: [PATCH 1/9] crypto: omap-sham - Remove unnecessary pr_info noise
Date: Fri, 21 Dec 2012 10:04:01 -0700
Message-ID: <1356109449-11624-2-git-send-email-mgreer@animalcreek.com>
References: <1356109449-11624-1-git-send-email-mgreer@animalcreek.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail20.dotsterhost.com ([66.11.232.73]:48750 "EHLO
	mail20.dotsterhost.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751745Ab2LURES (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 21 Dec 2012 12:04:18 -0500
In-Reply-To: <1356109449-11624-1-git-send-email-mgreer@animalcreek.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: davem@davemloft.net, herbert@gondor.apana.org.au
Cc: linux-crypto@vger.kernel.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, "Mark A. Greer" <mgreer@animalcreek.com>, Dmitry Kasatkin <dmitry.kasatkin@intel.com>

From: "Mark A. Greer" <mgreer@animalcreek.com>

Remove the unnecessary pr_info() call in omap_sham_mod_init().

CC: Dmitry Kasatkin <dmitry.kasatkin@intel.com>
Signed-off-by: Mark A. Greer <mgreer@animalcreek.com>
---
 drivers/crypto/omap-sham.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/crypto/omap-sham.c b/drivers/crypto/omap-sham.c
index 1d75e6f..2df7a54 100644
--- a/drivers/crypto/omap-sham.c
+++ b/drivers/crypto/omap-sham.c
@@ -1286,8 +1286,6 @@ static struct platform_driver omap_sham_driver = {
 
 static int __init omap_sham_mod_init(void)
 {
-	pr_info("loading %s driver\n", "omap-sham");
-
 	return platform_driver_register(&omap_sham_driver);
 }
 
-- 
1.7.12

