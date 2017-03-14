From: Arnd Bergmann <arnd@arndb.de>
Subject: [RESEND PATCH] ARM: omap2: mark omap_init_rng as __init
Date: Tue, 14 Mar 2017 22:24:48 +0100
Message-ID: <20170314212500.3612283-1-arnd@arndb.de>
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
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

I found this section mismatch when building with an older
compiler release:

WARNING: vmlinux.o(.text+0x3051c): Section mismatch in reference from the function omap_init_rng() to the function .init.text:omap_device_build()

Obviously this one function should be __init as well. Normally
we don't get a warning as the function gets inlined into its
caller.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Acked-by: Tony Lindgren <tony@atomide.com>
---
Originally submitted on Dec 16. Tony, could you pick it up for v4.12?
We haven't started merging stuff yet, and I forgot to apply it earlier
but want to get it out of my backlog.
---
 arch/arm/mach-omap2/devices.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/mach-omap2/devices.c b/arch/arm/mach-omap2/devices.c
index 3fdb94599184..473951203104 100644
--- a/arch/arm/mach-omap2/devices.c
+++ b/arch/arm/mach-omap2/devices.c
@@ -121,7 +121,7 @@ static inline void omap_init_mcspi(void) {}
  *
  * Bind the RNG hwmod to the RNG omap_device.  No return value.
  */
-static void omap_init_rng(void)
+static void __init omap_init_rng(void)
 {
 	struct omap_hwmod *oh;
 	struct platform_device *pdev;
-- 
2.9.0
