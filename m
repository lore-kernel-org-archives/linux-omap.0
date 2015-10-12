From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Subject: [PATCH 08/37] ARM: dts: omap3-sb-t35: Remove invalid
 enable-active-low regulator property
Date: Tue, 13 Oct 2015 00:12:37 +0300
Message-ID: <1444684386-17094-9-git-send-email-laurent.pinchart@ideasonboard.com>
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

The property isn't part of the regulator-fixed DT bindings and isn't
used by the driver. Remove it.

Signed-off-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
---
 arch/arm/boot/dts/omap3-sb-t35.dtsi | 1 -
 1 file changed, 1 deletion(-)

Cc: linux-omap@vger.kernel.org
Cc: Benoit Cousson <bcousson@baylibre.com>
Cc: Tony Lindgren <tony@atomide.com>

diff --git a/arch/arm/boot/dts/omap3-sb-t35.dtsi b/arch/arm/boot/dts/omap3-sb-t35.dtsi
index 827f614261f6..b77e25d20e07 100644
--- a/arch/arm/boot/dts/omap3-sb-t35.dtsi
+++ b/arch/arm/boot/dts/omap3-sb-t35.dtsi
@@ -50,7 +50,6 @@
 		pinctrl-names = "default";
 		pinctrl-0 = <&sb_t35_audio_amp>;
 		gpio = <&gpio2 29 GPIO_ACTIVE_LOW>;   /* gpio_61 */
-		enable-active-low;
 		regulator-always-on;
 	};
 };
-- 
2.4.9
