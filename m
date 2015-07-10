From: Dave Gerlach <d-gerlach@ti.com>
Subject: [PATCH] ARM: OMAP2+: Add HAVE_ARM_SCU for AM43XX
Date: Fri, 10 Jul 2015 16:05:48 -0500
Message-ID: <1436562348-53396-1-git-send-email-d-gerlach@ti.com>
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
To: linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org
Cc: Tony Lindgren <tony@atomide.com>, Dave Gerlach <d-gerlach@ti.com>
List-Id: linux-omap@vger.kernel.org

CONFIG_HAVE_ARM_SCU only gets selected if CONFIG_SMP is selected in an OMAP
system, however AM43XX needs this option regardless of CONFIG_SMP and also
for an AM43XX only build as it is important for controlling power in the SoC.
Without this we cannot suspend the CPU for SoC suspend or cpuidle. The
ARM Cortex A9 needs SCU CPU Power Status bits to be set to off mode in order
for the PRCM to transition the MPU to low power modes.

Signed-off-by: Dave Gerlach <d-gerlach@ti.com>
---
 arch/arm/mach-omap2/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/mach-omap2/Kconfig b/arch/arm/mach-omap2/Kconfig
index ecc04ff..4a023e8 100644
--- a/arch/arm/mach-omap2/Kconfig
+++ b/arch/arm/mach-omap2/Kconfig
@@ -60,6 +60,7 @@ config SOC_AM43XX
 	select ARM_GIC
 	select MACH_OMAP_GENERIC
 	select MIGHT_HAVE_CACHE_L2X0
+	select HAVE_ARM_SCU
 
 config SOC_DRA7XX
 	bool "TI DRA7XX"
-- 
2.4.5
