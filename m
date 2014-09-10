From: Suman Anna <s-anna@ti.com>
Subject: [REPOST PATCHv3] ARM: dts: OMAP2+: Add sub mailboxes device node information
Date: Wed, 10 Sep 2014 14:27:23 -0500
Message-ID: <1410377243-8147-2-git-send-email-s-anna@ti.com>
References: <1410377243-8147-1-git-send-email-s-anna@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:58957 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751754AbaIJT2E (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 10 Sep 2014 15:28:04 -0400
In-Reply-To: <1410377243-8147-1-git-send-email-s-anna@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Jassi Brar <jaswinder.singh@linaro.org>, Dave Gerlach <d-gerlach@ti.com>, linux-omap@vger.kernel.org, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Suman Anna <s-anna@ti.com>, =?UTF-8?q?Beno=C3=AEt=20Cousson?= <bcousson@baylibre.com>, Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>

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
index 3a0a161..e4f165a 100644
--- a/arch/arm/boot/dts/am33xx.dtsi
+++ b/arch/arm/boot/dts/am33xx.dtsi
@@ -354,6 +354,10 @@
 			ti,hwmods =3D "mailbox";
 			ti,mbox-num-users =3D <4>;
 			ti,mbox-num-fifos =3D <8>;
+			mbox_wkupm3: wkup_m3 {
+				ti,mbox-tx =3D <0 0 0>;
+				ti,mbox-rx =3D <0 0 3>;
+			};
 		};
=20
 		timer1: timer@44e31000 {
diff --git a/arch/arm/boot/dts/am4372.dtsi b/arch/arm/boot/dts/am4372.d=
tsi
index 9b3d2ba..a0503be 100644
--- a/arch/arm/boot/dts/am4372.dtsi
+++ b/arch/arm/boot/dts/am4372.dtsi
@@ -168,6 +168,10 @@
 			ti,hwmods =3D "mailbox";
 			ti,mbox-num-users =3D <4>;
 			ti,mbox-num-fifos =3D <8>;
+			mbox_wkupm3: wkup_m3 {
+				ti,mbox-tx =3D <0 0 0>;
+				ti,mbox-rx =3D <0 0 3>;
+			};
 		};
=20
 		timer1: timer@44e31000 {
diff --git a/arch/arm/boot/dts/omap2420.dtsi b/arch/arm/boot/dts/omap24=
20.dtsi
index 9be3c12..ae89aad 100644
--- a/arch/arm/boot/dts/omap2420.dtsi
+++ b/arch/arm/boot/dts/omap2420.dtsi
@@ -159,6 +159,14 @@
 			ti,hwmods =3D "mailbox";
 			ti,mbox-num-users =3D <4>;
 			ti,mbox-num-fifos =3D <6>;
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
index 1a00f15..b56d7161 100644
--- a/arch/arm/boot/dts/omap2430.dtsi
+++ b/arch/arm/boot/dts/omap2430.dtsi
@@ -249,6 +249,10 @@
 			ti,hwmods =3D "mailbox";
 			ti,mbox-num-users =3D <4>;
 			ti,mbox-num-fifos =3D <6>;
+			mbox_dsp: dsp {
+				ti,mbox-tx =3D <0 0 0>;
+				ti,mbox-rx =3D <1 0 0>;
+			};
 		};
=20
 		timer1: timer@49018000 {
diff --git a/arch/arm/boot/dts/omap3.dtsi b/arch/arm/boot/dts/omap3.dts=
i
index 575a49b..b2ae8b8 100644
--- a/arch/arm/boot/dts/omap3.dtsi
+++ b/arch/arm/boot/dts/omap3.dtsi
@@ -334,6 +334,10 @@
 			interrupts =3D <26>;
 			ti,mbox-num-users =3D <2>;
 			ti,mbox-num-fifos =3D <2>;
+			mbox_dsp: dsp {
+				ti,mbox-tx =3D <0 0 0>;
+				ti,mbox-rx =3D <1 0 0>;
+			};
 		};
=20
 		mcspi1: spi@48098000 {
diff --git a/arch/arm/boot/dts/omap4.dtsi b/arch/arm/boot/dts/omap4.dts=
i
index 69408b5..bc54d66 100644
--- a/arch/arm/boot/dts/omap4.dtsi
+++ b/arch/arm/boot/dts/omap4.dtsi
@@ -656,6 +656,14 @@
 			ti,hwmods =3D "mailbox";
 			ti,mbox-num-users =3D <3>;
 			ti,mbox-num-fifos =3D <8>;
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
index fc8df17..43336c2 100644
--- a/arch/arm/boot/dts/omap5.dtsi
+++ b/arch/arm/boot/dts/omap5.dtsi
@@ -642,6 +642,14 @@
 			ti,hwmods =3D "mailbox";
 			ti,mbox-num-users =3D <3>;
 			ti,mbox-num-fifos =3D <8>;
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
2.0.4

--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
