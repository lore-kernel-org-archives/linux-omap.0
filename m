From: yegorslists@googlemail.com
Subject: [PATCH] ARM: dts: am335x-baltos: don't reset gpio3 block
Date: Wed,  2 Nov 2016 10:08:16 +0100
Message-ID: <1478077696-21003-1-git-send-email-yegorslists@googlemail.com>
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
Cc: tony@atomide.com, bcousson@baylibre.com, linux-arm-kernel@lists.infradead.org, Yegor Yefremov <yegorslists@googlemail.com>
List-Id: linux-omap@vger.kernel.org

From: Yegor Yefremov <yegorslists@googlemail.com>

This change is needed in order to enable some hardware components
from bootloader.

Signed-off-by: Yegor Yefremov <yegorslists@googlemail.com>
---
 arch/arm/boot/dts/am335x-baltos.dtsi | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm/boot/dts/am335x-baltos.dtsi b/arch/arm/boot/dts/am335x-baltos.dtsi
index dd45d17..09b9541 100644
--- a/arch/arm/boot/dts/am335x-baltos.dtsi
+++ b/arch/arm/boot/dts/am335x-baltos.dtsi
@@ -406,3 +406,7 @@
 &gpio0 {
 	ti,no-reset-on-init;
 };
+
+&gpio3 {
+	ti,no-reset-on-init;
+};
-- 
2.1.4
