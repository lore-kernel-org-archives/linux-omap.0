From: Laurent Pinchart <laurent.pinchart+renesas-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org>
Subject: [PATCH v2 3/4] pwm: Update DT bindings to reference pwm.txt for cells
 documentation
Date: Thu, 18 Jul 2013 00:54:23 +0200
Message-ID: <1374101664-21112-4-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
References: <1374101664-21112-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
In-Reply-To: <1374101664-21112-1-git-send-email-laurent.pinchart+renesas-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/devicetree-discuss>,
 <mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/devicetree-discuss/>
List-Post: <mailto:devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
List-Help: <mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/devicetree-discuss>,
 <mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=subscribe>
Errors-To: devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org
Sender: "devicetree-discuss"
 <devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
To: Thierry Reding <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: linux-pwm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Boris BREZILLON <linux-arm-ZNYIgs0QAGpBDgjK7y7TUQ@public.gmane.org>, devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Steffen Trumtrar <s.trumtrar-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: linux-omap@vger.kernel.org

The PWM client cells format is documented in the generic pwm.txt
documentation and duplicated in all PWM driver bindings. Remove
duplicate information and reference pwm.txt instead.

Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org>
---
 Documentation/devicetree/bindings/pwm/atmel-tcb-pwm.txt      |  8 +++-----
 Documentation/devicetree/bindings/pwm/imx-pwm.txt            |  4 ++--
 Documentation/devicetree/bindings/pwm/mxs-pwm.txt            |  4 ++--
 Documentation/devicetree/bindings/pwm/nvidia,tegra20-pwm.txt |  5 ++---
 Documentation/devicetree/bindings/pwm/nxp,pca9685-pwm.txt    |  4 ++--
 Documentation/devicetree/bindings/pwm/pwm-samsung.txt        | 10 +++-------
 Documentation/devicetree/bindings/pwm/pwm-tiecap.txt         |  8 +++-----
 Documentation/devicetree/bindings/pwm/pwm-tiehrpwm.txt       |  8 +++-----
 Documentation/devicetree/bindings/pwm/spear-pwm.txt          |  5 ++---
 Documentation/devicetree/bindings/pwm/ti,twl-pwm.txt         |  4 ++--
 Documentation/devicetree/bindings/pwm/ti,twl-pwmled.txt      |  4 ++--
 Documentation/devicetree/bindings/pwm/vt8500-pwm.txt         |  8 +++-----
 12 files changed, 29 insertions(+), 43 deletions(-)

diff --git a/Documentation/devicetree/bindings/pwm/atmel-tcb-pwm.txt b/Documentation/devicetree/bindings/pwm/atmel-tcb-pwm.txt
index de0eaed..8031148 100644
--- a/Documentation/devicetree/bindings/pwm/atmel-tcb-pwm.txt
+++ b/Documentation/devicetree/bindings/pwm/atmel-tcb-pwm.txt
@@ -2,11 +2,9 @@ Atmel TCB PWM controller
 
 Required properties:
 - compatible: should be "atmel,tcb-pwm"
-- #pwm-cells: Should be 3.  The first cell specifies the per-chip index
-  of the PWM to use, the second cell is the period in nanoseconds and
-  bit 0 in the third cell is used to encode the polarity of PWM output.
-  Set bit 0 of the third cell in PWM specifier to 1 for inverse polarity &
-  set to 0 for normal polarity.
+- #pwm-cells: should be 3. See pwm.txt in this directory for a description of
+  the cells format. The only third cell flag supported by this binding is
+  PWM_POLARITY_INVERTED.
 - tc-block: The Timer Counter block to use as a PWM chip.
 
 Example:
diff --git a/Documentation/devicetree/bindings/pwm/imx-pwm.txt b/Documentation/devicetree/bindings/pwm/imx-pwm.txt
index 8522bfb..b50d7a6d 100644
--- a/Documentation/devicetree/bindings/pwm/imx-pwm.txt
+++ b/Documentation/devicetree/bindings/pwm/imx-pwm.txt
@@ -3,8 +3,8 @@ Freescale i.MX PWM controller
 Required properties:
 - compatible: should be "fsl,<soc>-pwm"
 - reg: physical base address and length of the controller's registers
-- #pwm-cells: should be 2.  The first cell specifies the per-chip index
-  of the PWM to use and the second cell is the period in nanoseconds.
+- #pwm-cells: should be 2. See pwm.txt in this directory for a description of
+  the cells format.
 - interrupts: The interrupt for the pwm controller
 
 Example:
diff --git a/Documentation/devicetree/bindings/pwm/mxs-pwm.txt b/Documentation/devicetree/bindings/pwm/mxs-pwm.txt
index 9e3f8f1..96cdde5 100644
--- a/Documentation/devicetree/bindings/pwm/mxs-pwm.txt
+++ b/Documentation/devicetree/bindings/pwm/mxs-pwm.txt
@@ -3,8 +3,8 @@ Freescale MXS PWM controller
 Required properties:
 - compatible: should be "fsl,imx23-pwm"
 - reg: physical base address and length of the controller's registers
