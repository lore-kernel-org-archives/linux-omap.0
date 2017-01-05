From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH] MAINTAINERS: Add Aaro Koskinen as TI omap1 SoC co-maintainer
Date: Thu,  5 Jan 2017 13:41:01 -0800
Message-ID: <20170105214101.30286-1-tony@atomide.com>
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
To: linux-kernel@vger.kernel.org
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Aaro Koskinen <aaro.koskinen@iki.fi>
List-Id: linux-omap@vger.kernel.org

Aaro has been doing a great job making sure mach-omap1 stays working
with the mainline kernel. So let's add Aaro as omap1 co-maintainer to
the MAINTAINERS file.

Cc: Aaro Koskinen <aaro.koskinen@iki.fi>
Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 MAINTAINERS | 19 ++++++++++++++++---
 1 file changed, 16 insertions(+), 3 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -8933,7 +8933,20 @@ M:	Josh Poimboeuf <jpoimboe@redhat.com>
 S:	Supported
 F:	tools/objtool/
 
-OMAP SUPPORT
+OMAP1 SUPPORT
+M:	Aaro Koskinen <aaro.koskinen@iki.fi>
+M:	Tony Lindgren <tony@atomide.com>
+L:	linux-omap@vger.kernel.org
+Q:	http://patchwork.kernel.org/project/linux-omap/list/
+T:	git git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap.git
+S:	Maintained
+F:	arch/arm/mach-omap1/
+F:	arch/arm/plat-omap/
+F:	arch/arm/configs/omap1_defconfig
+F:	drivers/i2c/busses/i2c-omap.c
+F:	include/linux/i2c-omap.h
+
+OMAP2+ SUPPORT
 M:	Tony Lindgren <tony@atomide.com>
 L:	linux-omap@vger.kernel.org
 W:	http://www.muru.com/linux/omap/
@@ -8941,8 +8954,8 @@ W:	http://linux.omap.com/
 Q:	http://patchwork.kernel.org/project/linux-omap/list/
 T:	git git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap.git
 S:	Maintained
-F:	arch/arm/*omap*/
-F:	arch/arm/configs/omap1_defconfig
+F:	arch/arm/mach-omap2/
+F:	arch/arm/plat-omap/
 F:	arch/arm/configs/omap2plus_defconfig
 F:	drivers/i2c/busses/i2c-omap.c
 F:	drivers/irqchip/irq-omap-intc.c
-- 
2.11.0
