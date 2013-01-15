From: "Mark A. Greer" <mgreer@animalcreek.com>
Subject: [PATCH] crypto: omap-sham - Fix compile errors when CONFIG_OF not defined
Date: Tue, 15 Jan 2013 13:53:02 -0700
Message-ID: <1358283182-29392-1-git-send-email-mgreer@animalcreek.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from m1plsmtpa01-03.prod.mesa1.secureserver.net ([64.202.165.4]:36748
	"EHLO m1plsmtpa01-03.prod.mesa1.secureserver.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755012Ab3AOUxM (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 15 Jan 2013 15:53:12 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: herbert@gondor.apana.org.au
Cc: davem@davemloft.net, linux-crypto@vger.kernel.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, "Mark A. Greer" <mgreer@animalcreek.com>

From: "Mark A. Greer" <mgreer@animalcreek.com>

Fix the compile errors created by commit 2545e8d
(crypto: omap-sham - Add Device Tree Support)
when CONFIG_OF is not defined.  This includes
changing omap_sham_get_res_dev() to omap_sham_get_res_of()
and creating an empty version of omap_sham_of_match[].

Signed-off-by: Mark A. Greer <mgreer@animalcreek.com>
---
 drivers/crypto/omap-sham.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/crypto/omap-sham.c b/drivers/crypto/omap-sham.c
index edff981..dc2d354 100644
--- a/drivers/crypto/omap-sham.c
+++ b/drivers/crypto/omap-sham.c
@@ -1607,7 +1607,11 @@ err:
 	return err;
 }
 #else
-static int omap_sham_get_res_dev(struct omap_sham_dev *dd,
+static const struct of_device_id omap_sham_of_match[] = {
+	{},
+};
+
+static int omap_sham_get_res_of(struct omap_sham_dev *dd,
 		struct device *dev, struct resource *res)
 {
 	return -EINVAL;
-- 
1.7.12

