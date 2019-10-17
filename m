From: Tero Kristo <t-kristo@ti.com>
Subject: [PATCH 05/10] crypto: omap-aes: add IV output handling
Date: Thu, 17 Oct 2019 15:25:44 +0300
Message-ID: <20191017122549.4634-6-t-kristo@ti.com>
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

Currently omap-aes driver does not copy end result IV out at all. This
is evident with the additional checks done at the crypto test manager.
Fix by copying out the IV values from HW.

Signed-off-by: Tero Kristo <t-kristo@ti.com>
---
 drivers/crypto/omap-aes.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/drivers/crypto/omap-aes.c b/drivers/crypto/omap-aes.c
index 38c750e83dbe..c40876353b19 100644
--- a/drivers/crypto/omap-aes.c
+++ b/drivers/crypto/omap-aes.c
@@ -479,6 +479,14 @@ static int omap_aes_crypt_req(struct crypto_engine *engine,
 	return omap_aes_crypt_dma_start(dd);
 }
 
+static void omap_aes_copy_ivout(struct omap_aes_dev *dd, u8 *ivbuf)
+{
+	int i;
+
+	for (i = 0; i < 4; i++)
+		((u32 *)ivbuf)[i] = omap_aes_read(dd, AES_REG_IV(dd, i));
+}
+
 static void omap_aes_done_task(unsigned long data)
 {
 	struct omap_aes_dev *dd = (struct omap_aes_dev *)data;
@@ -500,6 +508,10 @@ static void omap_aes_done_task(unsigned long data)
 	omap_crypto_cleanup(&dd->out_sgl, dd->orig_out, 0, dd->total_save,
 			    FLAGS_OUT_DATA_ST_SHIFT, dd->flags);
 
+	/* Update IV output */
+	if (dd->flags & (FLAGS_CBC | FLAGS_CTR))
+		omap_aes_copy_ivout(dd, dd->req->iv);
+
 	omap_aes_finish_req(dd, 0);
 
 	pr_debug("exit\n");
-- 
2.17.1

--
Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki. Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki
