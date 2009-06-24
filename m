From: Magnus Damm <magnus.damm-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: [PATCH 04/07] i2c: rework i2c-pxa suspend_late()/resume_early()
Date: Wed, 24 Jun 2009 18:23:42 +0900
Message-ID: <20090624092342.14276.2946.sendpatchset@rx1.opensource.se>
References: <20090624092306.14276.127.sendpatchset@rx1.opensource.se>
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20090624092306.14276.127.sendpatchset-/W6D1AVitZKvog7CDwlRTrNAH6kLmebB@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: gregkh-l3A5Bk7waGM@public.gmane.org, pavel-+ZI9xUNit7I@public.gmane.org, hskinnemoen-AIFe0yeh4nAAvxtiuMwx3w@public.gmane.org, anemo-7JcRY8pycbNHfZP73Gtkiw@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, rjw-KKrjLPT3xs0@public.gmane.org, stern-nwvwT67g6+6dFdvTe/nMLpVzexx5G7lz@public.gmane.org, ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org, linux-pm-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, akpm-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Magnus Damm <magnus.damm-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, felipe.balbi-xNZwKgViW5gAvxtiuMwx3w@public.gmane.org
List-Id: linux-omap@vger.kernel.org

From: Magnus Damm <damm-AlSX/UN32fvPDbFq/vQRIQ@public.gmane.org>

This patch reworks platform driver power management code
for i2c-pxa from legacy late/early callbacks to dev_pm_ops.

The callbacks are converted for CONFIG_SUSPEND like this:
  suspend_late() -> suspend_noirq()
  resume_early() -> resume_noirq()

Signed-off-by: Magnus Damm <damm-AlSX/UN32fvPDbFq/vQRIQ@public.gmane.org>
---

 Untested but compiles fine.

 drivers/i2c/busses/i2c-pxa.c |   25 +++++++++++++++++--------
 1 file changed, 17 insertions(+), 8 deletions(-)

--- 0001/drivers/i2c/busses/i2c-pxa.c
+++ work/drivers/i2c/busses/i2c-pxa.c	2009-06-01 15:26:06.000000000 +0900
@@ -1135,35 +1135,44 @@ static int __exit i2c_pxa_remove(struct 
 }
 
 #ifdef CONFIG_PM
-static int i2c_pxa_suspend_late(struct platform_device *dev, pm_message_t state)
+static int i2c_pxa_suspend_noirq(struct device *dev)
 {
-	struct pxa_i2c *i2c = platform_get_drvdata(dev);
+	struct platform_device *pdev = to_platform_device(dev);
+	struct pxa_i2c *i2c = platform_get_drvdata(pdev);
+
 	clk_disable(i2c->clk);
+
 	return 0;
 }
 
-static int i2c_pxa_resume_early(struct platform_device *dev)
+static int i2c_pxa_resume_noirq(struct device *dev)
 {
-	struct pxa_i2c *i2c = platform_get_drvdata(dev);
+	struct platform_device *pdev = to_platform_device(dev);
+	struct pxa_i2c *i2c = platform_get_drvdata(pdev);
 
 	clk_enable(i2c->clk);
 	i2c_pxa_reset(i2c);
 
 	return 0;
 }
+
+static struct dev_pm_ops i2c_pxa_dev_pm_ops = {
+	.suspend_noirq = i2c_pxa_suspend_noirq,
+	.resume_noirq = i2c_pxa_resume_noirq,
+};
+
+#define I2C_PXA_DEV_PM_OPS (&i2c_pxa_dev_pm_ops)
 #else
-#define i2c_pxa_suspend_late NULL
-#define i2c_pxa_resume_early NULL
+#define I2C_PXA_DEV_PM_OPS NULL
 #endif
 
 static struct platform_driver i2c_pxa_driver = {
 	.probe		= i2c_pxa_probe,
 	.remove		= __exit_p(i2c_pxa_remove),
-	.suspend_late	= i2c_pxa_suspend_late,
-	.resume_early	= i2c_pxa_resume_early,
 	.driver		= {
 		.name	= "pxa2xx-i2c",
 		.owner	= THIS_MODULE,
+		.pm	= I2C_PXA_DEV_PM_OPS,
 	},
 	.id_table	= i2c_pxa_id_table,
 };
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