-- #pwm-cells: should be 2.  The first cell specifies the per-chip index
-  of the PWM to use and the second cell is the period in nanoseconds.
+- #pwm-cells: should be 2. See pwm.txt in this directory for a description of
+  the cells format.
 - fsl,pwm-number: the number of PWM devices
 
 Example:
diff --git a/Documentation/devicetree/bindings/pwm/nvidia,tegra20-pwm.txt b/Documentation/devicetree/bindings/pwm/nvidia,tegra20-pwm.txt
index 01438ec..c3fc57a 100644
--- a/Documentation/devicetree/bindings/pwm/nvidia,tegra20-pwm.txt
+++ b/Documentation/devicetree/bindings/pwm/nvidia,tegra20-pwm.txt
@@ -5,9 +5,8 @@ Required properties:
   - "nvidia,tegra20-pwm"
   - "nvidia,tegra30-pwm"
 - reg: physical base address and length of the controller's registers
-- #pwm-cells: On Tegra the number of cells used to specify a PWM is 2. The
-  first cell specifies the per-chip index of the PWM to use and the second
-  cell is the period in nanoseconds.
+- #pwm-cells: should be 2. See pwm.txt in this directory for a description of
+  the cells format.
 
 Example:
 
diff --git a/Documentation/devicetree/bindings/pwm/nxp,pca9685-pwm.txt b/Documentation/devicetree/bindings/pwm/nxp,pca9685-pwm.txt
index 1e3dfe7..f84ec9d 100644
--- a/Documentation/devicetree/bindings/pwm/nxp,pca9685-pwm.txt
+++ b/Documentation/devicetree/bindings/pwm/nxp,pca9685-pwm.txt
@@ -3,8 +3,8 @@ NXP PCA9685 16-channel 12-bit PWM LED controller
 
 Required properties:
   - compatible: "nxp,pca9685-pwm"
-  - #pwm-cells: should be 2. The first cell specifies the per-chip index
-    of the PWM to use and the second cell is the period in nanoseconds.
+  - #pwm-cells: Should be 2. See pwm.txt in this directory for a description of
+    the cells format.
     The index 16 is the ALLCALL channel, that sets all PWM channels at the same
     time.
 
diff --git a/Documentation/devicetree/bindings/pwm/pwm-samsung.txt b/Documentation/devicetree/bindings/pwm/pwm-samsung.txt
index ac67c68..4caa1a7 100644
--- a/Documentation/devicetree/bindings/pwm/pwm-samsung.txt
+++ b/Documentation/devicetree/bindings/pwm/pwm-samsung.txt
@@ -19,13 +19,9 @@ Required properties:
 - reg: base address and size of register area
 - interrupts: list of timer interrupts (one interrupt per timer, starting at
   timer 0)
-- #pwm-cells: number of cells used for PWM specifier - must be 3
-   the specifier format is as follows:
-     - phandle to PWM controller node
-     - index of PWM channel (from 0 to 4)
-     - PWM signal period in nanoseconds
-     - bitmask of optional PWM flags:
-        0x1 - invert PWM signal
+- #pwm-cells: should be 3. See pwm.txt in this directory for a description of
+  the cells format. The only third cell flag supported by this binding is
+  PWM_POLARITY_INVERTED.
 
 Optional properties:
 - samsung,pwm-outputs: list of PWM channels used as PWM outputs on particular
diff --git a/Documentation/devicetree/bindings/pwm/pwm-tiecap.txt b/Documentation/devicetree/bindings/pwm/pwm-tiecap.txt
index 681afad..fb81179 100644
--- a/Documentation/devicetree/bindings/pwm/pwm-tiecap.txt
+++ b/Documentation/devicetree/bindings/pwm/pwm-tiecap.txt
@@ -4,11 +4,9 @@ Required properties:
 - compatible: Must be "ti,<soc>-ecap".
   for am33xx - compatible = "ti,am33xx-ecap";
   for da850  - compatible = "ti,da850-ecap", "ti,am33xx-ecap";
-- #pwm-cells: Should be 3. Number of cells being used to specify PWM property.
-  First cell specifies the per-chip index of the PWM to use, the second
-  cell is the period in nanoseconds and bit 0 in the third cell is used to
-  encode the polarity of PWM output. Set bit 0 of the third in PWM specifier
-  to 1 for inverse polarity & set to 0 for normal polarity.
+- #pwm-cells: should be 3. See pwm.txt in this directory for a description of
+  the cells format. The PWM channel index ranges from 0 to 4. The only third
+  cell flag supported by this binding is PWM_POLARITY_INVERTED.
 - reg: physical base address and size of the registers map.
 
 Optional properties:
