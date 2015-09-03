From: Nishanth Menon <nm@ti.com>
Subject: [PATCH] ARM: dts: am57xx-beagle-x15: Add wakeup irq for mcp79410
Date: Thu, 3 Sep 2015 14:24:00 -0500
Message-ID: <1441308240-26725-1-git-send-email-nm@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>, =?UTF-8?q?Beno=C3=AEt=20Cousson?= <bcousson@baylibre.com>
Cc: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, linux-omap@vger.kernel.org, Nishanth Menon <nm@ti.com>
List-Id: linux-omap@vger.kernel.org

With the support in the generic PM framework for wakeirq and capability
added to the rtc-ds1307 driver to support this, we can now define the
optional wakeup irq to allow the RTC to wakeup the system from low power
modes as part of suspend.

Signed-off-by: Nishanth Menon <nm@ti.com>
---

This patch depends on upcoming merge for RTC
https://git.kernel.org/cgit/linux/kernel/git/abelloni/linux.git/log/?h=rtc-next&ofs=50

merge to master of:
9901c41bd019 rtc: ds1307: Support optional wakeup interrupt source
496a7ede6cac rtc: ds1307: Sort the headers
e28475b15b65 rtc: ds1307: Switch to managed irq allocation
27a1dce6528a rtc: ds1307: Convert to threaded IRQ

Tested with the above commits from linux-next: http://pastebin.ubuntu.com/12265857/

Could probably go in round 2 of merges for 4.3?

 arch/arm/boot/dts/am57xx-beagle-x15.dts |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/am57xx-beagle-x15.dts b/arch/arm/boot/dts/am57xx-beagle-x15.dts
index ede7fb73c717..8464f3cea280 100644
--- a/arch/arm/boot/dts/am57xx-beagle-x15.dts
+++ b/arch/arm/boot/dts/am57xx-beagle-x15.dts
@@ -526,7 +526,8 @@
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
