From: Mugunthan V N <mugunthanvnm-l0cyMroinI0@public.gmane.org>
Subject: [PATCH 1/1] ARM: dts: dra72x-evm: Enable CPSW and MDIO
Date: Mon, 3 Nov 2014 15:28:13 +0530
Message-ID: <1415008693-28552-1-git-send-email-mugunthanvnm@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: bcousson-rdvid1DuHRBWk0Htik3J/w@public.gmane.org, tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org
Cc: nm-l0cyMroinI0@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Mugunthan V N <mugunthanvnm-l0cyMroinI0@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

Adding CPSW phy-id, CPSW and MDIO pinmux configuration for active and
sleep states and enable them in board evm dts file.

Signed-off-by: Mugunthan V N <mugunthanvnm-l0cyMroinI0@public.gmane.org>
---

Adding device tree entry for CPSW to make it work in Switch mode.
Patches are tested on top of Nishanth's PM tree for v3.17 [1] and pushed
my tree to [2].

Did a boot test with CPSW and ping test with suspend/resume, the boot logs
on DRA72x EVM are posted at [3]

This patch depends on the DRA7xx CPSW support patch series [4] and one driver
patch (47276fc drivers: net:cpsw: fix probe_dt when only slave 1 is pinned out)
which is already present in linux-next

[1] git://github.com/nmenon/linux-2.6-playground.git testing/v3.17/cpu-idle-suspend-dra7-omap5-framework
[2] git://git.ti.com/~mugunthanvnm/ti-linux-kernel/linux.git for-v3.19/dra72-evm-cpsw
[3] http://pastebin.ubuntu.com/8800549/
[4] http://comments.gmane.org/gmane.linux.kernel/1810171

---
 arch/arm/boot/dts/dra72-evm.dts | 73 +++++++++++++++++++++++++++++++++++++++++
 1 file changed, 73 insertions(+)

diff --git a/arch/arm/boot/dts/dra72-evm.dts b/arch/arm/boot/dts/dra72-evm.dts
index 5147023..b8ebf89 100644
--- a/arch/arm/boot/dts/dra72-evm.dts
+++ b/arch/arm/boot/dts/dra72-evm.dts
@@ -22,3 +22,76 @@
 &uart1 {
 	status = "okay";
 };
+
+&dra7_pmx_core {
+	cpsw_default: cpsw_default {
+		pinctrl-single,pins = <
+			/* Slave 2 */
+			0x198 (PIN_OUTPUT | MUX_MODE3)	/* vin2a_d12.rgmii1_txc */
+			0x19c (PIN_OUTPUT | MUX_MODE3)	/* vin2a_d13.rgmii1_tctl */
+			0x1a0 (PIN_OUTPUT | MUX_MODE3)	/* vin2a_d14.rgmii1_td3 */
+			0x1a4 (PIN_OUTPUT | MUX_MODE3)	/* vin2a_d15.rgmii1_td2 */
+			0x1a8 (PIN_OUTPUT | MUX_MODE3)	/* vin2a_d16.rgmii1_td1 */
+			0x1ac (PIN_OUTPUT | MUX_MODE3)	/* vin2a_d17.rgmii1_td0 */
+			0x1b0 (PIN_INPUT | MUX_MODE3)	/* vin2a_d18.rgmii1_rclk */
+			0x1b4 (PIN_INPUT | MUX_MODE3)	/* vin2a_d19.rgmii1_rctl */
+			0x1b8 (PIN_INPUT | MUX_MODE3)	/* vin2a_d20.rgmii1_rd3 */
+			0x1bc (PIN_INPUT | MUX_MODE3)	/* vin2a_d21.rgmii1_rd2 */
+			0x1c0 (PIN_INPUT | MUX_MODE3)	/* vin2a_d22.rgmii1_rd1 */
+			0x1c4 (PIN_INPUT | MUX_MODE3)	/* vin2a_d23.rgmii1_rd0 */
+		>;
+
+	};
+
+	cpsw_sleep: cpsw_sleep {
+		pinctrl-single,pins = <
+			/* Slave 2 */
+			0x198 (MUX_MODE15)
+			0x19c (MUX_MODE15)
+			0x1a0 (MUX_MODE15)
+			0x1a4 (MUX_MODE15)
+			0x1a8 (MUX_MODE15)
+			0x1ac (MUX_MODE15)
+			0x1b0 (MUX_MODE15)
+			0x1b4 (MUX_MODE15)
+			0x1b8 (MUX_MODE15)
+			0x1bc (MUX_MODE15)
+			0x1c0 (MUX_MODE15)
+			0x1c4 (MUX_MODE15)
+		>;
+	};
+
+	davinci_mdio_default: davinci_mdio_default {
+		pinctrl-single,pins = <
+			/* MDIO */
+			0x23c (PIN_OUTPUT_PULLUP | MUX_MODE0)	/* mdio_d.mdio_d */
+			0x240 (PIN_INPUT_PULLUP | MUX_MODE0)	/* mdio_clk.mdio_clk */
+		>;
+	};
+
+	davinci_mdio_sleep: davinci_mdio_sleep {
+		pinctrl-single,pins = <
+			0x23c (MUX_MODE15)
+			0x240 (MUX_MODE15)
+		>;
+	};
+};
+
+&mac {
+	status = "okay";
+	pinctrl-names = "default", "sleep";
+	pinctrl-0 = <&cpsw_default>;
+	pinctrl-1 = <&cpsw_sleep>;
+};
+
+&cpsw_emac1 {
+	phy_id = <&davinci_mdio>, <3>;
+	phy-mode = "rgmii";
+};
+
+&davinci_mdio {
+	pinctrl-names = "default", "sleep";
+	pinctrl-0 = <&davinci_mdio_default>;
+	pinctrl-1 = <&davinci_mdio_sleep>;
+	active_slave = <1>;
+};
-- 
2.1.2.484.g13da0fc

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
