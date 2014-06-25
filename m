From: Suman Anna <s-anna@ti.com>
Subject: [PATCH 3/6] ARM: dts: OMAP2+: Add sub mailboxes device node information
Date: Tue, 24 Jun 2014 20:47:55 -0500
Message-ID: <1403660878-56350-4-git-send-email-s-anna@ti.com>
References: <1403660878-56350-1-git-send-email-s-anna@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1403660878-56350-1-git-send-email-s-anna@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Jassi Brar <jaswinder.singh@linaro.org>, Dave Gerlach <d-gerlach@ti.com>, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Suman Anna <s-anna@ti.com>, =?UTF-8?q?Beno=C3=AEt=20Cousson?= <bcousson@baylibre.com>, Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>
List-Id: linux-omap@vger.kernel.org

The sub-mailbox devices are added to the Mailbox DT nodes on
OMAP2420, OMAP2430, OMAP3, AM33xx, AM43xx, OMAP4 and OMAP5
family of SoCs. This data represents the same mailboxes that
used to be represented in hwmod attribute data previously.
The node name is chosen based on the .name field of
omap_mbox_dev_info structure used in the hwmod data.

Cc: "Beno=C3=AEt Cousson" <bcousson@baylibre.com>
Cc: Rob Herring <robh+dt@kernel.org>
Cc: Pawel Moll <pawel.moll@arm.com>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Ian Campbell <ijc+devicetree@hellion.org.uk>
Cc: Kumar Gala <galak@codeaurora.org>
Signed-off-by: Suman Anna <s-anna@ti.com>
---
 arch/arm/boot/dts/am33xx.dtsi   | 4 ++++
 arch/arm/boot/dts/am4372.dtsi   | 4 ++++
 arch/arm/boot/dts/omap2420.dtsi | 8 ++++++++
 arch/arm/boot/dts/omap2430.dtsi | 4 ++++
 arch/arm/boot/dts/omap3.dtsi    | 4 ++++
 arch/arm/boot/dts/omap4.dtsi    | 8 ++++++++
 arch/arm/boot/dts/omap5.dtsi    | 8 ++++++++
 7 files changed, 40 insertions(+)

diff --git a/arch/arm/boot/dts/am33xx.dtsi b/arch/arm/boot/dts/am33xx.d=
tsi
index 1da3bcf..8c5abc7 100644
--- a/arch/arm/boot/dts/am33xx.dtsi
+++ b/arch/arm/boot/dts/am33xx.dtsi
@@ -352,6 +352,10 @@
 			reg =3D <0x480C8000 0x200>;
 			interrupts =3D <77>;
 			ti,hwmods =3D "mailbox";
+			mbox_wkupm3: wkup_m3 {
+				ti,mbox-tx =3D <0 0 0>;
+				ti,mbox-rx =3D <0 0 3>;
+			};
 		};
=20
 		timer1: timer@44e31000 {
diff --git a/arch/arm/boot/dts/am4372.dtsi b/arch/arm/boot/dts/am4372.d=
tsi
index 390cbb53..668b404 100644
--- a/arch/arm/boot/dts/am4372.dtsi
+++ b/arch/arm/boot/dts/am4372.dtsi
@@ -166,6 +166,10 @@
 			reg =3D <0x480C8000 0x200>;
 			interrupts =3D <GIC_SPI 77 IRQ_TYPE_LEVEL_HIGH>;
 			ti,hwmods =3D "mailbox";
+			mbox_wkupm3: wkup_m3 {
+				ti,mbox-tx =3D <0 0 0>;
+				ti,mbox-rx =3D <0 0 3>;
+			};
 		};
