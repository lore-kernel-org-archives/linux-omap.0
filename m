From: Roger Quadros <rogerq@ti.com>
Subject: [PATCH 06/16] dt-bindings: remoteproc: ti-pruss: Update bindings for supporting rpmsg
Date: Mon, 26 Nov 2018 09:52:39 +0200
Message-ID: <1543218769-5507-7-git-send-email-rogerq@ti.com>
References: <1543218769-5507-1-git-send-email-rogerq@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1543218769-5507-1-git-send-email-rogerq@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: ohad@wizery.com, bjorn.andersson@linaro.org
Cc: tony@atomide.com, robh+dt@kernel.org, bcousson@baylibre.com, ssantosh@kernel.org, s-anna@ti.com, nsekhar@ti.com, t-kristo@ti.com, nsaulnier@ti.com, jreeder@ti.com, m-karicheri2@ti.com, woods.technical@gmail.com, linux-omap@vger.kernel.org, linux-remoteproc@vger.kernel.org, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, rogerq@ti.com
List-Id: linux-omap@vger.kernel.org

From: Suman Anna <s-anna@ti.com>

Update the PRUSS DT bindings to add the properties required to support the
optional virtio rpmsg stack using the virtio-ring based communication
transport between MPU and a PRU core.

Signed-off-by: Suman Anna <s-anna@ti.com>
---
 .../devicetree/bindings/soc/ti/ti,pruss.txt        | 39 ++++++++++++++++++++++
 1 file changed, 39 insertions(+)

diff --git a/Documentation/devicetree/bindings/soc/ti/ti,pruss.txt b/Documentation/devicetree/bindings/soc/ti/ti,pruss.txt
index 24fedad..3e5f32f 100644
--- a/Documentation/devicetree/bindings/soc/ti/ti,pruss.txt
+++ b/Documentation/devicetree/bindings/soc/ti/ti,pruss.txt
@@ -175,6 +175,32 @@ Required Properties:
 - firmware-name  : should contain the name of the default firmware image file
                    located on the firmware search path
 
+Optional Properties:
+--------------------
+The virtio based communication between the MPU and a PRU core _requires_
+either the 'mboxes' property, or the set of 'interrupt-parent', 'interrupts'
+and 'interrupt-names' properties to be defined. The latter option is the
+preferred choice. The 'mboxes' property is not applicable for 66AK2G and
+DA850/OMAP-L138 SoCs.
+
+- mboxes           : OMAP Mailbox specifier denoting the sub-mailbox, if using
+                     a mailbox for IPC signalling between host and a PRU core.
+                     The specifier format is as per the bindings,
+                         Documentation/devicetree/bindings/mailbox/omap-mailbox.txt
+                     This property should match with the sub-mailbox node used
+                     in the corresponding firmware image.
+- interrupt-parent : phandle to the PRUSS INTC node. Should be defined if
+                     interrupts property is to be used.
+- interrupts       : array of interrupt specifiers if using PRU system events
+                     for IPC signalling between host and a PRU core. This
+                     property should match with the PRU system event used in
+                     the corresponding firmware image.
+- interrupt-names  : should use one of the following names for each interrupt,
+                     the name should match the corresponding PRU system event
+                     number,
+                         "vring" - for PRU to HOST virtqueue signalling
+                         "kick"  - for HOST to PRU virtqueue signalling
+
 
 MDIO Child Node
 ================
@@ -243,6 +269,9 @@ Example:
 				      <0x4a322400 0x100>;
 				reg-names = "iram", "control", "debug";
 				firmware-name = "am335x-pru0-fw";
+				interrupt-parent = <&pruss_intc>;
+				interrupts = <16>, <17>;
+				interrupt-names = "vring", "kick";
 			};
 
 			pru1: pru@4a338000 {
@@ -252,6 +281,10 @@ Example:
 				      <0x4a324400 0x100>;
 				reg-names = "iram", "control", "debug";
 				firmware-name = "am335x-pru1-fw";
+				interrupt-parent = <&pruss_intc>;
+				interrupts = <18>, <19>;
+				interrupt-names = "vring", "kick";
+				/* mboxes = <&mailbox &mbox_pru1>; */
 			};
 
 			pruss_mdio: mdio@4a332400 {
@@ -329,6 +362,9 @@ Example:
 				      <0x54422400 0x100>;
 				reg-names = "iram", "control", "debug";
 				firmware-name = "am437x-pru1_0-fw";
+				interrupt-parent = <&pruss1_intc>;
+				interrupts = <16>, <17>;
+				interrupt-names = "vring", "kick";
 			};
 
 			pru1_1: pru@54438000 {
@@ -338,6 +374,9 @@ Example:
 				      <0x54424400 0x100>;
 				reg-names = "iram", "control", "debug";
 				firmware-name = "am437x-pru1_1-fw";
+				interrupt-parent = <&pruss1_intc>;
+				interrupts = <18>, <19>;
+				interrupt-names = "vring", "kick";
 			};
 
 			pruss1_mdio: mdio@54432400 {
-- 
Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki
