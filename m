From: Dave Gerlach <d-gerlach@ti.com>
Subject: [PATCH v2 2/3] ARM: dts: am4372: Change operating-points-v2 table to
 am4372 version
Date: Wed, 31 Aug 2016 21:48:15 -0500
Message-ID: <20160901024816.32390-3-d-gerlach@ti.com>
References: <20160901024816.32390-1-d-gerlach@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20160901024816.32390-1-d-gerlach@ti.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, devicetree@vger.kernel.org, Tony Lindgren <tony@atomide.com>, linux-pm@vger.kernel.org
Cc: Mark Rutland <mark.rutland@arm.com>, Viresh Kumar <viresh.kumar@linaro.org>, Nishanth Menon <nm@ti.com>, Rob Herring <robh+dt@kernel.org>, Dave Gerlach <d-gerlach@ti.com>
List-Id: linux-omap@vger.kernel.org

The operating-points-v2 table got merged before the binding had
stabilized so update the compatible string to am4372 version.

Signed-off-by: Dave Gerlach <d-gerlach@ti.com>
---
 arch/arm/boot/dts/am4372.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/am4372.dtsi b/arch/arm/boot/dts/am4372.dtsi
index 0fadae5396e1..cdadcd793229 100644
--- a/arch/arm/boot/dts/am4372.dtsi
+++ b/arch/arm/boot/dts/am4372.dtsi
@@ -53,7 +53,7 @@
 	};
 
 	cpu0_opp_table: opp_table0 {
-		compatible = "operating-points-v2";
+		compatible = "operating-points-v2-ti-am4372-cpu";
 
 		opp50@300000000 {
 			opp-hz = /bits/ 64 <300000000>;
-- 
2.9.0
