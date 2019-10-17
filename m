From: Tero Kristo <t-kristo@ti.com>
Subject: [PATCH 02/10] crypto: omap-sham: remove the sysfs group during driver
 removal
Date: Thu, 17 Oct 2019 15:25:41 +0300
Message-ID: <20191017122549.4634-3-t-kristo@ti.com>
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

The driver removal should also cleanup the created sysfs group. If not,
the driver fails the subsequent probe as the files exist already.

Signed-off-by: Tero Kristo <t-kristo@ti.com>
---
 drivers/crypto/omap-sham.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/crypto/omap-sham.c b/drivers/crypto/omap-sham.c
index 2e9435577cea..0bf07a7c060b 100644
--- a/drivers/crypto/omap-sham.c
+++ b/drivers/crypto/omap-sham.c
@@ -2270,6 +2270,8 @@ static int omap_sham_remove(struct platform_device *pdev)
 	if (!dd->polling_mode)
 		dma_release_channel(dd->dma_lch);
 
+	sysfs_remove_group(&dd->dev->kobj, &omap_sham_attr_group);
+
 	return 0;
 }
 
-- 
2.17.1

--
Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki. Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki
