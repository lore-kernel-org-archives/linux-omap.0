From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] ARM: omap: make am43xx build with SMP enabled
Date: Mon, 24 Jun 2013 02:58:15 -0700
Message-ID: <20130624095814.GS5523@atomide.com>
References: <201306220122.47786.arnd@arndb.de>
 <C8443D0743D26F4388EA172BF4E2A7A93EB2495F@DBDE04.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:20078 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751157Ab3FXJ6T (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 24 Jun 2013 05:58:19 -0400
Content-Disposition: inline
In-Reply-To: <C8443D0743D26F4388EA172BF4E2A7A93EB2495F@DBDE04.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Mohammed, Afzal" <afzal@ti.com>
Cc: Arnd Bergmann <arnd@arndb.de>, "Kishore, Ankur" <a-kishore@ti.com>, Linux OMAP List <linux-omap@vger.kernel.org>, Linux ARM Kernel List <linux-arm-kernel@lists.infradead.org>

* Mohammed, Afzal <afzal@ti.com> [130624 01:19]:
> Hi Arnd, Tony,
> 
> On Sat, Jun 22, 2013 at 04:52:47, Arnd Bergmann wrote:
> > With am43xx enabled, omap4 and omap5 disabled and SMP on, I get these
> > build errors:
> 
> Getting AM43x only build with OMAP4/5 disabled was really difficult
> with original series itself, I thought finally had got a right
> Makefile change handling SMP combinations too, but still :(, my brain
> was not big enough to think of multiplatform case :)
> 
> Thanks Arnd for the patch.
> 
> > arch/arm/mach-omap2/built-in.o: In function `scu_gp_set':
> > :(.text+0x7858): undefined reference to `omap4_get_scu_base'
> > arch/arm/mach-omap2/built-in.o: In function `scu_gp_clear':
> > :(.text+0x793c): undefined reference to `omap4_get_scu_base'
> > arch/arm/mach-omap2/built-in.o: In function `omap4_cpu_die':
> > :(.ref.text+0x44): undefined reference to `omap4_hotplug_cpu'
> > 
> > The easiest way to work around that is to turn on the missing
> > functions, even though we know they won't be used on am43xx,
> > which is single-CPU.
> 
> This change was giving errors mainly due to unavailable omap4 prcm
> functions required by "omap-mpuss-lowpower.c"
> 
> How about the below patch - we don't need to include additional
> files with it, or something wrong with it ?

This too looks OK to me, sounds like you'll need a separate
sleep code anyways. It's probably best that Arnd applies this
directly:

Acked-by: Tony Lindgren <tony@atomide.com>

> ---8<------
> 
> From: Afzal Mohammed <afzal@ti.com>
> Date: Mon, 24 Jun 2013 12:41:05 +0530
> Subject: [PATCH] ARM: OMAP2+: AM43x: resolve SMP related build error
> 
> If AM43x and SMP is selected, OMAP4 & OMAP5 deselected, build error as
> follows,
> 
> arch/arm/mach-omap2/built-in.o: In function `scu_gp_set':
> arch/arm/mach-omap2/sleep44xx.S:131: undefined reference to `omap4_get_scu_base'
> arch/arm/mach-omap2/sleep44xx.S:132: undefined reference to `scu_power_mode'
> arch/arm/mach-omap2/built-in.o: In function `scu_gp_clear':
> arch/arm/mach-omap2/sleep44xx.S:227: undefined reference to `omap4_get_scu_base'
> arch/arm/mach-omap2/sleep44xx.S:229: undefined reference to `scu_power_mode'
> 
> Resolve it by building sleep44xx.S only for OMAP4 & OMAP5.
> 
> Signed-off-by: Afzal Mohammed <afzal@ti.com>
> ---
>  arch/arm/mach-omap2/Makefile | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/arm/mach-omap2/Makefile b/arch/arm/mach-omap2/Makefile
> index 0520dc4..a6c4187 100644
> --- a/arch/arm/mach-omap2/Makefile
> +++ b/arch/arm/mach-omap2/Makefile
> @@ -35,8 +35,9 @@ obj-$(CONFIG_SOC_HAS_OMAP2_SDRC)      += sdrc.o
> 
>  smp-$(CONFIG_SMP)                      += omap-smp.o omap-headsmp.o
>  smp-$(CONFIG_HOTPLUG_CPU)              += omap-hotplug.o
> -omap-4-5-common                                =  omap4-common.o omap-wakeupgen.o \
> -                                          sleep44xx.o
> +omap-4-5-common                                =  omap4-common.o omap-wakeupgen.o
> +obj-$(CONFIG_ARCH_OMAP4)               += sleep44xx.o
> +obj-$(CONFIG_SOC_OMAP5)                        += sleep44xx.o
>  obj-$(CONFIG_ARCH_OMAP4)               += $(omap-4-5-common) $(smp-y)
>  obj-$(CONFIG_SOC_OMAP5)                        += $(omap-4-5-common) $(smp-y)
>  obj-$(CONFIG_SOC_AM43XX)               += $(omap-4-5-common)
> --
> 
