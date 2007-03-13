From: Kevin Hilman <khilman@mvista.com>
Subject: ARCH_OMAP243x vs. ARCH_OMAP2430
Date: Tue, 13 Mar 2007 16:51:50 -0700
Message-ID: <45F73916.2000504@mvista.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="------------080201070809070706060600"
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: OMAP-Linux <linux-omap-open-source@linux.omap.com>
List-Id: linux-omap@vger.kernel.org

This is a multi-part message in MIME format.
--------------080201070809070706060600
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

In working on the platform support for MUSB for the 2430sdp, I noticed
that there are #ifdefs for CONFIG_ARCH_OMAP2430 and
CONFIG_ARCH_OMAP243X.  In the Kconfigs, only the following are available:

CONFIG_ARCH_OMAP2
CONFIG_ARCH_OMAP24XX
CONFIG_ARCH_OMAP2420
CONFIG_ARCH_OMAP2430

But in the MUSB code as well as prcm-regs.h there are #ifdefs for
OMAP243X.   Are there other 243x platforms in the wild, or should I just
convert these #ifdefs to 2430.  If converting is the right thing, here's
a patch.

Kevin


--------------080201070809070706060600
Content-Type: text/x-patch;
 name="Kconfig-OMAP243x.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="Kconfig-OMAP243x.patch"

---
 arch/arm/mach-omap2/prcm-regs.h |    4 ++--
 drivers/usb/musb/musbdefs.h     |    2 +-
 drivers/usb/musb/omap2430.h     |    2 +-
 drivers/usb/musb/plat_uds.c     |    2 +-
 4 files changed, 5 insertions(+), 5 deletions(-)

Index: dev/arch/arm/mach-omap2/prcm-regs.h
===================================================================
--- dev.orig/arch/arm/mach-omap2/prcm-regs.h
+++ dev/arch/arm/mach-omap2/prcm-regs.h
@@ -240,7 +240,7 @@
 #define GPIO3_SYSCONFIG		__REG32((GPIOX_BASE(3) + 0x10))
 #define GPIO4_SYSCONFIG		__REG32((GPIOX_BASE(4) + 0x10))
 
-#if defined(CONFIG_ARCH_OMAP243X)
+#if defined(CONFIG_ARCH_OMAP2430)
 #define GPIO5_SYSCONFIG		__REG32((OMAP24XX_GPIO5_BASE + 0x10))
 #endif
 
@@ -332,7 +332,7 @@
 #define GPIO4_DEBOUNCENABLE	GPIO4_REG32(0x050)
 #define GPIO4_DEBOUNCINGTIME	GPIO4_REG32(0x054)
 
-#if defined(CONFIG_ARCH_OMAP243X)
+#if defined(CONFIG_ARCH_OMAP2430)
 /* GPIO 5 */
 #define GPIO5_REG32(offset)	__REG32((OMAP24XX_GPIO5_BASE + (offset)))
 #define GPIO5_IRQENABLE1	GPIO5_REG32(0x01C)
Index: dev/drivers/usb/musb/musbdefs.h
===================================================================
--- dev.orig/drivers/usb/musb/musbdefs.h
+++ dev/drivers/usb/musb/musbdefs.h
@@ -202,7 +202,7 @@ enum musb_g_ep0_state {
  * directly with the "flat" model, or after setting up an index register.
  */
 
-#if defined(CONFIG_ARCH_DAVINCI) || defined(CONFIG_ARCH_OMAP243X)
+#if defined(CONFIG_ARCH_DAVINCI) || defined(CONFIG_ARCH_OMAP2430)
 /* REVISIT indexed access seemed to
  * misbehave (on DaVinci) for at least peripheral IN ...
  */
Index: dev/drivers/usb/musb/omap2430.h
===================================================================
--- dev.orig/drivers/usb/musb/omap2430.h
+++ dev/drivers/usb/musb/omap2430.h
@@ -26,6 +26,6 @@
 #define OTG_INTERFSEL		HS_OTG(0x40c)
 #define OTG_SIMENABLE		HS_OTG(0x410)
 
-#endif	/* CONFIG_ARCH_OMAP243X */
+#endif	/* CONFIG_ARCH_OMAP2430 */
 
 #endif	/* __MUSB_OMAP243X_H__ */
Index: dev/drivers/usb/musb/plat_uds.c
===================================================================
--- dev.orig/drivers/usb/musb/plat_uds.c
+++ dev/drivers/usb/musb/plat_uds.c
@@ -1302,7 +1302,7 @@ static int __init musb_core_init(u16 wTy
 
 /*-------------------------------------------------------------------------*/
 
-#ifdef CONFIG_ARCH_OMAP243X
+#ifdef CONFIG_ARCH_OMAP2430
 
 static irqreturn_t generic_interrupt(int irq, void *__hci)
 {

--------------080201070809070706060600
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--------------080201070809070706060600--
