From: Kishon Vijay Abraham I <kishon@ti.com>
Subject: [RESEND PATCH] gpio: pcf857x: restore the initial line state of all pcf lines
Date: Fri, 27 May 2016 12:05:29 +0530
Message-ID: <1464330929-10910-1-git-send-email-kishon@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-gpio-owner@vger.kernel.org>
Sender: linux-gpio-owner@vger.kernel.org
To: linus.walleij@linaro.org, gnurou@gmail.com, linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org
Cc: nsekhar@ti.com, kishon@ti.com
List-Id: linux-omap@vger.kernel.org

The reset values for all the PCF lines are high and hence on
shutdown we should drive all the lines high in order to
bring it to the reset state.

This is actually required since PCF doesn't have a reset
line and even after warm reset (by invoking "reboot" in
prompt) the PCF lines maintains it's previous programmed
state. This becomes a problem if the boards are designed to
work with the default initial state.

DRA7XX_evm uses PCF8575 and one of the PCF output lines
feeds to MMC/SD VDD and this line should be driven high in order
for the MMC/SD to be detected.  This line is modelled as
regulator and the hsmmc driver takes care of enabling and
disabling it. In the case of 'reboot', during shutdown path
as part of it's cleanup process the hsmmc driver disables
this regulator. This makes MMC *boot* not functional.

Fix it by driving all the pcf lines high.

Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
Signed-off-by: Sekhar Nori <nsekhar@ti.com>
---
This patch was sent long back [1].
But there was a concern that contention might occur if the
PCF shutdown handler is invoked before the shutdown handler
of the PCF's consumers. In that case PCF shutdown handler can't
drive all the pcf lines high without knowing if the PCF
consumers are still active.

However commit 52cdbdd4985 ("driver core: correct device's
shutdown order") will make sure shutdown handler of PCF's
consumers are invoked before invoking the shutdown
handler of PCF. So it should be safe to merge this now.

[1] -> https://patchwork.ozlabs.org/patch/420382/

 drivers/gpio/gpio-pcf857x.c |    9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/gpio/gpio-pcf857x.c b/drivers/gpio/gpio-pcf857x.c
index 169c09a..d168410 100644
--- a/drivers/gpio/gpio-pcf857x.c
+++ b/drivers/gpio/gpio-pcf857x.c
@@ -440,6 +440,14 @@ static int pcf857x_remove(struct i2c_client *client)
 	return status;
 }
 
+static void pcf857x_shutdown(struct i2c_client *client)
+{
+	struct pcf857x *gpio = i2c_get_clientdata(client);
+
+	/* Drive all the I/O lines high */
+	gpio->write(gpio->client, BIT(gpio->chip.ngpio) - 1);
+}
+
 static struct i2c_driver pcf857x_driver = {
 	.driver = {
 		.name	= "pcf857x",
@@ -447,6 +455,7 @@ static struct i2c_driver pcf857x_driver = {
 	},
 	.probe	= pcf857x_probe,
 	.remove	= pcf857x_remove,
+	.shutdown = pcf857x_shutdown,
 	.id_table = pcf857x_id,
 };
 
-- 
1.7.9.5

