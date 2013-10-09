From: Rajendra Nayak <rnayak@ti.com>
Subject: [PATCH v2 5/5] ARM: dts: AM335x-evmsk: Do not reset gpio0
Date: Wed, 9 Oct 2013 15:42:01 +0530
Message-ID: <1381313521-10422-6-git-send-email-rnayak@ti.com>
References: <1381313521-10422-1-git-send-email-rnayak@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-doc-owner@vger.kernel.org>
In-Reply-To: <1381313521-10422-1-git-send-email-rnayak@ti.com>
Sender: linux-doc-owner@vger.kernel.org
To: bcousson@baylibre.com, paul@pwsan.com, tony@atomide.com
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, linux-doc@vger.kernel.org, Rajendra Nayak <rnayak@ti.com>
List-Id: linux-omap@vger.kernel.org

Do not reset GPIO0 at  boot-up because GPIO0 is used
on AM335x EVM-SK to control VTT regulators on DDR3.

Without this EVM-SK boards fail to boot-up because
of DDR3 corruption.

Signed-off-by: Rajendra Nayak <rnayak@ti.com>
---
 arch/arm/boot/dts/am335x-evmsk.dts |    4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm/boot/dts/am335x-evmsk.dts b/arch/arm/boot/dts/am335x-evmsk.dts
index 4f339fa..0e44d29 100644
--- a/arch/arm/boot/dts/am335x-evmsk.dts
+++ b/arch/arm/boot/dts/am335x-evmsk.dts
@@ -419,3 +419,7 @@
 	phy_id = <&davinci_mdio>, <1>;
 	phy-mode = "rgmii-txid";
 };
+
+&gpio0 {
+	ti,no-reset-on-init;
+};
-- 
1.7.9.5

