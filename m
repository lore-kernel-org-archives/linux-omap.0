From: Johan Hovold <johan@kernel.org>
Subject: [PATCH 11/12] ARM: dts: am33xx: update rtc node compatible property
Date: Thu,  9 Oct 2014 21:06:33 +0200
Message-ID: <1412881594-25678-12-git-send-email-johan@kernel.org>
References: <1412881594-25678-1-git-send-email-johan@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1412881594-25678-1-git-send-email-johan@kernel.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Alessandro Zummo <a.zummo@towertech.it>, Tony Lindgren <tony@atomide.com>, =?UTF-8?q?Beno=C3=AEt=20Cousson?= <bcousson@baylibre.com>
Cc: devicetree@vger.kernel.org, rtc-linux@googlegroups.com, Colin Foe-Parker <colin.foeparker@logicpd.com>, Lokesh Vutla <lokeshvutla@ti.com>, j-keerthy@ti.com, nsekhar@ti.com, linux-kernel@vger.kernel.org, Felipe Balbi <balbi@ti.com>, Johan Hovold <johan@kernel.org>, t-kristo@ti.com, linux-arm-kernel@lists.infradead.org, AnilKumar Ch <anilkumar@ti.com>, Andrew Morton <akpm@linux-foundation.org>, linux-omap@vger.kernel.org, Guenter Roeck <linux@roeck-us.net>
List-Id: linux-omap@vger.kernel.org

Enable am33xx specific RTC features (e.g. PMIC control) by adding
"ti,am3352-rtc" to the compatible property of the rtc node.

Signed-off-by: Johan Hovold <johan@kernel.org>
---
 arch/arm/boot/dts/am33xx.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/am33xx.dtsi b/arch/arm/boot/dts/am33xx.dtsi
index 3a0a161342ba..098e53602d5c 100644
--- a/arch/arm/boot/dts/am33xx.dtsi
+++ b/arch/arm/boot/dts/am33xx.dtsi
@@ -411,7 +411,7 @@
 		};
 
 		rtc: rtc@44e3e000 {
-			compatible = "ti,da830-rtc";
+			compatible = "ti,am3352-rtc", "ti,da830-rtc";
 			reg = <0x44e3e000 0x1000>;
 			interrupts = <75
 				      76>;
-- 
2.0.4
