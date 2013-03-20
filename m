From: Laurent Navet <laurent.navet@gmail.com>
Subject: [PATCH 06/10] gpio: gpio-sch.c: fix checkpatch error
Date: Wed, 20 Mar 2013 13:16:00 +0100
Message-ID: <1363781764-17330-7-git-send-email-laurent.navet@gmail.com>
References: <1363781764-17330-1-git-send-email-laurent.navet@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1363781764-17330-1-git-send-email-laurent.navet@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: grant.likely@secretlab.ca, linus.walleij@linaro.org
Cc: santosh.shilimkar@ti.com, khilman@ti.com, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, Laurent Navet <laurent.navet@gmail.com>
List-Id: linux-omap@vger.kernel.org

Fix :
 gpio/gpio-sch.c:206: ERROR: switch and case should be at the same indent

Also remove blank lines

Signed-off-by: Laurent Navet <laurent.navet@gmail.com>
---
 drivers/gpio/gpio-sch.c |   74 ++++++++++++++++++++++-------------------------
 1 file changed, 35 insertions(+), 39 deletions(-)

diff --git a/drivers/gpio/gpio-sch.c b/drivers/gpio/gpio-sch.c
index edae963..cb60081 100644
--- a/drivers/gpio/gpio-sch.c
+++ b/drivers/gpio/gpio-sch.c
@@ -204,45 +204,41 @@ static int sch_gpio_probe(struct platform_device *pdev)
 	gpio_ba = res->start;
 
 	switch (id) {
-		case PCI_DEVICE_ID_INTEL_SCH_LPC:
-			sch_gpio_core.base = 0;
-			sch_gpio_core.ngpio = 10;
-
-			sch_gpio_resume.base = 10;
-			sch_gpio_resume.ngpio = 4;
-
-			/*
-			 * GPIO[6:0] enabled by default
-			 * GPIO7 is configured by the CMC as SLPIOVR
-			 * Enable GPIO[9:8] core powered gpios explicitly
-			 */
-			outb(0x3, gpio_ba + CGEN + 1);
-			/*
-			 * SUS_GPIO[2:0] enabled by default
-			 * Enable SUS_GPIO3 resume powered gpio explicitly
-			 */
-			outb(0x8, gpio_ba + RGEN);
-			break;
-
-		case PCI_DEVICE_ID_INTEL_ITC_LPC:
-			sch_gpio_core.base = 0;
-			sch_gpio_core.ngpio = 5;
-
-			sch_gpio_resume.base = 5;
-			sch_gpio_resume.ngpio = 9;
-			break;
-
-		case PCI_DEVICE_ID_INTEL_CENTERTON_ILB:
-			sch_gpio_core.base = 0;
-			sch_gpio_core.ngpio = 21;
-
-			sch_gpio_resume.base = 21;
-			sch_gpio_resume.ngpio = 9;
-			break;
-
-		default:
-			err = -ENODEV;
-			goto err_sch_gpio_core;
+	case PCI_DEVICE_ID_INTEL_SCH_LPC:
+		sch_gpio_core.base = 0;
+		sch_gpio_core.ngpio = 10;
+		sch_gpio_resume.base = 10;
+		sch_gpio_resume.ngpio = 4;
+		/*
+		 * GPIO[6:0] enabled by default
+		 * GPIO7 is configured by the CMC as SLPIOVR
+		 * Enable GPIO[9:8] core powered gpios explicitly
+		 */
+		outb(0x3, gpio_ba + CGEN + 1);
+		/*
+		 * SUS_GPIO[2:0] enabled by default
+		 * Enable SUS_GPIO3 resume powered gpio explicitly
+		 */
+		outb(0x8, gpio_ba + RGEN);
+		break;
+
+	case PCI_DEVICE_ID_INTEL_ITC_LPC:
+		sch_gpio_core.base = 0;
+		sch_gpio_core.ngpio = 5;
+		sch_gpio_resume.base = 5;
+		sch_gpio_resume.ngpio = 9;
+		break;
+
+	case PCI_DEVICE_ID_INTEL_CENTERTON_ILB:
+		sch_gpio_core.base = 0;
+		sch_gpio_core.ngpio = 21;
+		sch_gpio_resume.base = 21;
+		sch_gpio_resume.ngpio = 9;
+		break;
+
+	default:
+		err = -ENODEV;
+		goto err_sch_gpio_core;
 	}
 
 	sch_gpio_core.dev = &pdev->dev;
-- 
1.7.10.4
