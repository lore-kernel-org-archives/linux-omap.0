From: "Mark A. Greer" <mgreer@animalcreek.com>
Subject: [PATCH v2 01/10] crypto: omap-aes - Remmove unnecessary pr_info noise
Date: Tue,  8 Jan 2013 11:57:38 -0700
Message-ID: <1357671467-32363-2-git-send-email-mgreer@animalcreek.com>
References: <1357671467-32363-1-git-send-email-mgreer@animalcreek.com>
Return-path: <linux-crypto-owner@vger.kernel.org>
In-Reply-To: <1357671467-32363-1-git-send-email-mgreer@animalcreek.com>
Sender: linux-crypto-owner@vger.kernel.org
To: davem@davemloft.net, herbert@gondor.apana.org.au
Cc: linux-crypto@vger.kernel.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, russ.dill@gmail.com, "Mark A. Greer" <mgreer@animalcreek.com>, Dmitry Kasatkin <dmitry.kasatkin@intel.com>
List-Id: linux-omap@vger.kernel.org

From: "Mark A. Greer" <mgreer@animalcreek.com>

Remove the unnecessary pr_info() calls from omap_aes_probe()
and omap_aes_mod_init().

CC: Dmitry Kasatkin <dmitry.kasatkin@intel.com>
Signed-off-by: Mark A. Greer <mgreer@animalcreek.com>
---
 drivers/crypto/omap-aes.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/drivers/crypto/omap-aes.c b/drivers/crypto/omap-aes.c
index e66e8ee..481da71 100644
--- a/drivers/crypto/omap-aes.c
+++ b/drivers/crypto/omap-aes.c
@@ -880,8 +880,6 @@ static int omap_aes_probe(struct platform_device *pdev)
 			goto err_algs;
 	}
 
-	pr_info("probe() done\n");
-
 	return 0;
 err_algs:
 	for (j = 0; j < i; j++)
@@ -938,8 +936,6 @@ static struct platform_driver omap_aes_driver = {
 
 static int __init omap_aes_mod_init(void)
 {
-	pr_info("loading %s driver\n", "omap-aes");
-
 	return  platform_driver_register(&omap_aes_driver);
 }
 
-- 
1.7.12
