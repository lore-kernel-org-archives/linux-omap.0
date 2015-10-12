From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Subject: [PATCH 31/37] ARM: dts: omap3-beagle: Fix regulator enable GPIO
 polarity
Date: Tue, 13 Oct 2015 00:13:00 +0300
Message-ID: <1444684386-17094-32-git-send-email-laurent.pinchart@ideasonboard.com>
References: <1444684386-17094-1-git-send-email-laurent.pinchart@ideasonboard.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1444684386-17094-1-git-send-email-laurent.pinchart@ideasonboard.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: linux-arm-kernel@lists.infradead.org
Cc: Tony Lindgren <tony@atomide.com>, linux-omap@vger.kernel.org, Benoit Cousson <bcousson@baylibre.com>
List-Id: linux-omap@vger.kernel.org

The enable GPIO is active low, but is flagged as active high in the gpio
property. As the gpio property flags are currently unused by the driver
this doesn't cause any issue for now, but will break later if the driver
starts making use of the flags. Fix it.

Signed-off-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
---
 arch/arm/boot/dts/omap3-beagle.dts | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

Cc: linux-omap@vger.kernel.org
Cc: Benoit Cousson <bcousson@baylibre.com>
Cc: Tony Lindgren <tony@atomide.com>

diff --git a/arch/arm/boot/dts/omap3-beagle.dts b/arch/arm/boot/dts/omap3-beagle.dts
index a5474113cd50..0849035643fc 100644
--- a/arch/arm/boot/dts/omap3-beagle.dts
+++ b/arch/arm/boot/dts/omap3-beagle.dts
@@ -55,7 +55,7 @@
 		regulator-name = "hsusb2_vbus";
 		regulator-min-microvolt = <3300000>;
 		regulator-max-microvolt = <3300000>;
-		gpio = <&twl_gpio 18 0>;	/* GPIO LEDA */
+		gpio = <&twl_gpio 18 GPIO_ACTIVE_LOW>;	/* GPIO LEDA */
 		startup-delay-us = <70000>;
 	};
 
-- 
2.4.9
