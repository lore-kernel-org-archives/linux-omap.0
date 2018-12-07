From: Russell King - ARM Linux <linux@armlinux.org.uk>
Subject: [PATCH] Fix OMAP4430 SDP Ethernet startup
Date: Fri, 7 Dec 2018 12:52:24 +0000
Message-ID: <20181207125224.GW6920@n2100.armlinux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Tony Lindgren <tony@atomide.com>, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, Santosh Shilimkar <santosh.shilimkar@ti.com>
List-Id: linux-omap@vger.kernel.org

It was noticed that unbinding and rebinding the KSZ8851 ethernet
resulted in the driver reporting "failed to read device ID" at probe.
Probing the reset line with a 'scope while repeatedly attempting to
bind the driver in a shell loop revealed that the KSZ8851 RSTN pin is
constantly held at zero, meaning the device is held in reset, and
does not respond on the SPI bus.

Experimentation with the startup delay on the regulator set to 50ms
shows that the reset is positively released after 20ms.

Schematics for this board are not available, and the traces are buried
in the inner layers of the board which makes tracing where the RSTN pin
extremely difficult.  We can only guess that the RSTN pin is wired to a
reset generator chip driven off the ethernet supply, which fits the
observed behaviour.

Include this delay in the regulator startup delay - effectively
treating the reset as a "supply stable" indicator.

This can not be modelled as a delay in the KSZ8851 driver since the
reset generation is board specific - if the RSTN pin had been wired to
a GPIO, reset could be released earlier via the already provided support
in the KSZ8851 driver.

Signed-off-by: Russell King <rmk+kernel@armlinux.org.uk>
---
 arch/arm/boot/dts/omap4-sdp.dts | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/boot/dts/omap4-sdp.dts b/arch/arm/boot/dts/omap4-sdp.dts
index 0831a2bf6cec..57acf3a8b8a1 100644
--- a/arch/arm/boot/dts/omap4-sdp.dts
+++ b/arch/arm/boot/dts/omap4-sdp.dts
@@ -33,6 +33,7 @@
 		gpio = <&gpio2 16 GPIO_ACTIVE_HIGH>;  /* gpio line 48 */
 		enable-active-high;
 		regulator-boot-on;
+		startup-delay-us = <25000>;
 	};
 
 	vbat: fixedregulator-vbat {

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line in suburbia: sync at 12.1Mbps down 622kbps up
According to speedtest.net: 11.9Mbps down 500kbps up
