From: "Reizer, Eyal" <eyalr-l0cyMroinI0@public.gmane.org>
Subject: [PATCH] ARM: dts: am335x-evmsk: adjust mmc2 param to allow suspend
Date: Sun, 26 Mar 2017 08:53:10 +0000
Message-ID: <8665E2433BC68541A24DFFCA87B70F5B363623DC@DFRE01.ent.ti.com>
References: <1490517995-12895-1-git-send-email-eyalr@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="Windows-1252"
Content-Transfer-Encoding: quoted-printable
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1490517995-12895-1-git-send-email-eyalr-l0cyMroinI0@public.gmane.org>
Content-Language: en-US
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: =?Windows-1252?Q?Beno=EEt_Cousson?= <bcousson-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>, Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, "linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

mmc2 used for wl12xx was missing the keep-power-in suspend
parameter. As a result the board couldn't reach suspend state.

Signed-off-by: Eyal Reizer <eyalr-l0cyMroinI0@public.gmane.org>
---
 arch/arm/boot/dts/am335x-evmsk.dts | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/boot/dts/am335x-evmsk.dts b/arch/arm/boot/dts/am335x-=
evmsk.dts
index 9e43c44..9ba4b18 100644
--- a/arch/arm/boot/dts/am335x-evmsk.dts
+++ b/arch/arm/boot/dts/am335x-evmsk.dts
@@ -672,6 +672,7 @@
 	ti,non-removable;
 	bus-width =3D <4>;
 	cap-power-off-card;
+	keep-power-in-suspend;
 	pinctrl-names =3D "default";
 	pinctrl-0 =3D <&mmc2_pins>;
=20
--=20
2.7.4

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