diff --git a/Documentation/devicetree/bindings/pwm/pwm-tiehrpwm.txt b/Documentation/devicetree/bindings/pwm/pwm-tiehrpwm.txt
index 337c6fc..9c100b2 100644
--- a/Documentation/devicetree/bindings/pwm/pwm-tiehrpwm.txt
+++ b/Documentation/devicetree/bindings/pwm/pwm-tiehrpwm.txt
@@ -4,11 +4,9 @@ Required properties:
 - compatible: Must be "ti,<soc>-ehrpwm".
   for am33xx - compatible = "ti,am33xx-ehrpwm";
   for da850  - compatible = "ti,da850-ehrpwm", "ti,am33xx-ehrpwm";
-- #pwm-cells: Should be 3. Number of cells being used to specify PWM property.
-  First cell specifies the per-chip index of the PWM to use, the second
-  cell is the period in nanoseconds and bit 0 in the third cell is used to
-  encode the polarity of PWM output. Set bit 0 of the third in PWM specifier
-  to 1 for inverse polarity & set to 0 for normal polarity.
+- #pwm-cells: should be 3. See pwm.txt in this directory for a description of
+  the cells format. The only third cell flag supported by this binding is
+  PWM_POLARITY_INVERTED.
 - reg: physical base address and size of the registers map.
 
 Optional properties:
diff --git a/Documentation/devicetree/bindings/pwm/spear-pwm.txt b/Documentation/devicetree/bindings/pwm/spear-pwm.txt
index 3ac779d..b486de2 100644
--- a/Documentation/devicetree/bindings/pwm/spear-pwm.txt
+++ b/Documentation/devicetree/bindings/pwm/spear-pwm.txt
@@ -5,9 +5,8 @@ Required properties:
   - "st,spear320-pwm"
   - "st,spear1340-pwm"
 - reg: physical base address and length of the controller's registers
-- #pwm-cells: number of cells used to specify PWM which is fixed to 2 on
-  SPEAr. The first cell specifies the per-chip index of the PWM to use and
-  the second cell is the period in nanoseconds.
+- #pwm-cells: should be 2. See pwm.txt in this directory for a description of
+  the cells format.
 
 Example:
 
diff --git a/Documentation/devicetree/bindings/pwm/ti,twl-pwm.txt b/Documentation/devicetree/bindings/pwm/ti,twl-pwm.txt
index 2943ee5..4e32bee 100644
--- a/Documentation/devicetree/bindings/pwm/ti,twl-pwm.txt
+++ b/Documentation/devicetree/bindings/pwm/ti,twl-pwm.txt
@@ -6,8 +6,8 @@ On TWL6030 series: PWM0 and PWM1
 
 Required properties:
 - compatible: "ti,twl4030-pwm" or "ti,twl6030-pwm"
-- #pwm-cells: should be 2.  The first cell specifies the per-chip index
-  of the PWM to use and the second cell is the period in nanoseconds.
+- #pwm-cells: should be 2. See pwm.txt in this directory for a description of
+  the cells format.
 
 Example:
 
diff --git a/Documentation/devicetree/bindings/pwm/ti,twl-pwmled.txt b/Documentation/devicetree/bindings/pwm/ti,twl-pwmled.txt
index cb64f3a..9f4b460 100644
--- a/Documentation/devicetree/bindings/pwm/ti,twl-pwmled.txt
+++ b/Documentation/devicetree/bindings/pwm/ti,twl-pwmled.txt
@@ -6,8 +6,8 @@ On TWL6030 series: LED PWM (mainly used as charging indicator LED)
 
 Required properties:
 - compatible: "ti,twl4030-pwmled" or "ti,twl6030-pwmled"
-- #pwm-cells: should be 2.  The first cell specifies the per-chip index
-  of the PWM to use and the second cell is the period in nanoseconds.
+- #pwm-cells: should be 2. See pwm.txt in this directory for a description of
+  the cells format.
 
 Example:
 
diff --git a/Documentation/devicetree/bindings/pwm/vt8500-pwm.txt b/Documentation/devicetree/bindings/pwm/vt8500-pwm.txt
index d21d82d..a76390e 100644
--- a/Documentation/devicetree/bindings/pwm/vt8500-pwm.txt
+++ b/Documentation/devicetree/bindings/pwm/vt8500-pwm.txt
@@ -3,11 +3,9 @@ VIA/Wondermedia VT8500/WM8xxx series SoC PWM controller
 Required properties:
 - compatible: should be "via,vt8500-pwm"
 - reg: physical base address and length of the controller's registers
-- #pwm-cells: Should be 3. Number of cells being used to specify PWM property.
-  First cell specifies the per-chip index of the PWM to use, the second
-  cell is the period in nanoseconds and bit 0 in the third cell is used to
-  encode the polarity of PWM output. Set bit 0 of the third in PWM specifier
-  to 1 for inverse polarity & set to 0 for normal polarity.
+- #pwm-cells: should be 3. See pwm.txt in this directory for a description of
+  the cells format. The only third cell flag supported by this binding is
+  PWM_POLARITY_INVERTED.
 - clocks: phandle to the PWM source clock
 
 Example:
-- 
1.8.1.5
