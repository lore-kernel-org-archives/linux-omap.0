From: Sebastian Reichel <sre@kernel.org>
Subject: [PATCH 6/7] ARM: dts: N9/N950: Add support for 1GHz CPU clock
Date: Sun, 13 Mar 2016 01:06:19 +0100
Message-ID: <1457827580-16919-7-git-send-email-sre@kernel.org>
References: <1457827580-16919-1-git-send-email-sre@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1457827580-16919-1-git-send-email-sre@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Sebastian Reichel <sre@kernel.org>, Tony Lindgren <tony@atomide.com>, =?UTF-8?q?Beno=C3=AEt=20Cousson?= <bcousson@baylibre.com>, Aaro Koskinen <aaro.koskinen@iki.fi>
Cc: Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, linux-omap@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, =?UTF-8?q?Filip=20Matijevi=C4=87?= <filip.matijevic.pz@gmail.com>
List-Id: linux-omap@vger.kernel.org

=46rom: Filip Matijevi=C4=87 <filip.matijevic.pz@gmail.com>

Signed-off-by: Filip Matijevi=C4=87 <filip.matijevic.pz@gmail.com>
Signed-off-by: Sebastian Reichel <sre@kernel.org>
---
 arch/arm/boot/dts/omap3-n950-n9.dtsi | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/arch/arm/boot/dts/omap3-n950-n9.dtsi b/arch/arm/boot/dts/o=
map3-n950-n9.dtsi
index c42e8fc846b9..38d2d756acdd 100644
--- a/arch/arm/boot/dts/omap3-n950-n9.dtsi
+++ b/arch/arm/boot/dts/omap3-n950-n9.dtsi
@@ -14,6 +14,13 @@
 	cpus {
 		cpu@0 {
 			cpu0-supply =3D <&vcc>;
+			operating-points =3D <
+				/* kHz    uV */
+				300000  1012500
+				600000  1200000
+				800000  1325000
+				1000000	1375000
+			>;
 		};
 	};
=20
--=20
2.7.0
