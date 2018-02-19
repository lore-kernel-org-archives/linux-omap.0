From: Dave Gerlach <d-gerlach@ti.com>
Subject: [PATCH 7/9] ARM: dts: am33xx: Mark emif with ti,no-idle
Date: Sun, 18 Feb 2018 21:35:03 -0600
Message-ID: <1519011305-17822-8-git-send-email-d-gerlach@ti.com>
References: <1519011305-17822-1-git-send-email-d-gerlach@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1519011305-17822-1-git-send-email-d-gerlach@ti.com>
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
Cc: devicetree@vger.kernel.org, Dave Gerlach <d-gerlach@ti.com>, Keerthy J <j-keerthy@ti.com>, Johan Hovold <johan@kernel.org>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

We can never idle the emif hwmod from within the HLOS so mark the emif
node with ti,no-idle.

Signed-off-by: Dave Gerlach <d-gerlach@ti.com>
---
 arch/arm/boot/dts/am33xx.dtsi | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/boot/dts/am33xx.dtsi b/arch/arm/boot/dts/am33xx.dtsi
index 842e726b944e..77c618829734 100644
--- a/arch/arm/boot/dts/am33xx.dtsi
+++ b/arch/arm/boot/dts/am33xx.dtsi
@@ -964,6 +964,7 @@
 			ti,hwmods = "emif";
 			sram = <&pm_sram_code
 				&pm_sram_data>;
+			ti,no-idle;
 		};
 
 		gpmc: gpmc@50000000 {
-- 
2.16.1
