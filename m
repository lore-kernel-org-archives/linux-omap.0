From: Hiroki Kaminaga <kaminaga@sm.sony.co.jp>
Subject: build error on Linux-2.6.15-rc4-omap1
Date: Wed, 21 Dec 2005 10:25:34 +0900 (JST)
Message-ID: <20051221.102534.78702175.kaminaga@sm.sony.co.jp>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
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
To: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

Hi,

I'm building linux 2.6.15-rc, and applied Linux-2.6.15-rc4-omap1
on source.

However, when I tried to build for OSK5912, with CONFIG_PM=y (this is default),
following error was emitted.

--
make[2]: *** No rule to make target `arch/arm/mach-omap1/pm.o', needed by `arch/arm/mach-omap1/built-in.o'.  Stop.
make[1]: *** [arch/arm/mach-omap1] Error 2
--

However, on 2.6.14 omap patch, there was no such error when CONFIG_PM=y.

pm.c was in arch/arm/plat-omap/, and below diff, without pm.c (and 
I guess also sleep.c too) had caused this error.


diff -u linux-2.6.{14,15rc}/arch/arm/mach-omap1/Makefile
--- linux-2.6.14/arch/arm/mach-omap1/Makefile
+++ linux-2.6.15rc/arch/arm/mach-omap1/Makefile
@@ -3,7 +3,13 @@
 #
 
 # Common support
-obj-y := io.o id.o clock.o irq.o time.o mux.o serial.o devices.o
+obj-y := io.o id.o clock.o irq.o mux.o serial.o devices.o
+
+obj-$(CONFIG_OMAP_MPU_TIMER)           += time.o
+
+# Power Management
+obj-$(CONFIG_PM) += pm.o sleep.o
+
 led-y := leds.o


I'm currently doing work-around by making symbolic link from plat-omap/pm.c.

Anyone have same build error?


HK.
--
