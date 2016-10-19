From: Dave Gerlach <d-gerlach@ti.com>
Subject: [PATCH RESEND] ARM: AM43XX: Select OMAP_INTERCONNECT in Kconfig
Date: Wed, 19 Oct 2016 15:44:12 -0500
Message-ID: <20161019204412.18607-1-d-gerlach@ti.com>
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
To: Tony Lindgren <tony@atomide.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Dave Gerlach <d-gerlach@ti.com>
List-Id: linux-omap@vger.kernel.org

AM437x makes use of the omap_l3_noc driver so explicitly select
OMAP_INTERCONNECT in the Kconfig for SOC_AM43XX to ensure it gets enabled
for AM43XX only builds.

Signed-off-by: Dave Gerlach <d-gerlach@ti.com>
---
This was supposed to be picked up for v4.7 [1] but doesn't seem to have
ever been merged, maybe it was missed? Here it is again, rebased
on v4.9-rc1.

[1] http://www.spinics.net/lists/linux-omap/msg129708.html

 arch/arm/mach-omap2/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/mach-omap2/Kconfig b/arch/arm/mach-omap2/Kconfig
index a9afeebd59f2..0465338183c7 100644
--- a/arch/arm/mach-omap2/Kconfig
+++ b/arch/arm/mach-omap2/Kconfig
@@ -71,6 +71,7 @@ config SOC_AM43XX
 	select HAVE_ARM_TWD
 	select ARM_ERRATA_754322
 	select ARM_ERRATA_775420
+	select OMAP_INTERCONNECT
 
 config SOC_DRA7XX
 	bool "TI DRA7XX"
-- 
2.9.3
