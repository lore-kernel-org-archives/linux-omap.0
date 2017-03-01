From: Keerthy <j-keerthy@ti.com>
Subject: [PATCH 4/7] ARM: OMAP4460: Thermal: Add slope and offset values
Date: Wed, 1 Mar 2017 15:59:47 +0530
Message-ID: <1488364190-23488-5-git-send-email-j-keerthy@ti.com>
References: <1488364190-23488-1-git-send-email-j-keerthy@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1488364190-23488-1-git-send-email-j-keerthy@ti.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: tony@atomide.com, edubezval@gmail.com
Cc: linux-pm@vger.kernel.org, j-keerthy@ti.com, linux-kernel@vger.kernel.org, t-kristo@ti.com, robh+dt@kernel.org, rui.zhang@intel.com, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

Currently the slope and offset values for calculating the
hot spot temperature of a particular thermal zone is part
of driver data. Pass them here instead and obtain the values
while of node parsing.

Signed-off-by: Keerthy <j-keerthy@ti.com>
---
 arch/arm/boot/dts/omap4460.dtsi | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm/boot/dts/omap4460.dtsi b/arch/arm/boot/dts/omap4460.dtsi
index ef66e12..c43f2a2 100644
--- a/arch/arm/boot/dts/omap4460.dtsi
+++ b/arch/arm/boot/dts/omap4460.dtsi
@@ -90,4 +90,8 @@
 
 };
 
+&cpu_thermal {
+	coefficients = <348 (-9301)>;
+};
+
 /include/ "omap446x-clocks.dtsi"
-- 
1.9.1
