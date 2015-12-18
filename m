From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH] ARM: dts: Fix UART wakeirq for omap4 duovero parlor
Date: Fri, 18 Dec 2015 10:35:30 -0800
Message-ID: <1450463730-5973-1-git-send-email-tony@atomide.com>
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
Cc: Florian Vaussard <florian.vaussard@epfl.ch>, Arun Bharadwaj <arun@gumstix.com>, linux-arm-kernel@lists.infradead.org, Ash Charles <ash@gumstix.com>
List-Id: linux-omap@vger.kernel.org

Looks like we're missing the wakeirq for the console uart for
duovero parlor. Let's add that as without it console acess just
hangs with PM enabled.

Cc: Arun Bharadwaj <arun@gumstix.com>
Cc: Ash Charles <ash@gumstix.com>
Cc: Florian Vaussard <florian.vaussard@epfl.ch>
Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 arch/arm/boot/dts/omap4-duovero-parlor.dts | 4 ++++
 1 file changed, 4 insertions(+)

--- a/arch/arm/boot/dts/omap4-duovero-parlor.dts
+++ b/arch/arm/boot/dts/omap4-duovero-parlor.dts
@@ -189,3 +189,7 @@
 	};
 };
 
+&uart3 {
+	interrupts-extended = <&wakeupgen GIC_SPI 74 IRQ_TYPE_LEVEL_HIGH
+			       &omap4_pmx_core OMAP4_UART3_RX>;
+};
-- 
2.6.2
