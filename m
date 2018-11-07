From: Janusz Krzysztofik <jmkrzyszt@gmail.com>
Subject: [PATCH] ARM: OMAP1: ams-delta: Fix possible use of uninitialized field
Date: Wed,  7 Nov 2018 22:30:31 +0100
Message-ID: <20181107213031.21650-1-jmkrzyszt@gmail.com>
Return-path: <stable-owner@vger.kernel.org>
Sender: stable-owner@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Aaro Koskinen <aaro.koskinen@iki.fi>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org, Janusz Krzysztofik <jmkrzyszt@gmail.com>
List-Id: linux-omap@vger.kernel.org

While playing with initialization order of modem device, it has been
discovered that under some circumstances (early console init, I
believe) its .pm() callback may be called before the
uart_port->private_data pointer is initialized from
plat_serial8250_port->private_data, resulting in NULL pointer
dereference.  Fix it by checking for uninitialized pointer before using
it in modem_pm().

Fixes: aabf31737a6a ("ARM: OMAP1: ams-delta: update the modem to use regulator API")
Signed-off-by: Janusz Krzysztofik <jmkrzyszt@gmail.com>
---
 arch/arm/mach-omap1/board-ams-delta.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/arm/mach-omap1/board-ams-delta.c b/arch/arm/mach-omap1/board-ams-delta.c
index 1947bc63074e..17e0b386e1b2 100644
--- a/arch/arm/mach-omap1/board-ams-delta.c
+++ b/arch/arm/mach-omap1/board-ams-delta.c
@@ -764,6 +764,9 @@ static void modem_pm(struct uart_port *port, unsigned int state, unsigned old)
 	struct modem_private_data *priv = port->private_data;
 	int ret;
 
+	if (!priv)
+		return;
+
 	if (IS_ERR(priv->regulator))
 		return;
 
-- 
2.16.4
