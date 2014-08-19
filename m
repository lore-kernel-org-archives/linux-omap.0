From: Frans Klaver <frans.klaver@xsens.com>
Subject: [PATCH 4/4] tty: omap-serial: support setting of hardware flow control in dts
Date: Tue, 19 Aug 2014 14:14:48 +0200
Message-ID: <1408450488-4083-5-git-send-email-frans.klaver@xsens.com>
References: <1406645577-18620-1-git-send-email-frans.klaver@xsens.com>
 <1408450488-4083-1-git-send-email-frans.klaver@xsens.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1408450488-4083-1-git-send-email-frans.klaver@xsens.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Felipe Balbi <balbi@ti.com>
Cc: Frans Klaver <frans.klaver@xsens.com>, Tony Lindgren <tony@atomide.com>, Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Alexey Pelykh <alexey.pelykh@gmail.com>, Jiri Slaby <jslaby@suse.cz>, Frans Klaver <fransklaver@gmail.com>, linux-serial@vger.kernel.org, linux-omap@vger.kernel.org, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

This makes hardware flow control availability configurable from the
device tree.

Signed-off-by: Frans Klaver <frans.klaver@xsens.com>
---
 Documentation/devicetree/bindings/serial/omap_serial.txt | 1 +
 drivers/tty/serial/omap-serial.c                         | 4 ++++
 2 files changed, 5 insertions(+)

diff --git a/Documentation/devicetree/bindings/serial/omap_serial.txt b/Documentation/devicetree/bindings/serial/omap_serial.txt
index 342eedd..1b629e9 100644
--- a/Documentation/devicetree/bindings/serial/omap_serial.txt
+++ b/Documentation/devicetree/bindings/serial/omap_serial.txt
@@ -8,3 +8,4 @@ Required properties:
 
 Optional properties:
 - clock-frequency : frequency of the clock input to the UART
+- has-hw-flow-control : the hardware has flow control capability
diff --git a/drivers/tty/serial/omap-serial.c b/drivers/tty/serial/omap-serial.c
index 57664b9..7d3b3d2 100644
--- a/drivers/tty/serial/omap-serial.c
+++ b/drivers/tty/serial/omap-serial.c
@@ -1598,6 +1598,10 @@ static struct omap_uart_port_info *of_get_uart_port_info(struct device *dev)
 
 	of_property_read_u32(dev->of_node, "clock-frequency",
 					 &omap_up_info->uartclk);
+
+	if (of_property_read_bool(dev->of_node, "has-hw-flow-control"))
+		omap_up_info->flags |= UPF_HARD_FLOW;
+
 	return omap_up_info;
 }
 
-- 
1.9.3
