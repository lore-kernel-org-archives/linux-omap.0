From: Tero Kristo <t-kristo@ti.com>
Subject: [PATCH 3/8] soc: ti: omap-prm: poll for reset complete during
 de-assert
Date: Wed, 7 Aug 2019 10:48:54 +0300
Message-ID: <1565164139-21886-4-git-send-email-t-kristo@ti.com>
References: <1565164139-21886-1-git-send-email-t-kristo@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1565164139-21886-1-git-send-email-t-kristo@ti.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: ssantosh@kernel.org, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, robh+dt@kernel.org
Cc: tony@atomide.com, devicetree@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

Poll for reset completion status during de-assertion of reset, otherwise
the IP in question might be accessed before it has left reset properly.

Signed-off-by: Tero Kristo <t-kristo@ti.com>
---
 drivers/soc/ti/omap_prm.c | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/drivers/soc/ti/omap_prm.c b/drivers/soc/ti/omap_prm.c
index 7c89eb8..d412af3 100644
--- a/drivers/soc/ti/omap_prm.c
+++ b/drivers/soc/ti/omap_prm.c
@@ -107,6 +107,7 @@ static int omap_reset_deassert(struct reset_controller_dev *rcdev,
 	u32 v;
 	int st_bit = id;
 	bool has_rstst;
+	int timeout = 0;
 
 	/* check the current status to avoid de-asserting the line twice */
 	v = readl_relaxed(reset->prm->base + reset->prm->data->rstctl);
@@ -129,6 +130,22 @@ static int omap_reset_deassert(struct reset_controller_dev *rcdev,
 	v &= ~(1 << id);
 	writel_relaxed(v, reset->prm->base + reset->prm->data->rstctl);
 
+	if (!has_rstst)
+		return 0;
+
+	/* wait for the status to be set */
+	while (1) {
+		v = readl_relaxed(reset->prm->base + reset->prm->data->rstst);
+		v &= 1 << st_bit;
+		if (v)
+			break;
+		timeout++;
+		if (timeout > OMAP_RESET_MAX_WAIT)
+			return -EBUSY;
+
+		udelay(1);
+	}
+
 	return 0;
 }
 
-- 
1.9.1

--
Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki. Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki
