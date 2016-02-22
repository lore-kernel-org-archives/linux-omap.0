From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 4/4] ARM: dts: Add RTC entry for dm816x
Date: Mon, 22 Feb 2016 15:04:05 -0800
Message-ID: <1456182245-1843-5-git-send-email-tony@atomide.com>
References: <1456182245-1843-1-git-send-email-tony@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1456182245-1843-1-git-send-email-tony@atomide.com>
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
Cc: Matthijs van Duin <matthijsvanduin@gmail.com>, Nicolas Chauvet <kwizart@gmail.com>, Neil Armstrong <narmstrong@baylibre.com>, Philipp Rosenberger <ilu@linutronix.de>, Delio Brignoli <dbrignoli@audioscience.com>, Brian Hutchinson <b.hutchman@gmail.com>, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

Add RTC entry for dm816x.

Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 arch/arm/boot/dts/dm816x.dtsi | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/arch/arm/boot/dts/dm816x.dtsi b/arch/arm/boot/dts/dm816x.dtsi
index c3b8811..e850686 100644
--- a/arch/arm/boot/dts/dm816x.dtsi
+++ b/arch/arm/boot/dts/dm816x.dtsi
@@ -214,6 +214,13 @@
 			reg = <0x48200000 0x1000>;
 		};
 
+		rtc: rtc@480c0000 {
+			compatible = "ti,am3352-rtc", "ti,da830-rtc";
+			reg = <0x480c0000 0x1000>;
+			interrupts = <75 76>;
+			ti,hwmods = "rtc";
+		};
+
 		mailbox: mailbox@480c8000 {
 			compatible = "ti,omap4-mailbox";
 			reg = <0x480c8000 0x2000>;
-- 
2.7.0
