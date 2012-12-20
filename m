From: Ezequiel Garcia <ezequiel.garcia@free-electrons.com>
Subject: [PATCH] arm: omap3: igep0020: Add console default kernel arguments
Date: Thu, 20 Dec 2012 12:41:58 -0300
Message-ID: <1356018118-29852-1-git-send-email-ezequiel.garcia@free-electrons.com>
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
Sender: linux-arm-kernel-bounces@lists.infradead.org
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: Gregory Clement <gregory.clement@free-electrons.com>, Thomas Petazzoni <thomas.petazzoni@free-electrons.com>, Javier Martinez Canillas <javier@dowhile0.org>, Enric Balletbo i Serra <eballetbo@gmail.com>, Ezequiel Garcia <ezequiel.garcia@free-electrons.com>
List-Id: linux-omap@vger.kernel.org

IGEP v2 boards has console as ttyO2,115200n8.
It's better so simply set this as the default kernel argument
directly in the device tree board file.

Cc: Enric Balletbo i Serra <eballetbo@gmail.com>
Cc: Javier Martinez Canillas <javier@dowhile0.org>
Signed-off-by: Ezequiel Garcia <ezequiel.garcia@free-electrons.com>
---
 arch/arm/boot/dts/omap3-igep0020.dts |    4 ++++
 1 files changed, 4 insertions(+), 0 deletions(-)

diff --git a/arch/arm/boot/dts/omap3-igep0020.dts b/arch/arm/boot/dts/omap3-igep0020.dts
index e2b9849..45ffe21 100644
--- a/arch/arm/boot/dts/omap3-igep0020.dts
+++ b/arch/arm/boot/dts/omap3-igep0020.dts
@@ -15,6 +15,10 @@
 	model = "IGEPv2";
 	compatible = "isee,omap3-igep0020", "ti,omap3";
 
+	chosen {
+		bootargs = "console=ttyO2,115200n8 earlyprintk";
+	};
+
 	leds {
 		compatible = "gpio-leds";
 		boot {
-- 
1.7.8.6
