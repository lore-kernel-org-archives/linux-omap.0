From: Keerthy <j-keerthy-l0cyMroinI0@public.gmane.org>
Subject: [PATCH 2/5] drivers: gpio: Add support for multiple IPs
Date: Wed, 19 Oct 2016 11:03:56 +0530
Message-ID: <1476855239-32730-3-git-send-email-j-keerthy@ti.com>
References: <1476855239-32730-1-git-send-email-j-keerthy@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1476855239-32730-1-git-send-email-j-keerthy-l0cyMroinI0@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org
Cc: gnurou-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, lokeshvutla-l0cyMroinI0@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, linux-gpio-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, rogerq-l0cyMroinI0@public.gmane.org, grygorii.strashko-l0cyMroinI0@public.gmane.org, j-keerthy-l0cyMroinI0@public.gmane.org
List-Id: linux-omap@vger.kernel.org

From: Lokesh Vutla <lokeshvutla-l0cyMroinI0@public.gmane.org>

Update GPIO driver to support Multiple GPIO IPs.

Signed-off-by: Lokesh Vutla <lokeshvutla-l0cyMroinI0@public.gmane.org>
Signed-off-by: Keerthy <j-keerthy-l0cyMroinI0@public.gmane.org>
---
 drivers/gpio/gpio-davinci.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/gpio/gpio-davinci.c b/drivers/gpio/gpio-davinci.c
index 419cfaf..2654dae 100644
--- a/drivers/gpio/gpio-davinci.c
+++ b/drivers/gpio/gpio-davinci.c
@@ -183,6 +183,7 @@ static int davinci_gpio_probe(struct platform_device *pdev)
 	struct davinci_gpio_regs __iomem *regs;
 	struct device *dev = &pdev->dev;
 	struct resource *res;
+	static int bank_base;
 
 	pdata = davinci_gpio_get_pdata(pdev);
 	if (!pdata) {
@@ -226,7 +227,8 @@ static int davinci_gpio_probe(struct platform_device *pdev)
 		chips[i].chip.direction_output = davinci_direction_out;
 		chips[i].chip.set = davinci_gpio_set;
 
-		chips[i].chip.base = base;
+		chips[i].chip.base = bank_base;
+		bank_base += 32;
 		chips[i].chip.ngpio = ngpio - base;
 		if (chips[i].chip.ngpio > 32)
 			chips[i].chip.ngpio = 32;
-- 
1.9.1

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
