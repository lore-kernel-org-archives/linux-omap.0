From: Eric Miao <eric.y.miao@gmail.com>
Subject: Re: [PATCH] ARM: sort select statements alphanumerically
Date: Mon, 8 Oct 2012 10:50:00 +0800
Message-ID: <CAMPhdO-SuJwz4uN=1sQWtr3WOn656_M9iEGkMDjtOKTrsMUDpg@mail.gmail.com>
References: <E1TKX8k-0006QP-M5@rmk-PC.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <E1TKX8k-0006QP-M5@rmk-PC.arm.linux.org.uk>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.infradead.org
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Russell King <rmk+kernel@arm.linux.org.uk>
Cc: linux-sh@vger.kernel.org, Tony Lindgren <tony@atomide.com>, Linus Walleij <linus.walleij@linaro.org>, Nicolas Ferre <nicolas.ferre@atmel.com>, Daniel Walker <dwalker@fifo99.com>, Kevin Hilman <khilman@ti.com>, linux-samsung-soc@vger.kernel.org, Srinidhi Kasagar <srinidhi.kasagar@stericsson.com>, Magnus Damm <magnus.damm@gmail.com>, David Brown <davidb@codeaurora.org>, Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>, Alessandro Rubini <rubini@unipv.it>, Stephen Warren <swarren@wwwdotorg.org>, linux-arm-msm@vger.kernel.org, spear-devel@list.st.com, Sekhar Nori <nsekhar@ti.com>, Shiraz Hashim <shiraz.hashim@st.com>, Kukjin Kim <kgene.kim@samsung.com>, Haojian Zhuang <haojian.zhuang@gmail.com>, Ben Dooks <ben-linux@fluff.org>, Barry Song <baohua.song@csr.com>, linux-tegra@vger.kernel.org, linux-omap@vger.kernel.org, Andrew Victor <linux@maxim.org.za>, linux-arm-kern
List-Id: linux-omap@vger.kernel.org

