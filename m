From: AnilKumar Ch <anilkumar@ti.com>
Subject: [PATCH] ARM: dts: AM33XX: Add temperature sensor device tree data to
 am335x-evm
Date: Tue, 18 Sep 2012 13:24:19 +0530
Message-ID: <1347954859-11611-1-git-send-email-anilkumar@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.infradead.org
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: khali@linux-fr.org, linux@roeck-us.net, lm-sensors@lm-sensors.org
Cc: tony@atomide.com, linux-omap@vger.kernel.org, AnilKumar Ch <anilkumar@ti.com>, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

Add temperature sensor DT data to am335x-evm.dts. In AM335x EVM
tmp275 temperature sensor is connected to I2C2 bus. So this patch
adds child node inside i2c2 node with i2c slave address. This patch
is tested on AM335x EVM.

Signed-off-by: AnilKumar Ch <anilkumar@ti.com>
---
 arch/arm/boot/dts/am335x-evm.dts |    5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/arm/boot/dts/am335x-evm.dts b/arch/arm/boot/dts/am335x-evm.dts
index be309df..3b1f313 100644
--- a/arch/arm/boot/dts/am335x-evm.dts
+++ b/arch/arm/boot/dts/am335x-evm.dts
@@ -78,6 +78,11 @@
 				st,max-limit-y = <550>;
 				st,max-limit-z = <750>;
 			};
+
+			tmp275: tmp275@48 {
+				compatible = "ti,tmp275";
+				reg = <0x48>;
+			};
 		};
 
 		dcan1: d_can@481d0000 {
-- 
1.7.9.5
