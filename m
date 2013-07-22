From: Lee Jones <lee.jones@linaro.org>
Subject: [PATCH 17/22] ARM: dts: Remove '0x's from OMAP4 DTS file
Date: Mon, 22 Jul 2013 11:52:36 +0100
Message-ID: <1374490361-25769-17-git-send-email-lee.jones@linaro.org>
References: <1374490361-25769-1-git-send-email-lee.jones@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1374490361-25769-1-git-send-email-lee.jones@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc: arnd@arndb.de, linus.walleij@stericsson.com, Lee Jones <lee.jones@linaro.org>, =?UTF-8?q?Beno=C3=AEt=20Cousson?= <b-cousson@ti.com>, Tony Lindgren <tony@atomide.com>, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

Cc: Beno=C3=AEt Cousson <b-cousson@ti.com>
Cc: Tony Lindgren <tony@atomide.com>
Cc: linux-omap@vger.kernel.org
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 arch/arm/boot/dts/omap4.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/omap4.dtsi b/arch/arm/boot/dts/omap4.dts=
i
index 22d9f2b..45708e1 100644
--- a/arch/arm/boot/dts/omap4.dtsi
+++ b/arch/arm/boot/dts/omap4.dtsi
@@ -56,7 +56,7 @@
 		cache-level =3D <2>;
 	};
=20
-	local-timer@0x48240600 {
+	local-timer@48240600 {
 		compatible =3D "arm,cortex-a9-twd-timer";
 		reg =3D <0x48240600 0x20>;
 		interrupts =3D <GIC_PPI 13 (GIC_CPU_MASK_RAW(3) | IRQ_TYPE_LEVEL_HIG=
H)>;
--=20
1.8.1.2