On Sun, Oct 7, 2012 at 12:22 AM, Russell King
<rmk+kernel@arm.linux.org.uk> wrote:
> As suggested by Andrew Morton:
>
>   This is a pet peeve of mine.  Any time there's a long list of items
>   (header file inclusions, kconfig entries, array initalisers, etc) and
>   someone wants to add a new item, they *always* go and stick it at the
>   end of the list.
>   ...
>   Guys, don't do this.  Either put the new item into a randomly-chosen
>   position or, probably better, alphanumerically sort the list.
>
>   For this reason it looks like approximately 0% of the patchset will
>   apply, sorry.
>
> lets sort all our select statements alphanumerically.  This commit was
> created by the following script:
>
> #!/usr/bin/perl
> while (<>) {
>         while (/\\\s*$/) {
>                 $_ .= <>;
>         }
>         undef %selects if /^\s*config\s+/;
>         if (/^\s+select\s+(\w+).*/) {
>                 if (defined($selects{$1})) {
>                         if ($selects{$1} eq $_) {
>                                 print STDERR "Warning: removing duplicated $1 entry\n";
>                         } else {
>                                 print STDERR "Error: $1 differently selected\n".
>                                         "\tOld: $selects{$1}\n".
>                                         "\tNew: $_\n";
>                                 exit 1;
>                         }
>                 }
>                 $selects{$1} = $_;
>                 next;
>         }
>         if (%selects and (/^\s*$/ or /^\s+help/)) {
>                 foreach $k (sort (keys %selects)) {
>                         print "$selects{$k}";
>                 }
>                 undef %selects;
>         }
>         print;
> }
> if (%selects) {
>         foreach $k (sort (keys %selects)) {
>                 print "$selects{$k}";
>         }
> }
>
> It found two duplicates:
>
> Warning: removing duplicated S5P_SETUP_MIPIPHY entry
> Warning: removing duplicated HARDIRQS_SW_RESEND entry
>
> and they are identical duplicates, hence the shrinkage in the diffstat
> of two lines.
>
> Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
> ---
> This commit is likely to change as we get closer to the end of the merge
> window, as other changes get merged into Linus' tree.  I will be refreshing
> this from time to time, and keeping it out of linux-next, as it will cause
> more pain than its worth to put it into linux-next.
>
> Anyone who wants to give this a review to check that it's correct are welcome,
> but I don't think it would be appropriate to collect attributation tags for
> it, as this won't be the final patch.
>
> This patch is intentionally broken to prevent Linus from applying it - this
> is information only!
>
> Anyone who wants to apply it can do so by first running this patch through:
>
>         sed 's/^-- /@@ /'
>
>  arch/arm/Kconfig                  |  399 ++++++++++++++++++-------------------
>  arch/arm/common/Kconfig           |    4 +-
>  arch/arm/mach-at91/Kconfig        |   26 ++--
>  arch/arm/mach-clps711x/Kconfig    |    4 +-
>  arch/arm/mach-davinci/Kconfig     |   16 +-
>  arch/arm/mach-exynos/Kconfig      |  181 +++++++++---------
>  arch/arm/mach-footbridge/Kconfig  |    8 +-
>  arch/arm/mach-h720x/Kconfig       |    2 +-
>  arch/arm/mach-imx/Kconfig         |  120 ++++++------
>  arch/arm/mach-ixp4xx/Kconfig      |    2 +-
>  arch/arm/mach-mmp/Kconfig         |    6 +-
>  arch/arm/mach-msm/Kconfig         |   28 ++--
>  arch/arm/mach-nomadik/Kconfig     |    4 +-
>  arch/arm/mach-omap1/Kconfig       |    8 +-
>  arch/arm/mach-omap2/Kconfig       |   68 +++---
>  arch/arm/mach-prima2/Kconfig      |    2 +-
>  arch/arm/mach-pxa/Kconfig         |  124 ++++++------
>  arch/arm/mach-realview/Kconfig    |   12 +-
>  arch/arm/mach-s3c2412/Kconfig     |    2 +-
>  arch/arm/mach-s3c2440/Kconfig     |    2 +-
>  arch/arm/mach-s3c24xx/Kconfig     |   82 ++++----
>  arch/arm/mach-s3c64xx/Kconfig     |   96 +++++-----
>  arch/arm/mach-s5p64x0/Kconfig     |   28 ++--
>  arch/arm/mach-s5pc100/Kconfig     |   12 +-
>  arch/arm/mach-s5pv210/Kconfig     |   50 +++---
>  arch/arm/mach-sa1100/Kconfig      |   12 +-
>  arch/arm/mach-shmobile/Kconfig    |   42 ++--
>  arch/arm/mach-tegra/Kconfig       |   32 ++--
>  arch/arm/mach-u300/Kconfig        |    2 +-
>  arch/arm/mach-ux500/Kconfig       |   16 +-
>  arch/arm/mach-versatile/Kconfig   |    4 +-
>  arch/arm/mm/Kconfig               |  106 +++++-----
>  arch/arm/plat-mxc/Kconfig         |    4 +-
>  arch/arm/plat-mxc/devices/Kconfig |    2 +-
>  arch/arm/plat-nomadik/Kconfig     |    2 +-
>  arch/arm/plat-omap/Kconfig        |    8 +-
>  arch/arm/plat-s3c24xx/Kconfig     |    2 +-
>  arch/arm/plat-samsung/Kconfig     |   14 +-
>  arch/arm/plat-spear/Kconfig       |    4 +-
>  39 files changed, 767 insertions(+), 769 deletions(-)
>
> diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
> index 7bab17e..4df850c 100644
> --- a/arch/arm/Kconfig
> +++ b/arch/arm/Kconfig
> -- -1,54 +1,53 @@
>  config ARM
>         bool
>         default y
> +       select ARCH_BINFMT_ELF_RANDOMIZE_PIE
> +       select ARCH_HAS_ATOMIC64_DEC_IF_POSITIVE
>         select ARCH_HAVE_CUSTOM_GPIO_H
> -       select HAVE_AOUT
> -       select HAVE_DMA_API_DEBUG
> -       select HAVE_IDE if PCI || ISA || PCMCIA
> -       select HAVE_DMA_ATTRS
> -       select HAVE_DMA_CONTIGUOUS if MMU
> -       select HAVE_MEMBLOCK
> -       select RTC_LIB
> -       select SYS_SUPPORTS_APM_EMULATION
> +       select ARCH_WANT_IPC_PARSE_VERSION
> +       select CPU_PM if (SUSPEND || CPU_IDLE)
> +       select DCACHE_WORD_ACCESS if (CPU_V6 || CPU_V6K || CPU_V7) && !CPU_BIG_ENDIAN
>         select GENERIC_ATOMIC64 if (CPU_V6 || !CPU_32v6K || !AEABI)
> -       select ARCH_HAS_ATOMIC64_DEC_IF_POSITIVE
> -       select HAVE_OPROFILE if (HAVE_PERF_EVENTS)
> +       select GENERIC_CLOCKEVENTS_BROADCAST if SMP
> +       select GENERIC_IRQ_PROBE
> +       select GENERIC_IRQ_SHOW
> +       select GENERIC_PCI_IOMAP
> +       select GENERIC_SMP_IDLE_THREAD
> +       select GENERIC_STRNCPY_FROM_USER
> +       select GENERIC_STRNLEN_USER
> +       select HARDIRQS_SW_RESEND
> +       select HAVE_AOUT
>         select HAVE_ARCH_JUMP_LABEL if !XIP_KERNEL
>         select HAVE_ARCH_KGDB
>         select HAVE_ARCH_TRACEHOOK
> -       select HAVE_KPROBES if !XIP_KERNEL
> -       select HAVE_KRETPROBES if (HAVE_KPROBES)
> -       select HAVE_FUNCTION_TRACER if (!XIP_KERNEL)
> -       select HAVE_FTRACE_MCOUNT_RECORD if (!XIP_KERNEL)
> +       select HAVE_BPF_JIT
> +       select HAVE_C_RECORDMCOUNT
> +       select HAVE_DMA_API_DEBUG
> +       select HAVE_DMA_ATTRS
> +       select HAVE_DMA_CONTIGUOUS if MMU
>         select HAVE_DYNAMIC_FTRACE if (!XIP_KERNEL)
> +       select HAVE_FTRACE_MCOUNT_RECORD if (!XIP_KERNEL)
>         select HAVE_FUNCTION_GRAPH_TRACER if (!THUMB2_KERNEL)
> -       select ARCH_BINFMT_ELF_RANDOMIZE_PIE
> +       select HAVE_FUNCTION_TRACER if (!XIP_KERNEL)
>         select HAVE_GENERIC_DMA_COHERENT
> +       select HAVE_GENERIC_HARDIRQS
> +       select HAVE_HW_BREAKPOINT if (PERF_EVENTS && (CPU_V6 || CPU_V6K || CPU_V7))
> +       select HAVE_IDE if PCI || ISA || PCMCIA
> +       select HAVE_IRQ_WORK
>         select HAVE_KERNEL_GZIP
> -       select HAVE_KERNEL_LZO
>         select HAVE_KERNEL_LZMA
> +       select HAVE_KERNEL_LZO
>         select HAVE_KERNEL_XZ
> -       select HAVE_IRQ_WORK
> +       select HAVE_KPROBES if !XIP_KERNEL
> +       select HAVE_KRETPROBES if (HAVE_KPROBES)
> +       select HAVE_MEMBLOCK
> +       select HAVE_OPROFILE if (HAVE_PERF_EVENTS)
>         select HAVE_PERF_EVENTS
> -       select PERF_USE_VMALLOC
>         select HAVE_REGS_AND_STACK_ACCESS_API
> -       select HAVE_HW_BREAKPOINT if (PERF_EVENTS && (CPU_V6 || CPU_V6K || CPU_V7))
> -       select HAVE_C_RECORDMCOUNT
> -       select HAVE_GENERIC_HARDIRQS
> -       select HARDIRQS_SW_RESEND
> -       select GENERIC_IRQ_PROBE
> -       select GENERIC_IRQ_SHOW
> -       select ARCH_WANT_IPC_PARSE_VERSION
> -       select HARDIRQS_SW_RESEND
> -       select CPU_PM if (SUSPEND || CPU_IDLE)
> -       select GENERIC_PCI_IOMAP
> -       select HAVE_BPF_JIT
> -       select GENERIC_SMP_IDLE_THREAD
>         select KTIME_SCALAR
> -       select GENERIC_CLOCKEVENTS_BROADCAST if SMP
> -       select GENERIC_STRNCPY_FROM_USER
> -       select GENERIC_STRNLEN_USER
> -       select DCACHE_WORD_ACCESS if (CPU_V6 || CPU_V6K || CPU_V7) && !CPU_BIG_ENDIAN
> +       select PERF_USE_VMALLOC
> +       select RTC_LIB
> +       select SYS_SUPPORTS_APM_EMULATION
>         help
>           The ARM series is a line of low-power-consumption RISC chip designs
>           licensed by ARM Ltd and targeted at embedded applications and
> -- -64,9 +63,9 @@ config NEED_SG_DMA_LENGTH
>         bool
>
>  config ARM_DMA_USE_IOMMU
> -       select NEED_SG_DMA_LENGTH
> -       select ARM_HAS_SG_CHAIN
>         bool
> +       select ARM_HAS_SG_CHAIN
> +       select NEED_SG_DMA_LENGTH
>
>  config HAVE_PWM
>         bool
> -- -258,69 +257,69 @@ choice
>
>  config ARCH_MULTIPLATFORM
>         bool "Allow multiple platforms to be selected"
> +       depends on MMU
>         select ARM_PATCH_PHYS_VIRT
>         select AUTO_ZRELADDR
>         select COMMON_CLK
>         select MULTI_IRQ_HANDLER
>         select SPARSE_IRQ
>         select USE_OF
> -       depends on MMU
>
>  config ARCH_INTEGRATOR
>         bool "ARM Ltd. Integrator family"
> -       select ARM_AMBA
>         select ARCH_HAS_CPUFREQ
> +       select ARM_AMBA
>         select COMMON_CLK
>         select COMMON_CLK_VERSATILE
> +       select GENERIC_CLOCKEVENTS
>         select HAVE_TCM
>         select ICST
> -       select GENERIC_CLOCKEVENTS
> +       select MULTI_IRQ_HANDLER
> +       select NEED_MACH_MEMORY_H
>         select PLAT_VERSATILE
>         select PLAT_VERSATILE_FPGA_IRQ
> -       select NEED_MACH_MEMORY_H
>         select SPARSE_IRQ
> -       select MULTI_IRQ_HANDLER
>         help
>           Support for ARM's Integrator platform.
>
>  config ARCH_REALVIEW
>         bool "ARM Ltd. RealView family"
> +       select ARCH_WANT_OPTIONAL_GPIOLIB
>         select ARM_AMBA
> +       select ARM_TIMER_SP804
>         select COMMON_CLK
>         select COMMON_CLK_VERSATILE
> -       select ICST
>         select GENERIC_CLOCKEVENTS
> -       select ARCH_WANT_OPTIONAL_GPIOLIB
> -       select PLAT_VERSATILE
> -       select PLAT_VERSATILE_CLCD
> -       select ARM_TIMER_SP804
>         select GPIO_PL061 if GPIOLIB
> +       select ICST
>         select NEED_MACH_MEMORY_H
> +       select PLAT_VERSATILE
> +       select PLAT_VERSATILE_CLCD
>         help
>           This enables support for ARM Ltd RealView boards.
>
>  config ARCH_VERSATILE
>         bool "ARM Ltd. Versatile family"
> +       select ARCH_WANT_OPTIONAL_GPIOLIB
>         select ARM_AMBA
> +       select ARM_TIMER_SP804
>         select ARM_VIC
>         select CLKDEV_LOOKUP
> +       select GENERIC_CLOCKEVENTS
>         select HAVE_MACH_CLKDEV
>         select ICST
> -       select GENERIC_CLOCKEVENTS
> -       select ARCH_WANT_OPTIONAL_GPIOLIB
>         select PLAT_VERSATILE
> -       select PLAT_VERSATILE_CLOCK
>         select PLAT_VERSATILE_CLCD
> +       select PLAT_VERSATILE_CLOCK
>         select PLAT_VERSATILE_FPGA_IRQ
> -       select ARM_TIMER_SP804
>         help
>           This enables support for ARM Ltd Versatile board.
>
>  config ARCH_AT91
>         bool "Atmel AT91"
>         select ARCH_REQUIRE_GPIOLIB
> -       select HAVE_CLK
>         select CLKDEV_LOOKUP
> +       select HAVE_CLK
>         select IRQ_DOMAIN
>         select NEED_MACH_GPIO_H
>         select NEED_MACH_IO_H if PCCARD
> -- -347,19 +346,19 @@ config ARCH_BCM2835
>
>  config ARCH_CLPS711X
>         bool "Cirrus Logic CLPS711x/EP721x/EP731x-based"
> -       select CPU_ARM720T
>         select ARCH_USES_GETTIMEOFFSET
> -       select COMMON_CLK
>         select CLKDEV_LOOKUP
> +       select COMMON_CLK
> +       select CPU_ARM720T
>         select NEED_MACH_MEMORY_H
>         help
>           Support for Cirrus Logic 711x/721x/731x based boards.
>
>  config ARCH_CNS3XXX
>         bool "Cavium Networks CNS3XXX family"
> +       select ARM_GIC
>         select CPU_V6K
>         select GENERIC_CLOCKEVENTS
> -       select ARM_GIC
>         select MIGHT_HAVE_CACHE_L2X0
>         select MIGHT_HAVE_PCI
>         select PCI_DOMAINS if PCI
> -- -368,20 +367,20 @@ config ARCH_CNS3XXX
>
>  config ARCH_GEMINI
>         bool "Cortina Systems Gemini"
> -       select CPU_FA526
>         select ARCH_REQUIRE_GPIOLIB
>         select ARCH_USES_GETTIMEOFFSET
> +       select CPU_FA526
>         help
>           Support for the Cortina Systems Gemini family SoCs
>
>  config ARCH_SIRF
>         bool "CSR SiRF"
> -       select NO_IOPORT
>         select ARCH_REQUIRE_GPIOLIB
> -       select GENERIC_CLOCKEVENTS
>         select COMMON_CLK
> +       select GENERIC_CLOCKEVENTS
>         select GENERIC_IRQ_CHIP
>         select MIGHT_HAVE_CACHE_L2X0
> +       select NO_IOPORT
>         select PINCTRL
>         select PINCTRL_SIRF
>         select USE_OF
> -- -390,12 +389,12 @@ config ARCH_SIRF
>
>  config ARCH_EBSA110
>         bool "EBSA-110"
> +       select ARCH_USES_GETTIMEOFFSET
>         select CPU_SA110
>         select ISA
> -       select NO_IOPORT
> -       select ARCH_USES_GETTIMEOFFSET
>         select NEED_MACH_IO_H
>         select NEED_MACH_MEMORY_H
> +       select NO_IOPORT
>         help
>           This is an evaluation board for the StrongARM processor available
>           from Digital. It has limited hardware on-board, including an
> -- -404,13 +403,13 @@ config ARCH_EBSA110
>
>  config ARCH_EP93XX
>         bool "EP93xx-based"
> -       select CPU_ARM920T
> +       select ARCH_HAS_HOLES_MEMORYMODEL
> +       select ARCH_REQUIRE_GPIOLIB
> +       select ARCH_USES_GETTIMEOFFSET
>         select ARM_AMBA
>         select ARM_VIC
>         select CLKDEV_LOOKUP
> -       select ARCH_REQUIRE_GPIOLIB
> -       select ARCH_HAS_HOLES_MEMORYMODEL
> -       select ARCH_USES_GETTIMEOFFSET
> +       select CPU_ARM920T
>         select NEED_MACH_MEMORY_H
>         help
>           This enables support for the Cirrus EP93xx series of CPUs.
> -- -429,10 +428,10 @@ config ARCH_FOOTBRIDGE
>
>  config ARCH_MXC
>         bool "Freescale MXC/iMX-based"
> -       select GENERIC_CLOCKEVENTS
>         select ARCH_REQUIRE_GPIOLIB
>         select CLKDEV_LOOKUP
>         select CLKSRC_MMIO
> +       select GENERIC_CLOCKEVENTS
>         select GENERIC_IRQ_CHIP
>         select MULTI_IRQ_HANDLER
>         select SPARSE_IRQ
> -- -442,11 +441,11 @@ config ARCH_MXC
>
>  config ARCH_MXS
>         bool "Freescale MXS-based"
> -       select GENERIC_CLOCKEVENTS
>         select ARCH_REQUIRE_GPIOLIB
>         select CLKDEV_LOOKUP
>         select CLKSRC_MMIO
>         select COMMON_CLK
> +       select GENERIC_CLOCKEVENTS
>         select HAVE_CLK_PREPARE
>         select MULTI_IRQ_HANDLER
>         select PINCTRL
> -- -457,44 +456,44 @@ config ARCH_MXS
>
>  config ARCH_NETX
>         bool "Hilscher NetX based"
> +       select ARM_VIC
>         select CLKSRC_MMIO
>         select CPU_ARM926T
> -       select ARM_VIC
>         select GENERIC_CLOCKEVENTS
>         help
>           This enables support for systems based on the Hilscher NetX Soc
>
>  config ARCH_H720X
>         bool "Hynix HMS720x-based"
> +       select ARCH_USES_GETTIMEOFFSET
>         select CPU_ARM720T
>         select ISA_DMA_API
> -       select ARCH_USES_GETTIMEOFFSET
>         help
>           This enables support for systems based on the Hynix HMS720x
>
>  config ARCH_IOP13XX
>         bool "IOP13xx-based"
>         depends on MMU
> -       select CPU_XSC3
> -       select PLAT_IOP
> -       select PCI
>         select ARCH_SUPPORTS_MSI
> -       select VMSPLIT_1G
> +       select CPU_XSC3
>         select NEED_MACH_MEMORY_H
>         select NEED_RET_TO_USER
> +       select PCI
> +       select PLAT_IOP
> +       select VMSPLIT_1G
>         help
>           Support for Intel's IOP13XX (XScale) family of processors.
>
>  config ARCH_IOP32X
>         bool "IOP32x-based"
>         depends on MMU
> +       select ARCH_REQUIRE_GPIOLIB
>         select CPU_XSCALE
>         select NEED_MACH_GPIO_H
>         select NEED_MACH_IO_H
>         select NEED_RET_TO_USER
> -       select PLAT_IOP
>         select PCI
> -       select ARCH_REQUIRE_GPIOLIB
> +       select PLAT_IOP
>         help
>           Support for Intel's 80219 and IOP32X (XScale) family of
>           processors.
> -- -502,13 +501,13 @@ config ARCH_IOP32X
>  config ARCH_IOP33X
>         bool "IOP33x-based"
>         depends on MMU
> +       select ARCH_REQUIRE_GPIOLIB
>         select CPU_XSCALE
>         select NEED_MACH_GPIO_H
>         select NEED_MACH_IO_H
>         select NEED_RET_TO_USER
> -       select PLAT_IOP
>         select PCI
> -       select ARCH_REQUIRE_GPIOLIB
> +       select PLAT_IOP
>         help
>           Support for Intel's IOP33X (XScale) family of processors.
>
> -- -516,32 +515,32 @@ config ARCH_IXP4XX
>         bool "IXP4xx-based"
>         depends on MMU
>         select ARCH_HAS_DMA_SET_COHERENT_MASK
> +       select ARCH_REQUIRE_GPIOLIB
>         select CLKSRC_MMIO
>         select CPU_XSCALE
> -       select ARCH_REQUIRE_GPIOLIB
> +       select DMABOUNCE if PCI
>         select GENERIC_CLOCKEVENTS
>         select MIGHT_HAVE_PCI
>         select NEED_MACH_IO_H
> -       select DMABOUNCE if PCI
>         help
>           Support for Intel's IXP4XX (XScale) family of processors.
>
>  config ARCH_DOVE
>         bool "Marvell Dove"
> -       select CPU_V7
> -       select PCI
>         select ARCH_REQUIRE_GPIOLIB
> +       select CPU_V7
>         select GENERIC_CLOCKEVENTS
> +       select PCI
>         select PLAT_ORION
>         help
>           Support for the Marvell Dove SoC 88AP510
>
>  config ARCH_KIRKWOOD
>         bool "Marvell Kirkwood"
> -       select CPU_FEROCEON
> -       select PCI
>         select ARCH_REQUIRE_GPIOLIB
> +       select CPU_FEROCEON
>         select GENERIC_CLOCKEVENTS
> +       select PCI
>         select PLAT_ORION
>         help
>           Support for the following Marvell Kirkwood series SoCs:
> -- -549,25 +548,25 @@ config ARCH_KIRKWOOD
>
>  config ARCH_LPC32XX
>         bool "NXP LPC32XX"
> -       select CLKSRC_MMIO
> -       select CPU_ARM926T
>         select ARCH_REQUIRE_GPIOLIB
> -       select HAVE_IDE
>         select ARM_AMBA
> -       select USB_ARCH_HAS_OHCI
>         select CLKDEV_LOOKUP
> +       select CLKSRC_MMIO
> +       select CPU_ARM926T
>         select GENERIC_CLOCKEVENTS
> -       select USE_OF
> +       select HAVE_IDE
>         select HAVE_PWM
> +       select USB_ARCH_HAS_OHCI
> +       select USE_OF
>         help
>           Support for the NXP LPC32XX family of processors
>
>  config ARCH_MV78XX0
>         bool "Marvell MV78xx0"
> -       select CPU_FEROCEON
> -       select PCI
>         select ARCH_REQUIRE_GPIOLIB
> +       select CPU_FEROCEON
>         select GENERIC_CLOCKEVENTS
> +       select PCI
>         select PLAT_ORION
>         help
>           Support for the following Marvell MV78xx0 series SoCs:
> -- -576,10 +575,10 @@ config ARCH_MV78XX0
>  config ARCH_ORION5X
>         bool "Marvell Orion"
>         depends on MMU
> -       select CPU_FEROCEON
> -       select PCI
>         select ARCH_REQUIRE_GPIOLIB
> +       select CPU_FEROCEON
>         select GENERIC_CLOCKEVENTS
> +       select PCI
>         select PLAT_ORION
>         help
>           Support for the following Marvell Orion 5x series SoCs:
> -- -591,33 +590,33 @@ config ARCH_MMP
>         depends on MMU
>         select ARCH_REQUIRE_GPIOLIB
>         select CLKDEV_LOOKUP
> +       select GENERIC_ALLOCATOR
>         select GENERIC_CLOCKEVENTS
>         select GPIO_PXA
>         select IRQ_DOMAIN
> +       select NEED_MACH_GPIO_H
>         select PLAT_PXA
>         select SPARSE_IRQ
> -       select GENERIC_ALLOCATOR
> -       select NEED_MACH_GPIO_H
>         help
>           Support for Marvell's PXA168/PXA910(MMP) and MMP2 processor line.
>
>  config ARCH_KS8695
>         bool "Micrel/Kendin KS8695"
> -       select CPU_ARM922T
>         select ARCH_REQUIRE_GPIOLIB
> -       select NEED_MACH_MEMORY_H
>         select CLKSRC_MMIO
> +       select CPU_ARM922T
>         select GENERIC_CLOCKEVENTS
> +       select NEED_MACH_MEMORY_H
>         help
>           Support for Micrel/Kendin KS8695 "Centaur" (ARM922T) based
>           System-on-Chip devices.
>
>  config ARCH_W90X900
>         bool "Nuvoton W90X900 CPU"
> -       select CPU_ARM926T
>         select ARCH_REQUIRE_GPIOLIB
>         select CLKDEV_LOOKUP
>         select CLKSRC_MMIO
> +       select CPU_ARM926T
>         select GENERIC_CLOCKEVENTS
>         help
>           Support for Nuvoton (Winbond logic dept.) ARM9 processor,
> -- -630,16 +629,16 @@ config ARCH_W90X900
>
>  config ARCH_TEGRA
>         bool "NVIDIA Tegra"
> +       select ARCH_HAS_CPUFREQ
>         select CLKDEV_LOOKUP
>         select CLKSRC_MMIO
> +       select COMMON_CLK
>         select GENERIC_CLOCKEVENTS
>         select GENERIC_GPIO
>         select HAVE_CLK
>         select HAVE_SMP
>         select MIGHT_HAVE_CACHE_L2X0
> -       select ARCH_HAS_CPUFREQ
>         select USE_OF
> -       select COMMON_CLK
>         help
>           This enables support for NVIDIA Tegra based systems (Tegra APX,
>           Tegra 6xx and Tegra 2 series).
> -- -647,29 +646,29 @@ config ARCH_TEGRA
>  config ARCH_PXA
>         bool "PXA2xx/PXA3xx-based"
>         depends on MMU
> -       select ARCH_MTD_XIP
>         select ARCH_HAS_CPUFREQ
> +       select ARCH_MTD_XIP
> +       select ARCH_REQUIRE_GPIOLIB
> +       select ARM_CPU_SUSPEND if PM
> +       select AUTO_ZRELADDR
>         select CLKDEV_LOOKUP
>         select CLKSRC_MMIO
> -       select ARCH_REQUIRE_GPIOLIB
>         select GENERIC_CLOCKEVENTS
>         select GPIO_PXA
> -       select PLAT_PXA
> -       select SPARSE_IRQ
> -       select AUTO_ZRELADDR
> -       select MULTI_IRQ_HANDLER
> -       select ARM_CPU_SUSPEND if PM
>         select HAVE_IDE
> +       select MULTI_IRQ_HANDLER
>         select NEED_MACH_GPIO_H
> +       select PLAT_PXA
> +       select SPARSE_IRQ
>         help
>           Support for Intel/Marvell's PXA2xx/PXA3xx processor line.

The PXA related changes look good to me.

Acked-by: Eric Miao <eric.y.miao@gmail.com>

BTW, maybe we also need to sort the ARCH_XXX in alphanumeric order, so
new ARCH will find a better place to live?
