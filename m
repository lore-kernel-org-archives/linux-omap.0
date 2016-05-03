From: Franklin S Cooper Jr <fcooper@ti.com>
Subject: [PATCH v8 2/9] ARM: dts: am437x: Add missing compatibles to PWM
 binding documents
Date: Tue,  3 May 2016 10:56:48 -0500
Message-ID: <1462291015-1919-3-git-send-email-fcooper@ti.com>
References: <1462291015-1919-1-git-send-email-fcooper@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1462291015-1919-1-git-send-email-fcooper@ti.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: thierry.reding@gmail.com, robh+dt@kernel.org, tony@atomide.com, linux@arm.linux.org.uk, paul@pwsan.com, t-kristo@ti.com, mturquette@baylibre.com, sboyd@codeaurora.org, linux-pwm@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-clk@vger.kernel.org, vigneshr@ti.com, nsekhar@ti.com
Cc: Franklin S Cooper Jr <fcooper@ti.com>
List-Id: linux-omap@vger.kernel.org

There are several SOC specific compatibles for ECAP, EHRPWM and PWMMS
that are in use but aren't properly documented. Therefore, fix this
by adding the compatibles to the appropriate binding documents.

While at it make minor corrections to the binding document.

Signed-off-by: Franklin S Cooper Jr <fcooper@ti.com>
Acked-by: Rob Herring <robh@kernel.org>
---
 .../devicetree/bindings/pwm/pwm-tiecap.txt          | 12 ++++++++++--
 .../devicetree/bindings/pwm/pwm-tiehrpwm.txt        | 12 ++++++++++--
 .../devicetree/bindings/pwm/pwm-tipwmss.txt         | 21 +++++++++++++++++++--
 3 files changed, 39 insertions(+), 6 deletions(-)

diff --git a/Documentation/devicetree/bindings/pwm/pwm-tiecap.txt b/Documentation/devicetree/bindings/pwm/pwm-tiecap.txt
index fb81179..788da6c 100644
--- a/Documentation/devicetree/bindings/pwm/pwm-tiecap.txt
+++ b/Documentation/devicetree/bindings/pwm/pwm-tiecap.txt
@@ -2,8 +2,9 @@ TI SOC ECAP based APWM controller
 
 Required properties:
 - compatible: Must be "ti,<soc>-ecap".
-  for am33xx - compatible = "ti,am33xx-ecap";
-  for da850  - compatible = "ti,da850-ecap", "ti,am33xx-ecap";
+  for am33xx  - compatible = "ti,am33xx-ecap";
+  for am4372  - compatible = "ti,am4372-ecap", "ti,am33xx-ecap";
+  for da850   - compatible = "ti,da850-ecap", "ti,am33xx-ecap";
 - #pwm-cells: should be 3. See pwm.txt in this directory for a description of
   the cells format. The PWM channel index ranges from 0 to 4. The only third
   cell flag supported by this binding is PWM_POLARITY_INVERTED.
@@ -22,6 +23,13 @@ ecap0: ecap@0 { /* ECAP on am33xx */
 	ti,hwmods = "ecap0";
 };
 
+ecap0: ecap@0 { /* ECAP on am4372 */
+	compatible = "ti,am4372-ecap", "ti,am33xx-ecap";
+	#pwm-cells = <3>;
+	reg = <0x48300100 0x80>;
+	ti,hwmods = "ecap0";
+};
+
 ecap0: ecap@0 { /* ECAP on da850 */
 	compatible = "ti,da850-ecap", "ti,am33xx-ecap";
 	#pwm-cells = <3>;
diff --git a/Documentation/devicetree/bindings/pwm/pwm-tiehrpwm.txt b/Documentation/devicetree/bindings/pwm/pwm-tiehrpwm.txt
index 9c100b2..99b544f 100644
--- a/Documentation/devicetree/bindings/pwm/pwm-tiehrpwm.txt
+++ b/Documentation/devicetree/bindings/pwm/pwm-tiehrpwm.txt
@@ -2,8 +2,9 @@ TI SOC EHRPWM based PWM controller
 
 Required properties:
 - compatible: Must be "ti,<soc>-ehrpwm".
-  for am33xx - compatible = "ti,am33xx-ehrpwm";
-  for da850  - compatible = "ti,da850-ehrpwm", "ti,am33xx-ehrpwm";
+  for am33xx  - compatible = "ti,am33xx-ehrpwm";
+  for am4372  - compatible = "ti,am4372-ehrpwm", "ti,am33xx-ehrpwm";
+  for da850   - compatible = "ti,da850-ehrpwm", "ti,am33xx-ehrpwm";
 - #pwm-cells: should be 3. See pwm.txt in this directory for a description of
   the cells format. The only third cell flag supported by this binding is
   PWM_POLARITY_INVERTED.
@@ -22,6 +23,13 @@ ehrpwm0: ehrpwm@0 { /* EHRPWM on am33xx */
 	ti,hwmods = "ehrpwm0";
 };
 
+ehrpwm0: ehrpwm@0 { /* EHRPWM on am4372 */
+	compatible = "ti,am4372-ehrpwm", "ti,am33xx-ehrpwm";
+	#pwm-cells = <3>;
+	reg = <0x48300200 0x80>;
+	ti,hwmods = "ehrpwm0";
+};
+
 ehrpwm0: ehrpwm@0 { /* EHRPWM on da850 */
 	compatible = "ti,da850-ehrpwm", "ti,am33xx-ehrpwm";
 	#pwm-cells = <3>;
diff --git a/Documentation/devicetree/bindings/pwm/pwm-tipwmss.txt b/Documentation/devicetree/bindings/pwm/pwm-tipwmss.txt
index f7eae77..fd8e87c 100644
--- a/Documentation/devicetree/bindings/pwm/pwm-tipwmss.txt
+++ b/Documentation/devicetree/bindings/pwm/pwm-tipwmss.txt
@@ -1,7 +1,10 @@
 TI SOC based PWM Subsystem
 
 Required properties:
-- compatible: Must be "ti,am33xx-pwmss";
+- compatible: Must be "ti,<soc>-pwmss".
+  for am33xx  - compatible = "ti,am33xx-pwmss";
+  for am4372  - compatible = "ti,am4372-pwmss","ti,am33xx-pwmss";
+
 - reg: physical base address and size of the registers map.
 - address-cells: Specify the number of u32 entries needed in child nodes.
 		  Should set to 1.
@@ -16,7 +19,7 @@ Required properties:
 Also child nodes should also populated under PWMSS DT node.
 
 Example:
-pwmss0: pwmss@48300000 {
+epwmss0: epwmss@48300000 { /* PWMSS for am33xx */
 	compatible = "ti,am33xx-pwmss";
 	reg = <0x48300000 0x10>;
 	ti,hwmods = "epwmss0";
@@ -29,3 +32,17 @@ pwmss0: pwmss@48300000 {
 
 	/* child nodes go here */
 };
+
+epwmss0: epwmss@48300000 { /* PWMSS for am4372 */
+	compatible = "ti,am4372-pwmss","ti,am33xx-pwmss"
+	reg = <0x48300000 0x10>;
+	ti,hwmods = "epwmss0";
+	#address-cells = <1>;
+	#size-cells = <1>;
+	status = "disabled";
+	ranges = <0x48300100 0x48300100 0x80   /* ECAP */
+		  0x48300180 0x48300180 0x80   /* EQEP */
+		  0x48300200 0x48300200 0x80>; /* EHRPWM */
+
+	/* child nodes go here */
+};
-- 
2.7.0
