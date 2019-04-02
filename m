From: Dave Gerlach <d-gerlach@ti.com>
Subject: [PATCH 2/2] ARM: OMAP2+: sleep43xx: Run EMIF HW leveling on resume
 path
Date: Tue, 2 Apr 2019 11:57:43 -0500
Message-ID: <20190402165743.28106-3-d-gerlach@ti.com>
References: <20190402165743.28106-1-d-gerlach@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20190402165743.28106-1-d-gerlach@ti.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Tony Lindgren <tony@atomide.com>, Santosh Shilimkar <ssantosh@kernel.org>
Cc: Keerthy J <j-keerthy@ti.com>, linux-omap@vger.kernel.org, Brad Griffis <bgriffis@ti.com>, linux-arm-kernel@lists.infradead.org, Dave Gerlach <d-gerlach@ti.com>
List-Id: linux-omap@vger.kernel.org

When returning from DeepSleep mode on AM437x platforms the EMIF must run
DDR hardware leveling, same as done during u-boot, to properly restore the
EMIF PHY to it's operational state on platforms using DDR3.

Call the ti-emif-sram-pm run_hw_leveling routine to perform this. This
happens after all other EMIF values are restored so the exact same
configuration used at boot is used at the end of EMIF resume as well.

Signed-off-by: Dave Gerlach <d-gerlach@ti.com>
---
 arch/arm/mach-omap2/sleep43xx.S | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/arm/mach-omap2/sleep43xx.S b/arch/arm/mach-omap2/sleep43xx.S
index 5b9343b58fc7..0c1031442571 100644
--- a/arch/arm/mach-omap2/sleep43xx.S
+++ b/arch/arm/mach-omap2/sleep43xx.S
@@ -368,6 +368,9 @@ wait_emif_enable1:
 	mov     r1, #AM43XX_EMIF_POWEROFF_DISABLE
 	str     r1, [r2, #0x0]
 
+	ldr     r1, [r9, #EMIF_PM_RUN_HW_LEVELING]
+	blx     r1
+
 #ifdef CONFIG_CACHE_L2X0
 	ldr	r2, l2_cache_base
 	ldr	r0, [r2, #L2X0_CTRL]
-- 
2.20.1
