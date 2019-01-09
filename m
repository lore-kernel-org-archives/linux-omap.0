From: Vignesh R <vigneshr@ti.com>
Subject: [PATCH 2/3] dt-bindings: serial: omap_serial: add clocks entry
Date: Wed, 9 Jan 2019 14:42:05 +0530
Message-ID: <20190109091206.25759-3-vigneshr@ti.com>
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

Document clocks property used to pass phandle to functional clk.

Signed-off-by: Vignesh R <vigneshr@ti.com>
---
 Documentation/devicetree/bindings/serial/omap_serial.txt | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/serial/omap_serial.txt b/Documentation/devicetree/bindings/serial/omap_serial.txt
index c35d5ece1156..0a9b5444f4e6 100644
--- a/Documentation/devicetree/bindings/serial/omap_serial.txt
+++ b/Documentation/devicetree/bindings/serial/omap_serial.txt
@@ -22,6 +22,8 @@ Optional properties:
 - dma-names : "rx" for receive channel, "tx" for transmit channel.
 - rs485-rts-delay, rs485-rx-during-tx, linux,rs485-enabled-at-boot-time: see rs485.txt
 - rs485-rts-active-high: drive RTS high when sending (default is low).
+- clocks: phandle to the functional clock as per
+  Documentation/devicetree/bindings/clock/clock-bindings.txt
 
 Example:
 
-- 
2.20.1
