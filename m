From: Masahiro Yamada <yamada.masahiro@socionext.com>
Subject: [PATCH 3/3] ARM: omap2: move platform-specific asm-offset.h to
 arch/arm/mach-omap2
Date: Mon,  8 Apr 2019 16:54:27 +0900
Message-ID: <20190408075427.6052-3-yamada.masahiro@socionext.com>
References: <20190408075427.6052-1-yamada.masahiro@socionext.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20190408075427.6052-1-yamada.masahiro@socionext.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: arm@kernel.org, Olof Johansson <olof@lixom.net>, Arnd Bergmann <arnd@arndb.de>
Cc: Tony Lindgren <tony@atomide.com>, Russell King <linux@armlinux.org.uk>, linux-kernel@vger.kernel.org, Masahiro Yamada <yamada.masahiro@socionext.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

<generated/ti-pm-asm-offsets.h> is only generated and included
by arch/arm/mach-omap2/, so it does not need to reside in the
globally visible include/generated/.

I moved and renamed it to arch/arm/mach-omap2/pm-asm-offsets.h
since the prefix 'omap2-' is just redundant in mach-omap2/.

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

Can this be applied to ARM-SOC tree in a series?
(with Ack from the platform sub-maintainer.)

ti-pm-asm-offsets.h does not need to reside in include/generated/,
but you may ask "Why must it get out of include/generated/?"

My main motivation is to avoid a race condition in the currently
proposed patch:

https://lore.kernel.org/patchwork/patch/1052763/

This patch tries to embed some build artifacts into the kernel.

If arch/arm/mach-omap2/ and kernel/ are built at the same time,
it may embed a truncated file.


 arch/arm/mach-omap2/.gitignore  | 1 +
 arch/arm/mach-omap2/Makefile    | 5 +++--
 arch/arm/mach-omap2/sleep33xx.S | 2 +-
 arch/arm/mach-omap2/sleep43xx.S | 2 +-
 4 files changed, 6 insertions(+), 4 deletions(-)
 create mode 100644 arch/arm/mach-omap2/.gitignore

diff --git a/arch/arm/mach-omap2/.gitignore b/arch/arm/mach-omap2/.gitignore
new file mode 100644
index 000000000000..79a8d6ea7152
--- /dev/null
+++ b/arch/arm/mach-omap2/.gitignore
@@ -0,0 +1 @@
+pm-asm-offsets.h
diff --git a/arch/arm/mach-omap2/Makefile b/arch/arm/mach-omap2/Makefile
index 85d1b13c9215..26baeb6477af 100644
--- a/arch/arm/mach-omap2/Makefile
+++ b/arch/arm/mach-omap2/Makefile
@@ -236,9 +236,10 @@ obj-y					+= omap_phy_internal.o
 
 obj-$(CONFIG_MACH_OMAP2_TUSB6010)	+= usb-tusb6010.o
 
-include/generated/ti-pm-asm-offsets.h: arch/arm/mach-omap2/pm-asm-offsets.s FORCE
+$(obj)/pm-asm-offsets.h: $(obj)/pm-asm-offsets.s FORCE
 	$(call filechk,offsets,__TI_PM_ASM_OFFSETS_H__)
 
-$(obj)/sleep33xx.o $(obj)/sleep43xx.o: include/generated/ti-pm-asm-offsets.h
+$(obj)/sleep33xx.o $(obj)/sleep43xx.o: $(obj)/pm-asm-offsets.h
 
 targets += pm-asm-offsets.s
+clean-files += pm-asm-offsets.h
diff --git a/arch/arm/mach-omap2/sleep33xx.S b/arch/arm/mach-omap2/sleep33xx.S
index 47a816468cdb..a003769121aa 100644
--- a/arch/arm/mach-omap2/sleep33xx.S
+++ b/arch/arm/mach-omap2/sleep33xx.S
@@ -6,7 +6,6 @@
  *	Dave Gerlach, Vaibhav Bedia
  */
 
-#include <generated/ti-pm-asm-offsets.h>
 #include <linux/linkage.h>
 #include <linux/platform_data/pm33xx.h>
 #include <linux/ti-emif-sram.h>
@@ -15,6 +14,7 @@
 
 #include "iomap.h"
 #include "cm33xx.h"
+#include "pm-asm-offsets.h"
 
 #define AM33XX_CM_CLKCTRL_MODULESTATE_DISABLED			0x00030000
 #define AM33XX_CM_CLKCTRL_MODULEMODE_DISABLE			0x0003
diff --git a/arch/arm/mach-omap2/sleep43xx.S b/arch/arm/mach-omap2/sleep43xx.S
index 5b9343b58fc7..aa288f361c5e 100644
--- a/arch/arm/mach-omap2/sleep43xx.S
+++ b/arch/arm/mach-omap2/sleep43xx.S
@@ -6,7 +6,6 @@
  *	Dave Gerlach, Vaibhav Bedia
  */
 
-#include <generated/ti-pm-asm-offsets.h>
 #include <linux/linkage.h>
 #include <linux/ti-emif-sram.h>
 #include <linux/platform_data/pm33xx.h>
@@ -19,6 +18,7 @@
 #include "iomap.h"
 #include "omap-secure.h"
 #include "omap44xx.h"
+#include "pm-asm-offsets.h"
 #include "prm33xx.h"
 #include "prcm43xx.h"
 
-- 
2.17.1
