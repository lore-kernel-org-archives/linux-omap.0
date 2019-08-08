From: Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH 14/22] ARM: omap1: use pci_ioremap_io() for omap_cf
Date: Thu,  8 Aug 2019 23:22:23 +0200
Message-ID: <20190808212234.2213262-15-arnd@arndb.de>
References: <20190808212234.2213262-1-arnd@arndb.de>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190808212234.2213262-1-arnd@arndb.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>, Aaro Koskinen <aaro.koskinen@iki.fi>, Dominik Brodowski <linux@dominikbrodowski.net>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Linus Walleij <linus.walleij@linaro.org>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Tomi Valkeinen <tomi.valkeinen@ti.com>, Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

The ISA I/O space handling in omap_cf is incompatible with
PCI drivers in a multiplatform kernel, and requires a custom
mach/io.h.

Change the driver to use pci_ioremap_io() like PCI drivers do,
so the generic ioport access can work across platforms.

To actually use that code, we have to select CONFIG_PCI
here.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 arch/arm/Kconfig                      |  2 +-
 arch/arm/mach-omap1/include/mach/io.h | 45 ---------------------------
 drivers/pcmcia/omap_cf.c              |  9 ++----
 3 files changed, 4 insertions(+), 52 deletions(-)
 delete mode 100644 arch/arm/mach-omap1/include/mach/io.h

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index b7162ac8d756..8263fe7a5e64 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -496,13 +496,13 @@ config ARCH_OMAP1
 	select ARCH_OMAP
 	select CLKDEV_LOOKUP
 	select CLKSRC_MMIO
+	select FORCE_PCI if PCCARD
 	select GENERIC_CLOCKEVENTS
 	select GENERIC_IRQ_CHIP
 	select GENERIC_IRQ_MULTI_HANDLER
 	select GPIOLIB
 	select HAVE_IDE
 	select IRQ_DOMAIN
-	select NEED_MACH_IO_H if PCCARD
 	select NEED_MACH_MEMORY_H
 	select SPARSE_IRQ
 	help
diff --git a/arch/arm/mach-omap1/include/mach/io.h b/arch/arm/mach-omap1/include/mach/io.h
deleted file mode 100644
index ce4f8005b26f..000000000000
--- a/arch/arm/mach-omap1/include/mach/io.h
+++ /dev/null
@@ -1,45 +0,0 @@
-/*
- * arch/arm/mach-omap1/include/mach/io.h
- *
- * IO definitions for TI OMAP processors and boards
- *
- * Copied from arch/arm/mach-sa1100/include/mach/io.h
- * Copyright (C) 1997-1999 Russell King
- *
- * This program is free software; you can redistribute it and/or modify it
- * under the terms of the GNU General Public License as published by the
- * Free Software Foundation; either version 2 of the License, or (at your
- * option) any later version.
- *
- * THIS SOFTWARE IS PROVIDED ``AS IS'' AND ANY EXPRESS OR IMPLIED
- * WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES OF
- * MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED. IN
- * NO EVENT SHALL THE AUTHOR BE LIABLE FOR ANY DIRECT, INDIRECT,
- * INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT
- * NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF
- * USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON
- * ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
- * (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF
- * THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
- *
- * You should have received a copy of the GNU General Public License along
- * with this program; if not, write to the Free Software Foundation, Inc.,
- * 675 Mass Ave, Cambridge, MA 02139, USA.
- *
- * Modifications:
- *  06-12-1997	RMK	Created.
- *  07-04-1999	RMK	Major cleanup
- */
-
-#ifndef __ASM_ARM_ARCH_IO_H
-#define __ASM_ARM_ARCH_IO_H
-
-#define IO_SPACE_LIMIT 0xffffffff
-
-/*
- * We don't actually have real ISA nor PCI buses, but there is so many
- * drivers out there that might just work if we fake them...
- */
-#define __io(a)		__typesafe_io(a)
-
-#endif
diff --git a/drivers/pcmcia/omap_cf.c b/drivers/pcmcia/omap_cf.c
index 98df6473034d..9f8ad82f5fce 100644
--- a/drivers/pcmcia/omap_cf.c
+++ b/drivers/pcmcia/omap_cf.c
@@ -235,9 +235,9 @@ static int __init omap_cf_probe(struct platform_device *pdev)
 	cf->phys_cf = res->start;
 
 	/* pcmcia layer only remaps "real" memory */
-	cf->socket.io_offset = (unsigned long)
-			ioremap(cf->phys_cf + SZ_4K, SZ_2K);
-	if (!cf->socket.io_offset)
+	cf->socket.io_offset = 0x10000;
+	status = pci_ioremap_io(cf->socket.io_offset, cf->phys_cf + SZ_4K);
+	if (status)
 		goto fail1;
 
 	if (!request_mem_region(cf->phys_cf, SZ_8K, driver_name))
@@ -281,8 +281,6 @@ static int __init omap_cf_probe(struct platform_device *pdev)
 fail2:
 	release_mem_region(cf->phys_cf, SZ_8K);
 fail1:
-	if (cf->socket.io_offset)
-		iounmap((void __iomem *) cf->socket.io_offset);
 	free_irq(irq, cf);
 fail0:
 	kfree(cf);
@@ -296,7 +294,6 @@ static int __exit omap_cf_remove(struct platform_device *pdev)
 	cf->active = 0;
 	pcmcia_unregister_socket(&cf->socket);
 	del_timer_sync(&cf->timer);
-	iounmap((void __iomem *) cf->socket.io_offset);
 	release_mem_region(cf->phys_cf, SZ_8K);
 	free_irq(cf->irq, cf);
 	kfree(cf);
-- 
2.20.0
