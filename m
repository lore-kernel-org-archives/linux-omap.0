From: Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH] ARM: omap2: hide omap3_save_secure_ram on non-OMAP3 builds
Date: Wed,  6 Dec 2017 15:15:07 +0100
Message-ID: <20171206141517.670032-1-arnd@arndb.de>
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

In configurations without CONFIG_OMAP3 but with secure RAM support,
we now run into a link failure:

arch/arm/mach-omap2/omap-secure.o: In function `omap3_save_secure_ram':
omap-secure.c:(.text+0x130): undefined reference to `save_secure_ram_context'

The omap3_save_secure_ram() function is only called from the OMAP34xx
power management code, so we can simply hide that function in the
appropriate #ifdef.

Fixes: d09220a887f7 ("ARM: OMAP2+: Fix SRAM virt to phys translation for save_secure_ram_context")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 arch/arm/mach-omap2/omap-secure.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/mach-omap2/omap-secure.c b/arch/arm/mach-omap2/omap-secure.c
index f9303dc631e4..7be95cd8136d 100644
--- a/arch/arm/mach-omap2/omap-secure.c
+++ b/arch/arm/mach-omap2/omap-secure.c
@@ -72,6 +72,7 @@ phys_addr_t omap_secure_ram_mempool_base(void)
 	return omap_secure_memblock_base;
 }
 
+#ifdef CONFIG_ARCH_OMAP3
 u32 omap3_save_secure_ram(void __iomem *addr, int size)
 {
 	u32 ret;
@@ -90,6 +91,7 @@ u32 omap3_save_secure_ram(void __iomem *addr, int size)
 
 	return ret;
 }
+#endif
 
 /**
  * rx51_secure_dispatcher: Routine to dispatch secure PPA API calls
-- 
2.9.0
