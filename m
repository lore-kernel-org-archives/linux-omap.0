From: Jeroen Hofstee <jhofstee@victronenergy.com>
Subject: [PATCH] ARM: dts: am335x-sancloud-bbe: Fix PHY mode for ethernet
Date: Wed, 2 Oct 2019 09:54:40 +0000
Message-ID: <20191002095416.19603-1-jhofstee@victronenergy.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>
Cc: Jeroen Hofstee <jhofstee@victronenergy.com>, Koen Kooi <koen@dominion.thruhere.net>, =?iso-8859-1?Q?Beno=EEt_Cousson?= <bcousson@baylibre.com>, Tony Lindgren <tony@atomide.com>, open list <linux-kernel@vger.kernel.org>
List-Id: linux-omap@vger.kernel.org

cd28d1d6e52e: ("net: phy: at803x: Disable phy delay for RGMII mode") broke
the ethernet networking on the beaglebone enhanced.

The board relied on the bug in the at803x driver to always enable the rx
delay. So change the phy-mode to rgmii-id so it is enabled again.

Signed-off-by: Jeroen Hofstee <jhofstee@victronenergy.com>
cc: Koen Kooi <koen@dominion.thruhere.net>
---
 arch/arm/boot/dts/am335x-sancloud-bbe.dts | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/am335x-sancloud-bbe.dts b/arch/arm/boot/dts/=
am335x-sancloud-bbe.dts
index 8678e6e35493..e5fdb7abb0d5 100644
--- a/arch/arm/boot/dts/am335x-sancloud-bbe.dts
+++ b/arch/arm/boot/dts/am335x-sancloud-bbe.dts
@@ -108,7 +108,7 @@
=20
 &cpsw_emac0 {
 	phy-handle =3D <&ethphy0>;
-	phy-mode =3D "rgmii-txid";
+	phy-mode =3D "rgmii-id";
 };
=20
 &i2c0 {
--=20
2.17.1
