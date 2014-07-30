From: Suman Anna <s-anna-l0cyMroinI0@public.gmane.org>
Subject: [PATCHv3 1/5] Documentation: dt: add omap mailbox bindings
Date: Tue, 29 Jul 2014 19:34:35 -0500
Message-ID: <1406680479-18446-2-git-send-email-s-anna@ti.com>
References: <1406680479-18446-1-git-send-email-s-anna@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1406680479-18446-1-git-send-email-s-anna-l0cyMroinI0@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Cc: Jassi Brar <jaswinder.singh-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Dave Gerlach <d-gerlach-l0cyMroinI0@public.gmane.org>, Markus Mayer <markus.mayer-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Pavel Machek <pavel-+ZI9xUNit7I@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, Suman Anna <s-anna-l0cyMroinI0@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Ian Campbell <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>, Kumar Gala <galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

Add the device tree bindings document for OMAP2+ mailbox.

Cc: Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Cc: Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>
Cc: Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>
Cc: Ian Campbell <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>
Cc: Kumar Gala <galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
Signed-off-by: Suman Anna <s-anna-l0cyMroinI0@public.gmane.org>
---
 .../devicetree/bindings/mailbox/omap-mailbox.txt   | 108 +++++++++++++++++++++
 1 file changed, 108 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/mailbox/omap-mailbox.txt

diff --git a/Documentation/devicetree/bindings/mailbox/omap-mailbox.txt b/Documentation/devicetree/bindings/mailbox/omap-mailbox.txt
new file mode 100644
index 0000000..48edc4b
--- /dev/null
+++ b/Documentation/devicetree/bindings/mailbox/omap-mailbox.txt
@@ -0,0 +1,108 @@
+OMAP2+ Mailbox Driver
+=====================
+
+The OMAP mailbox hardware facilitates communication between different processors
+using a queued mailbox interrupt mechanism. The IP block is external to the
+various processor subsystems and is connected on an interconnect bus. The
+communication is achieved through a set of registers for message storage and
+interrupt configuration registers.
+
+Each mailbox IP block has a certain number of h/w fifo queues and output
+interrupt lines. An output interrupt line is routed to an interrupt controller
+within a processor subsystem, and there can be more than one line going to a
+specific processor's interrupt controller. The interrupt line connections are
+fixed for an instance and are dictated by the IP integration into the SoC
+(excluding the SoCs that have a Interrupt Crossbar IP). Each interrupt line is
+programmable through a set of interrupt configuration registers, and have a rx
+and tx interrupt source per h/w fifo. Communication between different processors
+is achieved through the appropriate programming of the rx and tx interrupt
+sources on the appropriate interrupt lines.
+
+The number of h/w fifo queues and interrupt lines dictate the usable registers.
+All the current OMAP SoCs except for the newest DRA7xx SoC has a single IP
+instance. DRA7xx has multiple instances with different number of h/w fifo queues
+and interrupt lines between different instances. The interrupt lines can also be
+routed to different processor sub-systems on DRA7xx as they are routed through
+the Crossbar, a kind of interrupt router/multiplexer.
+
+Mailbox Device Node:
+====================
+A Mailbox device node is used to represent a Mailbox IP instance within a SoC.
+The sub-mailboxes are represented as child nodes of this parent node.
+
+Required properties:
+--------------------
+- compatible:		Should be one of the following,
+			    "ti,omap2-mailbox" for OMAP2420, OMAP2430 SoCs
+			    "ti,omap3-mailbox" for OMAP3430, OMAP3630 SoCs
+			    "ti,omap4-mailbox" for OMAP44xx, OMAP54xx, AM33xx,
+						   AM43xx and DRA7xx SoCs
+- reg:			Contains the mailbox register address range (base
+			address and length)
+- interrupts:		Contains the interrupt information for the mailbox
+			device. The format is dependent on which interrupt
+			controller the OMAP device uses
+- ti,hwmods:		Name of the hwmod associated with the mailbox
+- ti,mbox-num-users:	Number of targets (processor devices) that the mailbox
+			device can interrupt
+- ti,mbox-num-fifos:	Number of h/w fifo queues within the mailbox IP block
+
+Child Nodes:
+============
+A child node is used for representing the actual sub-mailbox device that is
+used for the communication between the host processor and a remote processor.
+Each child node should have a unique node name across all the different
+mailbox device nodes.
+
+Required properties:
+--------------------
+- ti,mbox-tx:		sub-mailbox descriptor property defining a Tx fifo
+- ti,mbox-rx:		sub-mailbox descriptor property defining a Rx fifo
+
+Sub-mailbox Descriptor Data
+---------------------------
+Each of the above ti,mbox-tx and ti,mbox-rx properties should have 3 cells of
+data that represent the following:
+    Cell #1 (fifo_id) - mailbox fifo id used either for transmitting
+                        (ti,mbox-tx) or for receiving (ti,mbox-rx)
+    Cell #2 (irq_id)  - irq identifier index number to use from the parent's
+                        interrupts data. Should be 0 for most of the cases, a
+                        positive index value is seen only on mailboxes that have
+                        multiple interrupt lines connected to the MPU processor.
+    Cell #3 (usr_id)  - mailbox user id for identifying the interrupt line
+                        associated with generating a tx/rx fifo interrupt.
+
+Example:
+--------
+
+/* OMAP4 */
+mailbox: mailbox@4a0f4000 {
+	compatible = "ti,omap4-mailbox";
+	reg = <0x4a0f4000 0x200>;
+	interrupts = <GIC_SPI 26 IRQ_TYPE_LEVEL_HIGH>;
+	ti,hwmods = "mailbox";
+	ti,mbox-num-users = <3>;
+	ti,mbox-num-fifos = <8>;
+	mbox_ipu: mbox_ipu {
+		ti,mbox-tx = <0 0 0>;
+		ti,mbox-rx = <1 0 0>;
+	};
+	mbox_dsp: mbox_dsp {
+		ti,mbox-tx = <3 0 0>;
+		ti,mbox-rx = <2 0 0>;
+	};
+};
+
+/* AM33xx */
+mailbox: mailbox@480C8000 {
+	compatible = "ti,omap4-mailbox";
+	reg = <0x480C8000 0x200>;
+	interrupts = <77>;
+	ti,hwmods = "mailbox";
+	ti,mbox-num-users = <4>;
+	ti,mbox-num-fifos = <8>;
+	mbox_wkupm3: wkup_m3 {
+		ti,mbox-tx = <0 0 0>;
+		ti,mbox-rx = <0 0 3>;
+	};
+};
-- 
2.0.0

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
