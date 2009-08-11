From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 7/9] OMAP2: compile usb-tusb6010.c
Date: Tue, 11 Aug 2009 12:54:39 +0300
Message-ID: <20090811095439.32577.56202.stgit@localhost>
References: <20090811094348.32577.81307.stgit@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.arm.linux.org.uk>
In-Reply-To: <20090811094348.32577.81307.stgit@localhost>
List-Unsubscribe: <http://lists.arm.linux.org.uk/mailman/listinfo/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.arm.linux.org.uk?subject=unsubscribe>
List-Archive: <http://lists.arm.linux.org.uk/lurker/list/linux-arm-kernel.html>
List-Post: <mailto:linux-arm-kernel@lists.arm.linux.org.uk>
List-Help: <mailto:linux-arm-kernel-request@lists.arm.linux.org.uk?subject=help>
List-Subscribe: <http://lists.arm.linux.org.uk/mailman/listinfo/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.arm.linux.org.uk?subject=subscribe>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.arm.linux.org.uk
To: linux-arm-kernel@lists.arm.linux.org.uk
Cc: Kalle Valo <kalle.valo@iki.fi>, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

From: Kalle Valo <kalle.valo@iki.fi>

For some reason usb-tusb6010.c was't compiled, add it to Makefile and
Kconfig. This is prepraration for upcoming n8x0 support.

Signed-off-by: Kalle Valo <kalle.valo@iki.fi>
Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 arch/arm/mach-omap2/Kconfig  |    5 +++++
 arch/arm/mach-omap2/Makefile |    1 +
 2 files changed, 6 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap2/Kconfig b/arch/arm/mach-omap2/Kconfig
index a755eb5..bf54686 100644
--- a/arch/arm/mach-omap2/Kconfig
+++ b/arch/arm/mach-omap2/Kconfig
@@ -31,6 +31,11 @@ config MACH_OMAP_GENERIC
 	bool "Generic OMAP board"
 	depends on ARCH_OMAP2 && ARCH_OMAP24XX
 
+config MACH_OMAP2_TUSB6010
+	bool
+	depends on ARCH_OMAP2 && ARCH_OMAP2420
+	default y if MACH_NOKIA_N8X0
+
 config MACH_OMAP_H4
 	bool "OMAP 2420 H4 board"
 	depends on ARCH_OMAP2 && ARCH_OMAP24XX
diff --git a/arch/arm/mach-omap2/Makefile b/arch/arm/mach-omap2/Makefile
index 2a2361e..a125d38 100644
--- a/arch/arm/mach-omap2/Makefile
+++ b/arch/arm/mach-omap2/Makefile
@@ -76,6 +76,7 @@ obj-$(CONFIG_MACH_OMAP_4430SDP)		+= board-4430sdp.o
 
 # Platform specific device init code
 obj-y					+= usb-musb.o
+obj-$(CONFIG_MACH_OMAP2_TUSB6010)	+= usb-tusb6010.o
 
 onenand-$(CONFIG_MTD_ONENAND_OMAP2)	:= gpmc-onenand.o
 obj-y					+= $(onenand-m) $(onenand-y)


-------------------------------------------------------------------
List admin: http://lists.arm.linux.org.uk/mailman/listinfo/linux-arm-kernel
FAQ:        http://www.arm.linux.org.uk/mailinglists/faq.php
Etiquette:  http://www.arm.linux.org.uk/mailinglists/etiquette.php
