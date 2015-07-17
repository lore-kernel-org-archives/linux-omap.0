From: Dave Gerlach <d-gerlach@ti.com>
Subject: [PATCH 3/4] ARM: dts: AM33xx: Add the wkup_m3_ipc node
Date: Fri, 17 Jul 2015 16:08:03 -0500
Message-ID: <1437167284-25659-4-git-send-email-d-gerlach@ti.com>
References: <1437167284-25659-1-git-send-email-d-gerlach@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1437167284-25659-1-git-send-email-d-gerlach@ti.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org
Cc: Dave Gerlach <d-gerlach@ti.com>, Tony Lindgren <tony@atomide.com>, Keerthy <j-keerthy@ti.com>, Jassi Brar <jassisinghbrar@gmail.com>, Santosh Shilimkar <ssantosh@kernel.org>
List-Id: linux-omap@vger.kernel.org

From: Suman Anna <s-anna@ti.com>

Add the Wakeup M3 IPC node for the wkup_m3_ipc driver on AM33xx SoCs.
This node uses the IPC registers, part of the Control Module, and is
therefore added as a child of the scm node.

Signed-off-by: Suman Anna <s-anna@ti.com>
Signed-off-by: Dave Gerlach <d-gerlach@ti.com>
---
 arch/arm/boot/dts/am33xx.dtsi | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/arm/boot/dts/am33xx.dtsi b/arch/arm/boot/dts/am33xx.dtsi
index 4f2c07a..13f097f 100644
--- a/arch/arm/boot/dts/am33xx.dtsi
+++ b/arch/arm/boot/dts/am33xx.dtsi
@@ -153,6 +153,14 @@
 					};
 				};
 
+				wkup_m3_ipc: wkup_m3_ipc@1324 {
+					compatible = "ti,am3352-wkup-m3-ipc";
+					reg = <0x1324 0x24>;
+					interrupts = <78>;
+					ti,rproc = <&wkup_m3>;
+					mboxes = <&mailbox &mbox_wkupm3>;
+				};
+
 				scm_clockdomains: clockdomains {
 				};
 			};
-- 
2.4.5
