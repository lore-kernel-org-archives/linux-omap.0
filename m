From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH] ARM: dts: Fix ldp gpio keys to use defines
Date: Wed, 20 May 2015 14:25:12 -0700
Message-ID: <1432157112-19941-1-git-send-email-tony@atomide.com>
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
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: linux-omap@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

Fix ldp gpio keys to use defines.

Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 arch/arm/boot/dts/omap3-ldp.dts | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/arch/arm/boot/dts/omap3-ldp.dts b/arch/arm/boot/dts/omap3-ldp.dts
index b699bc4..bd6e676 100644
--- a/arch/arm/boot/dts/omap3-ldp.dts
+++ b/arch/arm/boot/dts/omap3-ldp.dts
@@ -34,63 +34,63 @@
 		key_enter {
 			label = "enter";
 			gpios = <&gpio4 5 GPIO_ACTIVE_LOW>; /* gpio101 */
-			linux,code = <0x0107001c>; /* KEY_ENTER */
+			linux,code = <KEY_ENTER>;
 			gpio-key,wakeup;
 		};
 
 		key_f1 {
 			label = "f1";
 			gpios = <&gpio4 6 GPIO_ACTIVE_LOW>; /* gpio102 */
-			linux,code = <0x0303003b>; /* KEY_F1 */
+			linux,code = <KEY_F1>;
 			gpio-key,wakeup;
 		};
 
 		key_f2 {
 			label = "f2";
 			gpios = <&gpio4 7 GPIO_ACTIVE_LOW>; /* gpio103 */
-			linux,code = <0x0403003c>; /* KEY_F2 */
+			linux,code = <KEY_F2>;
 			gpio-key,wakeup;
 		};
 
 		key_f3 {
 			label = "f3";
 			gpios = <&gpio4 8 GPIO_ACTIVE_LOW>; /* gpio104 */
-			linux,code = <0x0503003d>; /* KEY_F3 */
+			linux,code = <KEY_F3>;
 			gpio-key,wakeup;
 		};
 
 		key_f4 {
 			label = "f4";
 			gpios = <&gpio4 9 GPIO_ACTIVE_LOW>; /* gpio105 */
-			linux,code = <0x0704003e>; /* KEY_F4 */
+			linux,code = <KEY_F4>;
 			gpio-key,wakeup;
 		};
 
 		key_left {
 			label = "left";
 			gpios = <&gpio4 10 GPIO_ACTIVE_LOW>; /* gpio106 */
-			linux,code = <0x04070069>; /* KEY_LEFT */
+			linux,code = <KEY_LEFT>;
 			gpio-key,wakeup;
 		};
 
 		key_right {
 			label = "right";
 			gpios = <&gpio4 11 GPIO_ACTIVE_LOW>; /* gpio107 */
-			linux,code = <0x0507006a>; /* KEY_RIGHT */
+			linux,code = <KEY_RIGHT>;
 			gpio-key,wakeup;
 		};
 
 		key_up {
 			label = "up";
 			gpios = <&gpio4 12 GPIO_ACTIVE_LOW>; /* gpio108 */
-			linux,code = <0x06070067>; /* KEY_UP */
+			linux,code = <KEY_UP>;
 			gpio-key,wakeup;
 		};
 
 		key_down {
 			label = "down";
 			gpios = <&gpio4 13 GPIO_ACTIVE_LOW>; /* gpio109 */
-			linux,code = <0x0707006c>; /* KEY_DOWN */
+			linux,code = <KEY_DOWN>;
 			gpio-key,wakeup;
 		};
 	};
-- 
2.1.4
