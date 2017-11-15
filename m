From: "H. Nikolaus Schaller" <hns@goldelico.com>
Subject: [PATCH v3 2/5] DT: misc serdev: w2sg0004: add bindings documentation
 (GPS module with serdev UART)
Date: Wed, 15 Nov 2017 16:19:10 +0100
Message-ID: <876b6e7256bbf23cbff7fb2e67c33730592a4990.1510759152.git.hns@goldelico.com>
References: <cover.1510759152.git.hns@goldelico.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <cover.1510759152.git.hns@goldelico.com>
In-Reply-To: <cover.1510759152.git.hns@goldelico.com>
References: <cover.1510759152.git.hns@goldelico.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, =?UTF-8?q?Beno=C3=AEt=20Cousson?= <bcousson@baylibre.com>, Tony Lindgren <tony@atomide.com>, Russell King <linux@armlinux.org.uk>, Arnd Bergmann <arnd@arndb.de>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "H. Nikolaus Schaller" <hns@goldelico.com>, Kevin Hilman <khilman@baylibre.com>, =?UTF-8?q?Andreas=20F=C3=A4rber?= <afaerber@suse.de>, Thierry Reding <treding@nvidia.com>, Jonathan Cameron <jic23@kernel.org>
Cc: devicetree@vger.kernel.org, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, kernel@pyra-handheld.com, letux-kernel@openphoenux.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

add bindings documentation for Wi2Wi W2SG00x4 GPS module

Signed-off-by: H. Nikolaus Schaller <hns@goldelico.com>
---
 .../devicetree/bindings/misc/wi2wi,w2sg0004.txt    | 24 ++++++++++++++++++++++
 1 file changed, 24 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/misc/wi2wi,w2sg0004.txt

diff --git a/Documentation/devicetree/bindings/misc/wi2wi,w2sg0004.txt b/Documentation/devicetree/bindings/misc/wi2wi,w2sg0004.txt
new file mode 100644
index 000000000000..ccec9361a1a4
--- /dev/null
+++ b/Documentation/devicetree/bindings/misc/wi2wi,w2sg0004.txt
@@ -0,0 +1,24 @@
+Wi2Wi GPS module connected through UART
+
+Should be a subnode of the SoC UART it is connected to (serdev).
+
+Required properties:
+- compatible:	should be one of (depending on precise model)
+	"wi2wi,w2sg0004"
+	"wi2wi,w2sg0084"
+- enable-gpio:	the GPIO that controls the module's power toggle
+	input. A positive impulse of sufficent length toggles the
+	power state.
+
+Optional properties:
+- lna-supply:	an (optional) LNA regulator that is enabled together with the GPS receiver
+
+Example:
+
+&uart2 {
+	w2sg0004: gps {
+		compatible = "wi2wi,w2sg0004";
+		lna-supply = <&vsim>;   /* LNA regulator */
+		enable-gpios = <&gpio5 17 GPIO_ACTIVE_HIGH>;    /* GPIO_145: trigger for turning on/off w2sg0004 */
+        };
+};
-- 
2.12.2
