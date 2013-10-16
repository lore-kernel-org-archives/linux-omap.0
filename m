From: Nishanth Menon <nm@ti.com>
Subject: [PATCH V7 7/8] ARM: dts: DRA7: Add CPU OPP table
Date: Wed, 16 Oct 2013 10:39:07 -0500
Message-ID: <1381937948-27057-8-git-send-email-nm@ti.com>
References: <1381937948-27057-1-git-send-email-nm@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1381937948-27057-1-git-send-email-nm@ti.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: =?UTF-8?q?Beno=C3=AEt=20Cousson?= <bcousson@baylibre.com>, Tony Lindgren <tony@atomide.com>
Cc: Nishanth Menon <nm@ti.com>, devicetree@vger.kernel.org, Kevin Hilman <khilman@deeprootsystems.com>, J Keerthy <j-keerthy@ti.com>, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

From: J Keerthy <j-keerthy@ti.com>

Add DT OPP table for DRA7xx family of devices. This data is decoded by
OF with of_init_opp_table() helper function.

The data is based on DRA75x, DRA74x Data Manual revision F (Sept 2013).

TODO: add OPP_HIGH after AVS-Class0 is functional
NOTE: The voltage and frequency values work well only on NOM samples
and it is mandatory to use ABB/AVS Class 0 support for all OPPs.

Clock nodes are pending clock node alignment.

[nm@ti.com: cleanups and rebase to latest]
Signed-off-by: Nishanth Menon <nm@ti.com>
Signed-off-by: J Keerthy <j-keerthy@ti.com>
---
 arch/arm/boot/dts/dra7.dtsi |    6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/arm/boot/dts/dra7.dtsi b/arch/arm/boot/dts/dra7.dtsi
index 02e430b..92cbe3b 100644
--- a/arch/arm/boot/dts/dra7.dtsi
+++ b/arch/arm/boot/dts/dra7.dtsi
@@ -36,6 +36,12 @@
 			device_type = "cpu";
 			compatible = "arm,cortex-a15";
 			reg = <0>;
+
+			operating-points = <
+				/* kHz    uV */
+				1000000	1060000
+				1176000	1160000
+				>;
 		};
 		cpu@1 {
 			device_type = "cpu";
-- 
1.7.9.5
