From: Julia Lawall <Julia.Lawall@lip6.fr>
Subject: [PATCH 3/7] omapfb: fix error return code
Date: Sat, 26 Dec 2015 16:28:42 +0100
Message-ID: <1451143726-28195-4-git-send-email-Julia.Lawall@lip6.fr>
References: <1451143726-28195-1-git-send-email-Julia.Lawall@lip6.fr>
Return-path: <kernel-janitors-owner@vger.kernel.org>
In-Reply-To: <1451143726-28195-1-git-send-email-Julia.Lawall@lip6.fr>
Sender: kernel-janitors-owner@vger.kernel.org
To: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: kernel-janitors@vger.kernel.org, Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>, linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

Return a negative error code on failure.

A simplified version of the semantic match that finds this problem is as
follows: (http://coccinelle.lip6.fr/)

// <smpl>
@@
identifier ret; expression e1,e2;
@@
(
if (\(ret < 0\|ret != 0\))
 { ... return ret; }
|
ret = 0
)
... when != ret = e1
    when != &ret
*if(...)
{
  ... when != ret = e2
      when forall
 return ret;
}
// </smpl>

Signed-off-by: Julia Lawall <Julia.Lawall@lip6.fr>

---
 drivers/video/fbdev/omap2/omapfb/displays/encoder-tpd12s015.c |   12 +++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/drivers/video/fbdev/omap2/omapfb/displays/encoder-tpd12s015.c b/drivers/video/fbdev/omap2/omapfb/displays/encoder-tpd12s015.c
index 677e254..fc4cfa9 100644
--- a/drivers/video/fbdev/omap2/omapfb/displays/encoder-tpd12s015.c
+++ b/drivers/video/fbdev/omap2/omapfb/displays/encoder-tpd12s015.c
@@ -241,22 +241,28 @@ static int tpd_probe(struct platform_device *pdev)
 
 	gpio = devm_gpiod_get_index_optional(&pdev->dev, NULL, 0,
 		GPIOD_OUT_LOW);
-	if (IS_ERR(gpio))
+	if (IS_ERR(gpio)) {
+		r = PTR_ERR(gpio);
 		goto err_gpio;
+	}
 
 	ddata->ct_cp_hpd_gpio = gpio;
 
 	gpio = devm_gpiod_get_index_optional(&pdev->dev, NULL, 1,
 		GPIOD_OUT_LOW);
-	if (IS_ERR(gpio))
+	if (IS_ERR(gpio)) {
+		r = PTR_ERR(gpio);
 		goto err_gpio;
+	}
 
 	ddata->ls_oe_gpio = gpio;
 
 	gpio = devm_gpiod_get_index(&pdev->dev, NULL, 2,
 		GPIOD_IN);
-	if (IS_ERR(gpio))
+	if (IS_ERR(gpio)) {
+		r = PTR_ERR(gpio);
 		goto err_gpio;
+	}
 
 	ddata->hpd_gpio = gpio;
 

