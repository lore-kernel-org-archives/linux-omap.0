From: "Mohammed, Afzal" <afzal@ti.com>
Subject: RE: [PATCH] ARM: omap: make am43xx build with SMP enabled
Date: Mon, 24 Jun 2013 08:13:45 +0000
Message-ID: <C8443D0743D26F4388EA172BF4E2A7A93EB2495F@DBDE04.ent.ti.com>
References: <201306220122.47786.arnd@arndb.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="Windows-1252"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:59649 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753064Ab3FXIOQ convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 24 Jun 2013 04:14:16 -0400
In-Reply-To: <201306220122.47786.arnd@arndb.de>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>, Tony Lindgren <tony@atomide.com>
Cc: "Kishore, Ankur" <a-kishore@ti.com>, Linux OMAP List <linux-omap@vger.kernel.org>, Linux ARM Kernel List <linux-arm-kernel@lists.infradead.org>

Hi Arnd, Tony,

On Sat, Jun 22, 2013 at 04:52:47, Arnd Bergmann wrote:
> With am43xx enabled, omap4 and omap5 disabled and SMP on, I get these
> build errors:

Getting AM43x only build with OMAP4/5 disabled was really difficult
with original series itself, I thought finally had got a right
Makefile change handling SMP combinations too, but still :(, my brain
was not big enough to think of multiplatform case :)

Thanks Arnd for the patch.

> arch/arm/mach-omap2/built-in.o: In function `scu_gp_set':
> :(.text+0x7858): undefined reference to `omap4_get_scu_base'
> arch/arm/mach-omap2/built-in.o: In function `scu_gp_clear':
> :(.text+0x793c): undefined reference to `omap4_get_scu_base'
> arch/arm/mach-omap2/built-in.o: In function `omap4_cpu_die':
> :(.ref.text+0x44): undefined reference to `omap4_hotplug_cpu'
> 
> The easiest way to work around that is to turn on the missing
> functions, even though we know they won't be used on am43xx,
> which is single-CPU.

This change was giving errors mainly due to unavailable omap4 prcm
functions required by "omap-mpuss-lowpower.c"

How about the below patch - we don't need to include additional
files with it, or something wrong with it ?

Regards
Afzal

---8<------

From: Afzal Mohammed <afzal@ti.com>
Date: Mon, 24 Jun 2013 12:41:05 +0530
Subject: [PATCH] ARM: OMAP2+: AM43x: resolve SMP related build error

If AM43x and SMP is selected, OMAP4 & OMAP5 deselected, build error as
follows,

arch/arm/mach-omap2/built-in.o: In function `scu_gp_set':
arch/arm/mach-omap2/sleep44xx.S:131: undefined reference to `omap4_get_scu_base'
arch/arm/mach-omap2/sleep44xx.S:132: undefined reference to `scu_power_mode'
arch/arm/mach-omap2/built-in.o: In function `scu_gp_clear':
arch/arm/mach-omap2/sleep44xx.S:227: undefined reference to `omap4_get_scu_base'
arch/arm/mach-omap2/sleep44xx.S:229: undefined reference to `scu_power_mode'

Resolve it by building sleep44xx.S only for OMAP4 & OMAP5.

Signed-off-by: Afzal Mohammed <afzal@ti.com>
---
 arch/arm/mach-omap2/Makefile | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-omap2/Makefile b/arch/arm/mach-omap2/Makefile
index 0520dc4..a6c4187 100644
--- a/arch/arm/mach-omap2/Makefile
+++ b/arch/arm/mach-omap2/Makefile
@@ -35,8 +35,9 @@ obj-$(CONFIG_SOC_HAS_OMAP2_SDRC)      += sdrc.o

 smp-$(CONFIG_SMP)                      += omap-smp.o omap-headsmp.o
 smp-$(CONFIG_HOTPLUG_CPU)              += omap-hotplug.o
-omap-4-5-common                                =  omap4-common.o omap-wakeupgen.o \
-                                          sleep44xx.o
+omap-4-5-common                                =  omap4-common.o omap-wakeupgen.o
+obj-$(CONFIG_ARCH_OMAP4)               += sleep44xx.o
+obj-$(CONFIG_SOC_OMAP5)                        += sleep44xx.o
 obj-$(CONFIG_ARCH_OMAP4)               += $(omap-4-5-common) $(smp-y)
 obj-$(CONFIG_SOC_OMAP5)                        += $(omap-4-5-common) $(smp-y)
 obj-$(CONFIG_SOC_AM43XX)               += $(omap-4-5-common)
--

