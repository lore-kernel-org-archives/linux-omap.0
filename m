From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [PATCH 08/30] ARM: omap2+: fix building without i2c
Date: Sun, 2 Oct 2011 19:31:25 -0600 (MDT)
Message-ID: <alpine.DEB.2.00.1110021928170.4611@utopia.booyaka.com>
References: <1317566760-25681-1-git-send-email-arnd@arndb.de>
	<1317566760-25681-9-git-send-email-arnd@arndb.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1317566760-25681-9-git-send-email-arnd@arndb.de>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.infradead.org
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: Tony Lindgren <tony@atomide.com>, linux-omap@vger.kernel.org, "Avinash.H.M" <avinashhm@ti.com>, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

Hello Arnd,

On Sun, 2 Oct 2011, Arnd Bergmann wrote:

> A trivial typo causes build breakage when I2C is disabled
> and omap_i2c_reset is set to NULL on OMAP:
> 
> omap_hwmod_44xx_data.c:2287:11: error: lvalue required as unary '&' operand
> 
> Removing the '&' character solves this.
> 
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> Cc: Avinash.H.M <avinashhm@ti.com>
> Cc: Paul Walmsley <paul@pwsan.com>

Nice catch.  I think the bug is different, though.  omap_i2c_reset should 
never be NULL: that code is intended to execute even when 
CONFIG_I2C_OMAP=n.  The idea is to prevent the IP block from interfering 
with the rest of the kernel even if the driver is not compiled in, no 
matter how the bootloader or previous OS programmed the IP block.

I'd suggest something like the following patch instead.


- Paul

From: Paul Walmsley <paul@pwsan.com>
Date: Sun, 2 Oct 2011 19:15:10 -0600
Subject: [PATCH] ARM: omap2+: fix build breakage when CONFIG_I2C_OMAP=n

arch/arm/mach-omap2/Makefile incorrectly skips compilation of the I2C
IP block reset code when CONFIG_I2C_OMAP=n.  Fix by unconditionally
compiling arch/arm/mach-omap2/i2c.o, which is needed on all OMAP2+ platforms.

Problem noted by Arnd Bergmann <arnd@arndb.de>.

Signed-off-by: Paul Walmsley <paul@pwsan.com>
Cc: Avinash.H.M <avinashhm@ti.com>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Tony Lindgren <tony@atomide.com>
---
 arch/arm/mach-omap2/Makefile |    5 +----
 1 files changed, 1 insertions(+), 4 deletions(-)

diff --git a/arch/arm/mach-omap2/Makefile b/arch/arm/mach-omap2/Makefile
index f343365..0951986 100644
--- a/arch/arm/mach-omap2/Makefile
+++ b/arch/arm/mach-omap2/Makefile
@@ -4,7 +4,7 @@
 
 # Common support
 obj-y := id.o io.o control.o mux.o devices.o serial.o gpmc.o timer.o pm.o \
-	 common.o gpio.o dma.o wd_timer.o
+	 common.o gpio.o dma.o wd_timer.o i2c.o
 
 omap-2-3-common				= irq.o sdrc.o
 hwmod-common				= omap_hwmod.o \
@@ -175,9 +175,6 @@ obj-$(CONFIG_OMAP_IOMMU)		+= iommu2.o
 iommu-$(CONFIG_OMAP_IOMMU)		:= omap-iommu.o
 obj-y					+= $(iommu-m) $(iommu-y)
 
-i2c-omap-$(CONFIG_I2C_OMAP)		:= i2c.o
-obj-y					+= $(i2c-omap-m) $(i2c-omap-y)
-
 ifneq ($(CONFIG_TIDSPBRIDGE),)
 obj-y					+= dsp.o
 endif
-- 
1.7.6.3
