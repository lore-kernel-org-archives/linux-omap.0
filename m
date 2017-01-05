From: Teresa Remmet <t.remmet@phytec.de>
Subject: [PATCH 6/6] ARM: dts: am335x-wega: Update ethernet phy node
Date: Thu, 5 Jan 2017 15:50:51 +0100
Message-ID: <1483627851-17996-7-git-send-email-t.remmet@phytec.de>
References: <1483627851-17996-1-git-send-email-t.remmet@phytec.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1483627851-17996-1-git-send-email-t.remmet@phytec.de>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: linux-omap@vger.kernel.org, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: Tony Lindgren <tony@atomide.com>, Mark Rutland <mark.rutland@arm.com>, Rob Herring <robh+dt@kernel.org>, =?UTF-8?q?Beno=C3=AEt=20Cousson?= <bcousson@baylibre.com>
List-Id: linux-omap@vger.kernel.org

Update ethernet phy1 node to use phy-handle now.

Signed-off-by: Teresa Remmet <t.remmet@phytec.de>
---
 arch/arm/boot/dts/am335x-wega.dtsi | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/am335x-wega.dtsi b/arch/arm/boot/dts/am335x-wega.dtsi
index e97fd6d..8ce5417 100644
--- a/arch/arm/boot/dts/am335x-wega.dtsi
+++ b/arch/arm/boot/dts/am335x-wega.dtsi
@@ -119,11 +119,17 @@
 };
 
 &cpsw_emac1 {
-	phy_id = <&davinci_mdio>, <1>;
+	phy-handle = <&phy1>;
 	phy-mode = "mii";
 	dual_emac_res_vlan = <2>;
 };
 
+&davinci_mdio {
+	phy1: ethernet-phy@1 {
+		reg = <1>;
+	};
+};
+
 &mac {
 	slaves = <2>;
 	pinctrl-names = "default";
-- 
1.9.1
