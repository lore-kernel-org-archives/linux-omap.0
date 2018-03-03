From: Martin Blumenstingl <martin.blumenstingl-gM/Ye1E23mwN+BqQ9rBEUg@public.gmane.org>
Subject: [usb-next PATCH v11 1/8] dt-bindings: usb: add the documentation for
 USB HCDs
Date: Sat,  3 Mar 2018 22:43:02 +0100
Message-ID: <20180303214309.25643-2-martin.blumenstingl@googlemail.com>
References: <20180303214309.25643-1-martin.blumenstingl@googlemail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-mediatek-bounces+glpam-linux-mediatek=m.gmane.org-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
In-Reply-To: <20180303214309.25643-1-martin.blumenstingl-gM/Ye1E23mwN+BqQ9rBEUg@public.gmane.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-mediatek>,
 <mailto:linux-mediatek-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-mediatek/>
List-Post: <mailto:linux-mediatek-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Help: <mailto:linux-mediatek-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-mediatek>,
 <mailto:linux-mediatek-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=subscribe>
Sender: "Linux-mediatek" <linux-mediatek-bounces-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
Errors-To: linux-mediatek-bounces+glpam-linux-mediatek=m.gmane.org-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
To: linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, mathias.nyman-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, arnd-r2nGTMty4D4@public.gmane.org, gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org, felipe.balbi-VuQAYsv1563Yd54FQh9/CA@public.gmane.org
Cc: mark.rutland-5wv7dgnIgG8@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Peter.Chen-3arQi8VN3Tc@public.gmane.org, Martin Blumenstingl <martin.blumenstingl-gM/Ye1E23mwN+BqQ9rBEUg@public.gmane.org>, narmstrong-rdvid1DuHRBWk0Htik3J/w@public.gmane.org, yixun.lan-LpR1jeaWuhtBDgjK7y7TUQ@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, jonathanh-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org, linux-ci5G2KO2hbZ+pU9mqzGVBQ@public.gmane.org, matthias.bgg-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, linux-mediatek-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-amlogic-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, stern-nwvwT67g6+6dFdvTe/nMLpVzexx5G7lz@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: linux-omap@vger.kernel.org

A USB HCD may have several PHYs which need to be configured before the
the HCD starts working.
This adds the documentation for such a USB HCD as well as a reference to
the new "usb-hcd.txt" from all bindings that implement a USB HCD which
support one USB PHY per port.

Signed-off-by: Martin Blumenstingl <martin.blumenstingl-gM/Ye1E23mwN+BqQ9rBEUg@public.gmane.org>
Reviewed-by: Rob Herring <robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Tested-by: Yixun Lan <yixun.lan-LpR1jeaWuhtBDgjK7y7TUQ@public.gmane.org>
---
 Documentation/devicetree/bindings/usb/mediatek,mtk-xhci.txt | 5 ++++-
 Documentation/devicetree/bindings/usb/mediatek,mtu3.txt     | 5 ++++-
 Documentation/devicetree/bindings/usb/usb-ehci.txt          | 6 ++++--
 Documentation/devicetree/bindings/usb/usb-hcd.txt           | 9 +++++++++
 Documentation/devicetree/bindings/usb/usb-ohci.txt          | 6 ++++--
 Documentation/devicetree/bindings/usb/usb-uhci.txt          | 3 +++
 Documentation/devicetree/bindings/usb/usb-xhci.txt          | 5 +++++
 7 files changed, 33 insertions(+), 6 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/usb/usb-hcd.txt

diff --git a/Documentation/devicetree/bindings/usb/mediatek,mtk-xhci.txt b/Documentation/devicetree/bindings/usb/mediatek,mtk-xhci.txt
index 88d9f4a4b280..266c2d917a28 100644
--- a/Documentation/devicetree/bindings/usb/mediatek,mtk-xhci.txt
+++ b/Documentation/devicetree/bindings/usb/mediatek,mtk-xhci.txt
@@ -32,7 +32,7 @@ Required properties:
 	"mcu_ck": mcu_bus clock for register access,
 	"dma_ck": dma_bus clock for data transfer by DMA
 
- - phys : a list of phandle + phy specifier pairs
+ - phys : see usb-hcd.txt in the current directory
 
 Optional properties:
  - wakeup-source : enable USB remote wakeup;
@@ -52,6 +52,9 @@ Optional properties:
 	See: Documentation/devicetree/bindings/pinctrl/pinctrl-bindings.txt
  - imod-interval-ns: default interrupt moderation interval is 5000ns
 
