From: Tero Kristo <t-kristo@ti.com>
Subject: [PATCH 10/10] crypto: omap-aes: fixup aligned data cleanup
Date: Thu, 17 Oct 2019 15:25:49 +0300
Message-ID: <20191017122549.4634-11-t-kristo@ti.com>
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

Aligned data cleanup is using wrong pointers in the cleanup calls. Most
of the time these are right, but can cause mysterious problems in some
cases. Fix to use the same pointers that were used with the align call.

Signed-off-by: Tero Kristo <t-kristo@ti.com>
---
 drivers/crypto/omap-aes.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/crypto/omap-aes.c b/drivers/crypto/omap-aes.c
index c40876353b19..649abbc92fd4 100644
--- a/drivers/crypto/omap-aes.c
+++ b/drivers/crypto/omap-aes.c
@@ -502,10 +502,10 @@ static void omap_aes_done_task(unsigned long data)
 		omap_aes_crypt_dma_stop(dd);
 	}
 
-	omap_crypto_cleanup(dd->in_sgl, NULL, 0, dd->total_save,
+	omap_crypto_cleanup(dd->in_sg, NULL, 0, dd->total_save,
 			    FLAGS_IN_DATA_ST_SHIFT, dd->flags);
 
-	omap_crypto_cleanup(&dd->out_sgl, dd->orig_out, 0, dd->total_save,
+	omap_crypto_cleanup(dd->out_sg, dd->orig_out, 0, dd->total_save,
 			    FLAGS_OUT_DATA_ST_SHIFT, dd->flags);
 
 	/* Update IV output */
-- 
2.17.1

--
Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki. Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki
