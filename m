From: Felipe Balbi <balbi@ti.com>
Subject: [PATCH 2/2] arm: boot: dts: am437x-sk: reduce col-scan-delay-us
Date: Thu, 9 Apr 2015 10:59:27 -0500
Message-ID: <1428595167-10050-2-git-send-email-balbi@ti.com>
References: <1428595167-10050-1-git-send-email-balbi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1428595167-10050-1-git-send-email-balbi@ti.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Tony Lindgren <tony@atomide.com>
Cc: Linux OMAP Mailing List <linux-omap@vger.kernel.org>, Felipe Balbi <balbi@ti.com>, Linux ARM Kernel Mailing List <linux-arm-kernel@lists.infradead.org>
List-Id: linux-omap@vger.kernel.org

The new AM437x SK Beta boards have removed the
large capacitors on the gpio-matrix column lines
which means we can reduce col-scan-delay-us to 5us
without loosing functionality.

Signed-off-by: Felipe Balbi <balbi@ti.com>
---
 arch/arm/boot/dts/am437x-sk-evm.dts | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/am437x-sk-evm.dts b/arch/arm/boot/dts/am437x-sk-evm.dts
index 58dc1cd58bdd..37ce7b1bf07f 100644
--- a/arch/arm/boot/dts/am437x-sk-evm.dts
+++ b/arch/arm/boot/dts/am437x-sk-evm.dts
@@ -49,7 +49,7 @@
 		pinctrl-0 = <&matrix_keypad_pins>;
 
 		debounce-delay-ms = <5>;
-		col-scan-delay-us = <1500>;
+		col-scan-delay-us = <5>;
 
 		row-gpios = <&gpio5 5 GPIO_ACTIVE_HIGH		/* Bank5, pin5 */
 				&gpio5 6 GPIO_ACTIVE_HIGH>;	/* Bank5, pin6 */
-- 
2.3.0