=20
 		timer1: timer@44e31000 {
diff --git a/arch/arm/boot/dts/omap2420.dtsi b/arch/arm/boot/dts/omap24=
20.dtsi
index e83b046..f3e6d0f 100644
--- a/arch/arm/boot/dts/omap2420.dtsi
+++ b/arch/arm/boot/dts/omap2420.dtsi
@@ -157,6 +157,14 @@
 			interrupts =3D <26>, <34>;
 			interrupt-names =3D "dsp", "iva";
 			ti,hwmods =3D "mailbox";
+			mbox_dsp: dsp {
+				ti,mbox-tx =3D <0 0 0>;
+				ti,mbox-rx =3D <1 0 0>;
+			};
+			mbox_iva: iva {
+				ti,mbox-tx =3D <2 1 3>;
+				ti,mbox-rx =3D <3 1 3>;
+			};
 		};
=20
 		timer1: timer@48028000 {
diff --git a/arch/arm/boot/dts/omap2430.dtsi b/arch/arm/boot/dts/omap24=
30.dtsi
index c4e8013..13deb71 100644
--- a/arch/arm/boot/dts/omap2430.dtsi
+++ b/arch/arm/boot/dts/omap2430.dtsi
@@ -247,6 +247,10 @@
 			reg =3D <0x48094000 0x200>;
 			interrupts =3D <26>;
 			ti,hwmods =3D "mailbox";
+			mbox_dsp: dsp {
+				ti,mbox-tx =3D <0 0 0>;
+				ti,mbox-rx =3D <1 0 0>;
+			};
 		};
=20
 		timer1: timer@49018000 {
diff --git a/arch/arm/boot/dts/omap3.dtsi b/arch/arm/boot/dts/omap3.dts=
i
index b2891a9..3524adf 100644
--- a/arch/arm/boot/dts/omap3.dtsi
+++ b/arch/arm/boot/dts/omap3.dtsi
@@ -332,6 +332,10 @@
 			ti,hwmods =3D "mailbox";
 			reg =3D <0x48094000 0x200>;
 			interrupts =3D <26>;
+			mbox_dsp: dsp {
+				ti,mbox-tx =3D <0 0 0>;
+				ti,mbox-rx =3D <1 0 0>;
+			};
 		};
=20
 		mcspi1: spi@48098000 {
diff --git a/arch/arm/boot/dts/omap4.dtsi b/arch/arm/boot/dts/omap4.dts=
i
index 55bec30..19dc11d 100644
--- a/arch/arm/boot/dts/omap4.dtsi
+++ b/arch/arm/boot/dts/omap4.dtsi
@@ -654,6 +654,14 @@
 			reg =3D <0x4a0f4000 0x200>;
 			interrupts =3D <GIC_SPI 26 IRQ_TYPE_LEVEL_HIGH>;
 			ti,hwmods =3D "mailbox";
+			mbox_ipu: mbox_ipu {
+				ti,mbox-tx =3D <0 0 0>;
+				ti,mbox-rx =3D <1 0 0>;
+			};
+			mbox_dsp: mbox_dsp {
+				ti,mbox-tx =3D <3 0 0>;
+				ti,mbox-rx =3D <2 0 0>;
+			};
 		};
=20
 		timer1: timer@4a318000 {
diff --git a/arch/arm/boot/dts/omap5.dtsi b/arch/arm/boot/dts/omap5.dts=
i
index 3bfda16..ce54c13 100644
--- a/arch/arm/boot/dts/omap5.dtsi
+++ b/arch/arm/boot/dts/omap5.dtsi
@@ -641,6 +641,14 @@
 			reg =3D <0x4a0f4000 0x200>;
 			interrupts =3D <GIC_SPI 26 IRQ_TYPE_LEVEL_HIGH>;
 			ti,hwmods =3D "mailbox";
+			mbox_ipu: mbox_ipu {
+				ti,mbox-tx =3D <0 0 0>;
+				ti,mbox-rx =3D <1 0 0>;
+			};
+			mbox_dsp: mbox_dsp {
+				ti,mbox-tx =3D <3 0 0>;
+				ti,mbox-rx =3D <2 0 0>;
+			};
 		};
=20
 		timer1: timer@4ae18000 {
--=20
2.0.0
