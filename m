From: Vignesh R <vigneshr@ti.com>
Subject: [PATCH 3/3] serial: 8250_omap: Use clk_get_rate() to obtain fclk frequency
Date: Wed, 9 Jan 2019 14:42:06 +0530
Message-ID: <20190109091206.25759-4-vigneshr@ti.com>
References: <20190109091206.25759-1-vigneshr@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190109091206.25759-1-vigneshr@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Rob Herring <robh+dt@kernel.org>
Cc: Jiri Slaby <jslaby@suse.com>, Vignesh R <vigneshr@ti.com>, Tony Lindgren <tony@atomide.com>, Lokesh Vutla <lokeshvutla@ti.com>, linux-serial@vger.kernel.org, linux-omap@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

8250_omap driver uses clock-frequency DT property to obtain functional
clk frequency. This is not ideal as users need to calculate functional
clk frequency offline and populate it in DT.
Therefore add support to obtain functional clock frequency using clk
APIs when clock-frequency DT property is not defined.

Suggested-by: Lokesh Vutla <lokeshvutla@ti.com>
Signed-off-by: Vignesh R <vigneshr@ti.com>
---
 drivers/tty/serial/8250/8250_omap.c | 14 +++++++++++++-
 1 file changed, 13 insertions(+), 1 deletion(-)

diff --git a/drivers/tty/serial/8250/8250_omap.c b/drivers/tty/serial/8250/8250_omap.c
index a74126569785..0a8316632d75 100644
--- a/drivers/tty/serial/8250/8250_omap.c
+++ b/drivers/tty/serial/8250/8250_omap.c
@@ -12,6 +12,7 @@
 #define SUPPORT_SYSRQ
 #endif
 
+#include <linux/clk.h>
 #include <linux/device.h>
 #include <linux/io.h>
 #include <linux/module.h>
@@ -1203,7 +1204,18 @@ static int omap8250_probe(struct platform_device *pdev)
 	}
 	up.port.line = ret;
 
-	of_property_read_u32(np, "clock-frequency", &up.port.uartclk);
+	if (of_property_read_u32(np, "clock-frequency", &up.port.uartclk)) {
+		struct clk *clk;
+
+		clk = devm_clk_get(&pdev->dev, NULL);
+		if (IS_ERR(clk)) {
+			if (PTR_ERR(clk) == -EPROBE_DEFER)
+				return -EPROBE_DEFER;
+		} else {
+			up.port.uartclk = clk_get_rate(clk);
+		}
+	}
+
 	priv->wakeirq = irq_of_parse_and_map(np, 1);
 
 	id = of_match_device(of_match_ptr(omap8250_dt_ids), &pdev->dev);
-- 
2.20.1
