From: Tero Kristo <t-kristo@ti.com>
Subject: [PATCHv3 04/11] crypto: omap-sham: fix software fallback handling
Date: Thu, 4 Aug 2016 13:28:39 +0300
Message-ID: <1470306526-27219-5-git-send-email-t-kristo@ti.com>
References: <1470306526-27219-1-git-send-email-t-kristo@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-crypto-owner@vger.kernel.org>
In-Reply-To: <1470306526-27219-1-git-send-email-t-kristo@ti.com>
Sender: linux-crypto-owner@vger.kernel.org
To: herbert@gondor.apana.org.au, lokeshvutla@ti.com, davem@davemloft.net, linux-crypto@vger.kernel.org, tony@atomide.com, linux-omap@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

If we have processed any data with the hardware accelerator (digcnt > 0),
we must complete the entire hash by using it. This is because the current
hash value can't be imported to the software fallback algorithm. Otherwise
we end up with wrong hash results.

Signed-off-by: Tero Kristo <t-kristo@ti.com>
---
 drivers/crypto/omap-sham.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/crypto/omap-sham.c b/drivers/crypto/omap-sham.c
index aa71e61..b4f5131 100644
--- a/drivers/crypto/omap-sham.c
+++ b/drivers/crypto/omap-sham.c
@@ -1165,7 +1165,7 @@ static int omap_sham_final(struct ahash_request *req)
 	 * If buffersize is less than 240, we use fallback SW encoding,
 	 * as using DMA + HW in this case doesn't provide any benefit.
 	 */
-	if ((ctx->digcnt + ctx->bufcnt) < 240)
+	if (!ctx->digcnt && ctx->bufcnt < 240)
 		return omap_sham_final_shash(req);
 	else if (ctx->bufcnt)
 		return omap_sham_enqueue(req, OP_FINAL);
-- 
1.9.1
