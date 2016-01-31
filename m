From: Sebastian Reichel <sre@kernel.org>
Subject: [PATCH 4/5] HSI: nokia-modem: drop support for disabled pm
Date: Sun, 31 Jan 2016 02:19:46 +0100
Message-ID: <1454203187-688-5-git-send-email-sre@kernel.org>
References: <1454203187-688-1-git-send-email-sre@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1454203187-688-1-git-send-email-sre@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Sebastian Reichel <sre@kernel.org>, Tony Lindgren <tony@atomide.com>, =?UTF-8?q?Beno=C3=AEt=20Cousson?= <bcousson@baylibre.com>, Aaro Koskinen <aaro.koskinen@iki.fi>
Cc: =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali.rohar@gmail.com>, Pavel Machek <pavel@ucw.cz>, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

Disabled power management means, that the driver can only be
used together with further out-of-tree kernel patches. There
is no reason to support this in the mainline kernel and not
having support for it means, that userspace can automatically
detect if we are running kernel based power management.

Signed-off-by: Sebastian Reichel <sre@kernel.org>
---
 drivers/hsi/clients/nokia-modem.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/hsi/clients/nokia-modem.c b/drivers/hsi/clients/nokia-modem.c
index 1b4a250cf113..5e333eb82912 100644
--- a/drivers/hsi/clients/nokia-modem.c
+++ b/drivers/hsi/clients/nokia-modem.c
@@ -33,7 +33,7 @@
 static unsigned int pm = 1;
 module_param(pm, int, 0400);
 MODULE_PARM_DESC(pm,
-	"Enable power management (0=disabled, 1=userland based [default], 2=kernel based)");
+	"Enable power management (1=userland based [default], 2=kernel based)");
 
 struct nokia_modem_device {
 	struct tasklet_struct	nokia_modem_rst_ind_tasklet;
@@ -198,6 +198,11 @@ static int nokia_modem_gpio_probe(struct device *dev)
 	struct nokia_modem_device *modem = dev_get_drvdata(dev);
 	int gpio_count, gpio_name_count, i, err;
 
+	if (pm != 1 && pm != 2) {
+		dev_err(dev, "invalid pm configuration!");
+		return -EINVAL;
+	}
+
 	gpio_count = of_gpio_count(np);
 
 	if (gpio_count < 0) {
-- 
2.7.0.rc3
