From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH 2/4] ARM: OMAP4+: Prevent CPU1 related hang with kexec
Date: Fri, 24 Jun 2016 09:40:45 +0200
Message-ID: <4439074.kx9oBqeAS1@wuerfel>
References: <1466495565-17480-1-git-send-email-tony@atomide.com>
 <1466495565-17480-3-git-send-email-tony@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1466495565-17480-3-git-send-email-tony@atomide.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: linux-arm-kernel@lists.infradead.org
Cc: Nishanth Menon <nm@ti.com>, Grygorii Strashko <grygorii.strashko@ti.com>, Dave Gerlach <d-gerlach@ti.com>, Tony Lindgren <tony@atomide.com>, Tero Kristo <t-kristo@ti.com>, Santosh Shilimkar <ssantosh@kernel.org>, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

On Tuesday, June 21, 2016 12:52:43 AM CEST Tony Lindgren wrote:
> diff --git a/arch/arm/mach-omap2/Makefile b/arch/arm/mach-omap2/Makefile
> index 04e276c..cd820f5 100644
> --- a/arch/arm/mach-omap2/Makefile
> +++ b/arch/arm/mach-omap2/Makefile
> @@ -8,7 +8,7 @@ ccflags-y := -I$(srctree)/$(src)/include \
>  # Common support
>  obj-y := id.o io.o control.o mux.o devices.o fb.o serial.o timer.o pm.o \
>          common.o gpio.o dma.o wd_timer.o display.o i2c.o hdq1w.o omap_hwmod.o \
> -        omap_device.o sram.o drm.o
> +        omap_device.o omap-headsmp.o sram.o drm.o
>  
>  hwmod-common                           = omap_hwmod.o omap_hwmod_reset.o \
>                                           omap_hwmod_common_data.o
> @@ -32,7 +32,7 @@ obj-$(CONFIG_SOC_HAS_OMAP2_SDRC)      += sdrc.o
>  
>  # SMP support ONLY available for OMAP4
>  
> -smp-$(CONFIG_SMP)                      += omap-smp.o omap-headsmp.o
> +smp-$(CONFIG_SMP)                      += omap-smp.o
>  smp-$(CONFIG_HOTPLUG_CPU)              += omap-hotplug.o
>  omap-4-5-common                                =  omap4-common.o omap-wakeupgen.o
> 

This doesn't work:

arch/arm/mach-omap2/built-in.o: In function `omap5_secondary_startup':
dss-common.c:(.text+0x4cc4): undefined reference to `secondary_startup'
arch/arm/mach-omap2/built-in.o: In function `hyp_boot':
dss-common.c:(.text+0x4cf0): undefined reference to `secondary_startup'
arch/arm/mach-omap2/built-in.o: In function `omap4_secondary_startup':
dss-common.c:(.text+0x4d14): undefined reference to `secondary_startup'
arch/arm/mach-omap2/built-in.o: In function `omap4460_secondary_startup':
dss-common.c:(.text+0x4d48): undefined reference to `secondary_startup'

secondary_startup() is not defined when CONFIG_SMP is disabled.

	Arnd
