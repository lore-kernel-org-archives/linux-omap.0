From: Suman Anna <s-anna@ti.com>
Subject: [PATCHv2 5/5] ARM: dts: OMAP2+: Add #mbox-cells property to all mailbox nodes
Date: Fri, 11 Jul 2014 17:04:12 -0500
Message-ID: <1405116252-53612-6-git-send-email-s-anna@ti.com>
References: <1405116252-53612-1-git-send-email-s-anna@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1405116252-53612-1-git-send-email-s-anna@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Jassi Brar <jaswinder.singh@linaro.org>, Dave Gerlach <d-gerlach@ti.com>, Pavel Machek <pavel@ucw.cz>, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Suman Anna <s-anna@ti.com>, =?UTF-8?q?Beno=C3=AEt=20Cousson?= <bcousson@baylibre.com>, Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>
List-Id: linux-omap@vger.kernel.org

The '#mbox-cells' property is added to all the OMAP mailbox
nodes. This property is mandatory with the new mailbox framework.

Cc: "Beno=C3=AEt Cousson" <bcousson@baylibre.com>
Cc: Rob Herring <robh+dt@kernel.org>
Cc: Pawel Moll <pawel.moll@arm.com>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Ian Campbell <ijc+devicetree@hellion.org.uk>
Cc: Kumar Gala <galak@codeaurora.org>
Signed-off-by: Suman Anna <s-anna@ti.com>
---
 arch/arm/boot/dts/am33xx.dtsi   |  1 +
 arch/arm/boot/dts/am4372.dtsi   |  1 +
 arch/arm/boot/dts/dra7.dtsi     | 13 +++++++++++++
 arch/arm/boot/dts/omap2420.dtsi |  1 +
 arch/arm/boot/dts/omap2430.dtsi |  1 +
 arch/arm/boot/dts/omap3.dtsi    |  1 +
 arch/arm/boot/dts/omap4.dtsi    |  1 +
 arch/arm/boot/dts/omap5.dtsi    |  1 +
 8 files changed, 20 insertions(+)

diff --git a/arch/arm/boot/dts/am33xx.dtsi b/arch/arm/boot/dts/am33xx.d=
tsi
index e4f165a..5663ff5 100644
--- a/arch/arm/boot/dts/am33xx.dtsi
+++ b/arch/arm/boot/dts/am33xx.dtsi
@@ -352,6 +352,7 @@
 			reg =3D <0x480C8000 0x200>;
 			interrupts =3D <77>;
 			ti,hwmods =3D "mailbox";
