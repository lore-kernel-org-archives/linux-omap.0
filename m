From: Magnus Damm <magnus.damm-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: [PATCH 03/07] dma: rework txx9dmac suspend_late()/resume_early()
Date: Wed, 24 Jun 2009 18:23:33 +0900
Message-ID: <20090624092333.14276.13222.sendpatchset@rx1.opensource.se>
References: <20090624092306.14276.127.sendpatchset@rx1.opensource.se>
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20090624092306.14276.127.sendpatchset-/W6D1AVitZKvog7CDwlRTrNAH6kLmebB@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: gregkh-l3A5Bk7waGM@public.gmane.org, ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org, hskinnemoen-AIFe0yeh4nAAvxtiuMwx3w@public.gmane.org, anemo-7JcRY8pycbNHfZP73Gtkiw@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, akpm-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org, rjw-KKrjLPT3xs0@public.gmane.org, stern-nwvwT67g6+6dFdvTe/nMLpVzexx5G7lz@public.gmane.org, pavel-+ZI9xUNit7I@public.gmane.org, Magnus Damm <magnus.damm-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-pm-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, felipe.balbi-xNZwKgViW5gAvxtiuMwx3w@public.gmane.org
List-Id: linux-omap@vger.kernel.org

From: Magnus Damm <damm-AlSX/UN32fvPDbFq/vQRIQ@public.gmane.org>

This patch reworks platform driver power management code
for txx9dmac from legacy late/early callbacks to dev_pm_ops.

The callbacks are converted for CONFIG_SUSPEND like this:
  suspend_late() -> suspend_noirq()
  resume_early() -> resume_noirq()

Signed-off-by: Magnus Damm <damm-AlSX/UN32fvPDbFq/vQRIQ@public.gmane.org>
---

 Untested but compiles fine.

 drivers/dma/txx9dmac.c |   15 ++++++++++-----
 1 file changed, 10 insertions(+), 5 deletions(-)

--- 0001/drivers/dma/txx9dmac.c
+++ work/drivers/dma/txx9dmac.c	2009-06-01 16:34:23.000000000 +0900
@@ -1287,17 +1287,18 @@ static void txx9dmac_shutdown(struct pla
 	txx9dmac_off(ddev);
 }
 
-static int txx9dmac_suspend_late(struct platform_device *pdev,
-				 pm_message_t mesg)
+static int txx9dmac_suspend_noirq(struct device *dev)
 {
+	struct platform_device *pdev = to_platform_device(dev);
 	struct txx9dmac_dev *ddev = platform_get_drvdata(pdev);
 
 	txx9dmac_off(ddev);
 	return 0;
 }
 
-static int txx9dmac_resume_early(struct platform_device *pdev)
+static int txx9dmac_resume_noirq(struct device *dev)
 {
+	struct platform_device *pdev = to_platform_device(dev);
 	struct txx9dmac_dev *ddev = platform_get_drvdata(pdev);
 	struct txx9dmac_platform_data *pdata = pdev->dev.platform_data;
 	u32 mcr;
@@ -1310,6 +1311,11 @@ static int txx9dmac_resume_early(struct 
 
 }
 
+static struct dev_pm_ops txx9dmac_dev_pm_ops = {
+	.suspend_noirq = txx9dmac_suspend_noirq,
+	.resume_noirq = txx9dmac_resume_noirq,
+};
+
 static struct platform_driver txx9dmac_chan_driver = {
 	.remove		= __exit_p(txx9dmac_chan_remove),
 	.driver = {
@@ -1320,10 +1326,9 @@ static struct platform_driver txx9dmac_c
 static struct platform_driver txx9dmac_driver = {
 	.remove		= __exit_p(txx9dmac_remove),
 	.shutdown	= txx9dmac_shutdown,
-	.suspend_late	= txx9dmac_suspend_late,
-	.resume_early	= txx9dmac_resume_early,
 	.driver = {
 		.name	= "txx9dmac",
+		.pm	= &txx9dmac_dev_pm_ops,
 	},
 };
 
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
