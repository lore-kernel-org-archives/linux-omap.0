From: Nishanth Menon <nm@ti.com>
Subject: [TMP PATCH V2 5/5] ARM: dts: am57xx-beagle-x15: Add wakeup irq for
 mcp79410
Date: Tue, 23 Jun 2015 11:15:14 -0500
Message-ID: <1435076114-12416-6-git-send-email-nm@ti.com>
References: <1435076114-12416-1-git-send-email-nm@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1435076114-12416-1-git-send-email-nm@ti.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Alexandre Belloni <alexandre.belloni@free-electrons.com>, Alessandro Zummo <a.zummo@towertech.it>
Cc: Nishanth Menon <nm@ti.com>, grygorii.strashko@ti.com, rtc-linux@googlegroups.com, linux-kernel@vger.kernel.org, balbi@ti.com, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

With the support in the generic PM framework for wakeirq and capability
added to the rtc-ds1307 driver to support this, we can now define the
optional wakeup irq to allow the RTC to wakeup the system from low power
modes as part of suspend.

Signed-off-by: Nishanth Menon <nm@ti.com>
---

Please do not merge this patch -> since this needs to come via linux-omap
tree and also needs to be done with a few other changes on other peripherals.
This is meant for illustration only.

 arch/arm/boot/dts/am57xx-beagle-x15.dts |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/am57xx-beagle-x15.dts b/arch/arm/boot/dts/am57xx-beagle-x15.dts
index a42cc377a862..5c9ce2df260a 100644
--- a/arch/arm/boot/dts/am57xx-beagle-x15.dts
+++ b/arch/arm/boot/dts/am57xx-beagle-x15.dts
@@ -517,7 +517,8 @@
 	mcp_rtc: rtc@6f {
 		compatible = "microchip,mcp7941x";
 		reg = <0x6f>;
-		interrupts = <GIC_SPI 2 IRQ_TYPE_EDGE_RISING>;  /* IRQ_SYS_1N */
+		interrupts-extended = <&crossbar_mpu GIC_SPI 2 IRQ_TYPE_EDGE_RISING>,
+				      <&dra7_pmx_core 0x424>;
 
 		pinctrl-names = "default";
 		pinctrl-0 = <&mcp79410_pins_default>;
-- 
1.7.9.5
