From: Julia Lawall <Julia.Lawall@lip6.fr>
Subject: [PATCH 1/6] ASoC: omap: simplify
	platform_get_resource_byname/devm_ioremap_resource
Date: Mon, 19 Aug 2013 10:51:51 +0200
Message-ID: <1376902316-18520-2-git-send-email-Julia.Lawall@lip6.fr>
References: <1376902316-18520-1-git-send-email-Julia.Lawall@lip6.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
In-Reply-To: <1376902316-18520-1-git-send-email-Julia.Lawall@lip6.fr>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Peter Ujfalusi <peter.ujfalusi@ti.com>
Cc: alsa-devel@alsa-project.org, Takashi Iwai <tiwai@suse.de>, linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, linux-omap@vger.kernel.org, Jarkko Nikula <jarkko.nikula@bitmer.com>
List-Id: linux-omap@vger.kernel.org

From: Julia Lawall <Julia.Lawall@lip6.fr>

Remove unneeded error handling on the result of a call to
platform_get_resource_byname when the value is passed to devm_ioremap_resource.

In the case of omap-dmic.c, the error-handling code of
devm_ioremap_resource is also corrected to include releasing the clock.

A simplified version of the semantic patch that makes this change is as
follows: (http://coccinelle.lip6.fr/)

// <smpl>
@@
expression pdev,res,e,e1;
expression ret != 0;
identifier l;
@@

  res = platform_get_resource_byname(...);
- if (res == NULL) { ... \(goto l;\|return ret;\) }
  e = devm_ioremap_resource(e1, res);
// </smpl>

Signed-off-by: Julia Lawall <Julia.Lawall@lip6.fr>

---
 sound/soc/omap/omap-dmic.c  |    9 +++------
 sound/soc/omap/omap-mcpdm.c |    3 ---
 2 files changed, 3 insertions(+), 9 deletions(-)

diff --git a/sound/soc/omap/omap-dmic.c b/sound/soc/omap/omap-dmic.c
index 4db1f8e..12e566b 100644
--- a/sound/soc/omap/omap-dmic.c
+++ b/sound/soc/omap/omap-dmic.c
@@ -480,15 +480,12 @@ static int asoc_dmic_probe(struct platform_device *pdev)
 	dmic->dma_data.filter_data = "up_link";
 
 	res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "mpu");
-	if (!res) {
-		dev_err(dmic->dev, "invalid memory resource\n");
-		ret = -ENODEV;
+	dmic->io_base = devm_ioremap_resource(&pdev->dev, res);
+	if (IS_ERR(dmic->io_base)) {
+		ret = PTR_ERR(dmic->io_base);
 		goto err_put_clk;
 	}
 
-	dmic->io_base = devm_ioremap_resource(&pdev->dev, res);
-	if (IS_ERR(dmic->io_base))
-		return PTR_ERR(dmic->io_base);
 
 	ret = snd_soc_register_component(&pdev->dev, &omap_dmic_component,
 					 &omap_dmic_dai, 1);
diff --git a/sound/soc/omap/omap-mcpdm.c b/sound/soc/omap/omap-mcpdm.c
index a49dc52..90d2a7c 100644
--- a/sound/soc/omap/omap-mcpdm.c
+++ b/sound/soc/omap/omap-mcpdm.c
@@ -480,9 +480,6 @@ static int asoc_mcpdm_probe(struct platform_device *pdev)
 	mcpdm->dma_data[1].filter_data = "up_link";
 
 	res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "mpu");
-	if (res == NULL)
-		return -ENOMEM;
-
 	mcpdm->io_base = devm_ioremap_resource(&pdev->dev, res);
 	if (IS_ERR(mcpdm->io_base))
 		return PTR_ERR(mcpdm->io_base);