+			#mbox-cells =3D <1>;
 			ti,mbox-num-users =3D <4>;
 			ti,mbox-num-fifos =3D <8>;
 			mbox_wkupm3: wkup_m3 {
diff --git a/arch/arm/boot/dts/am4372.dtsi b/arch/arm/boot/dts/am4372.d=
tsi
index 3be2a87..8619519 100644
--- a/arch/arm/boot/dts/am4372.dtsi
+++ b/arch/arm/boot/dts/am4372.dtsi
@@ -166,6 +166,7 @@
 			reg =3D <0x480C8000 0x200>;
 			interrupts =3D <GIC_SPI 77 IRQ_TYPE_LEVEL_HIGH>;
 			ti,hwmods =3D "mailbox";
+			#mbox-cells =3D <1>;
 			ti,mbox-num-users =3D <4>;
 			ti,mbox-num-fifos =3D <8>;
 			mbox_wkupm3: wkup_m3 {
diff --git a/arch/arm/boot/dts/dra7.dtsi b/arch/arm/boot/dts/dra7.dtsi
index 99c40d4..626137f 100644
--- a/arch/arm/boot/dts/dra7.dtsi
+++ b/arch/arm/boot/dts/dra7.dtsi
@@ -342,6 +342,7 @@
 			compatible =3D "ti,omap4-mailbox";
 			reg =3D <0x4a0f4000 0x200>;
 			ti,hwmods =3D "mailbox1";
+			#mbox-cells =3D <1>;
 			ti,mbox-num-users =3D <3>;
 			ti,mbox-num-fifos =3D <8>;
 			status =3D "disabled";
@@ -351,6 +352,7 @@
 			compatible =3D "ti,omap4-mailbox";
 			reg =3D <0x4883a000 0x200>;
 			ti,hwmods =3D "mailbox2";
+			#mbox-cells =3D <1>;
 			ti,mbox-num-users =3D <4>;
 			ti,mbox-num-fifos =3D <12>;
 			status =3D "disabled";
@@ -360,6 +362,7 @@
 			compatible =3D "ti,omap4-mailbox";
 			reg =3D <0x4883c000 0x200>;
 			ti,hwmods =3D "mailbox3";
+			#mbox-cells =3D <1>;
 			ti,mbox-num-users =3D <4>;
 			ti,mbox-num-fifos =3D <12>;
 			status =3D "disabled";
@@ -369,6 +372,7 @@
 			compatible =3D "ti,omap4-mailbox";
 			reg =3D <0x4883e000 0x200>;
 			ti,hwmods =3D "mailbox4";
+			#mbox-cells =3D <1>;
 			ti,mbox-num-users =3D <4>;
 			ti,mbox-num-fifos =3D <12>;
 			status =3D "disabled";
@@ -378,6 +382,7 @@
 			compatible =3D "ti,omap4-mailbox";
 			reg =3D <0x48840000 0x200>;
 			ti,hwmods =3D "mailbox5";
+			#mbox-cells =3D <1>;
 			ti,mbox-num-users =3D <4>;
 			ti,mbox-num-fifos =3D <12>;
 			status =3D "disabled";
@@ -387,6 +392,7 @@
 			compatible =3D "ti,omap4-mailbox";
 			reg =3D <0x48842000 0x200>;
 			ti,hwmods =3D "mailbox6";
+			#mbox-cells =3D <1>;
 			ti,mbox-num-users =3D <4>;
 			ti,mbox-num-fifos =3D <12>;
 			status =3D "disabled";
@@ -396,6 +402,7 @@
 			compatible =3D "ti,omap4-mailbox";
 			reg =3D <0x48844000 0x200>;
 			ti,hwmods =3D "mailbox7";
+			#mbox-cells =3D <1>;
 			ti,mbox-num-users =3D <4>;
 			ti,mbox-num-fifos =3D <12>;
 			status =3D "disabled";
@@ -405,6 +412,7 @@
 			compatible =3D "ti,omap4-mailbox";
 			reg =3D <0x48846000 0x200>;
 			ti,hwmods =3D "mailbox8";
+			#mbox-cells =3D <1>;
 			ti,mbox-num-users =3D <4>;
 			ti,mbox-num-fifos =3D <12>;
 			status =3D "disabled";
@@ -414,6 +422,7 @@
 			compatible =3D "ti,omap4-mailbox";
 			reg =3D <0x4885e000 0x200>;
 			ti,hwmods =3D "mailbox9";
+			#mbox-cells =3D <1>;
 			ti,mbox-num-users =3D <4>;
 			ti,mbox-num-fifos =3D <12>;
 			status =3D "disabled";
@@ -423,6 +432,7 @@
 			compatible =3D "ti,omap4-mailbox";
 			reg =3D <0x48860000 0x200>;
 			ti,hwmods =3D "mailbox10";
+			#mbox-cells =3D <1>;
 			ti,mbox-num-users =3D <4>;
 			ti,mbox-num-fifos =3D <12>;
 			status =3D "disabled";
@@ -432,6 +442,7 @@
 			compatible =3D "ti,omap4-mailbox";
 			reg =3D <0x48862000 0x200>;
 			ti,hwmods =3D "mailbox11";
+			#mbox-cells =3D <1>;
 			ti,mbox-num-users =3D <4>;
 			ti,mbox-num-fifos =3D <12>;
 			status =3D "disabled";
@@ -441,6 +452,7 @@
 			compatible =3D "ti,omap4-mailbox";
 			reg =3D <0x48864000 0x200>;
 			ti,hwmods =3D "mailbox12";
+			#mbox-cells =3D <1>;
 			ti,mbox-num-users =3D <4>;
 			ti,mbox-num-fifos =3D <12>;
 			status =3D "disabled";
@@ -450,6 +462,7 @@
 			compatible =3D "ti,omap4-mailbox";
 			reg =3D <0x48802000 0x200>;
 			ti,hwmods =3D "mailbox13";
+			#mbox-cells =3D <1>;
 			ti,mbox-num-users =3D <4>;
 			ti,mbox-num-fifos =3D <12>;
 			status =3D "disabled";
diff --git a/arch/arm/boot/dts/omap2420.dtsi b/arch/arm/boot/dts/omap24=
20.dtsi
index d14f16c..bea6f07 100644
--- a/arch/arm/boot/dts/omap2420.dtsi
+++ b/arch/arm/boot/dts/omap2420.dtsi
@@ -157,6 +157,7 @@
 			interrupts =3D <26>, <34>;
 			interrupt-names =3D "dsp", "iva";
 			ti,hwmods =3D "mailbox";
+			#mbox-cells =3D <1>;
 			ti,mbox-num-users =3D <4>;
 			ti,mbox-num-fifos =3D <6>;
 			mbox_dsp: dsp {
diff --git a/arch/arm/boot/dts/omap2430.dtsi b/arch/arm/boot/dts/omap24=
30.dtsi
index db02be2..689bd08 100644
--- a/arch/arm/boot/dts/omap2430.dtsi
+++ b/arch/arm/boot/dts/omap2430.dtsi
@@ -247,6 +247,7 @@
 			reg =3D <0x48094000 0x200>;
 			interrupts =3D <26>;
 			ti,hwmods =3D "mailbox";
+			#mbox-cells =3D <1>;
 			ti,mbox-num-users =3D <4>;
 			ti,mbox-num-fifos =3D <6>;
 			mbox_dsp: dsp {
diff --git a/arch/arm/boot/dts/omap3.dtsi b/arch/arm/boot/dts/omap3.dts=
i
index b2ae8b8..75c290f 100644
--- a/arch/arm/boot/dts/omap3.dtsi
+++ b/arch/arm/boot/dts/omap3.dtsi
@@ -332,6 +332,7 @@
 			ti,hwmods =3D "mailbox";
 			reg =3D <0x48094000 0x200>;
 			interrupts =3D <26>;
+			#mbox-cells =3D <1>;
 			ti,mbox-num-users =3D <2>;
 			ti,mbox-num-fifos =3D <2>;
 			mbox_dsp: dsp {
diff --git a/arch/arm/boot/dts/omap4.dtsi b/arch/arm/boot/dts/omap4.dts=
i
index bc54d66..d08b98a 100644
--- a/arch/arm/boot/dts/omap4.dtsi
+++ b/arch/arm/boot/dts/omap4.dtsi
@@ -654,6 +654,7 @@
 			reg =3D <0x4a0f4000 0x200>;
 			interrupts =3D <GIC_SPI 26 IRQ_TYPE_LEVEL_HIGH>;
 			ti,hwmods =3D "mailbox";
+			#mbox-cells =3D <1>;
 			ti,mbox-num-users =3D <3>;
 			ti,mbox-num-fifos =3D <8>;
 			mbox_ipu: mbox_ipu {
diff --git a/arch/arm/boot/dts/omap5.dtsi b/arch/arm/boot/dts/omap5.dts=
i
index f7ec4cd..0b8cf23 100644
--- a/arch/arm/boot/dts/omap5.dtsi
+++ b/arch/arm/boot/dts/omap5.dtsi
@@ -641,6 +641,7 @@
 			reg =3D <0x4a0f4000 0x200>;
 			interrupts =3D <GIC_SPI 26 IRQ_TYPE_LEVEL_HIGH>;
 			ti,hwmods =3D "mailbox";
+			#mbox-cells =3D <1>;
 			ti,mbox-num-users =3D <3>;
 			ti,mbox-num-fifos =3D <8>;
 			mbox_ipu: mbox_ipu {
--=20
2.0.0
