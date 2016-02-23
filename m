From: Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH 3/3] ARM: omap1/ams-delta: warn about failed regulator enable
Date: Tue, 23 Feb 2016 14:57:53 +0100
Message-ID: <1456235876-4088840-4-git-send-email-arnd@arndb.de>
References: <1456235876-4088840-1-git-send-email-arnd@arndb.de>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1456235876-4088840-1-git-send-email-arnd@arndb.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

The modem pm handler in the ams-delta board uses regulator_enable()
but does not check for a successful return code:

board-ams-delta.c:521:3: error: ignoring return value of 'regulator_enable', declared with attribute warn_unused_result [-Werror=unused-result]

It is not easy to propagate that return code to the callers in
uart_configure_port/uart_suspend_port/uart_resume_port, unless
we change all UART drivers, and it is unclear what those would
do with the return code.

Instead, this patch uses a runtime warning to replace the
compiletime warning. I have checked that the regulator in question
is hardcoded to a fixed-voltage GPIO regulator, and that should
never fail to get enabled if I understand the code right.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 arch/arm/mach-omap1/board-ams-delta.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-omap1/board-ams-delta.c b/arch/arm/mach-omap1/board-ams-delta.c
index 6613a6ff5dbc..6cbc69c92913 100644
--- a/arch/arm/mach-omap1/board-ams-delta.c
+++ b/arch/arm/mach-omap1/board-ams-delta.c
@@ -510,6 +510,7 @@ static void __init ams_delta_init(void)
 static void modem_pm(struct uart_port *port, unsigned int state, unsigned old)
 {
 	struct modem_private_data *priv = port->private_data;
+	int ret;
 
 	if (IS_ERR(priv->regulator))
 		return;
@@ -518,9 +519,16 @@ static void modem_pm(struct uart_port *port, unsigned int state, unsigned old)
 		return;
 
 	if (state == 0)
-		regulator_enable(priv->regulator);
+		ret = regulator_enable(priv->regulator);
 	else if (old == 0)
-		regulator_disable(priv->regulator);
+		ret = regulator_disable(priv->regulator);
+	else
+		ret = 0;
+
+	if (ret)
+		dev_warn(port->dev,
+			 "ams_delta modem_pm: failed to %sable regulator: %d\n",
+			 state ? "dis" : "en", ret);
 }
 
 static struct plat_serial8250_port ams_delta_modem_ports[] = {
-- 
2.7.0
