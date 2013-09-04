From: Josh Boyer <jwboyer@redhat.com>
Subject: ARM: OMAP2: Make MACH_OMAP3EVM select NOP_USB_XCEIV
Date: Wed, 4 Sep 2013 09:38:50 -0400
Message-ID: <20130904133850.GC12834@hansolo.jdub.homelinux.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Tony Lindgren <tony@atomide.com>, Olof Johansson <olof@lixom.net>
Cc: linux-omap@vger.kernel.org, Russell King <linux@arm.linux.org.uk>, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

The board-omap3evm.c file unconditionally calls usb_nop_xceiv_register but
doesn't ensure this is built-in.  This can lead to build failures like:

arch/arm/mach-omap2/built-in.o: In function `omap3_evm_init':
linux-3.12.0-0.rc0.git2.1.fc21.armv7hl/arch/arm/mach-omap2/board-omap3evm.c:686: undefined reference to `usb_nop_xceiv_register'
make: *** [vmlinux] Error 1

Make MACH_OMAP3EVM select NOP_USB_XCEIV to avoid this.

Signed-off-by: Josh Boyer <jwboyer@fedoraproject.org>
---
 arch/arm/mach-omap2/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/mach-omap2/Kconfig b/arch/arm/mach-omap2/Kconfig
index 3eed000..3350389 100644
--- a/arch/arm/mach-omap2/Kconfig
+++ b/arch/arm/mach-omap2/Kconfig
@@ -258,6 +258,7 @@ config MACH_OMAP3EVM
 	depends on ARCH_OMAP3
 	default y
 	select OMAP_PACKAGE_CBB
+	select NOP_USB_XCEIV
 
 config MACH_OMAP3517EVM
 	bool "OMAP3517/ AM3517 EVM board"
-- 
1.8.3.1
