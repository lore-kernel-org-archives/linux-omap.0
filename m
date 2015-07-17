From: Dave Gerlach <d-gerlach@ti.com>
Subject: [PATCH v2 2/3] Documentation: dt: add bindings for TI Wakeup M3 IPC
 device
Date: Fri, 17 Jul 2015 15:56:31 -0500
Message-ID: <1437166592-25378-3-git-send-email-d-gerlach@ti.com>
References: <1437166592-25378-1-git-send-email-d-gerlach@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1437166592-25378-1-git-send-email-d-gerlach@ti.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org
Cc: Dave Gerlach <d-gerlach@ti.com>, Tony Lindgren <tony@atomide.com>, Keerthy <j-keerthy@ti.com>, Jassi Brar <jassisinghbrar@gmail.com>, Santosh Shilimkar <ssantosh@kernel.org>
List-Id: linux-omap@vger.kernel.org

Add the device tree bindings document for the TI Wakeup M3 IPC
device on AM33xx and AM43xx SoCs. These devices are used by the
TI wkup_m3_ipc driver, and contain the registers upon which the
IPC protocol to communicate with the Wakeup M3 processor is
implemented.

Signed-off-by: Dave Gerlach <d-gerlach@ti.com>
Signed-off-by: Suman Anna <s-anna@ti.com>
---
 .../devicetree/bindings/soc/ti/wkup_m3_ipc.txt     | 57 ++++++++++++++++++++++
 1 file changed, 57 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/soc/ti/wkup_m3_ipc.txt

diff --git a/Documentation/devicetree/bindings/soc/ti/wkup_m3_ipc.txt b/Documentation/devicetree/bindings/soc/ti/wkup_m3_ipc.txt
new file mode 100644
index 0000000..4015504
--- /dev/null
+++ b/Documentation/devicetree/bindings/soc/ti/wkup_m3_ipc.txt
@@ -0,0 +1,57 @@
+Wakeup M3 IPC Driver
+=====================
+
+The TI AM33xx and AM43xx family of devices use a small Cortex M3 co-processor
+(commonly referred to as Wakeup M3 or CM3) to help with various low power tasks
+that cannot be controlled from the MPU, like suspend/resume and certain deep
+C-states for CPU Idle. Once the wkup_m3_ipc driver uses the wkup_m3_rproc driver
+to boot the wkup_m3, it handles communication with the CM3 using IPC registers
+present in the SoC's control module and a mailbox. The wkup_m3_ipc exposes an
+API to allow the SoC PM code to execute specific PM tasks.
+
+Wkup M3 Device Node:
+====================
+A wkup_m3_ipc device node is used to represent the IPC registers within an
+SoC.
+
+Required properties:
+--------------------
+- compatible:		Should be,
+				"ti,am3352-wkup-m3-ipc" for AM33xx SoCs
+				"ti,am4372-wkup-m3-ipc" for AM43xx SoCs
+- reg:			Contains the IPC register address space to communicate
+			with the Wakeup M3 processor
+- interrupts:		Contains the interrupt information for the wkup_m3
+			interrupt that signals the MPU.
+- ti,rproc:		phandle to the wkup_m3 rproc node so the IPC driver
+			can boot it.
+- mboxes:		phandles used by IPC framework to get correct mbox
+			channel for communication. Must point to appropriate
+			mbox_wkupm3 child node.
+
+Example:
+--------
+/* AM33xx */
+	l4_wkup: l4_wkup@44c00000 {
+		...
+
+		scm: scm@210000 {
+			compatible = "ti,am3-scm", "simple-bus";
+			reg = <0x210000 0x2000>;
+			#address-cells = <1>;
+			#size-cells = <1>;
+			ranges = <0 0x210000 0x2000>;
+
+			...
+
+			wkup_m3_ipc: wkup_m3_ipc@1324 {
+				compatible = "ti,am3352-wkup-m3-ipc";
+				reg = <0x1324 0x24>;
+				interrupts = <78>;
+				ti,rproc = <&wkup_m3>;
+				mboxes = <&mailbox &mbox_wkupm3>;
+			};
+
+			...
+		};
+	};
-- 
2.4.5
