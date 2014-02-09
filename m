From: Paul Bolle <pebolle@tiscali.nl>
Subject: [PATCH] ARM: OMAP2+: Remove MACH_NOKIA_N800
Date: Sun, 09 Feb 2014 16:01:28 +0100
Message-ID: <1391958088.25424.17.camel@x220>
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
To: Tony Lindgren <tony@atomide.com>, Russell King <linux@arm.linux.org.uk>
Cc: linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

The last caller of machine_is_nokia_n800() was removed in commit
5a87cde490e1 ("ARM: OMAP2+: Remove legacy booting support for n8x0").
That means that the Kconfig symbol MACH_NOKIA_N800 is now unused. It can
safely be removed.

Signed-off-by: Paul Bolle <pebolle@tiscali.nl>
---
Untested.

 arch/arm/mach-omap2/Kconfig | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/arch/arm/mach-omap2/Kconfig b/arch/arm/mach-omap2/Kconfig
index 653b489..66da3f5 100644
--- a/arch/arm/mach-omap2/Kconfig
+++ b/arch/arm/mach-omap2/Kconfig
@@ -268,9 +268,6 @@ config MACH_OMAP_3430SDP
 	default y
 	select OMAP_PACKAGE_CBB
 
-config MACH_NOKIA_N800
-       bool
-
 config MACH_NOKIA_N810
        bool
 
@@ -281,7 +278,6 @@ config MACH_NOKIA_N8X0
 	bool "Nokia N800/N810"
 	depends on SOC_OMAP2420
 	default y
-	select MACH_NOKIA_N800
 	select MACH_NOKIA_N810
 	select MACH_NOKIA_N810_WIMAX
 	select OMAP_PACKAGE_ZAC
-- 
1.8.5.3
