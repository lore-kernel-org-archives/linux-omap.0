From: Tero Kristo <t-kristo@ti.com>
Subject: [PATCH 06/10] crypto: omap-sham: fix buffer handling for split test
 cases
Date: Thu, 17 Oct 2019 15:25:45 +0300
Message-ID: <20191017122549.4634-7-t-kristo@ti.com>
References: <20191017122549.4634-1-t-kristo@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20191017122549.4634-1-t-kristo@ti.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: herbert@gondor.apana.org.au, davem@davemloft.net, linux-crypto@vger.kernel.org, ard.biesheuvel@linaro.org
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

Current buffer handling logic fails in a case where the buffer contains
existing data from previous update which is divisible by block size.
This results in a block size of data to be left missing from the sg
list going out to the hw accelerator, ending up in stalling the
crypto accelerator driver (the last request never completes fully due
to missing data.)

Fix this by passing the total size of the data instead of the data size
of current request, and also parsing the buffer contents within the
prepare request handling.

Signed-off-by: Tero Kristo <t-kristo@ti.com>
---
 drivers/crypto/omap-sham.c | 15 +++++++++++++--
 1 file changed, 13 insertions(+), 2 deletions(-)

diff --git a/drivers/crypto/omap-sham.c b/drivers/crypto/omap-sham.c
index 0bf07a7c060b..e71cd977b621 100644
--- a/drivers/crypto/omap-sham.c
+++ b/drivers/crypto/omap-sham.c
@@ -740,11 +740,12 @@ static int omap_sham_align_sgs(struct scatterlist *sg,
 	struct scatterlist *sg_tmp = sg;
 	int new_len;
 	int offset = rctx->offset;
+	int bufcnt = rctx->bufcnt;
 
 	if (!sg || !sg->length || !nbytes)
 		return 0;
 
-	new_len = nbytes - offset;
+	new_len = nbytes;
 
 	if (offset)
 		list_ok = false;
@@ -763,6 +764,16 @@ static int omap_sham_align_sgs(struct scatterlist *sg,
 	while (nbytes > 0 && sg_tmp) {
 		n++;
 
+		if (bufcnt) {
+			if (!IS_ALIGNED(bufcnt, bs)) {
+				aligned = false;
+				break;
+			}
+			nbytes -= bufcnt;
+			bufcnt = 0;
+			continue;
+		}
+
 #ifdef CONFIG_ZONE_DMA
 		if (page_zonenum(sg_page(sg_tmp)) != ZONE_DMA) {
 			aligned = false;
@@ -859,7 +870,7 @@ static int omap_sham_prepare_request(struct ahash_request *req, bool update)
 	if (rctx->bufcnt)
 		memcpy(rctx->dd->xmit_buf, rctx->buffer, rctx->bufcnt);
 
-	ret = omap_sham_align_sgs(req->src, nbytes, bs, final, rctx);
+	ret = omap_sham_align_sgs(req->src, rctx->total, bs, final, rctx);
 	if (ret)
 		return ret;
 
-- 
2.17.1

--
Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki. Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki
