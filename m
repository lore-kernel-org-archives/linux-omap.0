From: Tero Kristo <t-kristo@ti.com>
Subject: [PATCH 04/10] crypto: omap-des: add IV output handling
Date: Thu, 17 Oct 2019 15:25:43 +0300
Message-ID: <20191017122549.4634-5-t-kristo@ti.com>
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

Currently omap-des driver does not copy end result IV out at all. This
is evident with the additional checks done at the crypto test manager.
Fix by copying out the IV values from HW.

Signed-off-by: Tero Kristo <t-kristo@ti.com>
---
 drivers/crypto/omap-des.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/crypto/omap-des.c b/drivers/crypto/omap-des.c
index 4c4dbc2b377e..ea82d55ea8c3 100644
--- a/drivers/crypto/omap-des.c
+++ b/drivers/crypto/omap-des.c
@@ -597,6 +597,7 @@ static int omap_des_crypt_req(struct crypto_engine *engine,
 static void omap_des_done_task(unsigned long data)
 {
 	struct omap_des_dev *dd = (struct omap_des_dev *)data;
+	int i;
 
 	pr_debug("enter done_task\n");
 
@@ -615,6 +616,11 @@ static void omap_des_done_task(unsigned long data)
 	omap_crypto_cleanup(&dd->out_sgl, dd->orig_out, 0, dd->total_save,
 			    FLAGS_OUT_DATA_ST_SHIFT, dd->flags);
 
+	if ((dd->flags & FLAGS_CBC) && dd->req->iv)
+		for (i = 0; i < 2; i++)
+			((u32 *)dd->req->iv)[i] =
+				omap_des_read(dd, DES_REG_IV(dd, i));
+
 	omap_des_finish_req(dd, 0);
 
 	pr_debug("exit\n");
-- 
2.17.1

--
Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki. Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki
