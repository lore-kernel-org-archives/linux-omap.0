From: Teresa Remmet <t.remmet@phytec.de>
Subject: [PATCH] ARM: dts: am335x-pcm953: Fix legacy wakeup source binding
Date: Fri, 10 Feb 2017 13:29:07 +0100
Message-ID: <1486729747-4604-1-git-send-email-t.remmet@phytec.de>
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
To: linux-omap@vger.kernel.org, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: Tony Lindgren <tony@atomide.com>, Mark Rutland <mark.rutland@arm.com>, Rob Herring <robh+dt@kernel.org>, =?UTF-8?q?Beno=C3=AEt=20Cousson?= <bcousson@baylibre.com>, Sudeep Holla <sudeep.holla@arm.com>
List-Id: linux-omap@vger.kernel.org

Replaced the legacy binding "gpio-key,wakeup" with "wakeup-source" as
noted in the kernel documentation.

Signed-off-by: Teresa Remmet <t.remmet@phytec.de>
Reported-by: Sudeep Holla <sudeep.holla@arm.com>
---
 arch/arm/boot/dts/am335x-pcm-953.dtsi | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/am335x-pcm-953.dtsi b/arch/arm/boot/dts/am335x-pcm-953.dtsi
index 02981ea..1ec8e0d 100644
--- a/arch/arm/boot/dts/am335x-pcm-953.dtsi
+++ b/arch/arm/boot/dts/am335x-pcm-953.dtsi
@@ -63,14 +63,14 @@
 			label = "home";
 			linux,code = <KEY_HOME>;
 			gpios = <&gpio3 7 GPIO_ACTIVE_HIGH>;
-			gpio-key,wakeup;
+			wakeup-source;
 		};
 
 		button@1 {
 			label = "menu";
 			linux,code = <KEY_MENU>;
 			gpios = <&gpio3 8 GPIO_ACTIVE_HIGH>;
-			gpio-key,wakeup;
+			wakeup-source;
 		};
 
 	};
-- 
1.9.1
