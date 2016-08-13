From: Sebastian Reichel <sre@kernel.org>
Subject: [RFC 1/7] tty: serial: omap: add UPF_BOOT_AUTOCONF flag for DT init
Date: Sat, 13 Aug 2016 05:14:32 +0200
Message-ID: <1471058078-5579-2-git-send-email-sre@kernel.org>
References: <1471058078-5579-1-git-send-email-sre@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1471058078-5579-1-git-send-email-sre@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Sebastian Reichel <sre@kernel.org>, Tony Lindgren <tony@atomide.com>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Marcel Holtmann <marcel@holtmann.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>
Cc: Ville Tervo <ville.tervo@iki.fi>, =?UTF-8?q?Filip=20Matijevi=C4=87?= <filip.matijevic.pz@gmail.com>, Aaro Koskinen <aaro.koskinen@iki.fi>, Pavel Machek <pavel@ucw.cz>, =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali.rohar@gmail.com>, ivo.g.dimitrov.75@gmail.com, linux-bluetooth@vger.kernel.org, linux-serial@vger.kernel.org, linux-omap@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

---
 drivers/tty/serial/omap-serial.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/tty/serial/omap-serial.c b/drivers/tty/serial/omap-serial.c
index a2a529994ba5..7c2c77789c2c 100644
--- a/drivers/tty/serial/omap-serial.c
+++ b/drivers/tty/serial/omap-serial.c
@@ -1542,6 +1542,9 @@ static struct omap_uart_port_info *of_get_uart_port_info(struct device *dev)
 
 	of_property_read_u32(dev->of_node, "clock-frequency",
 					 &omap_up_info->uartclk);
+
+	omap_up_info->flags = UPF_BOOT_AUTOCONF;
+
 	return omap_up_info;
 }
 
-- 
2.8.1