+additionally the properties from usb-hcd.txt (in the current directory) are
+supported.
+
 Example:
 usb30: usb@11270000 {
 	compatible = "mediatek,mt8173-xhci";
diff --git a/Documentation/devicetree/bindings/usb/mediatek,mtu3.txt b/Documentation/devicetree/bindings/usb/mediatek,mtu3.txt
index d589a1ef96a1..3382b5cb471d 100644
--- a/Documentation/devicetree/bindings/usb/mediatek,mtu3.txt
+++ b/Documentation/devicetree/bindings/usb/mediatek,mtu3.txt
@@ -17,7 +17,7 @@ Required properties:
  - clock-names : must contain "sys_ck" for clock of controller,
 	the following clocks are optional:
 	"ref_ck", "mcu_ck" and "dam_ck";
- - phys : a list of phandle + phy specifier pairs
+ - phys : see usb-hcd.txt in the current directory
  - dr_mode : should be one of "host", "peripheral" or "otg",
 	refer to usb/generic.txt
 
@@ -53,6 +53,9 @@ Optional properties:
  - mediatek,u3p-dis-msk : mask to disable u3ports, bit0 for u3port0,
 	bit1 for u3port1, ... etc;
 
+additionally the properties from usb-hcd.txt (in the current directory) are
+supported.
+
 Sub-nodes:
 The xhci should be added as subnode to mtu3 as shown in the following example
 if host mode is enabled. The DT binding details of xhci can be found in:
diff --git a/Documentation/devicetree/bindings/usb/usb-ehci.txt b/Documentation/devicetree/bindings/usb/usb-ehci.txt
index 3efde12b5d68..0f1b75386207 100644
--- a/Documentation/devicetree/bindings/usb/usb-ehci.txt
+++ b/Documentation/devicetree/bindings/usb/usb-ehci.txt
@@ -16,10 +16,12 @@ Optional properties:
  - has-transaction-translator : boolean, set this if EHCI have a Transaction
 				Translator built into the root hub.
  - clocks : a list of phandle + clock specifier pairs
- - phys : phandle + phy specifier pair
- - phy-names : "usb"
+ - phys : see usb-hcd.txt in the current directory
  - resets : phandle + reset specifier pair
 
+additionally the properties from usb-hcd.txt (in the current directory) are
+supported.
+
 Example (Sequoia 440EPx):
     ehci@e0000300 {
 	   compatible = "ibm,usb-ehci-440epx", "usb-ehci";
diff --git a/Documentation/devicetree/bindings/usb/usb-hcd.txt b/Documentation/devicetree/bindings/usb/usb-hcd.txt
new file mode 100644
index 000000000000..50529b838c9c
--- /dev/null
+++ b/Documentation/devicetree/bindings/usb/usb-hcd.txt
@@ -0,0 +1,9 @@
+Generic USB HCD (Host Controller Device) Properties
+
+Optional properties:
+- phys: a list of all USB PHYs on this HCD
+
+Example:
+	&usb1 {
+		phys = <&usb2_phy1>, <&usb3_phy1>;
+	};
diff --git a/Documentation/devicetree/bindings/usb/usb-ohci.txt b/Documentation/devicetree/bindings/usb/usb-ohci.txt
index 09e70c875bc6..a8d2103d1f3d 100644
--- a/Documentation/devicetree/bindings/usb/usb-ohci.txt
+++ b/Documentation/devicetree/bindings/usb/usb-ohci.txt
@@ -13,10 +13,12 @@ Optional properties:
 - remote-wakeup-connected: remote wakeup is wired on the platform
 - num-ports : u32, to override the detected port count
 - clocks : a list of phandle + clock specifier pairs
-- phys : phandle + phy specifier pair
-- phy-names : "usb"
+- phys : see usb-hcd.txt in the current directory
 - resets : a list of phandle + reset specifier pairs
 
+additionally the properties from usb-hcd.txt (in the current directory) are
+supported.
+
 Example:
 
 	ohci0: usb@1c14400 {
diff --git a/Documentation/devicetree/bindings/usb/usb-uhci.txt b/Documentation/devicetree/bindings/usb/usb-uhci.txt
index 298133416c97..cc2e6f7d602e 100644
--- a/Documentation/devicetree/bindings/usb/usb-uhci.txt
+++ b/Documentation/devicetree/bindings/usb/usb-uhci.txt
@@ -6,6 +6,9 @@ Required properties:
 - reg : Should contain 1 register ranges(address and length)
 - interrupts : UHCI controller interrupt
 
+additionally the properties from usb-hcd.txt (in the current directory) are
+supported.
+
 Example:
 
 	uhci@d8007b00 {
diff --git a/Documentation/devicetree/bindings/usb/usb-xhci.txt b/Documentation/devicetree/bindings/usb/usb-xhci.txt
index e2ea59bbca93..2f7663bb69ff 100644
--- a/Documentation/devicetree/bindings/usb/usb-xhci.txt
+++ b/Documentation/devicetree/bindings/usb/usb-xhci.txt
@@ -32,6 +32,11 @@ Optional properties:
   - usb3-lpm-capable: determines if platform is USB3 LPM capable
   - quirk-broken-port-ped: set if the controller has broken port disable mechanism
   - imod-interval-ns: default interrupt moderation interval is 5000ns
+  - phys : see usb-hcd.txt in the current directory
+
+additionally the properties from usb-hcd.txt (in the current directory) are
+supported.
+
 
 Example:
 	usb@f0931000 {
-- 
2.16.2
