From: Sekhar Nori <nsekhar@ti.com>
Subject: [PATCH v2 1/3] ARM: dts: dra71-evm: workaround incorrect DP83867
 RX_CTRL pin strap
Date: Wed, 9 Aug 2017 19:32:47 +0530
Message-ID: <dfb0980a35c345bc82f42128028c4d08ac6ae58c.1502284400.git.nsekhar@ti.com>
References: <cover.1502284400.git.nsekhar@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <cover.1502284400.git.nsekhar@ti.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Tony Lindgren <tony@atomide.com>
Cc: Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org, linux-omap@vger.kernel.org, Rob Herring <robh+dt@kernel.org>, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

The DRA71 EVM straps the DP83867 GigaBit Ethernet phy's RX_DV/RX_CTRL pin
in mode 1. Unfortunately, the phy data manual disallows this.

Add "ti,dp83867-rxctrl-strap-quirk" property to the phy's device-tree node
to allow kernel to enable software workaround for this incorrect strap
setting. This is as suggested by the phy's datamanual and ensures proper
operation of this PHY.

This needs to be done for both instances of this PHY present on the board.

Signed-off-by: Sekhar Nori <nsekhar@ti.com>
---
 arch/arm/boot/dts/dra71-evm.dts | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/boot/dts/dra71-evm.dts b/arch/arm/boot/dts/dra71-evm.dts
index a6298eb56978..9897e8fa6845 100644
--- a/arch/arm/boot/dts/dra71-evm.dts
+++ b/arch/arm/boot/dts/dra71-evm.dts
@@ -191,6 +191,7 @@
 		ti,tx-internal-delay = <DP83867_RGMIIDCTL_250_PS>;
 		ti,fifo-depth = <DP83867_PHYCR_FIFO_DEPTH_8_B_NIB>;
 		ti,min-output-impedance;
+		ti,dp83867-rxctrl-strap-quirk;
 	};
 
 	dp83867_1: ethernet-phy@3 {
@@ -199,6 +200,7 @@
 		ti,tx-internal-delay = <DP83867_RGMIIDCTL_250_PS>;
 		ti,fifo-depth = <DP83867_PHYCR_FIFO_DEPTH_8_B_NIB>;
 		ti,min-output-impedance;
+		ti,dp83867-rxctrl-strap-quirk;
 	};
 };
 
-- 
2.9.0
