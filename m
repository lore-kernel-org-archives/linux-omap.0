From: Adam Ford <aford173@gmail.com>
Subject: [RFC 1/5] usb: musb: am35x: Add device tree support
Date: Sun, 24 Jun 2018 19:12:29 -0500
Message-ID: <20180625001233.9785-2-aford173@gmail.com>
References: <20180625001233.9785-1-aford173@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20180625001233.9785-1-aford173@gmail.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: adam.ford@logicpd.com
Cc: mark.rutland@arm.com, devicetree@vger.kernel.org, tony@atomide.com, gregkh@linuxfoundation.org, linux-usb@vger.kernel.org, linux@armlinux.org.uk, robh+dt@kernel.org, bcousson@baylibre.com, linux-omap@vger.kernel.org, Adam Ford <aford173@gmail.com>, b-liu@ti.com, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

The AM35x glue doesn't yet support device tree, so this patch
adds the basics hooks so it doesn't haven't use pdata-quirks.c

Signed-off-by: Adam Ford <aford173@gmail.com>

diff --git a/drivers/usb/musb/am35x.c b/drivers/usb/musb/am35x.c
index 660641ab1545..a55db15a8457 100644
--- a/drivers/usb/musb/am35x.c
+++ b/drivers/usb/musb/am35x.c
@@ -591,6 +591,16 @@ static int am35x_resume(struct device *dev)
 }
 #endif
 
+#ifdef CONFIG_OF
+static const struct of_device_id am35xx_id_table[] = {
+	{
+		.compatible = "ti,am35xx-musb"
+	},
+	{},
+};
+MODULE_DEVICE_TABLE(of, am35xx_id_table);
+#endif
+
 static SIMPLE_DEV_PM_OPS(am35x_pm_ops, am35x_suspend, am35x_resume);
 
 static struct platform_driver am35x_driver = {
@@ -599,6 +609,7 @@ static struct platform_driver am35x_driver = {
 	.driver		= {
 		.name	= "musb-am35x",
 		.pm	= &am35x_pm_ops,
+		.of_match_table = of_match_ptr(am35xx_id_table),
 	},
 };
 
-- 
2.17.1
