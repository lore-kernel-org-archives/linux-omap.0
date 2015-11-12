From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: [PATCH v4 1/3] ARM: DTS: dra7: Fix McASP3 node regarding to clocks
Date: Thu, 12 Nov 2015 09:32:57 +0200
Message-ID: <1447313579-23873-2-git-send-email-peter.ujfalusi@ti.com>
References: <1447313579-23873-1-git-send-email-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1447313579-23873-1-git-send-email-peter.ujfalusi@ti.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: tony@atomide.com, paul@pwsan.com
Cc: t-kristo@ti.com, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, balbi@ti.com, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

McASP node needs to list all mandatory clocks: gfclk and ahclkx

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
Tested-by: Felipe Balbi <balbi@ti.com>
---
 arch/arm/boot/dts/dra7.dtsi | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/dra7.dtsi b/arch/arm/boot/dts/dra7.dtsi
index bc672fb91466..fe99231cbde5 100644
--- a/arch/arm/boot/dts/dra7.dtsi
+++ b/arch/arm/boot/dts/dra7.dtsi
@@ -1459,8 +1459,8 @@
 			interrupt-names = "tx", "rx";
 			dmas = <&sdma_xbar 133>, <&sdma_xbar 132>;
 			dma-names = "tx", "rx";
-			clocks = <&mcasp3_ahclkx_mux>;
-			clock-names = "fck";
+			clocks = <&mcasp3_aux_gfclk_mux>, <&mcasp3_ahclkx_mux>;
+			clock-names = "fck", "ahclkx";
 			status = "disabled";
 		};
 
-- 
2.6.2
