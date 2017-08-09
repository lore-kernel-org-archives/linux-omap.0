From: Sekhar Nori <nsekhar-l0cyMroinI0@public.gmane.org>
Subject: [PATCH v2 2/3] ARM: dts: dra72-evm-revc: workaround incorrect DP83867 RX_CTRL pin strap
Date: Wed, 9 Aug 2017 19:32:48 +0530
Message-ID: <a96549250204b80373ebf58abeed1c67441e6fb8.1502284400.git.nsekhar@ti.com>
References: <cover.1502284400.git.nsekhar@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <cover.1502284400.git.nsekhar-l0cyMroinI0@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Cc: Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: linux-omap@vger.kernel.org

The DRA72 EVM Rev C straps the DP83867 GigaBit Ethernet phy's RX_DV/RX_CTRL
pin in mode 1. Unfortunately, the phy data manual disallows this.

Add "ti,dp83867-rxctrl-strap-quirk" property to the phy's device-tree node
to allow kernel to enable software workaround for this incorrect strap
setting. This is as suggested by the phy's datamanual and ensures proper
operation of this PHY.

This needs to be done for both instances of this PHY present on the board.

Signed-off-by: Sekhar Nori <nsekhar-l0cyMroinI0@public.gmane.org>
---
 arch/arm/boot/dts/dra72-evm-revc.dts | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/arm/boot/dts/dra72-evm-revc.dts b/arch/arm/boot/dts/dra72-evm-revc.dts
index 3ecac56bf504..be18bc023c3f 100644
--- a/arch/arm/boot/dts/dra72-evm-revc.dts
+++ b/arch/arm/boot/dts/dra72-evm-revc.dts
@@ -70,6 +70,7 @@
 		ti,min-output-impedance;
 		interrupt-parent = <&gpio6>;
 		interrupts = <16 IRQ_TYPE_EDGE_FALLING>;
+		ti,dp83867-rxctrl-strap-quirk;
 	};
 
 	dp83867_1: ethernet-phy@3 {
@@ -80,5 +81,7 @@
 		ti,min-output-impedance;
 		interrupt-parent = <&gpio6>;
 		interrupts = <16 IRQ_TYPE_EDGE_FALLING>;
+		ti,dp83867-rxctrl-strap-quirk;
 	};
 };
+
-- 
2.9.0

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
