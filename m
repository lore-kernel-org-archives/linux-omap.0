From: Russell King <rmk+kernel-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>
Subject: [PATCH 1/2] ARM: config: sort select statements alphanumerically
Date: Fri, 12 Oct 2012 14:26:19 +0100
Message-ID: <E1TMfFr-0001Kt-W5@rmk-PC.arm.linux.org.uk>
References: <20121012132553.GK28061@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <davinci-linux-open-source-bounces-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org>
In-Reply-To: <20121012132553.GK28061-l+eeeJia6m9vn6HldHNs0ANdhmdF6hFW@public.gmane.org>
List-Unsubscribe: <http://linux.davincidsp.com/mailman/options/davinci-linux-open-source>,
	<mailto:davinci-linux-open-source-request-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org?subject=unsubscribe>
List-Archive: <http://linux.davincidsp.com/pipermail/davinci-linux-open-source>
List-Post: <mailto:davinci-linux-open-source-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org>
List-Help: <mailto:davinci-linux-open-source-request-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org?subject=help>
List-Subscribe: <http://linux.davincidsp.com/mailman/listinfo/davinci-linux-open-source>,
	<mailto:davinci-linux-open-source-request-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org?subject=subscribe>
Sender: <davinci-linux-open-source-bounces-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org>
Errors-To: davinci-linux-open-source-bounces-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org
To: linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, davinci-linux-open-source-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org, linux-samsung-soc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-msm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-sh-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, spear-devel-nkJGhpqTU55BDgjK7y7TUQ@public.gmane.org
Cc: Srinidhi Kasagar <srinidhi.kasagar-0IS4wlFg1OjSUeElwK9/Pw@public.gmane.org>, Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, Linus Walleij <linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Daniel Walker <dwalker-zu3NM2574RrQT0dZR+AlfA@public.gmane.org>, Kevin Hilman <khilman-l0cyMroinI0@public.gmane.org>, Kukjin Kim <kgene.kim-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, Magnus Damm <magnus.damm-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, David Brown <davidb-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, Jean-Christophe Plagniol-Villard <plagnioj-sclMFOaUSTBWk0Htik3J/w@public.gmane.org>, Alessandro Rubini <rubini-9wsNiZum9E8@public.gmane.org>, Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>, Nicolas Ferre <nicolas.ferre-AIFe0yeh4nAAvxtiuMwx3w@public.gmane.org>, Haojian Zhuang <haojian.zhuang-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Shiraz Hashim <shiraz.hashim-qxv4g6HH51o@public.gmane.org>, Ben Dooks <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>, Barry Song <baohua.song-kQvG35nSl+M@public.gmane.org>, Andrew Victor <linux-PelNFVqkFnVyf+4FbqDuWQ@public.gmane.org>, Eric Miao <eric.y.miao-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Bryan Huntsman <bryanh-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, Paul Mundt <lethal>
List-Id: linux-omap@vger.kernel.org

As suggested by Andrew Morton:

  This is a pet peeve of mine.  Any time there's a long list of items
  (header file inclusions, kconfig entries, array initalisers, etc) and
  someone wants to add a new item, they *always* go and stick it at the
  end of the list.

  Guys, don't do this.  Either put the new item into a randomly-chosen
  position or, probably better, alphanumerically sort the list.

lets sort all our select statements alphanumerically.  This commit was
created by the following perl:

while (<>) {
        while (/\\\s*$/) {
                $_ .= <>;
        }
        undef %selects if /^\s*config\s+/;
        if (/^\s+select\s+(\w+).*/) {
                if (defined($selects{$1})) {
                        if ($selects{$1} eq $_) {
                                print STDERR "Warning: removing duplicated $1 entry\n";
                        } else {
                                print STDERR "Error: $1 differently selected\n".
                                        "\tOld: $selects{$1}\n".
                                        "\tNew: $_\n";
                                exit 1;
                        }
                }
                $selects{$1} = $_;
                next;
        }
        if (%selects and (/^\s*$/ or /^\s+help/)) {
                foreach $k (sort (keys %selects)) {
                        print "$selects{$k}";
                }
                undef %selects;
        }
        print;
}
if (%selects) {
        foreach $k (sort (keys %selects)) {
                print "$selects{$k}";
        }
}

It found two duplicates:

Warning: removing duplicated S5P_SETUP_MIPIPHY entry
Warning: removing duplicated HARDIRQS_SW_RESEND entry

and they are identical duplicates, hence the shrinkage in the diffstat
of two lines.

Signed-off-by: Russell King <rmk+kernel-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>
---
 arch/arm/Kconfig                  |  403 ++++++++++++++++++-------------------
 arch/arm/common/Kconfig           |    4 +-
 arch/arm/mach-at91/Kconfig        |   26 ++--
 arch/arm/mach-clps711x/Kconfig    |    4 +-
 arch/arm/mach-davinci/Kconfig     |   16 +-
 arch/arm/mach-exynos/Kconfig      |  181 ++++++++---------
 arch/arm/mach-footbridge/Kconfig  |    8 +-
 arch/arm/mach-h720x/Kconfig       |    2 +-
 arch/arm/mach-imx/Kconfig         |  120 ++++++------
 arch/arm/mach-ixp4xx/Kconfig      |    2 +-
 arch/arm/mach-mmp/Kconfig         |    6 +-
 arch/arm/mach-msm/Kconfig         |   28 ++--
 arch/arm/mach-nomadik/Kconfig     |    4 +-
 arch/arm/mach-omap1/Kconfig       |    8 +-
 arch/arm/mach-omap2/Kconfig       |   68 +++---
 arch/arm/mach-prima2/Kconfig      |    2 +-
 arch/arm/mach-pxa/Kconfig         |  124 ++++++------
 arch/arm/mach-realview/Kconfig    |   12 +-
 arch/arm/mach-s3c2412/Kconfig     |    2 +-
 arch/arm/mach-s3c2440/Kconfig     |    2 +-
 arch/arm/mach-s3c24xx/Kconfig     |   82 ++++----
 arch/arm/mach-s3c64xx/Kconfig     |   96 +++++-----
 arch/arm/mach-s5p64x0/Kconfig     |   28 ++--
 arch/arm/mach-s5pc100/Kconfig     |   12 +-
 arch/arm/mach-s5pv210/Kconfig     |   50 +++---
 arch/arm/mach-sa1100/Kconfig      |   12 +-
 arch/arm/mach-shmobile/Kconfig    |   42 ++--
 arch/arm/mach-tegra/Kconfig       |   32 ++--
 arch/arm/mach-u300/Kconfig        |    2 +-
 arch/arm/mach-ux500/Kconfig       |   16 +-
 arch/arm/mach-versatile/Kconfig   |    4 +-
 arch/arm/mm/Kconfig               |  106 +++++-----
 arch/arm/plat-mxc/Kconfig         |    4 +-
 arch/arm/plat-mxc/devices/Kconfig |    2 +-
 arch/arm/plat-nomadik/Kconfig     |    2 +-
 arch/arm/plat-omap/Kconfig        |   10 +-
 arch/arm/plat-s3c24xx/Kconfig     |    2 +-
 arch/arm/plat-samsung/Kconfig     |   14 +-
 arch/arm/plat-spear/Kconfig       |    4 +-
 39 files changed, 770 insertions(+), 772 deletions(-)

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index 767aae8..bd12ddd 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -1,58 +1,57 @@
 config ARM
 	bool
 	default y
+	select ARCH_BINFMT_ELF_RANDOMIZE_PIE
+	select ARCH_HAS_ATOMIC64_DEC_IF_POSITIVE
 	select ARCH_HAVE_CUSTOM_GPIO_H
-	select HAVE_AOUT
-	select HAVE_DMA_API_DEBUG
-	select HAVE_IDE if PCI || ISA || PCMCIA
-	select HAVE_DMA_ATTRS
-	select HAVE_DMA_CONTIGUOUS if MMU
-	select HAVE_MEMBLOCK
-	select RTC_LIB
-	select SYS_SUPPORTS_APM_EMULATION
+	select ARCH_WANT_IPC_PARSE_VERSION
+	select CPU_PM if (SUSPEND || CPU_IDLE)
+	select DCACHE_WORD_ACCESS if (CPU_V6 || CPU_V6K || CPU_V7) && !CPU_BIG_ENDIAN
 	select GENERIC_ATOMIC64 if (CPU_V6 || !CPU_32v6K || !AEABI)
-	select ARCH_HAS_ATOMIC64_DEC_IF_POSITIVE
-	select HAVE_OPROFILE if (HAVE_PERF_EVENTS)
+	select GENERIC_CLOCKEVENTS_BROADCAST if SMP
+	select GENERIC_IRQ_PROBE
+	select GENERIC_IRQ_SHOW
+	select GENERIC_KERNEL_THREAD
+	select GENERIC_PCI_IOMAP
+	select GENERIC_SMP_IDLE_THREAD
+	select GENERIC_STRNCPY_FROM_USER
+	select GENERIC_STRNLEN_USER
+	select HARDIRQS_SW_RESEND
+	select HAVE_AOUT
 	select HAVE_ARCH_JUMP_LABEL if !XIP_KERNEL
 	select HAVE_ARCH_KGDB
 	select HAVE_ARCH_TRACEHOOK
-	select HAVE_SYSCALL_TRACEPOINTS
-	select HAVE_KPROBES if !XIP_KERNEL
-	select HAVE_KRETPROBES if (HAVE_KPROBES)
-	select HAVE_FUNCTION_TRACER if (!XIP_KERNEL)
-	select HAVE_FTRACE_MCOUNT_RECORD if (!XIP_KERNEL)
+	select HAVE_BPF_JIT
+	select HAVE_C_RECORDMCOUNT
+	select HAVE_DEBUG_KMEMLEAK
+	select HAVE_DMA_API_DEBUG
+	select HAVE_DMA_ATTRS
+	select HAVE_DMA_CONTIGUOUS if MMU
 	select HAVE_DYNAMIC_FTRACE if (!XIP_KERNEL)
+	select HAVE_FTRACE_MCOUNT_RECORD if (!XIP_KERNEL)
 	select HAVE_FUNCTION_GRAPH_TRACER if (!THUMB2_KERNEL)
-	select ARCH_BINFMT_ELF_RANDOMIZE_PIE
+	select HAVE_FUNCTION_TRACER if (!XIP_KERNEL)
 	select HAVE_GENERIC_DMA_COHERENT
-	select HAVE_DEBUG_KMEMLEAK
+	select HAVE_GENERIC_HARDIRQS
+	select HAVE_HW_BREAKPOINT if (PERF_EVENTS && (CPU_V6 || CPU_V6K || CPU_V7))
+	select HAVE_IDE if PCI || ISA || PCMCIA
+	select HAVE_IRQ_WORK
 	select HAVE_KERNEL_GZIP
-	select HAVE_KERNEL_LZO
 	select HAVE_KERNEL_LZMA
+	select HAVE_KERNEL_LZO
 	select HAVE_KERNEL_XZ
-	select HAVE_IRQ_WORK
+	select HAVE_KPROBES if !XIP_KERNEL
+	select HAVE_KRETPROBES if (HAVE_KPROBES)
+	select HAVE_MEMBLOCK
+	select HAVE_OPROFILE if (HAVE_PERF_EVENTS)
 	select HAVE_PERF_EVENTS
-	select PERF_USE_VMALLOC
 	select HAVE_REGS_AND_STACK_ACCESS_API
-	select HAVE_HW_BREAKPOINT if (PERF_EVENTS && (CPU_V6 || CPU_V6K || CPU_V7))
-	select HAVE_C_RECORDMCOUNT
-	select HAVE_GENERIC_HARDIRQS
-	select HARDIRQS_SW_RESEND
-	select GENERIC_IRQ_PROBE
-	select GENERIC_IRQ_SHOW
+	select HAVE_SYSCALL_TRACEPOINTS
 	select HAVE_UID16
-	select ARCH_WANT_IPC_PARSE_VERSION
-	select HARDIRQS_SW_RESEND
-	select CPU_PM if (SUSPEND || CPU_IDLE)
-	select GENERIC_PCI_IOMAP
-	select HAVE_BPF_JIT
-	select GENERIC_SMP_IDLE_THREAD
 	select KTIME_SCALAR
-	select GENERIC_CLOCKEVENTS_BROADCAST if SMP
-	select GENERIC_STRNCPY_FROM_USER
-	select GENERIC_STRNLEN_USER
-	select DCACHE_WORD_ACCESS if (CPU_V6 || CPU_V6K || CPU_V7) && !CPU_BIG_ENDIAN
-	select GENERIC_KERNEL_THREAD
+	select PERF_USE_VMALLOC
+	select RTC_LIB
+	select SYS_SUPPORTS_APM_EMULATION
 	help
 	  The ARM series is a line of low-power-consumption RISC chip designs
 	  licensed by ARM Ltd and targeted at embedded applications and
@@ -68,9 +67,9 @@ config NEED_SG_DMA_LENGTH
 	bool
 
 config ARM_DMA_USE_IOMMU
-	select NEED_SG_DMA_LENGTH
-	select ARM_HAS_SG_CHAIN
 	bool
+	select ARM_HAS_SG_CHAIN
+	select NEED_SG_DMA_LENGTH
 
 config HAVE_PWM
 	bool
@@ -262,69 +261,69 @@ choice
 
 config ARCH_MULTIPLATFORM
 	bool "Allow multiple platforms to be selected"
+	depends on MMU
 	select ARM_PATCH_PHYS_VIRT
 	select AUTO_ZRELADDR
 	select COMMON_CLK
 	select MULTI_IRQ_HANDLER
 	select SPARSE_IRQ
 	select USE_OF
-	depends on MMU
 
 config ARCH_INTEGRATOR
 	bool "ARM Ltd. Integrator family"
-	select ARM_AMBA
 	select ARCH_HAS_CPUFREQ
+	select ARM_AMBA
 	select COMMON_CLK
 	select COMMON_CLK_VERSATILE
+	select GENERIC_CLOCKEVENTS
 	select HAVE_TCM
 	select ICST
-	select GENERIC_CLOCKEVENTS
+	select MULTI_IRQ_HANDLER
+	select NEED_MACH_MEMORY_H
 	select PLAT_VERSATILE
 	select PLAT_VERSATILE_FPGA_IRQ
-	select NEED_MACH_MEMORY_H
 	select SPARSE_IRQ
-	select MULTI_IRQ_HANDLER
 	help
 	  Support for ARM's Integrator platform.
 
 config ARCH_REALVIEW
 	bool "ARM Ltd. RealView family"
+	select ARCH_WANT_OPTIONAL_GPIOLIB
 	select ARM_AMBA
+	select ARM_TIMER_SP804
 	select COMMON_CLK
 	select COMMON_CLK_VERSATILE
-	select ICST
 	select GENERIC_CLOCKEVENTS
-	select ARCH_WANT_OPTIONAL_GPIOLIB
-	select PLAT_VERSATILE
-	select PLAT_VERSATILE_CLCD
-	select ARM_TIMER_SP804
 	select GPIO_PL061 if GPIOLIB
+	select ICST
 	select NEED_MACH_MEMORY_H
+	select PLAT_VERSATILE
+	select PLAT_VERSATILE_CLCD
 	help
 	  This enables support for ARM Ltd RealView boards.
 
 config ARCH_VERSATILE
 	bool "ARM Ltd. Versatile family"
+	select ARCH_WANT_OPTIONAL_GPIOLIB
 	select ARM_AMBA
+	select ARM_TIMER_SP804
 	select ARM_VIC
 	select CLKDEV_LOOKUP
+	select GENERIC_CLOCKEVENTS
 	select HAVE_MACH_CLKDEV
 	select ICST
-	select GENERIC_CLOCKEVENTS
-	select ARCH_WANT_OPTIONAL_GPIOLIB
 	select PLAT_VERSATILE
-	select PLAT_VERSATILE_CLOCK
 	select PLAT_VERSATILE_CLCD
+	select PLAT_VERSATILE_CLOCK
 	select PLAT_VERSATILE_FPGA_IRQ
-	select ARM_TIMER_SP804
 	help
 	  This enables support for ARM Ltd Versatile board.
 
 config ARCH_AT91
 	bool "Atmel AT91"
 	select ARCH_REQUIRE_GPIOLIB
-	select HAVE_CLK
 	select CLKDEV_LOOKUP
+	select HAVE_CLK
 	select IRQ_DOMAIN
 	select NEED_MACH_GPIO_H
 	select NEED_MACH_IO_H if PCCARD
@@ -351,19 +350,19 @@ config ARCH_BCM2835
 
 config ARCH_CLPS711X
 	bool "Cirrus Logic CLPS711x/EP721x/EP731x-based"
-	select CPU_ARM720T
 	select ARCH_USES_GETTIMEOFFSET
-	select COMMON_CLK
 	select CLKDEV_LOOKUP
+	select COMMON_CLK
+	select CPU_ARM720T
 	select NEED_MACH_MEMORY_H
 	help
 	  Support for Cirrus Logic 711x/721x/731x based boards.
 
 config ARCH_CNS3XXX
 	bool "Cavium Networks CNS3XXX family"
+	select ARM_GIC
 	select CPU_V6K
 	select GENERIC_CLOCKEVENTS
-	select ARM_GIC
 	select MIGHT_HAVE_CACHE_L2X0
 	select MIGHT_HAVE_PCI
 	select PCI_DOMAINS if PCI
@@ -372,20 +371,20 @@ config ARCH_CNS3XXX
 
 config ARCH_GEMINI
 	bool "Cortina Systems Gemini"
-	select CPU_FA526
 	select ARCH_REQUIRE_GPIOLIB
 	select ARCH_USES_GETTIMEOFFSET
+	select CPU_FA526
 	help
 	  Support for the Cortina Systems Gemini family SoCs
 
 config ARCH_SIRF
 	bool "CSR SiRF"
-	select NO_IOPORT
 	select ARCH_REQUIRE_GPIOLIB
-	select GENERIC_CLOCKEVENTS
 	select COMMON_CLK
+	select GENERIC_CLOCKEVENTS
 	select GENERIC_IRQ_CHIP
 	select MIGHT_HAVE_CACHE_L2X0
+	select NO_IOPORT
 	select PINCTRL
 	select PINCTRL_SIRF
 	select USE_OF
@@ -394,12 +393,12 @@ config ARCH_SIRF
 
 config ARCH_EBSA110
 	bool "EBSA-110"
+	select ARCH_USES_GETTIMEOFFSET
 	select CPU_SA110
 	select ISA
-	select NO_IOPORT
-	select ARCH_USES_GETTIMEOFFSET
 	select NEED_MACH_IO_H
 	select NEED_MACH_MEMORY_H
+	select NO_IOPORT
 	help
 	  This is an evaluation board for the StrongARM processor available
 	  from Digital. It has limited hardware on-board, including an
@@ -408,13 +407,13 @@ config ARCH_EBSA110
 
 config ARCH_EP93XX
 	bool "EP93xx-based"
-	select CPU_ARM920T
+	select ARCH_HAS_HOLES_MEMORYMODEL
+	select ARCH_REQUIRE_GPIOLIB
+	select ARCH_USES_GETTIMEOFFSET
 	select ARM_AMBA
 	select ARM_VIC
 	select CLKDEV_LOOKUP
-	select ARCH_REQUIRE_GPIOLIB
-	select ARCH_HAS_HOLES_MEMORYMODEL
-	select ARCH_USES_GETTIMEOFFSET
+	select CPU_ARM920T
 	select NEED_MACH_MEMORY_H
 	help
 	  This enables support for the Cirrus EP93xx series of CPUs.
@@ -433,10 +432,10 @@ config ARCH_FOOTBRIDGE
 
 config ARCH_MXC
 	bool "Freescale MXC/iMX-based"
-	select GENERIC_CLOCKEVENTS
 	select ARCH_REQUIRE_GPIOLIB
 	select CLKDEV_LOOKUP
 	select CLKSRC_MMIO
+	select GENERIC_CLOCKEVENTS
 	select GENERIC_IRQ_CHIP
 	select MULTI_IRQ_HANDLER
 	select SPARSE_IRQ
@@ -446,11 +445,11 @@ config ARCH_MXC
 
 config ARCH_MXS
 	bool "Freescale MXS-based"
-	select GENERIC_CLOCKEVENTS
 	select ARCH_REQUIRE_GPIOLIB
 	select CLKDEV_LOOKUP
 	select CLKSRC_MMIO
 	select COMMON_CLK
+	select GENERIC_CLOCKEVENTS
 	select HAVE_CLK_PREPARE
 	select MULTI_IRQ_HANDLER
 	select PINCTRL
@@ -461,43 +460,43 @@ config ARCH_MXS
 
 config ARCH_NETX
 	bool "Hilscher NetX based"
+	select ARM_VIC
 	select CLKSRC_MMIO
 	select CPU_ARM926T
-	select ARM_VIC
 	select GENERIC_CLOCKEVENTS
 	help
 	  This enables support for systems based on the Hilscher NetX Soc
 
 config ARCH_H720X
 	bool "Hynix HMS720x-based"
+	select ARCH_USES_GETTIMEOFFSET
 	select CPU_ARM720T
 	select ISA_DMA_API
-	select ARCH_USES_GETTIMEOFFSET
 	help
 	  This enables support for systems based on the Hynix HMS720x
 
 config ARCH_IOP13XX
 	bool "IOP13xx-based"
 	depends on MMU
-	select CPU_XSC3
-	select PLAT_IOP
-	select PCI
 	select ARCH_SUPPORTS_MSI
-	select VMSPLIT_1G
+	select CPU_XSC3
 	select NEED_MACH_MEMORY_H
 	select NEED_RET_TO_USER
+	select PCI
+	select PLAT_IOP
+	select VMSPLIT_1G
 	help
 	  Support for Intel's IOP13XX (XScale) family of processors.
 
 config ARCH_IOP32X
 	bool "IOP32x-based"
 	depends on MMU
+	select ARCH_REQUIRE_GPIOLIB
 	select CPU_XSCALE
 	select NEED_MACH_GPIO_H
 	select NEED_RET_TO_USER
-	select PLAT_IOP
 	select PCI
-	select ARCH_REQUIRE_GPIOLIB
+	select PLAT_IOP
 	help
 	  Support for Intel's 80219 and IOP32X (XScale) family of
 	  processors.
@@ -505,12 +504,12 @@ config ARCH_IOP32X
 config ARCH_IOP33X
 	bool "IOP33x-based"
 	depends on MMU
+	select ARCH_REQUIRE_GPIOLIB
 	select CPU_XSCALE
 	select NEED_MACH_GPIO_H
 	select NEED_RET_TO_USER
-	select PLAT_IOP
 	select PCI
-	select ARCH_REQUIRE_GPIOLIB
+	select PLAT_IOP
 	help
 	  Support for Intel's IOP33X (XScale) family of processors.
 
@@ -518,20 +517,20 @@ config ARCH_IXP4XX
 	bool "IXP4xx-based"
 	depends on MMU
 	select ARCH_HAS_DMA_SET_COHERENT_MASK
+	select ARCH_REQUIRE_GPIOLIB
 	select CLKSRC_MMIO
 	select CPU_XSCALE
-	select ARCH_REQUIRE_GPIOLIB
+	select DMABOUNCE if PCI
 	select GENERIC_CLOCKEVENTS
 	select MIGHT_HAVE_PCI
 	select NEED_MACH_IO_H
-	select DMABOUNCE if PCI
 	help
 	  Support for Intel's IXP4XX (XScale) family of processors.
 
 config ARCH_DOVE
 	bool "Marvell Dove"
-	select CPU_V7
 	select ARCH_REQUIRE_GPIOLIB
+	select CPU_V7
 	select GENERIC_CLOCKEVENTS
 	select MIGHT_HAVE_PCI
 	select PLAT_ORION_LEGACY
@@ -541,10 +540,10 @@ config ARCH_DOVE
 
 config ARCH_KIRKWOOD
 	bool "Marvell Kirkwood"
-	select CPU_FEROCEON
-	select PCI
 	select ARCH_REQUIRE_GPIOLIB
+	select CPU_FEROCEON
 	select GENERIC_CLOCKEVENTS
+	select PCI
 	select PLAT_ORION_LEGACY
 	help
 	  Support for the following Marvell Kirkwood series SoCs:
@@ -552,25 +551,25 @@ config ARCH_KIRKWOOD
 
 config ARCH_LPC32XX
 	bool "NXP LPC32XX"
-	select CLKSRC_MMIO
-	select CPU_ARM926T
 	select ARCH_REQUIRE_GPIOLIB
-	select HAVE_IDE
 	select ARM_AMBA
-	select USB_ARCH_HAS_OHCI
 	select CLKDEV_LOOKUP
+	select CLKSRC_MMIO
+	select CPU_ARM926T
 	select GENERIC_CLOCKEVENTS
-	select USE_OF
+	select HAVE_IDE
 	select HAVE_PWM
+	select USB_ARCH_HAS_OHCI
+	select USE_OF
 	help
 	  Support for the NXP LPC32XX family of processors
 
 config ARCH_MV78XX0
 	bool "Marvell MV78xx0"
-	select CPU_FEROCEON
-	select PCI
 	select ARCH_REQUIRE_GPIOLIB
+	select CPU_FEROCEON
 	select GENERIC_CLOCKEVENTS
+	select PCI
 	select PLAT_ORION_LEGACY
 	help
 	  Support for the following Marvell MV78xx0 series SoCs:
@@ -579,10 +578,10 @@ config ARCH_MV78XX0
 config ARCH_ORION5X
 	bool "Marvell Orion"
 	depends on MMU
-	select CPU_FEROCEON
-	select PCI
 	select ARCH_REQUIRE_GPIOLIB
+	select CPU_FEROCEON
 	select GENERIC_CLOCKEVENTS
+	select PCI
 	select PLAT_ORION_LEGACY
 	help
 	  Support for the following Marvell Orion 5x series SoCs:
@@ -594,33 +593,33 @@ config ARCH_MMP
 	depends on MMU
 	select ARCH_REQUIRE_GPIOLIB
 	select CLKDEV_LOOKUP
+	select GENERIC_ALLOCATOR
 	select GENERIC_CLOCKEVENTS
 	select GPIO_PXA
 	select IRQ_DOMAIN
+	select NEED_MACH_GPIO_H
 	select PLAT_PXA
 	select SPARSE_IRQ
-	select GENERIC_ALLOCATOR
-	select NEED_MACH_GPIO_H
 	help
 	  Support for Marvell's PXA168/PXA910(MMP) and MMP2 processor line.
 
 config ARCH_KS8695
 	bool "Micrel/Kendin KS8695"
-	select CPU_ARM922T
 	select ARCH_REQUIRE_GPIOLIB
-	select NEED_MACH_MEMORY_H
 	select CLKSRC_MMIO
+	select CPU_ARM922T
 	select GENERIC_CLOCKEVENTS
+	select NEED_MACH_MEMORY_H
 	help
 	  Support for Micrel/Kendin KS8695 "Centaur" (ARM922T) based
 	  System-on-Chip devices.
 
 config ARCH_W90X900
 	bool "Nuvoton W90X900 CPU"
-	select CPU_ARM926T
 	select ARCH_REQUIRE_GPIOLIB
 	select CLKDEV_LOOKUP
 	select CLKSRC_MMIO
+	select CPU_ARM926T
 	select GENERIC_CLOCKEVENTS
 	help
 	  Support for Nuvoton (Winbond logic dept.) ARM9 processor,
@@ -633,16 +632,16 @@ config ARCH_W90X900
 
 config ARCH_TEGRA
 	bool "NVIDIA Tegra"
+	select ARCH_HAS_CPUFREQ
 	select CLKDEV_LOOKUP
 	select CLKSRC_MMIO
+	select COMMON_CLK
 	select GENERIC_CLOCKEVENTS
 	select GENERIC_GPIO
 	select HAVE_CLK
 	select HAVE_SMP
 	select MIGHT_HAVE_CACHE_L2X0
-	select ARCH_HAS_CPUFREQ
 	select USE_OF
-	select COMMON_CLK
 	help
 	  This enables support for NVIDIA Tegra based systems (Tegra APX,
 	  Tegra 6xx and Tegra 2 series).
@@ -650,29 +649,29 @@ config ARCH_TEGRA
 config ARCH_PXA
 	bool "PXA2xx/PXA3xx-based"
 	depends on MMU
-	select ARCH_MTD_XIP
 	select ARCH_HAS_CPUFREQ
+	select ARCH_MTD_XIP
+	select ARCH_REQUIRE_GPIOLIB
+	select ARM_CPU_SUSPEND if PM
+	select AUTO_ZRELADDR
 	select CLKDEV_LOOKUP
 	select CLKSRC_MMIO
-	select ARCH_REQUIRE_GPIOLIB
 	select GENERIC_CLOCKEVENTS
 	select GPIO_PXA
-	select PLAT_PXA
-	select SPARSE_IRQ
-	select AUTO_ZRELADDR
-	select MULTI_IRQ_HANDLER
-	select ARM_CPU_SUSPEND if PM
 	select HAVE_IDE
+	select MULTI_IRQ_HANDLER
 	select NEED_MACH_GPIO_H
+	select PLAT_PXA
+	select SPARSE_IRQ
 	help
 	  Support for Intel/Marvell's PXA2xx/PXA3xx processor line.
 
 config ARCH_MSM
 	bool "Qualcomm MSM"
-	select HAVE_CLK
-	select GENERIC_CLOCKEVENTS
 	select ARCH_REQUIRE_GPIOLIB
 	select CLKDEV_LOOKUP
+	select GENERIC_CLOCKEVENTS
+	select HAVE_CLK
 	help
 	  Support for Qualcomm MSM/QSD based systems.  This runs on the
 	  apps processor of the MSM/QSD and depends on a shared memory
@@ -682,50 +681,50 @@ config ARCH_MSM
 
 config ARCH_SHMOBILE
 	bool "Renesas SH-Mobile / R-Mobile"
-	select HAVE_CLK
 	select CLKDEV_LOOKUP
+	select GENERIC_CLOCKEVENTS
+	select HAVE_CLK
 	select HAVE_MACH_CLKDEV
 	select HAVE_SMP
-	select GENERIC_CLOCKEVENTS
 	select MIGHT_HAVE_CACHE_L2X0
-	select NO_IOPORT
-	select SPARSE_IRQ
 	select MULTI_IRQ_HANDLER
-	select PM_GENERIC_DOMAINS if PM
 	select NEED_MACH_MEMORY_H
+	select NO_IOPORT
+	select PM_GENERIC_DOMAINS if PM
+	select SPARSE_IRQ
 	help
 	  Support for Renesas's SH-Mobile and R-Mobile ARM platforms.
 
 config ARCH_RPC
 	bool "RiscPC"
 	select ARCH_ACORN
-	select FIQ
 	select ARCH_MAY_HAVE_PC_FDC
-	select HAVE_PATA_PLATFORM
-	select ISA_DMA_API
-	select NO_IOPORT
 	select ARCH_SPARSEMEM_ENABLE
 	select ARCH_USES_GETTIMEOFFSET
+	select FIQ
 	select HAVE_IDE
+	select HAVE_PATA_PLATFORM
+	select ISA_DMA_API
 	select NEED_MACH_IO_H
 	select NEED_MACH_MEMORY_H
+	select NO_IOPORT
 	help
 	  On the Acorn Risc-PC, Linux can support the internal IDE disk and
 	  CD-ROM interface, serial and parallel port, and the floppy drive.
 
 config ARCH_SA1100
 	bool "SA1100-based"
-	select CLKSRC_MMIO
-	select CPU_SA1100
-	select ISA
-	select ARCH_SPARSEMEM_ENABLE
-	select ARCH_MTD_XIP
 	select ARCH_HAS_CPUFREQ
+	select ARCH_MTD_XIP
+	select ARCH_REQUIRE_GPIOLIB
+	select ARCH_SPARSEMEM_ENABLE
+	select CLKDEV_LOOKUP
+	select CLKSRC_MMIO
 	select CPU_FREQ
+	select CPU_SA1100
 	select GENERIC_CLOCKEVENTS
-	select CLKDEV_LOOKUP
-	select ARCH_REQUIRE_GPIOLIB
 	select HAVE_IDE
+	select ISA
 	select NEED_MACH_GPIO_H
 	select NEED_MACH_MEMORY_H
 	select SPARSE_IRQ
@@ -734,14 +733,14 @@ config ARCH_SA1100
 
 config ARCH_S3C24XX
 	bool "Samsung S3C24XX SoCs"
-	select GENERIC_GPIO
 	select ARCH_HAS_CPUFREQ
-	select HAVE_CLK
-	select CLKDEV_LOOKUP
 	select ARCH_USES_GETTIMEOFFSET
+	select CLKDEV_LOOKUP
+	select GENERIC_GPIO
+	select HAVE_CLK
 	select HAVE_S3C2410_I2C if I2C
-	select HAVE_S3C_RTC if RTC_CLASS
 	select HAVE_S3C2410_WATCHDOG if WATCHDOG
+	select HAVE_S3C_RTC if RTC_CLASS
 	select NEED_MACH_GPIO_H
 	select NEED_MACH_IO_H
 	help
@@ -752,38 +751,38 @@ config ARCH_S3C24XX
 
 config ARCH_S3C64XX
 	bool "Samsung S3C64XX"
-	select PLAT_SAMSUNG
-	select CPU_V6
+	select ARCH_HAS_CPUFREQ
+	select ARCH_REQUIRE_GPIOLIB
+	select ARCH_USES_GETTIMEOFFSET
 	select ARM_VIC
+	select CLKDEV_LOOKUP
+	select CPU_V6
 	select HAVE_CLK
+	select HAVE_S3C2410_I2C if I2C
+	select HAVE_S3C2410_WATCHDOG if WATCHDOG
 	select HAVE_TCM
-	select CLKDEV_LOOKUP
+	select NEED_MACH_GPIO_H
 	select NO_IOPORT
-	select ARCH_USES_GETTIMEOFFSET
-	select ARCH_HAS_CPUFREQ
-	select ARCH_REQUIRE_GPIOLIB
+	select PLAT_SAMSUNG
+	select S3C_DEV_NAND
+	select S3C_GPIO_TRACK
 	select SAMSUNG_CLKSRC
+	select SAMSUNG_GPIOLIB_4BIT
 	select SAMSUNG_IRQ_VIC_TIMER
-	select S3C_GPIO_TRACK
-	select S3C_DEV_NAND
 	select USB_ARCH_HAS_OHCI
-	select SAMSUNG_GPIOLIB_4BIT
-	select HAVE_S3C2410_I2C if I2C
-	select HAVE_S3C2410_WATCHDOG if WATCHDOG
-	select NEED_MACH_GPIO_H
 	help
 	  Samsung S3C64XX series based systems
 
 config ARCH_S5P64X0
 	bool "Samsung S5P6440 S5P6450"
-	select CPU_V6
-	select GENERIC_GPIO
-	select HAVE_CLK
 	select CLKDEV_LOOKUP
 	select CLKSRC_MMIO
-	select HAVE_S3C2410_WATCHDOG if WATCHDOG
+	select CPU_V6
 	select GENERIC_CLOCKEVENTS
+	select GENERIC_GPIO
+	select HAVE_CLK
 	select HAVE_S3C2410_I2C if I2C
+	select HAVE_S3C2410_WATCHDOG if WATCHDOG
 	select HAVE_S3C_RTC if RTC_CLASS
 	select NEED_MACH_GPIO_H
 	help
@@ -792,32 +791,32 @@ config ARCH_S5P64X0
 
 config ARCH_S5PC100
 	bool "Samsung S5PC100"
-	select GENERIC_GPIO
-	select HAVE_CLK
+	select ARCH_USES_GETTIMEOFFSET
 	select CLKDEV_LOOKUP
 	select CPU_V7
-	select ARCH_USES_GETTIMEOFFSET
+	select GENERIC_GPIO
+	select HAVE_CLK
 	select HAVE_S3C2410_I2C if I2C
-	select HAVE_S3C_RTC if RTC_CLASS
 	select HAVE_S3C2410_WATCHDOG if WATCHDOG
+	select HAVE_S3C_RTC if RTC_CLASS
 	select NEED_MACH_GPIO_H
 	help
 	  Samsung S5PC100 series based systems
 
 config ARCH_S5PV210
 	bool "Samsung S5PV210/S5PC110"
-	select CPU_V7
-	select ARCH_SPARSEMEM_ENABLE
+	select ARCH_HAS_CPUFREQ
 	select ARCH_HAS_HOLES_MEMORYMODEL
-	select GENERIC_GPIO
-	select HAVE_CLK
+	select ARCH_SPARSEMEM_ENABLE
 	select CLKDEV_LOOKUP
 	select CLKSRC_MMIO
-	select ARCH_HAS_CPUFREQ
+	select CPU_V7
 	select GENERIC_CLOCKEVENTS
+	select GENERIC_GPIO
+	select HAVE_CLK
 	select HAVE_S3C2410_I2C if I2C
-	select HAVE_S3C_RTC if RTC_CLASS
 	select HAVE_S3C2410_WATCHDOG if WATCHDOG
+	select HAVE_S3C_RTC if RTC_CLASS
 	select NEED_MACH_GPIO_H
 	select NEED_MACH_MEMORY_H
 	help
@@ -825,17 +824,17 @@ config ARCH_S5PV210
 
 config ARCH_EXYNOS
 	bool "SAMSUNG EXYNOS"
-	select CPU_V7
-	select ARCH_SPARSEMEM_ENABLE
+	select ARCH_HAS_CPUFREQ
 	select ARCH_HAS_HOLES_MEMORYMODEL
-	select GENERIC_GPIO
-	select HAVE_CLK
+	select ARCH_SPARSEMEM_ENABLE
 	select CLKDEV_LOOKUP
-	select ARCH_HAS_CPUFREQ
+	select CPU_V7
 	select GENERIC_CLOCKEVENTS
-	select HAVE_S3C_RTC if RTC_CLASS
+	select GENERIC_GPIO
+	select HAVE_CLK
 	select HAVE_S3C2410_I2C if I2C
 	select HAVE_S3C2410_WATCHDOG if WATCHDOG
+	select HAVE_S3C_RTC if RTC_CLASS
 	select NEED_MACH_GPIO_H
 	select NEED_MACH_MEMORY_H
 	help
@@ -843,13 +842,13 @@ config ARCH_EXYNOS
 
 config ARCH_SHARK
 	bool "Shark"
+	select ARCH_USES_GETTIMEOFFSET
 	select CPU_SA110
 	select ISA
 	select ISA_DMA
-	select ZONE_DMA
-	select PCI
-	select ARCH_USES_GETTIMEOFFSET
 	select NEED_MACH_MEMORY_H
+	select PCI
+	select ZONE_DMA
 	help
 	  Support for the StrongARM based Digital DNARD machine, also known
 	  as "Shark" (<http://www.shark-linux.de/shark.html>).
@@ -857,17 +856,17 @@ config ARCH_SHARK
 config ARCH_U300
 	bool "ST-Ericsson U300 Series"
 	depends on MMU
-	select CLKSRC_MMIO
-	select CPU_ARM926T
-	select HAVE_TCM
+	select ARCH_REQUIRE_GPIOLIB
 	select ARM_AMBA
 	select ARM_PATCH_PHYS_VIRT
 	select ARM_VIC
-	select GENERIC_CLOCKEVENTS
 	select CLKDEV_LOOKUP
+	select CLKSRC_MMIO
 	select COMMON_CLK
+	select CPU_ARM926T
+	select GENERIC_CLOCKEVENTS
 	select GENERIC_GPIO
-	select ARCH_REQUIRE_GPIOLIB
+	select HAVE_TCM
 	select SPARSE_IRQ
 	help
 	  Support for ST-Ericsson U300 series mobile platforms.
@@ -875,12 +874,12 @@ config ARCH_U300
 config ARCH_U8500
 	bool "ST-Ericsson U8500 Series"
 	depends on MMU
-	select CPU_V7
+	select ARCH_HAS_CPUFREQ
+	select ARCH_REQUIRE_GPIOLIB
 	select ARM_AMBA
-	select GENERIC_CLOCKEVENTS
 	select CLKDEV_LOOKUP
-	select ARCH_REQUIRE_GPIOLIB
-	select ARCH_HAS_CPUFREQ
+	select CPU_V7
+	select GENERIC_CLOCKEVENTS
 	select HAVE_SMP
 	select MIGHT_HAVE_CACHE_L2X0
 	help
@@ -888,52 +887,52 @@ config ARCH_U8500
 
 config ARCH_NOMADIK
 	bool "STMicroelectronics Nomadik"
+	select ARCH_REQUIRE_GPIOLIB
 	select ARM_AMBA
 	select ARM_VIC
-	select CPU_ARM926T
 	select COMMON_CLK
+	select CPU_ARM926T
 	select GENERIC_CLOCKEVENTS
+	select MIGHT_HAVE_CACHE_L2X0
 	select PINCTRL
 	select PINCTRL_STN8815
-	select MIGHT_HAVE_CACHE_L2X0
-	select ARCH_REQUIRE_GPIOLIB
 	help
 	  Support for the Nomadik platform by ST-Ericsson
 
 config ARCH_DAVINCI
 	bool "TI DaVinci"
-	select GENERIC_CLOCKEVENTS
+	select ARCH_HAS_HOLES_MEMORYMODEL
 	select ARCH_REQUIRE_GPIOLIB
-	select ZONE_DMA
-	select HAVE_IDE
 	select CLKDEV_LOOKUP
 	select GENERIC_ALLOCATOR
+	select GENERIC_CLOCKEVENTS
 	select GENERIC_IRQ_CHIP
-	select ARCH_HAS_HOLES_MEMORYMODEL
+	select HAVE_IDE
 	select NEED_MACH_GPIO_H
+	select ZONE_DMA
 	help
 	  Support for TI's DaVinci platform.
 
 config ARCH_OMAP
 	bool "TI OMAP"
 	depends on MMU
-	select HAVE_CLK
-	select ARCH_REQUIRE_GPIOLIB
 	select ARCH_HAS_CPUFREQ
+	select ARCH_HAS_HOLES_MEMORYMODEL
+	select ARCH_REQUIRE_GPIOLIB
 	select CLKSRC_MMIO
 	select GENERIC_CLOCKEVENTS
-	select ARCH_HAS_HOLES_MEMORYMODEL
+	select HAVE_CLK
 	select NEED_MACH_GPIO_H
 	help
 	  Support for TI's OMAP platform (OMAP1/2/3/4).
 
 config PLAT_SPEAR
 	bool "ST SPEAr"
-	select ARM_AMBA
 	select ARCH_REQUIRE_GPIOLIB
+	select ARM_AMBA
 	select CLKDEV_LOOKUP
-	select COMMON_CLK
 	select CLKSRC_MMIO
+	select COMMON_CLK
 	select GENERIC_CLOCKEVENTS
 	select HAVE_CLK
 	help
@@ -941,25 +940,25 @@ config PLAT_SPEAR
 
 config ARCH_VT8500
 	bool "VIA/WonderMedia 85xx"
-	select CPU_ARM926T
-	select GENERIC_GPIO
 	select ARCH_HAS_CPUFREQ
-	select GENERIC_CLOCKEVENTS
 	select ARCH_REQUIRE_GPIOLIB
-	select USE_OF
+	select CLKDEV_LOOKUP
 	select COMMON_CLK
+	select CPU_ARM926T
+	select GENERIC_CLOCKEVENTS
+	select GENERIC_GPIO
 	select HAVE_CLK
-	select CLKDEV_LOOKUP
+	select USE_OF
 	help
 	  Support for VIA/WonderMedia VT8500/WM85xx System-on-Chip.
 
 config ARCH_ZYNQ
 	bool "Xilinx Zynq ARM Cortex A9 Platform"
+	select ARM_AMBA
+	select ARM_GIC
+	select CLKDEV_LOOKUP
 	select CPU_V7
 	select GENERIC_CLOCKEVENTS
-	select CLKDEV_LOOKUP
-	select ARM_GIC
-	select ARM_AMBA
 	select ICST
 	select MIGHT_HAVE_CACHE_L2X0
 	select USE_OF
@@ -974,33 +973,33 @@ comment "CPU Core family selection"
 
 config ARCH_MULTI_V4
 	bool "ARMv4 based platforms (FA526, StrongARM)"
-	select ARCH_MULTI_V4_V5
 	depends on !ARCH_MULTI_V6_V7
+	select ARCH_MULTI_V4_V5
 
 config ARCH_MULTI_V4T
 	bool "ARMv4T based platforms (ARM720T, ARM920T, ...)"
-	select ARCH_MULTI_V4_V5
 	depends on !ARCH_MULTI_V6_V7
+	select ARCH_MULTI_V4_V5
 
 config ARCH_MULTI_V5
 	bool "ARMv5 based platforms (ARM926T, XSCALE, PJ1, ...)"
-	select ARCH_MULTI_V4_V5
 	depends on !ARCH_MULTI_V6_V7
+	select ARCH_MULTI_V4_V5
 
 config ARCH_MULTI_V4_V5
 	bool
 
 config ARCH_MULTI_V6
 	bool "ARMv6 based platforms (ARM11, Scorpion, ...)"
-	select CPU_V6
 	select ARCH_MULTI_V6_V7
+	select CPU_V6
 
 config ARCH_MULTI_V7
 	bool "ARMv7 based platforms (Cortex-A, PJ4, Krait)"
-	select CPU_V7
-	select ARCH_VEXPRESS
 	default y
 	select ARCH_MULTI_V6_V7
+	select ARCH_VEXPRESS
+	select CPU_V7
 
 config ARCH_MULTI_V6_V7
 	bool
@@ -1137,9 +1136,9 @@ config PLAT_IOP
 config PLAT_ORION
 	bool
 	select CLKSRC_MMIO
+	select COMMON_CLK
 	select GENERIC_IRQ_CHIP
 	select IRQ_DOMAIN
-	select COMMON_CLK
 
 config PLAT_ORION_LEGACY
 	bool
@@ -1497,8 +1496,8 @@ config SMP
 	depends on GENERIC_CLOCKEVENTS
 	depends on HAVE_SMP
 	depends on MMU
-	select USE_GENERIC_SMP_HELPERS
 	select HAVE_ARM_SCU if !ARCH_MSM_SCORPIONMP
+	select USE_GENERIC_SMP_HELPERS
 	help
 	  This enables support for systems with more than one CPU. If you have
 	  a system with only one CPU, like most personal computers, say N. If
@@ -1857,9 +1856,9 @@ menu "Boot options"
 
 config USE_OF
 	bool "Flattened Device Tree support"
+	select IRQ_DOMAIN
 	select OF
 	select OF_EARLY_FLATTREE
-	select IRQ_DOMAIN
 	help
 	  Include support for flattened device tree machine descriptions.
 
@@ -2141,8 +2140,8 @@ config CPU_FREQ_PXA
 	bool
 	depends on CPU_FREQ && ARCH_PXA && PXA25x
 	default y
-	select CPU_FREQ_TABLE
 	select CPU_FREQ_DEFAULT_GOV_USERSPACE
+	select CPU_FREQ_TABLE
 
 config CPU_FREQ_S3C
 	bool
diff --git a/arch/arm/common/Kconfig b/arch/arm/common/Kconfig
index 283fa1d..45ceeb0 100644
--- a/arch/arm/common/Kconfig
+++ b/arch/arm/common/Kconfig
@@ -1,15 +1,15 @@
 config ARM_GIC
+	bool
 	select IRQ_DOMAIN
 	select MULTI_IRQ_HANDLER
-	bool
 
 config GIC_NON_BANKED
 	bool
 
 config ARM_VIC
+	bool
 	select IRQ_DOMAIN
 	select MULTI_IRQ_HANDLER
-	bool
 
 config ARM_VIC_NR
 	int
diff --git a/arch/arm/mach-at91/Kconfig b/arch/arm/mach-at91/Kconfig
index c8050b1..b142071 100644
--- a/arch/arm/mach-at91/Kconfig
+++ b/arch/arm/mach-at91/Kconfig
@@ -19,8 +19,8 @@ config AT91_SAM9G45_RESET
 
 config SOC_AT91SAM9
 	bool
-	select GENERIC_CLOCKEVENTS
 	select CPU_ARM926T
+	select GENERIC_CLOCKEVENTS
 
 menu "Atmel AT91 System-on-Chip"
 
@@ -28,66 +28,66 @@ comment "Atmel AT91 Processor"
 
 config SOC_AT91SAM9
 	bool
+	select AT91_SAM9_SMC
+	select AT91_SAM9_TIME
 	select CPU_ARM926T
 	select MULTI_IRQ_HANDLER
 	select SPARSE_IRQ
-	select AT91_SAM9_TIME
-	select AT91_SAM9_SMC
 
 config SOC_AT91RM9200
 	bool "AT91RM9200"
 	select CPU_ARM920T
-	select MULTI_IRQ_HANDLER
-	select SPARSE_IRQ
 	select GENERIC_CLOCKEVENTS
 	select HAVE_AT91_DBGU0
+	select MULTI_IRQ_HANDLER
+	select SPARSE_IRQ
 
 config SOC_AT91SAM9260
 	bool "AT91SAM9260, AT91SAM9XE or AT91SAM9G20"
-	select SOC_AT91SAM9
 	select HAVE_AT91_DBGU0
 	select HAVE_NET_MACB
+	select SOC_AT91SAM9
 	help
 	  Select this if you are using one of Atmel's AT91SAM9260, AT91SAM9XE
 	  or AT91SAM9G20 SoC.
 
 config SOC_AT91SAM9261
 	bool "AT91SAM9261 or AT91SAM9G10"
-	select SOC_AT91SAM9
 	select HAVE_AT91_DBGU0
 	select HAVE_FB_ATMEL
+	select SOC_AT91SAM9
 	help
 	  Select this if you are using one of Atmel's AT91SAM9261 or AT91SAM9G10 SoC.
 
 config SOC_AT91SAM9263
 	bool "AT91SAM9263"
-	select SOC_AT91SAM9
 	select HAVE_AT91_DBGU1
 	select HAVE_FB_ATMEL
 	select HAVE_NET_MACB
+	select SOC_AT91SAM9
 
 config SOC_AT91SAM9RL
 	bool "AT91SAM9RL"
-	select SOC_AT91SAM9
 	select HAVE_AT91_DBGU0
 	select HAVE_FB_ATMEL
+	select SOC_AT91SAM9
 
 config SOC_AT91SAM9G45
 	bool "AT91SAM9G45 or AT91SAM9M10 families"
-	select SOC_AT91SAM9
 	select HAVE_AT91_DBGU1
 	select HAVE_FB_ATMEL
 	select HAVE_NET_MACB
+	select SOC_AT91SAM9
 	help
 	  Select this if you are using one of Atmel's AT91SAM9G45 family SoC.
 	  This support covers AT91SAM9G45, AT91SAM9G46, AT91SAM9M10 and AT91SAM9M11.
 
 config SOC_AT91SAM9X5
 	bool "AT91SAM9x5 family"
-	select SOC_AT91SAM9
 	select HAVE_AT91_DBGU0
 	select HAVE_FB_ATMEL
 	select HAVE_NET_MACB
+	select SOC_AT91SAM9
 	help
 	  Select this if you are using one of Atmel's AT91SAM9x5 family SoC.
 	  This means that your SAM9 name finishes with a '5' (except if it is
@@ -97,9 +97,9 @@ config SOC_AT91SAM9X5
 
 config SOC_AT91SAM9N12
 	bool "AT91SAM9N12 family"
-	select SOC_AT91SAM9
 	select HAVE_AT91_DBGU0
 	select HAVE_FB_ATMEL
+	select SOC_AT91SAM9
 	help
 	  Select this if you are using Atmel's AT91SAM9N12 SoC.
 
@@ -144,9 +144,9 @@ config ARCH_AT91SAM9G45
 config ARCH_AT91X40
 	bool "AT91x40"
 	depends on !MMU
+	select ARCH_USES_GETTIMEOFFSET
 	select MULTI_IRQ_HANDLER
 	select SPARSE_IRQ
-	select ARCH_USES_GETTIMEOFFSET
 
 endchoice
 
diff --git a/arch/arm/mach-clps711x/Kconfig b/arch/arm/mach-clps711x/Kconfig
index e613536..263242d 100644
--- a/arch/arm/mach-clps711x/Kconfig
+++ b/arch/arm/mach-clps711x/Kconfig
@@ -23,9 +23,9 @@ config ARCH_CLEP7312
 
 config ARCH_EDB7211
 	bool "EDB7211"
-	select ISA
-	select ARCH_SPARSEMEM_ENABLE
 	select ARCH_SELECT_MEMORY_MODEL
+	select ARCH_SPARSEMEM_ENABLE
+	select ISA
 	help
 	  Say Y here if you intend to run this kernel on a Cirrus Logic EDB-7211
 	  evaluation board.
diff --git a/arch/arm/mach-davinci/Kconfig b/arch/arm/mach-davinci/Kconfig
index 026b4b2..f8eecb9 100644
--- a/arch/arm/mach-davinci/Kconfig
+++ b/arch/arm/mach-davinci/Kconfig
@@ -4,12 +4,12 @@ config AINTC
 	bool
 
 config CP_INTC
-	select IRQ_DOMAIN
 	bool
+	select IRQ_DOMAIN
 
 config ARCH_DAVINCI_DMx
-	select CPU_ARM926T
 	bool
+	select CPU_ARM926T
 
 menu "TI DaVinci Implementations"
 
@@ -32,19 +32,19 @@ config ARCH_DAVINCI_DM646x
 
 config ARCH_DAVINCI_DA830
 	bool "DA830/OMAP-L137/AM17x based system"
-	select CP_INTC
 	select ARCH_DAVINCI_DA8XX
 	select CPU_DCACHE_WRITETHROUGH # needed on silicon revs 1.0, 1.1
+	select CP_INTC
 
 config ARCH_DAVINCI_DA850
 	bool "DA850/OMAP-L138/AM18x based system"
-	select CP_INTC
 	select ARCH_DAVINCI_DA8XX
 	select ARCH_HAS_CPUFREQ
+	select CP_INTC
 
 config ARCH_DAVINCI_DA8XX
-	select CPU_ARM926T
 	bool
+	select CPU_ARM926T
 
 config ARCH_DAVINCI_DM365
 	bool "DaVinci 365 based system"
@@ -52,9 +52,9 @@ config ARCH_DAVINCI_DM365
 	select ARCH_DAVINCI_DMx
 
 config ARCH_DAVINCI_TNETV107X
+	bool "TNETV107X based system"
 	select CPU_V6
 	select CP_INTC
-	bool "TNETV107X based system"
 
 comment "DaVinci Board Type"
 
@@ -103,9 +103,9 @@ config MACH_DAVINCI_DM6467_EVM
 	bool "TI DM6467 EVM"
 	default ARCH_DAVINCI_DM646x
 	depends on ARCH_DAVINCI_DM646x
-	select MACH_DAVINCI_DM6467TEVM
 	select EEPROM_AT24
 	select I2C
+	select MACH_DAVINCI_DM6467TEVM
 	help
 	  Configure this option to specify the whether the board used
 	  for development is a DM6467 EVM
@@ -127,8 +127,8 @@ config MACH_DAVINCI_DA830_EVM
 	bool "TI DA830/OMAP-L137/AM17x Reference Platform"
 	default ARCH_DAVINCI_DA830
 	depends on ARCH_DAVINCI_DA830
-	select GPIO_PCF857X
 	select EEPROM_AT24
+	select GPIO_PCF857X
 	select I2C
 	help
 	  Say Y here to select the TI DA830/OMAP-L137/AM17x Evaluation Module.
diff --git a/arch/arm/mach-exynos/Kconfig b/arch/arm/mach-exynos/Kconfig
index 4372075..da55107 100644
--- a/arch/arm/mach-exynos/Kconfig
+++ b/arch/arm/mach-exynos/Kconfig
@@ -31,11 +31,11 @@ config CPU_EXYNOS4210
 	bool "SAMSUNG EXYNOS4210"
 	default y
 	depends on ARCH_EXYNOS4
-	select SAMSUNG_DMADEV
 	select ARM_CPU_SUSPEND if PM
+	select PM_GENERIC_DOMAINS
 	select S5P_PM if PM
 	select S5P_SLEEP if PM
-	select PM_GENERIC_DOMAINS
+	select SAMSUNG_DMADEV
 	help
 	  Enable EXYNOS4210 CPU support
 
@@ -43,9 +43,9 @@ config SOC_EXYNOS4212
 	bool "SAMSUNG EXYNOS4212"
 	default y
 	depends on ARCH_EXYNOS4
-	select SAMSUNG_DMADEV
 	select S5P_PM if PM
 	select S5P_SLEEP if PM
+	select SAMSUNG_DMADEV
 	help
 	  Enable EXYNOS4212 SoC support
 
@@ -61,9 +61,9 @@ config SOC_EXYNOS5250
 	bool "SAMSUNG EXYNOS5250"
 	default y
 	depends on ARCH_EXYNOS5
-	select SAMSUNG_DMADEV
 	select S5P_PM if PM
 	select S5P_SLEEP if PM
+	select SAMSUNG_DMADEV
 	help
 	  Enable EXYNOS5250 SoC support
 
@@ -189,71 +189,71 @@ config MACH_SMDKC210
 config MACH_SMDKV310
 	bool "SMDKV310"
 	select CPU_EXYNOS4210
-	select S5P_DEV_FIMD0
+	select EXYNOS4_DEV_AHCI
+	select EXYNOS4_DEV_USB_OHCI
+	select EXYNOS4_SETUP_FIMD0
+	select EXYNOS4_SETUP_I2C1
+	select EXYNOS4_SETUP_KEYPAD
+	select EXYNOS4_SETUP_SDHCI
+	select EXYNOS4_SETUP_USB_PHY
+	select EXYNOS_DEV_DMA
+	select EXYNOS_DEV_DRM
+	select EXYNOS_DEV_SYSMMU
+	select S3C24XX_PWM
+	select S3C_DEV_HSMMC
+	select S3C_DEV_HSMMC1
+	select S3C_DEV_HSMMC2
+	select S3C_DEV_HSMMC3
+	select S3C_DEV_I2C1
 	select S3C_DEV_RTC
+	select S3C_DEV_USB_HSOTG
 	select S3C_DEV_WDT
-	select S3C_DEV_I2C1
 	select S5P_DEV_FIMC0
 	select S5P_DEV_FIMC1
 	select S5P_DEV_FIMC2
 	select S5P_DEV_FIMC3
+	select S5P_DEV_FIMD0
 	select S5P_DEV_G2D
 	select S5P_DEV_I2C_HDMIPHY
 	select S5P_DEV_JPEG
 	select S5P_DEV_MFC
 	select S5P_DEV_TV
 	select S5P_DEV_USB_EHCI
-	select S3C_DEV_HSMMC
-	select S3C_DEV_HSMMC1
-	select S3C_DEV_HSMMC2
-	select S3C_DEV_HSMMC3
-	select S3C_DEV_USB_HSOTG
 	select SAMSUNG_DEV_BACKLIGHT
-	select EXYNOS_DEV_DRM
-	select EXYNOS_DEV_SYSMMU
-	select EXYNOS4_DEV_AHCI
 	select SAMSUNG_DEV_KEYPAD
-	select EXYNOS_DEV_DMA
 	select SAMSUNG_DEV_PWM
-	select EXYNOS4_DEV_USB_OHCI
-	select EXYNOS4_SETUP_FIMD0
-	select EXYNOS4_SETUP_I2C1
-	select EXYNOS4_SETUP_KEYPAD
-	select EXYNOS4_SETUP_SDHCI
-	select EXYNOS4_SETUP_USB_PHY
-	select S3C24XX_PWM
 	help
 	  Machine support for Samsung SMDKV310
 
 config MACH_ARMLEX4210
 	bool "ARMLEX4210"
 	select CPU_EXYNOS4210
-	select S3C_DEV_RTC
-	select S3C_DEV_WDT
+	select EXYNOS4_DEV_AHCI
+	select EXYNOS4_SETUP_SDHCI
+	select EXYNOS_DEV_DMA
 	select S3C_DEV_HSMMC
 	select S3C_DEV_HSMMC2
 	select S3C_DEV_HSMMC3
-	select EXYNOS4_DEV_AHCI
-	select EXYNOS_DEV_DMA
-	select EXYNOS4_SETUP_SDHCI
+	select S3C_DEV_RTC
+	select S3C_DEV_WDT
 	help
 	  Machine support for Samsung ARMLEX4210 based on EXYNOS4210
 
 config MACH_UNIVERSAL_C210
 	bool "Mobile UNIVERSAL_C210 Board"
-	select CPU_EXYNOS4210
-	select S5P_HRT
 	select CLKSRC_MMIO
+	select CPU_EXYNOS4210
+	select EXYNOS4_SETUP_FIMC
+	select EXYNOS4_SETUP_FIMD0
+	select EXYNOS4_SETUP_I2C1
+	select EXYNOS4_SETUP_I2C3
+	select EXYNOS4_SETUP_I2C5
+	select EXYNOS4_SETUP_SDHCI
+	select EXYNOS4_SETUP_USB_PHY
+	select EXYNOS_DEV_DMA
+	select EXYNOS_DEV_DRM
+	select EXYNOS_DEV_SYSMMU
 	select HAVE_SCHED_CLOCK
-	select S5P_GPIO_INT
-	select S5P_DEV_FIMC0
-	select S5P_DEV_FIMC1
-	select S5P_DEV_FIMC2
-	select S5P_DEV_FIMC3
-	select S5P_DEV_G2D
-	select S5P_DEV_CSIS0
-	select S5P_DEV_JPEG
-	select S5P_DEV_FIMD0
 	select S3C_DEV_HSMMC
 	select S3C_DEV_HSMMC2
 	select S3C_DEV_HSMMC3
@@ -261,21 +261,21 @@ config MACH_UNIVERSAL_C210
 	select S3C_DEV_I2C3
 	select S3C_DEV_I2C5
 	select S3C_DEV_USB_HSOTG
+	select S5P_DEV_CSIS0
+	select S5P_DEV_FIMC0
+	select S5P_DEV_FIMC1
+	select S5P_DEV_FIMC2
+	select S5P_DEV_FIMC3
+	select S5P_DEV_FIMD0
+	select S5P_DEV_G2D
 	select S5P_DEV_I2C_HDMIPHY
+	select S5P_DEV_JPEG
 	select S5P_DEV_MFC
 	select S5P_DEV_ONENAND
 	select S5P_DEV_TV
-	select EXYNOS_DEV_SYSMMU
-	select EXYNOS_DEV_DMA
-	select EXYNOS_DEV_DRM
-	select EXYNOS4_SETUP_FIMD0
-	select EXYNOS4_SETUP_I2C1
-	select EXYNOS4_SETUP_I2C3
-	select EXYNOS4_SETUP_I2C5
-	select EXYNOS4_SETUP_SDHCI
-	select EXYNOS4_SETUP_FIMC
+	select S5P_GPIO_INT
+	select S5P_HRT
 	select S5P_SETUP_MIPIPHY
-	select EXYNOS4_SETUP_USB_PHY
 	help
 	  Machine support for Samsung Mobile Universal S5PC210 Reference
 	  Board.
@@ -283,10 +283,16 @@ config MACH_UNIVERSAL_C210
 config MACH_NURI
 	bool "Mobile NURI Board"
 	select CPU_EXYNOS4210
-	select S5P_GPIO_INT
-	select S3C_DEV_WDT
-	select S3C_DEV_RTC
-	select S5P_DEV_FIMD0
+	select EXYNOS4_SETUP_FIMC
+	select EXYNOS4_SETUP_FIMD0
+	select EXYNOS4_SETUP_I2C1
+	select EXYNOS4_SETUP_I2C3
+	select EXYNOS4_SETUP_I2C5
+	select EXYNOS4_SETUP_I2C6
+	select EXYNOS4_SETUP_SDHCI
+	select EXYNOS4_SETUP_USB_PHY
+	select EXYNOS_DEV_DMA
+	select EXYNOS_DEV_DRM
 	select S3C_DEV_HSMMC
 	select S3C_DEV_HSMMC2
 	select S3C_DEV_HSMMC3
@@ -294,41 +300,42 @@ config MACH_NURI
 	select S3C_DEV_I2C3
 	select S3C_DEV_I2C5
 	select S3C_DEV_I2C6
+	select S3C_DEV_RTC
 	select S3C_DEV_USB_HSOTG
+	select S3C_DEV_WDT
 	select S5P_DEV_CSIS0
-	select S5P_DEV_JPEG
 	select S5P_DEV_FIMC0
 	select S5P_DEV_FIMC1
 	select S5P_DEV_FIMC2
 	select S5P_DEV_FIMC3
+	select S5P_DEV_FIMD0
 	select S5P_DEV_G2D
+	select S5P_DEV_JPEG
 	select S5P_DEV_MFC
 	select S5P_DEV_USB_EHCI
+	select S5P_GPIO_INT
 	select S5P_SETUP_MIPIPHY
-	select EXYNOS_DEV_DMA
-	select EXYNOS_DEV_DRM
-	select EXYNOS4_SETUP_FIMC
-	select EXYNOS4_SETUP_FIMD0
-	select EXYNOS4_SETUP_I2C1
-	select EXYNOS4_SETUP_I2C3
-	select EXYNOS4_SETUP_I2C5
-	select EXYNOS4_SETUP_I2C6
-	select EXYNOS4_SETUP_SDHCI
-	select EXYNOS4_SETUP_USB_PHY
-	select S5P_SETUP_MIPIPHY
-	select SAMSUNG_DEV_PWM
 	select SAMSUNG_DEV_ADC
+	select SAMSUNG_DEV_PWM
 	help
 	  Machine support for Samsung Mobile NURI Board.
 
 config MACH_ORIGEN
 	bool "ORIGEN"
 	select CPU_EXYNOS4210
-	select S3C_DEV_RTC
-	select S3C_DEV_WDT
+	select EXYNOS4_DEV_USB_OHCI
+	select EXYNOS4_SETUP_FIMD0
+	select EXYNOS4_SETUP_SDHCI
+	select EXYNOS4_SETUP_USB_PHY
+	select EXYNOS_DEV_DMA
+	select EXYNOS_DEV_DRM
+	select EXYNOS_DEV_SYSMMU
+	select S3C24XX_PWM
 	select S3C_DEV_HSMMC
 	select S3C_DEV_HSMMC2
+	select S3C_DEV_RTC
 	select S3C_DEV_USB_HSOTG
+	select S3C_DEV_WDT
 	select S5P_DEV_FIMC0
 	select S5P_DEV_FIMC1
 	select S5P_DEV_FIMC2
@@ -342,14 +349,6 @@ config MACH_ORIGEN
 	select S5P_DEV_USB_EHCI
 	select SAMSUNG_DEV_BACKLIGHT
 	select SAMSUNG_DEV_PWM
-	select EXYNOS_DEV_DRM
-	select EXYNOS_DEV_SYSMMU
-	select EXYNOS_DEV_DMA
-	select EXYNOS4_DEV_USB_OHCI
-	select EXYNOS4_SETUP_FIMD0
-	select EXYNOS4_SETUP_SDHCI
-	select EXYNOS4_SETUP_USB_PHY
-	select S3C24XX_PWM
 	help
 	  Machine support for ORIGEN based on Samsung EXYNOS4210
 
@@ -357,7 +356,17 @@ comment "EXYNOS4212 Boards"
 
 config MACH_SMDK4212
 	bool "SMDK4212"
-	select SOC_EXYNOS4212
+	select EXYNOS4_SETUP_FIMD0
+	select EXYNOS4_SETUP_I2C1
+	select EXYNOS4_SETUP_I2C3
+	select EXYNOS4_SETUP_I2C7
+	select EXYNOS4_SETUP_KEYPAD
+	select EXYNOS4_SETUP_SDHCI
+	select EXYNOS4_SETUP_USB_PHY
+	select EXYNOS_DEV_DMA
+	select EXYNOS_DEV_DRM
+	select EXYNOS_DEV_SYSMMU
+	select S3C24XX_PWM
 	select S3C_DEV_HSMMC2
 	select S3C_DEV_HSMMC3
 	select S3C_DEV_I2C1
@@ -375,17 +384,7 @@ config MACH_SMDK4212
 	select SAMSUNG_DEV_BACKLIGHT
 	select SAMSUNG_DEV_KEYPAD
 	select SAMSUNG_DEV_PWM
-	select EXYNOS_DEV_SYSMMU
-	select EXYNOS_DEV_DMA
-	select EXYNOS_DEV_DRM
-	select EXYNOS4_SETUP_FIMD0
-	select EXYNOS4_SETUP_I2C1
-	select EXYNOS4_SETUP_I2C3
-	select EXYNOS4_SETUP_I2C7
-	select EXYNOS4_SETUP_KEYPAD
-	select EXYNOS4_SETUP_SDHCI
-	select EXYNOS4_SETUP_USB_PHY
-	select S3C24XX_PWM
+	select SOC_EXYNOS4212
 	help
 	  Machine support for Samsung SMDK4212
 
@@ -393,8 +392,8 @@ comment "EXYNOS4412 Boards"
 
 config MACH_SMDK4412
 	bool "SMDK4412"
-	select SOC_EXYNOS4412
 	select MACH_SMDK4212
+	select SOC_EXYNOS4412
 	help
 	  Machine support for Samsung SMDK4412
 endif
@@ -404,12 +403,12 @@ comment "Flattened Device Tree based board for EXYNOS SoCs"
 config MACH_EXYNOS4_DT
 	bool "Samsung Exynos4 Machine using device tree"
 	depends on ARCH_EXYNOS4
-	select CPU_EXYNOS4210
-	select USE_OF
 	select ARM_AMBA
+	select CPU_EXYNOS4210
 	select HAVE_SAMSUNG_KEYPAD if INPUT_KEYBOARD
 	select PINCTRL
 	select PINCTRL_EXYNOS4
+	select USE_OF
 	help
 	  Machine support for Samsung Exynos4 machine with device tree enabled.
 	  Select this if a fdt blob is available for the Exynos4 SoC based board.
@@ -419,9 +418,9 @@ config MACH_EXYNOS4_DT
 config MACH_EXYNOS5_DT
 	bool "SAMSUNG EXYNOS5 Machine using device tree"
 	depends on ARCH_EXYNOS5
+	select ARM_AMBA
 	select SOC_EXYNOS5250
 	select USE_OF
-	select ARM_AMBA
 	help
 	  Machine support for Samsung EXYNOS5 machine with device tree enabled.
 	  Select this if a fdt blob is available for the EXYNOS5 SoC based board.
diff --git a/arch/arm/mach-footbridge/Kconfig b/arch/arm/mach-footbridge/Kconfig
index f643ef8..a47c623 100644
--- a/arch/arm/mach-footbridge/Kconfig
+++ b/arch/arm/mach-footbridge/Kconfig
@@ -17,13 +17,13 @@ config ARCH_CATS
 
 config ARCH_PERSONAL_SERVER
 	bool "Compaq Personal Server"
+	---help---
+	  Say Y here if you intend to run this kernel on the Compaq
+	  Personal Server.
 	select FOOTBRIDGE_HOST
 	select ISA
 	select ISA_DMA
 	select PCI
-	---help---
-	  Say Y here if you intend to run this kernel on the Compaq
-	  Personal Server.
 
 	  Saying N will reduce the size of the Footbridge kernel.
 
@@ -91,7 +91,7 @@ config FOOTBRIDGE_ADDIN
 
 # EBSA285 board in either host or addin mode
 config ARCH_EBSA285
-	select ARCH_MAY_HAVE_PC_FDC
 	bool
+	select ARCH_MAY_HAVE_PC_FDC
 
 endif
diff --git a/arch/arm/mach-h720x/Kconfig b/arch/arm/mach-h720x/Kconfig
index abf356c..6bb755b 100644
--- a/arch/arm/mach-h720x/Kconfig
+++ b/arch/arm/mach-h720x/Kconfig
@@ -12,9 +12,9 @@ config ARCH_H7201
 
 config ARCH_H7202
 	bool "hms30c7202"
+	depends on ARCH_H720X
 	select CPU_H7202
 	select ZONE_DMA
-	depends on ARCH_H720X
 	help
 	  Say Y here if you are using the Hynix HMS30C7202 Reference Board
 
diff --git a/arch/arm/mach-imx/Kconfig b/arch/arm/mach-imx/Kconfig
index 32197c1..8d27658 100644
--- a/arch/arm/mach-imx/Kconfig
+++ b/arch/arm/mach-imx/Kconfig
@@ -41,68 +41,68 @@ config SOC_IMX1
 
 config SOC_IMX21
 	bool
-	select MACH_MX21
-	select CPU_ARM926T
 	select COMMON_CLK
+	select CPU_ARM926T
 	select IMX_HAVE_IOMUX_V1
+	select MACH_MX21
 	select MXC_AVIC
 
 config SOC_IMX25
 	bool
 	select ARCH_MX25
+	select ARCH_MXC_IOMUX_V3
 	select COMMON_CLK
 	select CPU_ARM926T
 	select HAVE_CAN_FLEXCAN if CAN
-	select ARCH_MXC_IOMUX_V3
 	select MXC_AVIC
 
 config SOC_IMX27
 	bool
-	select MACH_MX27
-	select CPU_ARM926T
 	select COMMON_CLK
+	select CPU_ARM926T
 	select IMX_HAVE_IOMUX_V1
+	select MACH_MX27
 	select MXC_AVIC
 
 config SOC_IMX31
 	bool
+	select COMMON_CLK
 	select CPU_V6
 	select IMX_HAVE_PLATFORM_MXC_RNGA
 	select MXC_AVIC
-	select COMMON_CLK
 	select SMP_ON_UP if SMP
 
 config SOC_IMX35
 	bool
-	select CPU_V6K
 	select ARCH_MXC_IOMUX_V3
 	select COMMON_CLK
+	select CPU_V6K
+	select HAVE_CAN_FLEXCAN if CAN
 	select HAVE_EPIT
 	select MXC_AVIC
 	select SMP_ON_UP if SMP
-	select HAVE_CAN_FLEXCAN if CAN
 
 config SOC_IMX5
-	select CPU_V7
-	select MXC_TZIC
-	select COMMON_CLK
-	select ARCH_MXC_IOMUX_V3
+	bool
 	select ARCH_HAS_CPUFREQ
 	select ARCH_MX5
-	bool
+	select ARCH_MXC_IOMUX_V3
+	select COMMON_CLK
+	select CPU_V7
+	select MXC_TZIC
 
 config SOC_IMX50
 	bool
-	select SOC_IMX5
 	select ARCH_MX50
+	select SOC_IMX5
 
 config	SOC_IMX51
 	bool
-	select SOC_IMX5
 	select ARCH_MX5
 	select ARCH_MX51
 	select PINCTRL
 	select PINCTRL_IMX51
+	select SOC_IMX5
 
 if ARCH_IMX_V4_V5
 
@@ -112,10 +112,10 @@ config MACH_MXLADS
 
 config ARCH_MX1ADS
 	bool "MX1ADS platform"
-	select MACH_MXLADS
-	select SOC_IMX1
 	select IMX_HAVE_PLATFORM_IMX_I2C
 	select IMX_HAVE_PLATFORM_IMX_UART
+	select MACH_MXLADS
+	select SOC_IMX1
 	help
 	  Say Y here if you are using Motorola MX1ADS/MXLADS boards
 
@@ -127,9 +127,9 @@ config MACH_SCB9328
 
 config MACH_APF9328
 	bool "APF9328"
-	select SOC_IMX1
 	select IMX_HAVE_PLATFORM_IMX_I2C
 	select IMX_HAVE_PLATFORM_IMX_UART
+	select SOC_IMX1
 	help
 	  Say Yes here if you are using the Armadeus APF9328 development board
 
@@ -137,11 +137,11 @@ comment "MX21 platforms:"
 
 config MACH_MX21ADS
 	bool "MX21ADS platform"
-	select SOC_IMX21
 	select IMX_HAVE_PLATFORM_IMX_FB
 	select IMX_HAVE_PLATFORM_IMX_UART
 	select IMX_HAVE_PLATFORM_MXC_MMC
 	select IMX_HAVE_PLATFORM_MXC_NAND
+	select SOC_IMX21
 	help
 	  Include support for MX21ADS platform. This includes specific
 	  configurations for the board and its peripherals.
@@ -150,22 +150,21 @@ comment "MX25 platforms:"
 
 config MACH_MX25_3DS
 	bool "Support MX25PDK (3DS) Platform"
-	select SOC_IMX25
 	select IMX_HAVE_PLATFORM_FLEXCAN
 	select IMX_HAVE_PLATFORM_FSL_USB2_UDC
 	select IMX_HAVE_PLATFORM_IMX2_WDT
 	select IMX_HAVE_PLATFORM_IMXDI_RTC
-	select IMX_HAVE_PLATFORM_IMX_I2C
 	select IMX_HAVE_PLATFORM_IMX_FB
+	select IMX_HAVE_PLATFORM_IMX_I2C
 	select IMX_HAVE_PLATFORM_IMX_KEYPAD
 	select IMX_HAVE_PLATFORM_IMX_UART
 	select IMX_HAVE_PLATFORM_MXC_EHCI
 	select IMX_HAVE_PLATFORM_MXC_NAND
 	select IMX_HAVE_PLATFORM_SDHCI_ESDHC_IMX
+	select SOC_IMX25
 
 config MACH_EUKREA_CPUIMX25SD
 	bool "Support Eukrea CPUIMX25 Platform"
-	select SOC_IMX25
 	select IMX_HAVE_PLATFORM_FLEXCAN
 	select IMX_HAVE_PLATFORM_FSL_USB2_UDC
 	select IMX_HAVE_PLATFORM_IMX2_WDT
@@ -177,6 +176,7 @@ config MACH_EUKREA_CPUIMX25SD
 	select IMX_HAVE_PLATFORM_MXC_NAND
 	select IMX_HAVE_PLATFORM_SDHCI_ESDHC_IMX
 	select MXC_ULPI if USB_ULPI
+	select SOC_IMX25
 
 choice
 	prompt "Baseboard"
@@ -199,20 +199,19 @@ comment "MX27 platforms:"
 
 config MACH_MX27ADS
 	bool "MX27ADS platform"
-	select SOC_IMX27
 	select IMX_HAVE_PLATFORM_IMX_FB
 	select IMX_HAVE_PLATFORM_IMX_I2C
 	select IMX_HAVE_PLATFORM_IMX_UART
 	select IMX_HAVE_PLATFORM_MXC_MMC
 	select IMX_HAVE_PLATFORM_MXC_NAND
 	select IMX_HAVE_PLATFORM_MXC_W1
+	select SOC_IMX27
 	help
 	  Include support for MX27ADS platform. This includes specific
 	  configurations for the board and its peripherals.
 
 config MACH_PCM038
 	bool "Phytec phyCORE-i.MX27 CPU module (pcm038)"
-	select SOC_IMX27
 	select IMX_HAVE_PLATFORM_IMX2_WDT
 	select IMX_HAVE_PLATFORM_IMX_I2C
 	select IMX_HAVE_PLATFORM_IMX_UART
@@ -221,6 +220,7 @@ config MACH_PCM038
 	select IMX_HAVE_PLATFORM_MXC_W1
 	select IMX_HAVE_PLATFORM_SPI_IMX
 	select MXC_ULPI if USB_ULPI
+	select SOC_IMX27
 	help
 	  Include support for phyCORE-i.MX27 (aka pcm038) platform. This
 	  includes specific configurations for the module and its peripherals.
@@ -242,7 +242,6 @@ endchoice
 
 config MACH_CPUIMX27
 	bool "Eukrea CPUIMX27 module"
-	select SOC_IMX27
 	select IMX_HAVE_PLATFORM_FSL_USB2_UDC
 	select IMX_HAVE_PLATFORM_IMX2_WDT
 	select IMX_HAVE_PLATFORM_IMX_I2C
@@ -251,6 +250,7 @@ config MACH_CPUIMX27
 	select IMX_HAVE_PLATFORM_MXC_NAND
 	select IMX_HAVE_PLATFORM_MXC_W1
 	select MXC_ULPI if USB_ULPI
+	select SOC_IMX27
 	help
 	  Include support for Eukrea CPUIMX27 platform. This includes
 	  specific configurations for the module and its peripherals.
@@ -292,7 +292,6 @@ endchoice
 
 config MACH_MX27_3DS
 	bool "MX27PDK platform"
-	select SOC_IMX27
 	select IMX_HAVE_PLATFORM_FSL_USB2_UDC
 	select IMX_HAVE_PLATFORM_IMX2_WDT
 	select IMX_HAVE_PLATFORM_IMX_FB
@@ -306,13 +305,13 @@ config MACH_MX27_3DS
 	select IMX_HAVE_PLATFORM_SPI_IMX
 	select MXC_DEBUG_BOARD
 	select MXC_ULPI if USB_ULPI
+	select SOC_IMX27
 	help
 	  Include support for MX27PDK platform. This includes specific
 	  configurations for the board and its peripherals.
 
 config MACH_IMX27_VISSTRIM_M10
 	bool "Vista Silicon i.MX27 Visstrim_m10"
-	select SOC_IMX27
 	select IMX_HAVE_PLATFORM_GPIO_KEYS
 	select IMX_HAVE_PLATFORM_IMX_I2C
 	select IMX_HAVE_PLATFORM_IMX_SSI
@@ -321,6 +320,7 @@ config MACH_IMX27_VISSTRIM_M10
 	select IMX_HAVE_PLATFORM_MXC_EHCI
 	select IMX_HAVE_PLATFORM_MXC_MMC
 	select LEDS_GPIO_REGISTER
+	select SOC_IMX27
 	help
 	  Include support for Visstrim_m10 platform and its different variants.
 	  This includes specific configurations for the board and its
@@ -328,16 +328,15 @@ config MACH_IMX27_VISSTRIM_M10
 
 config MACH_IMX27LITE
 	bool "LogicPD MX27 LITEKIT platform"
-	select SOC_IMX27
-	select IMX_HAVE_PLATFORM_IMX_UART
 	select IMX_HAVE_PLATFORM_IMX_SSI
+	select IMX_HAVE_PLATFORM_IMX_UART
+	select SOC_IMX27
 	help
 	  Include support for MX27 LITEKIT platform. This includes specific
 	  configurations for the board and its peripherals.
 
 config MACH_PCA100
 	bool "Phytec phyCARD-s (pca100)"
-	select SOC_IMX27
 	select IMX_HAVE_PLATFORM_FSL_USB2_UDC
 	select IMX_HAVE_PLATFORM_IMX2_WDT
 	select IMX_HAVE_PLATFORM_IMX_FB
@@ -350,27 +349,28 @@ config MACH_PCA100
 	select IMX_HAVE_PLATFORM_MXC_W1
 	select IMX_HAVE_PLATFORM_SPI_IMX
 	select MXC_ULPI if USB_ULPI
+	select SOC_IMX27
 	help
 	  Include support for phyCARD-s (aka pca100) platform. This
 	  includes specific configurations for the module and its peripherals.
 
 config MACH_MXT_TD60
 	bool "Maxtrack i-MXT TD60"
-	select SOC_IMX27
 	select IMX_HAVE_PLATFORM_IMX_FB
 	select IMX_HAVE_PLATFORM_IMX_I2C
 	select IMX_HAVE_PLATFORM_IMX_UART
 	select IMX_HAVE_PLATFORM_MXC_MMC
 	select IMX_HAVE_PLATFORM_MXC_NAND
+	select SOC_IMX27
 	help
 	  Include support for i-MXT (aka td60) platform. This
 	  includes specific configurations for the module and its peripherals.
 
 config MACH_IMX27IPCAM
 	bool "IMX27 IPCAM platform"
-	select SOC_IMX27
 	select IMX_HAVE_PLATFORM_IMX2_WDT
 	select IMX_HAVE_PLATFORM_IMX_UART
+	select SOC_IMX27
 	help
 	  Include support for IMX27 IPCAM platform. This includes specific
 	  configurations for the board and its peripherals.
@@ -390,11 +390,11 @@ comment "MX31 platforms:"
 
 config MACH_MX31ADS
 	bool "Support MX31ADS platforms"
-	select SOC_IMX31
+	default y
 	select IMX_HAVE_PLATFORM_IMX_I2C
 	select IMX_HAVE_PLATFORM_IMX_SSI
 	select IMX_HAVE_PLATFORM_IMX_UART
-	default y
+	select SOC_IMX31
 	help
 	  Include support for MX31ADS platform. This includes specific
 	  configurations for the board and its peripherals.
@@ -412,21 +412,19 @@ config MACH_MX31ADS_WM1133_EV1
 
 config MACH_MX31LILLY
 	bool "Support MX31 LILLY-1131 platforms (INCO startec)"
-	select SOC_IMX31
 	select IMX_HAVE_PLATFORM_IMX_UART
 	select IMX_HAVE_PLATFORM_IPU_CORE
 	select IMX_HAVE_PLATFORM_MXC_EHCI
 	select IMX_HAVE_PLATFORM_MXC_MMC
 	select IMX_HAVE_PLATFORM_SPI_IMX
 	select MXC_ULPI if USB_ULPI
+	select SOC_IMX31
 	help
 	  Include support for mx31 based LILLY1131 modules. This includes
 	  specific configurations for the board and its peripherals.
 
 config MACH_MX31LITE
 	bool "Support MX31 LITEKIT (LogicPD)"
-	select SOC_IMX31
-	select MXC_ULPI if USB_ULPI
 	select IMX_HAVE_PLATFORM_IMX2_WDT
 	select IMX_HAVE_PLATFORM_IMX_UART
 	select IMX_HAVE_PLATFORM_MXC_EHCI
@@ -435,13 +433,14 @@ config MACH_MX31LITE
 	select IMX_HAVE_PLATFORM_MXC_RTC
 	select IMX_HAVE_PLATFORM_SPI_IMX
 	select LEDS_GPIO_REGISTER
+	select MXC_ULPI if USB_ULPI
+	select SOC_IMX31
 	help
 	  Include support for MX31 LITEKIT platform. This includes specific
 	  configurations for the board and its peripherals.
 
 config MACH_PCM037
 	bool "Support Phytec pcm037 (i.MX31) platforms"
-	select SOC_IMX31
 	select IMX_HAVE_PLATFORM_FSL_USB2_UDC
 	select IMX_HAVE_PLATFORM_IMX2_WDT
 	select IMX_HAVE_PLATFORM_IMX_I2C
@@ -452,6 +451,7 @@ config MACH_PCM037
 	select IMX_HAVE_PLATFORM_MXC_NAND
 	select IMX_HAVE_PLATFORM_MXC_W1
 	select MXC_ULPI if USB_ULPI
+	select SOC_IMX31
 	help
 	  Include support for Phytec pcm037 platform. This includes
 	  specific configurations for the board and its peripherals.
@@ -468,8 +468,6 @@ config MACH_PCM037_EET
 
 config MACH_MX31_3DS
 	bool "Support MX31PDK (3DS)"
-	select SOC_IMX31
-	select MXC_DEBUG_BOARD
 	select IMX_HAVE_PLATFORM_FSL_USB2_UDC
 	select IMX_HAVE_PLATFORM_IMX2_WDT
 	select IMX_HAVE_PLATFORM_IMX_I2C
@@ -481,7 +479,9 @@ config MACH_MX31_3DS
 	select IMX_HAVE_PLATFORM_MXC_MMC
 	select IMX_HAVE_PLATFORM_MXC_NAND
 	select IMX_HAVE_PLATFORM_SPI_IMX
+	select MXC_DEBUG_BOARD
 	select MXC_ULPI if USB_ULPI
+	select SOC_IMX31
 	help
 	  Include support for MX31PDK (3DS) platform. This includes specific
 	  configurations for the board and its peripherals.
@@ -497,7 +497,6 @@ config MACH_MX31_3DS_MXC_NAND_USE_BBT
 
 config MACH_MX31MOBOARD
 	bool "Support mx31moboard platforms (EPFL Mobots group)"
-	select SOC_IMX31
 	select IMX_HAVE_PLATFORM_FSL_USB2_UDC
 	select IMX_HAVE_PLATFORM_IMX2_WDT
 	select IMX_HAVE_PLATFORM_IMX_I2C
@@ -509,22 +508,22 @@ config MACH_MX31MOBOARD
 	select IMX_HAVE_PLATFORM_SPI_IMX
 	select LEDS_GPIO_REGISTER
 	select MXC_ULPI if USB_ULPI
+	select SOC_IMX31
 	help
 	  Include support for mx31moboard platform. This includes specific
 	  configurations for the board and its peripherals.
 
 config MACH_QONG
 	bool "Support Dave/DENX QongEVB-LITE platform"
-	select SOC_IMX31
-	select IMX_HAVE_PLATFORM_IMX_UART
 	select IMX_HAVE_PLATFORM_IMX2_WDT
+	select IMX_HAVE_PLATFORM_IMX_UART
+	select SOC_IMX31
 	help
 	  Include support for Dave/DENX QongEVB-LITE platform. This includes
 	  specific configurations for the board and its peripherals.
 
 config MACH_ARMADILLO5X0
 	bool "Support Atmark Armadillo-500 Development Base Board"
-	select SOC_IMX31
 	select IMX_HAVE_PLATFORM_GPIO_KEYS
 	select IMX_HAVE_PLATFORM_IMX_I2C
 	select IMX_HAVE_PLATFORM_IMX_UART
@@ -533,23 +532,24 @@ config MACH_ARMADILLO5X0
 	select IMX_HAVE_PLATFORM_MXC_MMC
 	select IMX_HAVE_PLATFORM_MXC_NAND
 	select MXC_ULPI if USB_ULPI
+	select SOC_IMX31
 	help
 	  Include support for Atmark Armadillo-500 platform. This includes
 	  specific configurations for the board and its peripherals.
 
 config MACH_KZM_ARM11_01
 	bool "Support KZM-ARM11-01(Kyoto Microcomputer)"
-	select SOC_IMX31
 	select IMX_HAVE_PLATFORM_IMX_UART
+	select SOC_IMX31
 	help
 	  Include support for KZM-ARM11-01. This includes specific
 	  configurations for the board and its peripherals.
 
 config MACH_BUG
 	bool "Support Buglabs BUGBase platform"
-	select SOC_IMX31
-	select IMX_HAVE_PLATFORM_IMX_UART
 	default y
+	select IMX_HAVE_PLATFORM_IMX_UART
+	select SOC_IMX31
 	help
 	  Include support for BUGBase 1.3 platform. This includes specific
 	  configurations for the board and its peripherals.
@@ -565,7 +565,6 @@ comment "MX35 platforms:"
 
 config MACH_PCM043
 	bool "Support Phytec pcm043 (i.MX35) platforms"
-	select SOC_IMX35
 	select IMX_HAVE_PLATFORM_FLEXCAN
 	select IMX_HAVE_PLATFORM_FSL_USB2_UDC
 	select IMX_HAVE_PLATFORM_IMX2_WDT
@@ -577,14 +576,13 @@ config MACH_PCM043
 	select IMX_HAVE_PLATFORM_MXC_NAND
 	select IMX_HAVE_PLATFORM_SDHCI_ESDHC_IMX
 	select MXC_ULPI if USB_ULPI
+	select SOC_IMX35
 	help
 	  Include support for Phytec pcm043 platform. This includes
 	  specific configurations for the board and its peripherals.
 
 config MACH_MX35_3DS
 	bool "Support MX35PDK platform"
-	select SOC_IMX35
-	select MXC_DEBUG_BOARD
 	select IMX_HAVE_PLATFORM_FSL_USB2_UDC
 	select IMX_HAVE_PLATFORM_IMX2_WDT
 	select IMX_HAVE_PLATFORM_IMX_FB
@@ -595,13 +593,14 @@ config MACH_MX35_3DS
 	select IMX_HAVE_PLATFORM_MXC_NAND
 	select IMX_HAVE_PLATFORM_MXC_RTC
 	select IMX_HAVE_PLATFORM_SDHCI_ESDHC_IMX
+	select MXC_DEBUG_BOARD
+	select SOC_IMX35
 	help
 	  Include support for MX35PDK platform. This includes specific
 	  configurations for the board and its peripherals.
 
 config MACH_EUKREA_CPUIMX35SD
 	bool "Support Eukrea CPUIMX35 Platform"
-	select SOC_IMX35
 	select IMX_HAVE_PLATFORM_FLEXCAN
 	select IMX_HAVE_PLATFORM_FSL_USB2_UDC
 	select IMX_HAVE_PLATFORM_IMX2_WDT
@@ -611,6 +610,7 @@ config MACH_EUKREA_CPUIMX35SD
 	select IMX_HAVE_PLATFORM_MXC_NAND
 	select IMX_HAVE_PLATFORM_SDHCI_ESDHC_IMX
 	select MXC_ULPI if USB_ULPI
+	select SOC_IMX35
 	help
 	  Include support for Eukrea CPUIMX35 platform. This includes
 	  specific configurations for the board and its peripherals.
@@ -635,16 +635,16 @@ endchoice
 
 config MACH_VPR200
 	bool "Support VPR200 platform"
-	select SOC_IMX35
 	select IMX_HAVE_PLATFORM_FSL_USB2_UDC
 	select IMX_HAVE_PLATFORM_GPIO_KEYS
 	select IMX_HAVE_PLATFORM_IMX2_WDT
-	select IMX_HAVE_PLATFORM_IMX_UART
 	select IMX_HAVE_PLATFORM_IMX_I2C
+	select IMX_HAVE_PLATFORM_IMX_UART
 	select IMX_HAVE_PLATFORM_IPU_CORE
 	select IMX_HAVE_PLATFORM_MXC_EHCI
 	select IMX_HAVE_PLATFORM_MXC_NAND
 	select IMX_HAVE_PLATFORM_SDHCI_ESDHC_IMX
+	select SOC_IMX35
 	help
 	  Include support for VPR200 platform. This includes specific
 	  configurations for the board and its peripherals.
@@ -654,11 +654,11 @@ comment "i.MX5 platforms:"
 config MACH_MX50_RDP
 	bool "Support MX50 reference design platform"
 	depends on BROKEN
-	select SOC_IMX50
 	select IMX_HAVE_PLATFORM_IMX_I2C
 	select IMX_HAVE_PLATFORM_IMX_UART
 	select IMX_HAVE_PLATFORM_SDHCI_ESDHC_IMX
 	select IMX_HAVE_PLATFORM_SPI_IMX
+	select SOC_IMX50
 	help
 	  Include support for MX50 reference design platform (RDP) board. This
 	  includes specific configurations for the board and its peripherals.
@@ -667,15 +667,14 @@ comment "i.MX51 machines:"
 
 config MACH_IMX51_DT
 	bool "Support i.MX51 platforms from device tree"
-	select SOC_IMX51
 	select MACH_MX51_BABBAGE
+	select SOC_IMX51
 	help
 	  Include support for Freescale i.MX51 based platforms
 	  using the device tree for discovery
 
 config MACH_MX51_BABBAGE
 	bool "Support MX51 BABBAGE platforms"
-	select SOC_IMX51
 	select IMX_HAVE_PLATFORM_FSL_USB2_UDC
 	select IMX_HAVE_PLATFORM_IMX2_WDT
 	select IMX_HAVE_PLATFORM_IMX_I2C
@@ -683,6 +682,7 @@ config MACH_MX51_BABBAGE
 	select IMX_HAVE_PLATFORM_MXC_EHCI
 	select IMX_HAVE_PLATFORM_SDHCI_ESDHC_IMX
 	select IMX_HAVE_PLATFORM_SPI_IMX
+	select SOC_IMX51
 	help
 	  Include support for MX51 Babbage platform, also known as MX51EVK in
 	  u-boot. This includes specific configurations for the board and its
@@ -690,27 +690,27 @@ config MACH_MX51_BABBAGE
 
 config MACH_MX51_3DS
 	bool "Support MX51PDK (3DS)"
-	select SOC_IMX51
 	select IMX_HAVE_PLATFORM_IMX2_WDT
 	select IMX_HAVE_PLATFORM_IMX_KEYPAD
 	select IMX_HAVE_PLATFORM_IMX_UART
 	select IMX_HAVE_PLATFORM_SDHCI_ESDHC_IMX
 	select IMX_HAVE_PLATFORM_SPI_IMX
 	select MXC_DEBUG_BOARD
+	select SOC_IMX51
 	help
 	  Include support for MX51PDK (3DS) platform. This includes specific
 	  configurations for the board and its peripherals.
 
 config MACH_EUKREA_CPUIMX51SD
 	bool "Support Eukrea CPUIMX51SD module"
-	select SOC_IMX51
 	select IMX_HAVE_PLATFORM_FSL_USB2_UDC
+	select IMX_HAVE_PLATFORM_IMX2_WDT
 	select IMX_HAVE_PLATFORM_IMX_I2C
 	select IMX_HAVE_PLATFORM_IMX_UART
-	select IMX_HAVE_PLATFORM_IMX2_WDT
 	select IMX_HAVE_PLATFORM_MXC_EHCI
 	select IMX_HAVE_PLATFORM_MXC_NAND
 	select IMX_HAVE_PLATFORM_SPI_IMX
+	select SOC_IMX51
 	help
 	  Include support for Eukrea CPUIMX51SD platform. This includes
 	  specific configurations for the module and its peripherals.
@@ -736,12 +736,12 @@ comment "Device tree only"
 
 config	SOC_IMX53
 	bool "i.MX53 support"
-	select SOC_IMX5
 	select ARCH_MX5
 	select ARCH_MX53
 	select HAVE_CAN_FLEXCAN if CAN
 	select PINCTRL
 	select PINCTRL_IMX53
+	select SOC_IMX5
 
 	help
 	  This enables support for Freescale i.MX53 processor.
diff --git a/arch/arm/mach-ixp4xx/Kconfig b/arch/arm/mach-ixp4xx/Kconfig
index fd5e7b6..73a2d90 100644
--- a/arch/arm/mach-ixp4xx/Kconfig
+++ b/arch/arm/mach-ixp4xx/Kconfig
@@ -234,8 +234,8 @@ config IXP4XX_QMGR
 
 config IXP4XX_NPE
 	tristate "IXP4xx Network Processor Engine support"
-	select HOTPLUG
 	select FW_LOADER
+	select HOTPLUG
 	help
 	  This driver supports IXP4xx built-in network coprocessors
 	  and is automatically selected by Ethernet and HSS drivers.
diff --git a/arch/arm/mach-mmp/Kconfig b/arch/arm/mach-mmp/Kconfig
index d697d07..178d4da 100644
--- a/arch/arm/mach-mmp/Kconfig
+++ b/arch/arm/mach-mmp/Kconfig
@@ -107,22 +107,22 @@ endmenu
 
 config CPU_PXA168
 	bool
-	select CPU_MOHAWK
 	select COMMON_CLK
+	select CPU_MOHAWK
 	help
 	  Select code specific to PXA168
 
 config CPU_PXA910
 	bool
-	select CPU_MOHAWK
 	select COMMON_CLK
+	select CPU_MOHAWK
 	help
 	  Select code specific to PXA910
 
 config CPU_MMP2
 	bool
-	select CPU_PJ4
 	select COMMON_CLK
+	select CPU_PJ4
 	help
 	  Select code specific to MMP2. MMP2 is ARMv7 compatible.
 
diff --git a/arch/arm/mach-msm/Kconfig b/arch/arm/mach-msm/Kconfig
index 7902de15..b619085 100644
--- a/arch/arm/mach-msm/Kconfig
+++ b/arch/arm/mach-msm/Kconfig
@@ -10,35 +10,35 @@ choice
 
 config ARCH_MSM7X00A
 	bool "MSM7x00A / MSM7x01A"
-	select MACH_TROUT if !MACH_HALIBUT
 	select ARCH_MSM_ARM11
-	select MSM_SMD
-	select MSM_SMD_PKG3
 	select CPU_V6
 	select GPIO_MSM_V1
+	select MACH_TROUT if !MACH_HALIBUT
 	select MSM_PROC_COMM
+	select MSM_SMD
+	select MSM_SMD_PKG3
 
 config ARCH_MSM7X30
 	bool "MSM7x30"
-	select MACH_MSM7X30_SURF # if !
 	select ARCH_MSM_SCORPION
-	select MSM_SMD
-	select MSM_VIC
 	select CPU_V7
-	select MSM_GPIOMUX
 	select GPIO_MSM_V1
+	select MACH_MSM7X30_SURF # if !
+	select MSM_GPIOMUX
 	select MSM_PROC_COMM
+	select MSM_SMD
+	select MSM_VIC
 
 config ARCH_QSD8X50
 	bool "QSD8X50"
-	select MACH_QSD8X50_SURF if !MACH_QSD8X50A_ST1_5
 	select ARCH_MSM_SCORPION
-	select MSM_SMD
-	select MSM_VIC
 	select CPU_V7
-	select MSM_GPIOMUX
 	select GPIO_MSM_V1
+	select MACH_QSD8X50_SURF if !MACH_QSD8X50A_ST1_5
+	select MSM_GPIOMUX
 	select MSM_PROC_COMM
+	select MSM_SMD
+	select MSM_VIC
 
 endchoice
 
@@ -47,10 +47,10 @@ config ARCH_MSM8X60
 	select ARCH_MSM_SCORPIONMP
 	select ARM_GIC
 	select CPU_V7
-	select MSM_V2_TLMM
 	select GPIO_MSM_V2
 	select MSM_GPIOMUX
 	select MSM_SCM if SMP
+	select MSM_V2_TLMM
 	select USE_OF
 
 config ARCH_MSM8960
@@ -58,9 +58,9 @@ config ARCH_MSM8960
 	select ARCH_MSM_SCORPIONMP
 	select ARM_GIC
 	select CPU_V7
-	select MSM_V2_TLMM
 	select MSM_GPIOMUX
 	select MSM_SCM if SMP
+	select MSM_V2_TLMM
 	select USE_OF
 
 config MSM_HAS_DEBUG_UART_HS
@@ -110,8 +110,8 @@ config MACH_QSD8X50_SURF
 
 config MACH_QSD8X50A_ST1_5
 	depends on ARCH_QSD8X50
-	select MSM_SOC_REV_A
 	bool "QSD8x50A ST1.5"
+	select MSM_SOC_REV_A
 	help
 	  Support for the Qualcomm ST1.5.
 
diff --git a/arch/arm/mach-nomadik/Kconfig b/arch/arm/mach-nomadik/Kconfig
index 365879b..c744946 100644
--- a/arch/arm/mach-nomadik/Kconfig
+++ b/arch/arm/mach-nomadik/Kconfig
@@ -4,8 +4,8 @@ menu "Nomadik boards"
 
 config MACH_NOMADIK_8815NHK
 	bool "ST 8815 Nomadik Hardware Kit (evaluation board)"
-	select NOMADIK_8815
 	select HAS_MTU
+	select NOMADIK_8815
 
 endmenu
 
@@ -16,7 +16,7 @@ config I2C_BITBANG_8815NHK
 	tristate "Driver for bit-bang busses found on the 8815 NHK"
 	depends on I2C && MACH_NOMADIK_8815NHK
 	depends on PINCTRL_NOMADIK
-	select I2C_ALGOBIT
 	default y
+	select I2C_ALGOBIT
 
 endif
diff --git a/arch/arm/mach-omap1/Kconfig b/arch/arm/mach-omap1/Kconfig
index cba3f71..903da8e 100644
--- a/arch/arm/mach-omap1/Kconfig
+++ b/arch/arm/mach-omap1/Kconfig
@@ -8,15 +8,15 @@ comment "OMAP Core Type"
 config ARCH_OMAP730
 	depends on ARCH_OMAP1
 	bool "OMAP730 Based System"
+	select ARCH_OMAP_OTG
 	select CPU_ARM926T
 	select OMAP_MPU_TIMER
-	select ARCH_OMAP_OTG
 
 config ARCH_OMAP850
 	depends on ARCH_OMAP1
 	bool "OMAP850 Based System"
-	select CPU_ARM926T
 	select ARCH_OMAP_OTG
+	select CPU_ARM926T
 
 config ARCH_OMAP15XX
 	depends on ARCH_OMAP1
@@ -28,8 +28,8 @@ config ARCH_OMAP15XX
 config ARCH_OMAP16XX
 	depends on ARCH_OMAP1
 	bool "OMAP16xx Based System"
-	select CPU_ARM926T
 	select ARCH_OMAP_OTG
+	select CPU_ARM926T
 
 comment "OMAP Board Type"
 	depends on ARCH_OMAP1
@@ -132,8 +132,8 @@ config MACH_OMAP_PALMTT
 
 config MACH_SX1
 	bool "Siemens SX1"
-	select I2C
 	depends on ARCH_OMAP1 && ARCH_OMAP15XX
+	select I2C
 	help
 	  Support for the Siemens SX1 phone. To boot the kernel,
 	  you'll need a SX1 compatible bootloader; check out
diff --git a/arch/arm/mach-omap2/Kconfig b/arch/arm/mach-omap2/Kconfig
index a6219ea..2a1a898 100644
--- a/arch/arm/mach-omap2/Kconfig
+++ b/arch/arm/mach-omap2/Kconfig
@@ -6,19 +6,19 @@ config ARCH_OMAP2PLUS_TYPICAL
 	bool "Typical OMAP configuration"
 	default y
 	select AEABI
-	select REGULATOR
-	select PM_RUNTIME
-	select VFP
-	select NEON if ARCH_OMAP3 || ARCH_OMAP4 || SOC_OMAP5
-	select SERIAL_OMAP
-	select SERIAL_OMAP_CONSOLE
+	select HIGHMEM
 	select I2C
 	select I2C_OMAP
 	select MENELAUS if ARCH_OMAP2
+	select NEON if ARCH_OMAP3 || ARCH_OMAP4 || SOC_OMAP5
+	select PINCTRL
+	select PM_RUNTIME
+	select REGULATOR
+	select SERIAL_OMAP
+	select SERIAL_OMAP_CONSOLE
 	select TWL4030_CORE if ARCH_OMAP3 || ARCH_OMAP4
 	select TWL4030_POWER if ARCH_OMAP3 || ARCH_OMAP4
-	select HIGHMEM
-	select PINCTRL
+	select VFP
 	help
 	  Compile a kernel suitable for booting most boards
 
@@ -40,44 +40,44 @@ config ARCH_OMAP3
 	bool "TI OMAP3"
 	depends on ARCH_OMAP2PLUS
 	default y
-	select CPU_V7
-	select USB_ARCH_HAS_EHCI if USB_SUPPORT
 	select ARCH_HAS_OPP
-	select PM_RUNTIME if CPU_IDLE
-	select PM_OPP if PM
 	select ARM_CPU_SUSPEND if PM
+	select CPU_V7
 	select MULTI_IRQ_HANDLER
-	select SOC_HAS_OMAP2_SDRC
 	select OMAP_INTERCONNECT
+	select PM_OPP if PM
+	select PM_RUNTIME if CPU_IDLE
+	select SOC_HAS_OMAP2_SDRC
+	select USB_ARCH_HAS_EHCI if USB_SUPPORT
 
 config ARCH_OMAP4
 	bool "TI OMAP4"
 	default y
 	depends on ARCH_OMAP2PLUS
+	select ARCH_HAS_OPP
+	select ARCH_NEEDS_CPU_IDLE_COUPLED if SMP
+	select ARM_CPU_SUSPEND if PM
+	select ARM_ERRATA_720789
+	select ARM_GIC
 	select CACHE_L2X0
 	select CPU_V7
-	select ARM_GIC
 	select HAVE_SMP
 	select LOCAL_TIMERS if SMP
+	select OMAP_INTERCONNECT
 	select PL310_ERRATA_588369
 	select PL310_ERRATA_727915
-	select ARM_ERRATA_720789
-	select ARCH_HAS_OPP
-	select PM_RUNTIME if CPU_IDLE
 	select PM_OPP if PM
+	select PM_RUNTIME if CPU_IDLE
 	select USB_ARCH_HAS_EHCI if USB_SUPPORT
-	select ARM_CPU_SUSPEND if PM
-	select ARCH_NEEDS_CPU_IDLE_COUPLED if SMP
-	select OMAP_INTERCONNECT
 
 config SOC_OMAP5
 	bool "TI OMAP5"
-	select CPU_V7
+	select ARM_ARCH_TIMER
+	select ARM_CPU_SUSPEND if PM
 	select ARM_GIC
+	select CPU_V7
 	select HAVE_SMP
-	select ARM_CPU_SUSPEND if PM
 	select SOC_HAS_REALTIME_COUNTER
-	select ARM_ARCH_TIMER
 
 comment "OMAP Core Type"
 	depends on ARCH_OMAP2
@@ -109,8 +109,8 @@ config SOC_TI81XX
 config SOC_AM33XX
 	bool "AM33XX support"
 	default y
-	select CPU_V7
 	select ARM_CPU_SUSPEND if PM
+	select CPU_V7
 	select MULTI_IRQ_HANDLER
 
 config OMAP_PACKAGE_ZAF
@@ -157,8 +157,8 @@ config MACH_OMAP_H4
 	bool "OMAP 2420 H4 board"
 	depends on SOC_OMAP2420
 	default y
-	select OMAP_PACKAGE_ZAF
 	select OMAP_DEBUG_DEVICES
+	select OMAP_PACKAGE_ZAF
 
 config MACH_OMAP_APOLLON
 	bool "OMAP 2420 Apollon board"
@@ -193,8 +193,8 @@ config MACH_OMAP_LDP
 config MACH_OMAP3530_LV_SOM
 	bool "OMAP3 Logic 3530 LV SOM board"
 	depends on ARCH_OMAP3
-	select OMAP_PACKAGE_CBB
 	default y
+	select OMAP_PACKAGE_CBB
 	help
 	 Support for the LogicPD OMAP3530 SOM Development kit
 	 for full description please see the products webpage at
@@ -203,8 +203,8 @@ config MACH_OMAP3530_LV_SOM
 config MACH_OMAP3_TORPEDO
 	bool "OMAP3 Logic 35x Torpedo board"
 	depends on ARCH_OMAP3
-	select OMAP_PACKAGE_CBB
 	default y
+	select OMAP_PACKAGE_CBB
 	help
 	 Support for the LogicPD OMAP35x Torpedo Development kit
 	 for full description please see the products webpage at
@@ -265,17 +265,17 @@ config MACH_NOKIA_N8X0
 	bool "Nokia N800/N810"
 	depends on SOC_OMAP2420
 	default y
-	select OMAP_PACKAGE_ZAC
 	select MACH_NOKIA_N800
 	select MACH_NOKIA_N810
 	select MACH_NOKIA_N810_WIMAX
+	select OMAP_PACKAGE_ZAC
 
 config MACH_NOKIA_RM680
 	bool "Nokia RM-680/696 board"
 	depends on ARCH_OMAP3
 	default y
-	select OMAP_PACKAGE_CBB
 	select MACH_NOKIA_RM696
+	select OMAP_PACKAGE_CBB
 
 config MACH_NOKIA_RX51
 	bool "Nokia RX-51 board"
@@ -288,20 +288,20 @@ config MACH_OMAP_ZOOM2
 	depends on ARCH_OMAP3
 	default y
 	select OMAP_PACKAGE_CBB
+	select REGULATOR_FIXED_VOLTAGE if REGULATOR
 	select SERIAL_8250
-	select SERIAL_CORE_CONSOLE
 	select SERIAL_8250_CONSOLE
-	select REGULATOR_FIXED_VOLTAGE if REGULATOR
+	select SERIAL_CORE_CONSOLE
 
 config MACH_OMAP_ZOOM3
 	bool "OMAP3630 Zoom3 board"
 	depends on ARCH_OMAP3
 	default y
 	select OMAP_PACKAGE_CBP
+	select REGULATOR_FIXED_VOLTAGE if REGULATOR
 	select SERIAL_8250
-	select SERIAL_CORE_CONSOLE
 	select SERIAL_8250_CONSOLE
-	select REGULATOR_FIXED_VOLTAGE if REGULATOR
+	select SERIAL_CORE_CONSOLE
 
 config MACH_CM_T35
 	bool "CompuLab CM-T35/CM-T3730 modules"
@@ -329,8 +329,8 @@ config MACH_IGEP0030
 	bool "IGEP OMAP3 module"
 	depends on ARCH_OMAP3
 	default y
-	select OMAP_PACKAGE_CBB
 	select MACH_IGEP0020
+	select OMAP_PACKAGE_CBB
 
 config MACH_SBC3530
 	bool "OMAP3 SBC STALKER board"
diff --git a/arch/arm/mach-prima2/Kconfig b/arch/arm/mach-prima2/Kconfig
index 41fc853..558ccfb 100644
--- a/arch/arm/mach-prima2/Kconfig
+++ b/arch/arm/mach-prima2/Kconfig
@@ -6,8 +6,8 @@ config ARCH_PRIMA2
 	bool "CSR SiRFSoC PRIMA2 ARM Cortex A9 Platform"
 	default y
 	select CPU_V7
-	select ZONE_DMA
 	select SIRF_IRQ
+	select ZONE_DMA
 	help
           Support for CSR SiRFSoC ARM Cortex A9 Platform
 
diff --git a/arch/arm/mach-pxa/Kconfig b/arch/arm/mach-pxa/Kconfig
index 8e6288d..6f5de85 100644
--- a/arch/arm/mach-pxa/Kconfig
+++ b/arch/arm/mach-pxa/Kconfig
@@ -13,8 +13,8 @@ config MACH_TAVOREVB3
 
 config MACH_SAARB
 	bool "PXA955 Handheld Platform (aka SAARB)"
-	select CPU_PXA955
 endif
+	select CPU_PXA955
 
 config PXA_V7_MACH_AUTO
 	def_bool y
@@ -27,10 +27,10 @@ comment "Intel/Marvell Dev Platforms (sorted by hardware release time)"
 
 config MACH_PXA3XX_DT
 	bool "Support PXA3xx platforms from device tree"
-	select PXA3xx
 	select CPU_PXA300
-	select POWER_SUPPLY
 	select HAVE_PWM
+	select POWER_SUPPLY
+	select PXA3xx
 	select USE_OF
 	help
 	  Include support for Marvell PXA3xx based platforms using
@@ -44,13 +44,13 @@ config ARCH_LUBBOCK
 
 config MACH_MAINSTONE
 	bool "Intel HCDDBBVA0 Development Platform (aka Mainstone)"
-	select PXA27x
 	select HAVE_PWM
+	select PXA27x
 
 config MACH_ZYLONITE
 	bool
-	select PXA3xx
 	select HAVE_PWM
+	select PXA3xx
 
 config MACH_ZYLONITE300
 	bool "PXA3xx Development Platform (aka Zylonite) PXA300/310"
@@ -65,19 +65,19 @@ config MACH_ZYLONITE320
 
 config MACH_LITTLETON
 	bool "PXA3xx Form Factor Platform (aka Littleton)"
-	select PXA3xx
 	select CPU_PXA300
 	select CPU_PXA310
+	select PXA3xx
 
 config MACH_TAVOREVB
 	bool "PXA930 Evaluation Board (aka TavorEVB)"
-	select PXA3xx
 	select CPU_PXA930
+	select PXA3xx
 
 config MACH_SAAR
 	bool "PXA930 Handheld Platform (aka SAAR)"
-	select PXA3xx
 	select CPU_PXA930
+	select PXA3xx
 
 comment "Third Party Dev Platforms (sorted by vendor name)"
 
@@ -87,29 +87,29 @@ config ARCH_PXA_IDP
 
 config ARCH_VIPER
 	bool "Arcom/Eurotech VIPER SBC"
-	select PXA25x
-	select ISA
-	select I2C_GPIO
+	select ARCOM_PCMCIA
 	select HAVE_PWM
+	select I2C_GPIO
+	select ISA
+	select PXA25x
 	select PXA_HAVE_ISA_IRQS
-	select ARCOM_PCMCIA
 
 config MACH_ARCOM_ZEUS
 	bool "Arcom/Eurotech ZEUS SBC"
-	select PXA27x
+	select ARCOM_PCMCIA
 	select ISA
+	select PXA27x
 	select PXA_HAVE_ISA_IRQS
-	select ARCOM_PCMCIA
 
 config MACH_BALLOON3
 	bool "Balloon 3 board"
-	select PXA27x
 	select IWMMXT
+	select PXA27x
 
 config MACH_CSB726
 	bool "Enable Cogent CSB726 System On a Module"
-	select PXA27x
 	select IWMMXT
+	select PXA27x
 	help
 	  Say Y here if you intend to run this kernel on a Cogent
 	  CSB726 System On Module.
@@ -121,11 +121,11 @@ config CSB726_CSB701
 config MACH_ARMCORE
 	bool "CompuLab CM-X255/CM-X270 modules"
 	select ARCH_HAS_DMA_SET_COHERENT_MASK if PCI
-	select PXA27x
 	select IWMMXT
-	select PXA25x
 	select MIGHT_HAVE_PCI
 	select NEED_MACH_IO_H if PCI
+	select PXA25x
+	select PXA27x
 
 config MACH_EM_X270
 	bool "CompuLab EM-x270 platform"
@@ -137,10 +137,10 @@ config MACH_EXEDA
 
 config MACH_CM_X300
 	bool "CompuLab CM-X300 modules"
-	select PXA3xx
 	select CPU_PXA300
 	select CPU_PXA310
 	select HAVE_PWM
+	select PXA3xx
 
 config MACH_CAPC7117
 	bool "Embedian CAPC-7117 evaluation kit based on the MXM-8x10 CoM"
@@ -168,22 +168,22 @@ endchoice
 
 config MACH_INTELMOTE2
 	bool "Intel Mote 2 Platform"
-	select PXA27x
 	select IWMMXT
+	select PXA27x
 
 config MACH_STARGATE2
 	bool "Intel Stargate 2 Platform"
-	select PXA27x
 	select IWMMXT
+	select PXA27x
 
 config MACH_XCEP
 	bool "Iskratel Electronics XCEP"
-	select PXA25x
 	select MTD
-	select MTD_PHYSMAP
-	select MTD_CFI_INTELEXT
 	select MTD_CFI
+	select MTD_CFI_INTELEXT
 	select MTD_CHAR
+	select MTD_PHYSMAP
+	select PXA25x
 	select SMC91X
 	help
 	  PXA255 based Single Board Computer with SMC 91C111 ethernet chip and 64 MB of flash.
@@ -195,14 +195,14 @@ config TRIZEPS_PXA
 config MACH_TRIZEPS4
 	bool "Keith und Koep Trizeps4 DIMM-Module"
 	depends on TRIZEPS_PXA
-	select TRIZEPS_PCMCIA
 	select PXA27x
+	select TRIZEPS_PCMCIA
 
 config MACH_TRIZEPS4WL
 	bool "Keith und Koep Trizeps4-WL DIMM-Module"
 	depends on TRIZEPS_PXA
-	select TRIZEPS_PCMCIA
 	select PXA27x
+	select TRIZEPS_PCMCIA
 
 choice
 	prompt "Select base board for Trizeps module"
@@ -231,18 +231,18 @@ config TRIZEPS_PCMCIA
 
 config MACH_LOGICPD_PXA270
 	bool "LogicPD PXA270 Card Engine Development Platform"
-	select PXA27x
 	select HAVE_PWM
+	select PXA27x
 
 config MACH_PCM027
 	bool "Phytec phyCORE-PXA270 CPU module (PCM-027)"
-	select PXA27x
 	select IWMMXT
+	select PXA27x
 
 config MACH_PCM990_BASEBOARD
 	bool "PHYTEC PCM-990 development board"
-	select HAVE_PWM
 	depends on MACH_PCM027
+	select HAVE_PWM
 
 choice
 	prompt "display on pcm990"
@@ -266,19 +266,19 @@ config MACH_COLIBRI
 config MACH_COLIBRI_PXA270_INCOME
 	bool "Income s.r.o. PXA270 SBC"
 	depends on MACH_COLIBRI
-	select PXA27x
 	select HAVE_PWM
+	select PXA27x
 
 config MACH_COLIBRI300
 	bool "Toradex Colibri PXA300/310"
-	select PXA3xx
 	select CPU_PXA300
 	select CPU_PXA310
+	select PXA3xx
 
 config MACH_COLIBRI320
 	bool "Toradex Colibri PXA320"
-	select PXA3xx
 	select CPU_PXA320
+	select PXA3xx
 
 config MACH_COLIBRI_EVALBOARD
 	bool "Toradex Colibri Evaluation Carrier Board support"
@@ -286,8 +286,8 @@ config MACH_COLIBRI_EVALBOARD
 
 config MACH_VPAC270
 	bool "Voipac PXA270"
-	select PXA27x
 	select HAVE_PATA_PLATFORM
+	select PXA27x
 	help
 	  PXA270 based Single Board Computer.
 
@@ -295,9 +295,9 @@ comment "End-user Products (sorted by vendor name)"
 
 config MACH_H4700
 	bool "HP iPAQ hx4700"
-	select PXA27x
-	select IWMMXT
 	select HAVE_PWM
+	select IWMMXT
+	select PXA27x
 
 config MACH_H5000
 	bool "HP iPAQ h5000"
@@ -309,16 +309,16 @@ config MACH_HIMALAYA
 
 config MACH_MAGICIAN
 	bool "Enable HTC Magician Support"
-	select PXA27x
-	select IWMMXT
 	select HAVE_PWM
+	select IWMMXT
+	select PXA27x
 
 config MACH_MIOA701
 	bool "Mitac Mio A701 Support"
-	select PXA27x
-	select IWMMXT
-	select HAVE_PWM
 	select GPIO_SYSFS
+	select HAVE_PWM
+	select IWMMXT
+	select PXA27x
 	help
 	  Say Y here if you intend to run this kernel on a
 	  MIO A701. Currently there is only basic support
@@ -326,9 +326,9 @@ config MACH_MIOA701
 
 config PXA_EZX
 	bool "Motorola EZX Platform"
-	select PXA27x
-	select IWMMXT
 	select HAVE_PWM
+	select IWMMXT
+	select PXA27x
 
 config MACH_EZX_A780
 	bool "Motorola EZX A780"
@@ -393,9 +393,9 @@ config MACH_PALMT5
 	bool "Palm Tungsten|T5"
 	default y
 	depends on ARCH_PXA_PALM
-	select PXA27x
 	select IWMMXT
 	select MACH_PALM27X
+	select PXA27x
 	help
 	  Say Y here if you intend to run this kernel on a Palm Tungsten|T5
 	  handheld computer.
@@ -404,9 +404,9 @@ config MACH_PALMTX
 	bool "Palm T|X"
 	default y
 	depends on ARCH_PXA_PALM
-	select PXA27x
 	select IWMMXT
 	select MACH_PALM27X
+	select PXA27x
 	help
 	  Say Y here if you intend to run this kernel on a Palm T|X
 	  handheld computer.
@@ -415,9 +415,9 @@ config MACH_PALMZ72
 	bool "Palm Zire 72"
 	default y
 	depends on ARCH_PXA_PALM
-	select PXA27x
 	select IWMMXT
 	select MACH_PALM27X
+	select PXA27x
 	help
 	  Say Y here if you intend to run this kernel on Palm Zire 72
 	  handheld computer.
@@ -426,9 +426,9 @@ config MACH_PALMLD
 	bool "Palm LifeDrive"
 	default y
 	depends on ARCH_PXA_PALM
-	select PXA27x
 	select IWMMXT
 	select MACH_PALM27X
+	select PXA27x
 	help
 	  Say Y here if you intend to run this kernel on a Palm LifeDrive
 	  handheld computer.
@@ -441,10 +441,10 @@ config MACH_CENTRO
 	bool "Palm Centro 685 (GSM)"
 	default y
 	depends on ARCH_PXA_PALM
-	select MACH_PALM27X
-	select PXA27x
 	select IWMMXT
+	select MACH_PALM27X
 	select PALM_TREO
+	select PXA27x
 	help
 	  Say Y here if you intend to run this kernel on Palm Centro 685 (GSM)
 	  smartphone.
@@ -453,37 +453,37 @@ config MACH_TREO680
 	bool "Palm Treo 680"
 	default y
 	depends on ARCH_PXA_PALM
-	select MACH_PALM27X
-	select PXA27x
 	select IWMMXT
+	select MACH_PALM27X
 	select PALM_TREO
+	select PXA27x
 	help
 	  Say Y here if you intend to run this kernel on Palm Treo 680
 	  smartphone.
 
 config MACH_RAUMFELD_RC
 	bool "Raumfeld Controller"
-	select PXA3xx
 	select CPU_PXA300
-	select POWER_SUPPLY
 	select HAVE_PWM
+	select POWER_SUPPLY
+	select PXA3xx
 
 config MACH_RAUMFELD_CONNECTOR
 	bool "Raumfeld Connector"
+	select CPU_PXA300
 	select POWER_SUPPLY
 	select PXA3xx
-	select CPU_PXA300
 
 config MACH_RAUMFELD_SPEAKER
 	bool "Raumfeld Speaker"
+	select CPU_PXA300
 	select POWER_SUPPLY
 	select PXA3xx
-	select CPU_PXA300
 
 config PXA_SHARPSL
 	bool "SHARP Zaurus SL-5600, SL-C7xx and SL-Cxx00 Models"
-	select SHARP_SCOOP
 	select SHARP_PARAM
+	select SHARP_SCOOP
 	help
 	  Say Y here if you intend to run this kernel on a
 	  Sharp Zaurus SL-5600 (Poodle), SL-C700 (Corgi),
@@ -526,11 +526,11 @@ config MACH_HUSKY
 config MACH_AKITA
 	bool "Enable Sharp SL-1000 (Akita) Support"
 	depends on PXA_SHARPSL
-	select PXA27x
-	select PXA_SHARP_Cxx00
-	select MACH_SPITZ
 	select I2C
 	select I2C_PXA
+	select MACH_SPITZ
+	select PXA27x
+	select PXA_SHARP_Cxx00
 
 config MACH_SPITZ
 	bool "Enable Sharp Zaurus SL-3000 (Spitz) Support"
@@ -575,8 +575,8 @@ config MACH_ICONTROL
 
 config ARCH_PXA_ESERIES
 	bool "PXA based Toshiba e-series PDAs"
-	select PXA25x
 	select FB_W100
+	select PXA25x
 
 config MACH_E330
 	bool "Toshiba e330"
@@ -628,10 +628,10 @@ config MACH_E800
 
 config MACH_ZIPIT2
 	bool "Zipit Z2 Handheld"
-	select PXA27x
-	select HAVE_PWM
 endif
 endmenu
+	select HAVE_PWM
+	select PXA27x
 
 config PXA25x
 	bool
@@ -720,9 +720,9 @@ config SHARPSL_PM
 config SHARPSL_PM_MAX1111
 	bool
 	select HWMON
+	select SENSORS_MAX1111
 	select SPI
 	select SPI_MASTER
-	select SENSORS_MAX1111
 
 config PXA_HAVE_ISA_IRQS
 	bool
diff --git a/arch/arm/mach-realview/Kconfig b/arch/arm/mach-realview/Kconfig
index c593be4..14c1d47 100644
--- a/arch/arm/mach-realview/Kconfig
+++ b/arch/arm/mach-realview/Kconfig
@@ -21,8 +21,8 @@ config REALVIEW_EB_A9MP
 config REALVIEW_EB_ARM11MP
 	bool "Support ARM11MPCore Tile"
 	depends on MACH_REALVIEW_EB
-	select CPU_V6K
 	select ARCH_HAS_BARRIERS if SMP
+	select CPU_V6K
 	select HAVE_SMP
 	select MIGHT_HAVE_CACHE_L2X0
 	help
@@ -40,12 +40,12 @@ config REALVIEW_EB_ARM11MP_REVB
 
 config MACH_REALVIEW_PB11MP
 	bool "Support RealView(R) Platform Baseboard for ARM11MPCore"
-	select CPU_V6K
+	select ARCH_HAS_BARRIERS if SMP
 	select ARM_GIC
+	select CPU_V6K
 	select HAVE_PATA_PLATFORM
 	select HAVE_SMP
 	select MIGHT_HAVE_CACHE_L2X0
-	select ARCH_HAS_BARRIERS if SMP
 	help
 	  Include support for the ARM(R) RealView(R) Platform Baseboard for
 	  the ARM11MPCore.  This platform has an on-board ARM11MPCore and has
@@ -54,8 +54,8 @@ config MACH_REALVIEW_PB11MP
 # ARMv6 CPU without K extensions, but does have the new exclusive ops
 config MACH_REALVIEW_PB1176
 	bool "Support RealView(R) Platform Baseboard for ARM1176JZF-S"
-	select CPU_V6
 	select ARM_GIC
+	select CPU_V6
 	select HAVE_TCM
 	select MIGHT_HAVE_CACHE_L2X0
 	help
@@ -73,8 +73,8 @@ config REALVIEW_PB1176_SECURE_FLASH
 
 config MACH_REALVIEW_PBA8
 	bool "Support RealView(R) Platform Baseboard for Cortex(tm)-A8 platform"
-	select CPU_V7
 	select ARM_GIC
+	select CPU_V7
 	select HAVE_PATA_PLATFORM
 	help
 	  Include support for the ARM(R) RealView Platform Baseboard for
@@ -83,11 +83,11 @@ config MACH_REALVIEW_PBA8
 
 config MACH_REALVIEW_PBX
 	bool "Support RealView(R) Platform Baseboard Explore"
+	select ARCH_SPARSEMEM_ENABLE if CPU_V7 && !REALVIEW_HIGH_PHYS_OFFSET
 	select ARM_GIC
 	select HAVE_PATA_PLATFORM
 	select HAVE_SMP
 	select MIGHT_HAVE_CACHE_L2X0
-	select ARCH_SPARSEMEM_ENABLE if CPU_V7 && !REALVIEW_HIGH_PHYS_OFFSET
 	select ZONE_DMA if SPARSEMEM
 	help
 	  Include support for the ARM(R) RealView(R) Platform Baseboard
diff --git a/arch/arm/mach-s3c2412/Kconfig b/arch/arm/mach-s3c2412/Kconfig
index c5256f4..495f692 100644
--- a/arch/arm/mach-s3c2412/Kconfig
+++ b/arch/arm/mach-s3c2412/Kconfig
@@ -7,7 +7,7 @@
 config S3C2412_CPUFREQ
 	bool
 	depends on CPU_FREQ_S3C24XX && CPU_S3C2412
-	select S3C2412_IOTIMING
 	default y
+	select S3C2412_IOTIMING
 	help
 	  CPU Frequency scaling support for S3C2412 and S3C2413 SoC CPUs.
diff --git a/arch/arm/mach-s3c2440/Kconfig b/arch/arm/mach-s3c2440/Kconfig
index ece7a10..a4d7fd2 100644
--- a/arch/arm/mach-s3c2440/Kconfig
+++ b/arch/arm/mach-s3c2440/Kconfig
@@ -5,8 +5,8 @@
 config S3C2440_CPUFREQ
 	bool "S3C2440/S3C2442 CPU Frequency scaling support"
 	depends on CPU_FREQ_S3C24XX && (CPU_S3C2440 || CPU_S3C2442)
-	select S3C2410_CPUFREQ_UTILS
 	default y
+	select S3C2410_CPUFREQ_UTILS
 	help
 	  CPU Frequency scaling support for S3C2440 and S3C2442 SoC CPUs.
 
diff --git a/arch/arm/mach-s3c24xx/Kconfig b/arch/arm/mach-s3c24xx/Kconfig
index d56b0f7..2b6cb5f 100644
--- a/arch/arm/mach-s3c24xx/Kconfig
+++ b/arch/arm/mach-s3c24xx/Kconfig
@@ -17,10 +17,10 @@ config CPU_S3C2410
 	bool "SAMSUNG S3C2410"
 	default y
 	select CPU_ARM920T
-	select S3C2410_CLOCK
 	select CPU_LLSERIAL_S3C2410
-	select S3C2410_PM if PM
+	select S3C2410_CLOCK
 	select S3C2410_CPUFREQ if CPU_FREQ_S3C24XX
+	select S3C2410_PM if PM
 	help
 	  Support for S3C2410 and S3C2410A family from the S3C24XX line
 	  of Samsung Mobile CPUs.
@@ -30,8 +30,8 @@ config CPU_S3C2412
 	depends on ARCH_S3C24XX
 	select CPU_ARM926T
 	select CPU_LLSERIAL_S3C2440
-	select S3C2412_PM if PM
 	select S3C2412_DMA if S3C24XX_DMA
+	select S3C2412_PM if PM
 	help
 	  Support for the S3C2412 and S3C2413 SoCs from the S3C24XX line
 
@@ -40,10 +40,10 @@ config CPU_S3C2416
 	depends on ARCH_S3C24XX
 	select CPU_ARM926T
 	select CPU_LLSERIAL_S3C2440
-	select SAMSUNG_CLKSRC
+	select S3C2416_PM if PM
 	select S3C2443_COMMON
 	select S3C2443_DMA if S3C24XX_DMA
-	select S3C2416_PM if PM
+	select SAMSUNG_CLKSRC
 	help
 	  Support for the S3C2416 SoC from the S3C24XX line
 
@@ -75,9 +75,9 @@ config CPU_S3C2443
 	depends on ARCH_S3C24XX
 	select CPU_ARM920T
 	select CPU_LLSERIAL_S3C2440
-	select SAMSUNG_CLKSRC
 	select S3C2443_COMMON
 	select S3C2443_DMA if S3C24XX_DMA
+	select SAMSUNG_CLKSRC
 	help
 	  Support for the S3C2443 SoC from the S3C24XX line
 
@@ -156,16 +156,16 @@ config MACH_AML_M5900
 
 config ARCH_BAST
 	bool "Simtec Electronics BAST (EB2410ITX)"
+	select ISA
+	select MACH_BAST_IDE
 	select S3C2410_IOTIMING if S3C2410_CPUFREQ
-	select S3C24XX_SIMTEC_PM if PM
+	select S3C24XX_DCLK
 	select S3C24XX_SIMTEC_NOR
+	select S3C24XX_SIMTEC_PM if PM
 	select S3C24XX_SIMTEC_USB
-	select MACH_BAST_IDE
-	select S3C24XX_DCLK
-	select ISA
 	select S3C_DEV_HWMON
-	select S3C_DEV_USB_HOST
 	select S3C_DEV_NAND
+	select S3C_DEV_USB_HOST
 	help
 	  Say Y here if you are using the Simtec Electronics EB2410ITX
 	  development board (also known as BAST)
@@ -181,9 +181,9 @@ config BAST_PC104_IRQ
 config ARCH_H1940
 	bool "IPAQ H1940"
 	select PM_H1940 if PM
-	select S3C_DEV_USB_HOST
-	select S3C_DEV_NAND
 	select S3C24XX_SETUP_TS
+	select S3C_DEV_NAND
+	select S3C_DEV_USB_HOST
 	help
 	  Say Y here if you are using the HP IPAQ H1940
 
@@ -203,23 +203,23 @@ config PM_H1940
 config MACH_N30
 	bool "Acer N30 family"
 	select MACH_N35
-	select S3C_DEV_USB_HOST
 	select S3C_DEV_NAND
+	select S3C_DEV_USB_HOST
 	help
 	  Say Y here if you want suppt for the Acer N30, Acer N35,
 	  Navman PiN570, Yakumo AlphaX or Airis NC05 PDAs.
 
 config MACH_OTOM
 	bool "NexVision OTOM Board"
-	select S3C_DEV_USB_HOST
 	select S3C_DEV_NAND
+	select S3C_DEV_USB_HOST
 	help
 	  Say Y here if you are using the Nex Vision OTOM board
 
 config MACH_QT2410
 	bool "QT2410"
-	select S3C_DEV_USB_HOST
 	select S3C_DEV_NAND
+	select S3C_DEV_USB_HOST
 	help
 	  Say Y here if you are using the Armzone QT2410
 
@@ -239,12 +239,12 @@ config MACH_TCT_HAMMER
 
 config MACH_VR1000
 	bool "Thorcom VR1000"
-	select S3C24XX_SIMTEC_PM if PM
+	select MACH_BAST_IDE
 	select S3C24XX_DCLK
 	select S3C24XX_SIMTEC_NOR
-	select MACH_BAST_IDE
-	select S3C_DEV_USB_HOST
+	select S3C24XX_SIMTEC_PM if PM
 	select S3C24XX_SIMTEC_USB
+	select S3C_DEV_USB_HOST
 	help
 	  Say Y here if you are using the Thorcom VR1000 board.
 
@@ -285,8 +285,8 @@ comment "S3C2412 Boards"
 
 config MACH_JIVE
 	bool "Logitech Jive"
-	select S3C_DEV_USB_HOST
 	select S3C_DEV_NAND
+	select S3C_DEV_USB_HOST
 	help
 	  Say Y here if you are using the Logitech Jive.
 
@@ -314,15 +314,15 @@ config MACH_SMDK2413
 	bool "SMDK2413"
 	select MACH_S3C2413
 	select S3C24XX_SMDK
-	select S3C_DEV_USB_HOST
 	select S3C_DEV_NAND
+	select S3C_DEV_USB_HOST
 	help
 	  Say Y here if you are using an SMDK2413
 
 config MACH_VSTMS
 	bool "VMSTMS"
-	select S3C_DEV_USB_HOST
 	select S3C_DEV_NAND
+	select S3C_DEV_USB_HOST
 	help
 	  Say Y here if you are using an VSTMS board
 
@@ -351,13 +351,13 @@ comment "S3C2416 Boards"
 
 config MACH_SMDK2416
 	bool "SMDK2416"
+	select S3C2416_SETUP_SDHCI
 	select S3C24XX_SMDK
 	select S3C_DEV_FB
 	select S3C_DEV_HSMMC
 	select S3C_DEV_HSMMC1
 	select S3C_DEV_NAND
 	select S3C_DEV_USB_HOST
-	select S3C2416_SETUP_SDHCI
 	help
 	  Say Y here if you are using an SMDK2416
 
@@ -379,11 +379,11 @@ comment "S3C2440 Boards"
 
 config MACH_ANUBIS
 	bool "Simtec Electronics ANUBIS"
-	select S3C24XX_DCLK
-	select S3C24XX_SIMTEC_PM if PM
 	select HAVE_PATA_PLATFORM
-	select S3C24XX_GPIO_EXTRA64
 	select S3C2440_XTAL_12000000
+	select S3C24XX_DCLK
+	select S3C24XX_GPIO_EXTRA64
+	select S3C24XX_SIMTEC_PM if PM
 	select S3C_DEV_USB_HOST
 	help
 	  Say Y here if you are using the Simtec Electronics ANUBIS
@@ -391,18 +391,18 @@ config MACH_ANUBIS
 
 config MACH_AT2440EVB
 	bool "Avantech AT2440EVB development board"
-	select S3C_DEV_USB_HOST
 	select S3C_DEV_NAND
+	select S3C_DEV_USB_HOST
 	help
 	  Say Y here if you are using the AT2440EVB development board
 
 config MACH_MINI2440
 	bool "MINI2440 development board"
 	select EEPROM_AT24
-	select NEW_LEDS
 	select LEDS_CLASS
 	select LEDS_TRIGGER
 	select LEDS_TRIGGER_BACKLIGHT
+	select NEW_LEDS
 	select S3C_DEV_NAND
 	select S3C_DEV_USB_HOST
 	help
@@ -412,20 +412,20 @@ config MACH_MINI2440
 config MACH_NEXCODER_2440
 	bool "NexVision NEXCODER 2440 Light Board"
 	select S3C2440_XTAL_12000000
-	select S3C_DEV_USB_HOST
 	select S3C_DEV_NAND
+	select S3C_DEV_USB_HOST
 	help
 	  Say Y here if you are using the Nex Vision NEXCODER 2440 Light Board
 
 config MACH_OSIRIS
 	bool "Simtec IM2440D20 (OSIRIS) module"
+	select S3C2410_IOTIMING if S3C2440_CPUFREQ
+	select S3C2440_XTAL_12000000
 	select S3C24XX_DCLK
-	select S3C24XX_SIMTEC_PM if PM
 	select S3C24XX_GPIO_EXTRA128
-	select S3C2440_XTAL_12000000
-	select S3C2410_IOTIMING if S3C2440_CPUFREQ
-	select S3C_DEV_USB_HOST
+	select S3C24XX_SIMTEC_PM if PM
 	select S3C_DEV_NAND
+	select S3C_DEV_USB_HOST
 	help
 	  Say Y here if you are using the Simtec IM2440D20 module, also
 	  known as the Osiris.
@@ -445,8 +445,8 @@ config MACH_OSIRIS_DVS
 
 config MACH_RX3715
 	bool "HP iPAQ rx3715"
-	select S3C2440_XTAL_16934400
 	select PM_H1940 if PM
+	select S3C2440_XTAL_16934400
 	select S3C_DEV_NAND
 	help
 	  Say Y here if you are using the HP iPAQ rx3715.
@@ -455,8 +455,8 @@ config ARCH_S3C2440
 	bool "SMDK2440"
 	select S3C2440_XTAL_16934400
 	select S3C24XX_SMDK
-	select S3C_DEV_USB_HOST
 	select S3C_DEV_NAND
+	select S3C_DEV_USB_HOST
 	help
 	  Say Y here if you are using the SMDK2440.
 
@@ -478,11 +478,11 @@ comment "S3C2442 Boards"
 
 config MACH_NEO1973_GTA02
 	bool "Openmoko GTA02 / Freerunner phone"
+	select I2C
+	select MACH_NEO1973
 	select MFD_PCF50633
 	select PCF50633_GPIO
-	select I2C
 	select POWER_SUPPLY
-	select MACH_NEO1973
 	select S3C24XX_PWM
 	select S3C_DEV_USB_HOST
 	help
@@ -490,13 +490,13 @@ config MACH_NEO1973_GTA02
 
 config MACH_RX1950
 	bool "HP iPAQ rx1950"
-	select S3C24XX_DCLK
-	select PM_H1940 if PM
 	select I2C
-	select S3C24XX_PWM
-	select S3C_DEV_NAND
+	select PM_H1940 if PM
 	select S3C2410_IOTIMING if S3C2440_CPUFREQ
 	select S3C2440_XTAL_16934400
+	select S3C24XX_DCLK
+	select S3C24XX_PWM
+	select S3C_DEV_NAND
 	help
 	   Say Y here if you're using HP iPAQ rx1950
 
diff --git a/arch/arm/mach-s3c64xx/Kconfig b/arch/arm/mach-s3c64xx/Kconfig
index 06ca1cd..63e7ae3 100644
--- a/arch/arm/mach-s3c64xx/Kconfig
+++ b/arch/arm/mach-s3c64xx/Kconfig
@@ -7,9 +7,9 @@
 config PLAT_S3C64XX
 	bool
 	depends on ARCH_S3C64XX
-	select SAMSUNG_WAKEMASK
-	select PM_GENERIC_DOMAINS
 	default y
+	select PM_GENERIC_DOMAINS
+	select SAMSUNG_WAKEMASK
 	help
 	  Base platform code for any Samsung S3C64XX device
 
@@ -31,8 +31,8 @@ config S3C64XX_DMA
 	select S3C_DMA
 
 config S3C64XX_SETUP_SDHCI
-	select S3C64XX_SETUP_SDHCI_GPIO
 	bool
+	select S3C64XX_SETUP_SDHCI_GPIO
 	help
 	  Internal configuration for default SDHCI setup for S3C6400 and
 	  S3C6410 SoCs.
@@ -93,9 +93,9 @@ config S3C64XX_SETUP_USB_PHY
 config MACH_SMDK6400
        bool "SMDK6400"
 	select CPU_S3C6400
+	select S3C64XX_SETUP_SDHCI
 	select S3C_DEV_HSMMC
 	select S3C_DEV_NAND
-	select S3C64XX_SETUP_SDHCI
 	help
 	  Machine support for the Samsung SMDK6400
 
@@ -104,21 +104,21 @@ config MACH_SMDK6400
 config MACH_ANW6410
 	bool "A&W6410"
 	select CPU_S3C6410
-	select S3C_DEV_FB
 	select S3C64XX_SETUP_FB_24BPP
+	select S3C_DEV_FB
 	help
 	  Machine support for the A&W6410
 
 config MACH_MINI6410
 	bool "MINI6410"
 	select CPU_S3C6410
+	select S3C64XX_SETUP_FB_24BPP
+	select S3C64XX_SETUP_SDHCI
+	select S3C_DEV_FB
 	select S3C_DEV_HSMMC
 	select S3C_DEV_HSMMC1
-	select S3C64XX_SETUP_SDHCI
-	select S3C_DEV_USB_HOST
 	select S3C_DEV_NAND
-	select S3C_DEV_FB
-	select S3C64XX_SETUP_FB_24BPP
+	select S3C_DEV_USB_HOST
 	select SAMSUNG_DEV_ADC
 	select SAMSUNG_DEV_TS
 	help
@@ -127,42 +127,42 @@ config MACH_MINI6410
 config MACH_REAL6410
 	bool "REAL6410"
 	select CPU_S3C6410
-	select S3C_DEV_HSMMC
-	select S3C_DEV_HSMMC1
+	select S3C64XX_SETUP_FB_24BPP
 	select S3C64XX_SETUP_SDHCI
 	select S3C_DEV_FB
-	select S3C64XX_SETUP_FB_24BPP
+	select S3C_DEV_HSMMC
+	select S3C_DEV_HSMMC1
 	select S3C_DEV_NAND
+	select S3C_DEV_USB_HOST
 	select SAMSUNG_DEV_ADC
 	select SAMSUNG_DEV_TS
-	select S3C_DEV_USB_HOST
 	help
 	  Machine support for the CoreWind REAL6410
 
 config MACH_SMDK6410
 	bool "SMDK6410"
 	select CPU_S3C6410
-	select SAMSUNG_DEV_ADC
+	select HAVE_S3C2410_WATCHDOG if WATCHDOG
+	select S3C64XX_SETUP_FB_24BPP
+	select S3C64XX_SETUP_I2C1
+	select S3C64XX_SETUP_IDE
+	select S3C64XX_SETUP_KEYPAD
+	select S3C64XX_SETUP_SDHCI
+	select S3C64XX_SETUP_USB_PHY
+	select S3C_DEV_FB
 	select S3C_DEV_HSMMC
 	select S3C_DEV_HSMMC1
 	select S3C_DEV_I2C1
-	select SAMSUNG_DEV_IDE
-	select S3C_DEV_FB
 	select S3C_DEV_RTC
-	select SAMSUNG_DEV_TS
 	select S3C_DEV_USB_HOST
 	select S3C_DEV_USB_HSOTG
 	select S3C_DEV_WDT
+	select SAMSUNG_DEV_ADC
 	select SAMSUNG_DEV_BACKLIGHT
+	select SAMSUNG_DEV_IDE
 	select SAMSUNG_DEV_KEYPAD
 	select SAMSUNG_DEV_PWM
-	select HAVE_S3C2410_WATCHDOG if WATCHDOG
-	select S3C64XX_SETUP_SDHCI
-	select S3C64XX_SETUP_I2C1
-	select S3C64XX_SETUP_IDE
-	select S3C64XX_SETUP_FB_24BPP
-	select S3C64XX_SETUP_KEYPAD
-	select S3C64XX_SETUP_USB_PHY
+	select SAMSUNG_DEV_TS
 	help
 	  Machine support for the Samsung SMDK6410
 
@@ -198,13 +198,13 @@ endchoice
 config SMDK6410_WM1190_EV1
 	bool "Support Wolfson Microelectronics 1190-EV1 PMIC card"
 	depends on MACH_SMDK6410
-	select REGULATOR
-	select REGULATOR_WM8350
-	select SAMSUNG_GPIO_EXTRA64
-	select MFD_WM8350_I2C
 	select MFD_WM8350_CONFIG_MODE_0
 	select MFD_WM8350_CONFIG_MODE_3
+	select MFD_WM8350_I2C
 	select MFD_WM8352_CONFIG_MODE_0
+	select REGULATOR
+	select REGULATOR_WM8350
+	select SAMSUNG_GPIO_EXTRA64
 	help
 	  The Wolfson Microelectronics 1190-EV1 is a WM835x based PMIC
 	  and audio daughtercard for the Samsung SMDK6410 reference
@@ -216,11 +216,11 @@ config SMDK6410_WM1190_EV1
 config SMDK6410_WM1192_EV1
 	bool "Support Wolfson Microelectronics 1192-EV1 PMIC card"
 	depends on MACH_SMDK6410
+	select MFD_WM831X
+	select MFD_WM831X_I2C
 	select REGULATOR
 	select REGULATOR_WM831X
 	select SAMSUNG_GPIO_EXTRA64
-	select MFD_WM831X
-	select MFD_WM831X_I2C
 	help
 	  The Wolfson Microelectronics 1192-EV1 is a WM831x based PMIC
 	  daughtercard for the Samsung SMDK6410 reference platform.
@@ -232,19 +232,19 @@ config SMDK6410_WM1192_EV1
 config MACH_NCP
 	bool "NCP"
 	select CPU_S3C6410
-	select S3C_DEV_I2C1
-	select S3C_DEV_HSMMC1
 	select S3C64XX_SETUP_I2C1
+	select S3C_DEV_HSMMC1
+	select S3C_DEV_I2C1
 	help
           Machine support for the Samsung NCP
 
 config MACH_HMT
 	bool "Airgoo HMT"
 	select CPU_S3C6410
+	select S3C64XX_SETUP_FB_24BPP
 	select S3C_DEV_FB
 	select S3C_DEV_NAND
 	select S3C_DEV_USB_HOST
-	select S3C64XX_SETUP_FB_24BPP
 	select SAMSUNG_DEV_PWM
 	help
 	  Machine support for the Airgoo HMT
@@ -252,17 +252,17 @@ config MACH_HMT
 config MACH_SMARTQ
 	bool
 	select CPU_S3C6410
+	select S3C64XX_SETUP_FB_24BPP
+	select S3C64XX_SETUP_SDHCI
+	select S3C64XX_SETUP_USB_PHY
+	select S3C_DEV_FB
 	select S3C_DEV_HSMMC
 	select S3C_DEV_HSMMC1
 	select S3C_DEV_HSMMC2
-	select S3C_DEV_FB
 	select S3C_DEV_HWMON
 	select S3C_DEV_RTC
-	select S3C_DEV_USB_HSOTG
 	select S3C_DEV_USB_HOST
-	select S3C64XX_SETUP_SDHCI
-	select S3C64XX_SETUP_FB_24BPP
-	select S3C64XX_SETUP_USB_PHY
+	select S3C_DEV_USB_HSOTG
 	select SAMSUNG_DEV_ADC
 	select SAMSUNG_DEV_PWM
 	select SAMSUNG_DEV_TS
@@ -284,26 +284,26 @@ config MACH_SMARTQ7
 config MACH_WLF_CRAGG_6410
 	bool "Wolfson Cragganmore 6410"
 	select CPU_S3C6410
-	select S3C64XX_SETUP_SDHCI
+	select I2C
+	select LEDS_GPIO_REGISTER
+	select S3C64XX_DEV_SPI0
+	select S3C64XX_SETUP_FB_24BPP
 	select S3C64XX_SETUP_I2C1
 	select S3C64XX_SETUP_IDE
-	select S3C64XX_SETUP_FB_24BPP
 	select S3C64XX_SETUP_KEYPAD
+	select S3C64XX_SETUP_SDHCI
 	select S3C64XX_SETUP_SPI
 	select S3C64XX_SETUP_USB_PHY
-	select SAMSUNG_DEV_ADC
-	select SAMSUNG_DEV_KEYPAD
-	select S3C_DEV_USB_HOST
-	select S3C_DEV_USB_HSOTG
 	select S3C_DEV_HSMMC
 	select S3C_DEV_HSMMC1
 	select S3C_DEV_HSMMC2
 	select S3C_DEV_I2C1
-	select S3C_DEV_WDT
 	select S3C_DEV_RTC
-	select S3C64XX_DEV_SPI0
+	select S3C_DEV_USB_HOST
+	select S3C_DEV_USB_HSOTG
+	select S3C_DEV_WDT
+	select SAMSUNG_DEV_ADC
+	select SAMSUNG_DEV_KEYPAD
 	select SAMSUNG_GPIO_EXTRA128
-	select I2C
-	select LEDS_GPIO_REGISTER
 	help
 	  Machine support for the Wolfson Cragganmore S3C6410 variant.
diff --git a/arch/arm/mach-s5p64x0/Kconfig b/arch/arm/mach-s5p64x0/Kconfig
index c87f610..e8742cb 100644
--- a/arch/arm/mach-s5p64x0/Kconfig
+++ b/arch/arm/mach-s5p64x0/Kconfig
@@ -9,18 +9,18 @@ if ARCH_S5P64X0
 
 config CPU_S5P6440
 	bool
-	select SAMSUNG_DMADEV
 	select S5P_HRT
 	select S5P_SLEEP if PM
+	select SAMSUNG_DMADEV
 	select SAMSUNG_WAKEMASK if PM
 	help
 	  Enable S5P6440 CPU support
 
 config CPU_S5P6450
 	bool
-	select SAMSUNG_DMADEV
 	select S5P_HRT
 	select S5P_SLEEP if PM
+	select SAMSUNG_DMADEV
 	select SAMSUNG_WAKEMASK if PM
 	help
 	  Enable S5P6450 CPU support
@@ -52,19 +52,19 @@ config MACH_SMDK6440
 	bool "SMDK6440"
 	select CPU_S5P6440
 	select S3C_DEV_FB
-	select S3C_DEV_I2C1
-	select S3C_DEV_RTC
-	select S3C_DEV_WDT
 	select S3C_DEV_HSMMC
 	select S3C_DEV_HSMMC1
 	select S3C_DEV_HSMMC2
+	select S3C_DEV_I2C1
+	select S3C_DEV_RTC
+	select S3C_DEV_WDT
+	select S5P64X0_SETUP_FB_24BPP
+	select S5P64X0_SETUP_I2C1
+	select S5P64X0_SETUP_SDHCI_GPIO
 	select SAMSUNG_DEV_ADC
 	select SAMSUNG_DEV_BACKLIGHT
 	select SAMSUNG_DEV_PWM
 	select SAMSUNG_DEV_TS
-	select S5P64X0_SETUP_FB_24BPP
-	select S5P64X0_SETUP_I2C1
-	select S5P64X0_SETUP_SDHCI_GPIO
 	help
 	  Machine support for the Samsung SMDK6440
 
@@ -72,19 +72,19 @@ config MACH_SMDK6450
 	bool "SMDK6450"
 	select CPU_S5P6450
 	select S3C_DEV_FB
-	select S3C_DEV_I2C1
-	select S3C_DEV_RTC
-	select S3C_DEV_WDT
 	select S3C_DEV_HSMMC
 	select S3C_DEV_HSMMC1
 	select S3C_DEV_HSMMC2
+	select S3C_DEV_I2C1
+	select S3C_DEV_RTC
+	select S3C_DEV_WDT
+	select S5P64X0_SETUP_FB_24BPP
+	select S5P64X0_SETUP_I2C1
+	select S5P64X0_SETUP_SDHCI_GPIO
 	select SAMSUNG_DEV_ADC
 	select SAMSUNG_DEV_BACKLIGHT
 	select SAMSUNG_DEV_PWM
 	select SAMSUNG_DEV_TS
-	select S5P64X0_SETUP_FB_24BPP
-	select S5P64X0_SETUP_I2C1
-	select S5P64X0_SETUP_SDHCI_GPIO
 	help
 	  Machine support for the Samsung SMDK6450
 
diff --git a/arch/arm/mach-s5pc100/Kconfig b/arch/arm/mach-s5pc100/Kconfig
index 75a26ea..15170be 100644
--- a/arch/arm/mach-s5pc100/Kconfig
+++ b/arch/arm/mach-s5pc100/Kconfig
@@ -60,12 +60,6 @@ config MACH_SMDKC100
 	select S3C_DEV_I2C1
 	select S3C_DEV_RTC
 	select S3C_DEV_WDT
-	select SAMSUNG_DEV_ADC
-	select SAMSUNG_DEV_BACKLIGHT
-	select SAMSUNG_DEV_IDE
-	select SAMSUNG_DEV_KEYPAD
-	select SAMSUNG_DEV_PWM
-	select SAMSUNG_DEV_TS
 	select S5PC100_SETUP_FB_24BPP
 	select S5PC100_SETUP_I2C1
 	select S5PC100_SETUP_IDE
@@ -74,6 +68,12 @@ config MACH_SMDKC100
 	select S5P_DEV_FIMC0
 	select S5P_DEV_FIMC1
 	select S5P_DEV_FIMC2
+	select SAMSUNG_DEV_ADC
+	select SAMSUNG_DEV_BACKLIGHT
+	select SAMSUNG_DEV_IDE
+	select SAMSUNG_DEV_KEYPAD
+	select SAMSUNG_DEV_PWM
+	select SAMSUNG_DEV_TS
 	help
 	  Machine support for the Samsung SMDKC100
 
diff --git a/arch/arm/mach-s5pv210/Kconfig b/arch/arm/mach-s5pv210/Kconfig
index 77185c3..92ad72f 100644
--- a/arch/arm/mach-s5pv210/Kconfig
+++ b/arch/arm/mach-s5pv210/Kconfig
@@ -11,11 +11,11 @@ if ARCH_S5PV210
 
 config CPU_S5PV210
 	bool
-	select SAMSUNG_DMADEV
 	select S5P_EXT_INT
 	select S5P_HRT
 	select S5P_PM if PM
 	select S5P_SLEEP if PM
+	select SAMSUNG_DMADEV
 	help
 	  Enable S5PV210 CPU support
 
@@ -76,44 +76,44 @@ config MACH_AQUILA
 	bool "Aquila"
 	select CPU_S5PV210
 	select S3C_DEV_FB
-	select S5P_DEV_FIMC0
-	select S5P_DEV_FIMC1
-	select S5P_DEV_FIMC2
 	select S3C_DEV_HSMMC
 	select S3C_DEV_HSMMC1
 	select S3C_DEV_HSMMC2
-	select S5P_DEV_ONENAND
 	select S5PV210_SETUP_FB_24BPP
 	select S5PV210_SETUP_SDHCI
 	select S5PV210_SETUP_USB_PHY
+	select S5P_DEV_FIMC0
+	select S5P_DEV_FIMC1
+	select S5P_DEV_FIMC2
+	select S5P_DEV_ONENAND
 	help
 	  Machine support for the Samsung Aquila target based on S5PC110 SoC
 
 config MACH_GONI
 	bool "GONI"
 	select CPU_S5PV210
-	select S5P_GPIO_INT
 	select S3C_DEV_FB
-	select S5P_DEV_FIMC0
-	select S5P_DEV_FIMC1
-	select S5P_DEV_FIMC2
 	select S3C_DEV_HSMMC
 	select S3C_DEV_HSMMC1
 	select S3C_DEV_HSMMC2
 	select S3C_DEV_I2C1
 	select S3C_DEV_I2C2
-	select S5P_DEV_MFC
 	select S3C_DEV_USB_HSOTG
-	select S5P_DEV_ONENAND
-	select SAMSUNG_DEV_KEYPAD
-	select S5P_DEV_TV
 	select S5PV210_SETUP_FB_24BPP
+	select S5PV210_SETUP_FIMC
 	select S5PV210_SETUP_I2C1
 	select S5PV210_SETUP_I2C2
 	select S5PV210_SETUP_KEYPAD
 	select S5PV210_SETUP_SDHCI
-	select S5PV210_SETUP_FIMC
 	select S5PV210_SETUP_USB_PHY
+	select S5P_DEV_FIMC0
+	select S5P_DEV_FIMC1
+	select S5P_DEV_FIMC2
+	select S5P_DEV_MFC
+	select S5P_DEV_ONENAND
+	select S5P_DEV_TV
+	select S5P_GPIO_INT
+	select SAMSUNG_DEV_KEYPAD
 	help
 	  Machine support for Samsung GONI board
 	  S5PC110(MCP) is one of package option of S5PV210
@@ -125,14 +125,14 @@ config MACH_SMDKC110
 	select S3C_DEV_I2C2
 	select S3C_DEV_RTC
 	select S3C_DEV_WDT
+	select S5PV210_SETUP_I2C1
+	select S5PV210_SETUP_I2C2
+	select S5PV210_SETUP_IDE
 	select S5P_DEV_FIMC0
 	select S5P_DEV_FIMC1
 	select S5P_DEV_FIMC2
 	select S5P_DEV_MFC
 	select SAMSUNG_DEV_IDE
-	select S5PV210_SETUP_I2C1
-	select S5PV210_SETUP_I2C2
-	select S5PV210_SETUP_IDE
 	help
 	  Machine support for Samsung SMDKC110
 	  S5PC110(MCP) is one of package option of S5PV210
@@ -154,6 +154,13 @@ config MACH_SMDKV210
 	select S3C_DEV_RTC
 	select S3C_DEV_USB_HSOTG
 	select S3C_DEV_WDT
+	select S5PV210_SETUP_FB_24BPP
+	select S5PV210_SETUP_I2C1
+	select S5PV210_SETUP_I2C2
+	select S5PV210_SETUP_IDE
+	select S5PV210_SETUP_KEYPAD
+	select S5PV210_SETUP_SDHCI
+	select S5PV210_SETUP_USB_PHY
 	select S5P_DEV_FIMC0
 	select S5P_DEV_FIMC1
 	select S5P_DEV_FIMC2
@@ -165,20 +172,13 @@ config MACH_SMDKV210
 	select SAMSUNG_DEV_KEYPAD
 	select SAMSUNG_DEV_PWM
 	select SAMSUNG_DEV_TS
-	select S5PV210_SETUP_FB_24BPP
-	select S5PV210_SETUP_I2C1
-	select S5PV210_SETUP_I2C2
-	select S5PV210_SETUP_IDE
-	select S5PV210_SETUP_KEYPAD
-	select S5PV210_SETUP_SDHCI
-	select S5PV210_SETUP_USB_PHY
 	help
 	  Machine support for Samsung SMDKV210
 
 config MACH_TORBRECK
 	bool "Torbreck"
-	select CPU_S5PV210
 	select ARCH_SPARSEMEM_ENABLE
+	select CPU_S5PV210
 	select S3C_DEV_HSMMC
 	select S3C_DEV_HSMMC1
 	select S3C_DEV_HSMMC2
diff --git a/arch/arm/mach-sa1100/Kconfig b/arch/arm/mach-sa1100/Kconfig
index 42625e4..ca14dbd 100644
--- a/arch/arm/mach-sa1100/Kconfig
+++ b/arch/arm/mach-sa1100/Kconfig
@@ -49,15 +49,15 @@ config SA1100_COLLIE
 	bool "Sharp Zaurus SL5500"
 	# FIXME: select CPU_FREQ_SA11x0
 	select SHARP_LOCOMO
-	select SHARP_SCOOP
 	select SHARP_PARAM
+	select SHARP_SCOOP
 	help
 	  Say Y here to support the Sharp Zaurus SL5500 PDAs.
 
 config SA1100_H3100
 	bool "Compaq iPAQ H3100"
-	select HTC_EGPIO
 	select CPU_FREQ_SA1110
+	select HTC_EGPIO
 	help
 	  Say Y here if you intend to run this kernel on the Compaq iPAQ
 	  H3100 handheld computer.  Information about this machine and the
@@ -67,8 +67,8 @@ config SA1100_H3100
 
 config SA1100_H3600
 	bool "Compaq iPAQ H3600/H3700"
-	select HTC_EGPIO
 	select CPU_FREQ_SA1110
+	select HTC_EGPIO
 	help
 	  Say Y here if you intend to run this kernel on the Compaq iPAQ
 	  H3600 handheld computer.  Information about this machine and the
@@ -78,16 +78,16 @@ config SA1100_H3600
 
 config SA1100_BADGE4
 	bool "HP Labs BadgePAD 4"
-	select SA1111
 	select CPU_FREQ_SA1100
+	select SA1111
 	help
 	  Say Y here if you want to build a kernel for the HP Laboratories
 	  BadgePAD 4.
 
 config SA1100_JORNADA720
 	bool "HP Jornada 720"
-	select SA1111
 	# FIXME: select CPU_FREQ_SA11x0
+	select SA1111
 	help
 	  Say Y here if you want to build a kernel for the HP Jornada 720
 	  handheld computer.  See 
@@ -95,8 +95,8 @@ config SA1100_JORNADA720
 
 config SA1100_JORNADA720_SSP
 	bool "HP Jornada 720 Extended SSP driver"
-	select SA1100_SSP
 	depends on SA1100_JORNADA720
+	select SA1100_SSP
 	help
 	  Say Y here if you have a HP Jornada 7xx handheld computer and you
 	  want to access devices connected to the MCU. Those include the
diff --git a/arch/arm/mach-shmobile/Kconfig b/arch/arm/mach-shmobile/Kconfig
index 4cacc2d..8ae100c 100644
--- a/arch/arm/mach-shmobile/Kconfig
+++ b/arch/arm/mach-shmobile/Kconfig
@@ -4,49 +4,49 @@ comment "SH-Mobile System Type"
 
 config ARCH_SH7367
 	bool "SH-Mobile G3 (SH7367)"
+	select ARCH_WANT_OPTIONAL_GPIOLIB
 	select CPU_V6
 	select SH_CLK_CPG
-	select ARCH_WANT_OPTIONAL_GPIOLIB
 
 config ARCH_SH7377
 	bool "SH-Mobile G4 (SH7377)"
+	select ARCH_WANT_OPTIONAL_GPIOLIB
 	select CPU_V7
 	select SH_CLK_CPG
-	select ARCH_WANT_OPTIONAL_GPIOLIB
 
 config ARCH_SH7372
 	bool "SH-Mobile AP4 (SH7372)"
-	select CPU_V7
-	select SH_CLK_CPG
 	select ARCH_WANT_OPTIONAL_GPIOLIB
 	select ARM_CPU_SUSPEND if PM || CPU_IDLE
+	select CPU_V7
+	select SH_CLK_CPG
 
 config ARCH_SH73A0
 	bool "SH-Mobile AG5 (R8A73A00)"
-	select CPU_V7
-	select SH_CLK_CPG
 	select ARCH_WANT_OPTIONAL_GPIOLIB
 	select ARM_GIC
+	select CPU_V7
 	select I2C
+	select SH_CLK_CPG
 
 config ARCH_R8A7740
 	bool "R-Mobile A1 (R8A77400)"
+	select ARCH_WANT_OPTIONAL_GPIOLIB
 	select CPU_V7
 	select SH_CLK_CPG
-	select ARCH_WANT_OPTIONAL_GPIOLIB
 
 config ARCH_R8A7779
 	bool "R-Car H1 (R8A77790)"
+	select ARCH_WANT_OPTIONAL_GPIOLIB
+	select ARM_GIC
 	select CPU_V7
 	select SH_CLK_CPG
-	select ARM_GIC
-	select ARCH_WANT_OPTIONAL_GPIOLIB
 
 config ARCH_EMEV2
 	bool "Emma Mobile EV2"
-	select CPU_V7
-	select ARM_GIC
 	select ARCH_WANT_OPTIONAL_GPIOLIB
+	select ARM_GIC
+	select CPU_V7
 
 comment "SH-Mobile Board Type"
 
@@ -65,9 +65,9 @@ config MACH_AP4EVB
 	bool "AP4EVB board"
 	depends on ARCH_SH7372
 	select ARCH_REQUIRE_GPIOLIB
+	select REGULATOR_FIXED_VOLTAGE if REGULATOR
 	select SH_LCD_MIPI_DSI
 	select SND_SOC_AK4642 if SND_SIMPLE_CARD
-	select REGULATOR_FIXED_VOLTAGE if REGULATOR
 
 choice
 	prompt "AP4EVB LCD panel selection"
@@ -84,37 +84,37 @@ endchoice
 
 config MACH_AG5EVM
 	bool "AG5EVM board"
+	depends on ARCH_SH73A0
 	select ARCH_REQUIRE_GPIOLIB
-	select SH_LCD_MIPI_DSI
 	select REGULATOR_FIXED_VOLTAGE if REGULATOR
-	depends on ARCH_SH73A0
+	select SH_LCD_MIPI_DSI
 
 config MACH_MACKEREL
 	bool "mackerel board"
 	depends on ARCH_SH7372
 	select ARCH_REQUIRE_GPIOLIB
-	select SND_SOC_AK4642 if SND_SIMPLE_CARD
 	select REGULATOR_FIXED_VOLTAGE if REGULATOR
+	select SND_SOC_AK4642 if SND_SIMPLE_CARD
 
 config MACH_KOTA2
 	bool "KOTA2 board"
+	depends on ARCH_SH73A0
 	select ARCH_REQUIRE_GPIOLIB
 	select REGULATOR_FIXED_VOLTAGE if REGULATOR
-	depends on ARCH_SH73A0
 
 config MACH_BONITO
 	bool "bonito board"
+	depends on ARCH_R8A7740
 	select ARCH_REQUIRE_GPIOLIB
 	select REGULATOR_FIXED_VOLTAGE if REGULATOR
-	depends on ARCH_R8A7740
 
 config MACH_ARMADILLO800EVA
 	bool "Armadillo-800 EVA board"
 	depends on ARCH_R8A7740
 	select ARCH_REQUIRE_GPIOLIB
-	select USE_OF
 	select REGULATOR_FIXED_VOLTAGE if REGULATOR
 	select SND_SOC_WM8978 if SND_SIMPLE_CARD
+	select USE_OF
 
 config MACH_MARZEN
 	bool "MARZEN board"
@@ -125,16 +125,16 @@ config MACH_MARZEN
 config MACH_KZM9D
 	bool "KZM9D board"
 	depends on ARCH_EMEV2
-	select USE_OF
 	select REGULATOR_FIXED_VOLTAGE if REGULATOR
+	select USE_OF
 
 config MACH_KZM9G
 	bool "KZM-A9-GT board"
 	depends on ARCH_SH73A0
 	select ARCH_REQUIRE_GPIOLIB
-	select USE_OF
-	select SND_SOC_AK4642 if SND_SIMPLE_CARD
 	select REGULATOR_FIXED_VOLTAGE if REGULATOR
+	select SND_SOC_AK4642 if SND_SIMPLE_CARD
+	select USE_OF
 
 comment "SH-Mobile System Configuration"
 
diff --git a/arch/arm/mach-tegra/Kconfig b/arch/arm/mach-tegra/Kconfig
index 11680c5..9ff6f6e 100644
--- a/arch/arm/mach-tegra/Kconfig
+++ b/arch/arm/mach-tegra/Kconfig
@@ -4,42 +4,42 @@ comment "NVIDIA Tegra options"
 
 config ARCH_TEGRA_2x_SOC
 	bool "Enable support for Tegra20 family"
-	select CPU_V7
-	select ARM_GIC
 	select ARCH_REQUIRE_GPIOLIB
-	select PINCTRL
-	select PINCTRL_TEGRA20
-	select USB_ARCH_HAS_EHCI if USB_SUPPORT
-	select USB_ULPI if USB
-	select USB_ULPI_VIEWPORT if USB_SUPPORT
 	select ARM_ERRATA_720789
 	select ARM_ERRATA_742230
 	select ARM_ERRATA_751472
 	select ARM_ERRATA_754327
 	select ARM_ERRATA_764369 if SMP
+	select ARM_GIC
+	select CPU_FREQ_TABLE if CPU_FREQ
+	select CPU_V7
+	select PINCTRL
+	select PINCTRL_TEGRA20
 	select PL310_ERRATA_727915 if CACHE_L2X0
 	select PL310_ERRATA_769419 if CACHE_L2X0
-	select CPU_FREQ_TABLE if CPU_FREQ
+	select USB_ARCH_HAS_EHCI if USB_SUPPORT
+	select USB_ULPI if USB
+	select USB_ULPI_VIEWPORT if USB_SUPPORT
 	help
 	  Support for NVIDIA Tegra AP20 and T20 processors, based on the
 	  ARM CortexA9MP CPU and the ARM PL310 L2 cache controller
 
 config ARCH_TEGRA_3x_SOC
 	bool "Enable support for Tegra30 family"
-	select CPU_V7
-	select ARM_GIC
 	select ARCH_REQUIRE_GPIOLIB
-	select PINCTRL
-	select PINCTRL_TEGRA30
-	select USB_ARCH_HAS_EHCI if USB_SUPPORT
-	select USB_ULPI if USB
-	select USB_ULPI_VIEWPORT if USB_SUPPORT
 	select ARM_ERRATA_743622
 	select ARM_ERRATA_751472
 	select ARM_ERRATA_754322
 	select ARM_ERRATA_764369 if SMP
-	select PL310_ERRATA_769419 if CACHE_L2X0
+	select ARM_GIC
 	select CPU_FREQ_TABLE if CPU_FREQ
+	select CPU_V7
+	select PINCTRL
+	select PINCTRL_TEGRA30
+	select PL310_ERRATA_769419 if CACHE_L2X0
+	select USB_ARCH_HAS_EHCI if USB_SUPPORT
+	select USB_ULPI if USB
+	select USB_ULPI_VIEWPORT if USB_SUPPORT
 	help
 	  Support for NVIDIA Tegra T30 processor family, based on the
 	  ARM CortexA9MP CPU and the ARM PL310 L2 cache controller
diff --git a/arch/arm/mach-u300/Kconfig b/arch/arm/mach-u300/Kconfig
index f7e12ed..1f59764 100644
--- a/arch/arm/mach-u300/Kconfig
+++ b/arch/arm/mach-u300/Kconfig
@@ -7,8 +7,8 @@ comment "ST-Ericsson Mobile Platform Products"
 config MACH_U300
 	bool "U300"
 	select PINCTRL
-	select PINCTRL_U300
 	select PINCTRL_COH901
+	select PINCTRL_U300
 
 comment "ST-Ericsson U300/U335 Feature Selections"
 
diff --git a/arch/arm/mach-ux500/Kconfig b/arch/arm/mach-ux500/Kconfig
index 5848206..e8c3f0d 100644
--- a/arch/arm/mach-ux500/Kconfig
+++ b/arch/arm/mach-ux500/Kconfig
@@ -3,33 +3,33 @@ if ARCH_U8500
 config UX500_SOC_COMMON
 	bool
 	default y
-	select ARM_GIC
-	select HAS_MTU
-	select PL310_ERRATA_753970 if CACHE_PL310
 	select ARM_ERRATA_754322
 	select ARM_ERRATA_764369 if SMP
+	select ARM_GIC
 	select CACHE_L2X0
+	select COMMON_CLK
+	select HAS_MTU
 	select PINCTRL
 	select PINCTRL_NOMADIK
-	select COMMON_CLK
+	select PL310_ERRATA_753970 if CACHE_PL310
 
 config UX500_SOC_DB8500
 	bool
+	select CPU_FREQ_TABLE if CPU_FREQ
 	select MFD_DB8500_PRCMU
+	select PINCTRL_DB8500
 	select REGULATOR
 	select REGULATOR_DB8500_PRCMU
-	select CPU_FREQ_TABLE if CPU_FREQ
-	select PINCTRL_DB8500
 
 menu "Ux500 target platform (boards)"
 
 config MACH_MOP500
 	bool "U8500 Development platform, MOP500 versions"
-	select UX500_SOC_DB8500
 	select I2C
 	select I2C_NOMADIK
-	select SOC_BUS
 	select REGULATOR_FIXED_VOLTAGE
+	select SOC_BUS
+	select UX500_SOC_DB8500
 	help
 	  Include support for the MOP500 development platform.
 
diff --git a/arch/arm/mach-versatile/Kconfig b/arch/arm/mach-versatile/Kconfig
index c1f38f6..63d8e9f 100644
--- a/arch/arm/mach-versatile/Kconfig
+++ b/arch/arm/mach-versatile/Kconfig
@@ -3,9 +3,9 @@ menu "Versatile platform type"
 
 config ARCH_VERSATILE_PB
 	bool "Support Versatile Platform Baseboard for ARM926EJ-S"
+	default y
 	select CPU_ARM926T
 	select MIGHT_HAVE_PCI
-	default y
 	help
 	  Include support for the ARM(R) Versatile Platform Baseboard
 	  for the ARM926EJ-S.
@@ -19,8 +19,8 @@ config MACH_VERSATILE_AB
 
 config MACH_VERSATILE_DT
 	bool "Support Versatile platform from device tree"
-	select USE_OF
 	select CPU_ARM926T
+	select USE_OF
 	help
 	  Include support for the ARM(R) Versatile/PB platform,
 	  using the device tree for discovery
diff --git a/arch/arm/mm/Kconfig b/arch/arm/mm/Kconfig
index c9a4963..94186b6 100644
--- a/arch/arm/mm/Kconfig
+++ b/arch/arm/mm/Kconfig
@@ -10,8 +10,8 @@ config CPU_ARM7TDMI
 	depends on !MMU
 	select CPU_32v4T
 	select CPU_ABRT_LV4T
-	select CPU_PABRT_LEGACY
 	select CPU_CACHE_V4
+	select CPU_PABRT_LEGACY
 	help
 	  A 32-bit RISC microprocessor based on the ARM7 processor core
 	  which has no memory control unit and cache.
@@ -24,11 +24,11 @@ config CPU_ARM720T
 	bool "Support ARM720T processor" if ARCH_INTEGRATOR
 	select CPU_32v4T
 	select CPU_ABRT_LV4T
-	select CPU_PABRT_LEGACY
 	select CPU_CACHE_V4
 	select CPU_CACHE_VIVT
-	select CPU_CP15_MMU
 	select CPU_COPY_V4WT if MMU
+	select CPU_CP15_MMU
+	select CPU_PABRT_LEGACY
 	select CPU_TLB_V4WT if MMU
 	help
 	  A 32-bit RISC processor with 8kByte Cache, Write Buffer and
@@ -43,9 +43,9 @@ config CPU_ARM740T
 	depends on !MMU
 	select CPU_32v4T
 	select CPU_ABRT_LV4T
-	select CPU_PABRT_LEGACY
 	select CPU_CACHE_V3	# although the core is v4t
 	select CPU_CP15_MPU
+	select CPU_PABRT_LEGACY
 	help
 	  A 32-bit RISC processor with 8KB cache or 4KB variants,
 	  write buffer and MPU(Protection Unit) built around
@@ -60,8 +60,8 @@ config CPU_ARM9TDMI
 	depends on !MMU
 	select CPU_32v4T
 	select CPU_ABRT_NOMMU
-	select CPU_PABRT_LEGACY
 	select CPU_CACHE_V4
+	select CPU_PABRT_LEGACY
 	help
 	  A 32-bit RISC microprocessor based on the ARM9 processor core
 	  which has no memory control unit and cache.
@@ -74,11 +74,11 @@ config CPU_ARM920T
 	bool "Support ARM920T processor" if ARCH_INTEGRATOR
 	select CPU_32v4T
 	select CPU_ABRT_EV4T
-	select CPU_PABRT_LEGACY
 	select CPU_CACHE_V4WT
 	select CPU_CACHE_VIVT
-	select CPU_CP15_MMU
 	select CPU_COPY_V4WB if MMU
+	select CPU_CP15_MMU
+	select CPU_PABRT_LEGACY
 	select CPU_TLB_V4WBI if MMU
 	help
 	  The ARM920T is licensed to be produced by numerous vendors,
@@ -92,11 +92,11 @@ config CPU_ARM922T
 	bool "Support ARM922T processor" if ARCH_INTEGRATOR
 	select CPU_32v4T
 	select CPU_ABRT_EV4T
-	select CPU_PABRT_LEGACY
 	select CPU_CACHE_V4WT
 	select CPU_CACHE_VIVT
-	select CPU_CP15_MMU
 	select CPU_COPY_V4WB if MMU
+	select CPU_CP15_MMU
+	select CPU_PABRT_LEGACY
 	select CPU_TLB_V4WBI if MMU
 	help
 	  The ARM922T is a version of the ARM920T, but with smaller
@@ -111,11 +111,11 @@ config CPU_ARM925T
  	bool "Support ARM925T processor" if ARCH_OMAP1
 	select CPU_32v4T
 	select CPU_ABRT_EV4T
-	select CPU_PABRT_LEGACY
 	select CPU_CACHE_V4WT
 	select CPU_CACHE_VIVT
-	select CPU_CP15_MMU
 	select CPU_COPY_V4WB if MMU
+	select CPU_CP15_MMU
+	select CPU_PABRT_LEGACY
 	select CPU_TLB_V4WBI if MMU
  	help
  	  The ARM925T is a mix between the ARM920T and ARM926T, but with
@@ -130,10 +130,10 @@ config CPU_ARM926T
 	bool "Support ARM926T processor" if ARCH_INTEGRATOR || MACH_REALVIEW_EB
 	select CPU_32v5
 	select CPU_ABRT_EV5TJ
-	select CPU_PABRT_LEGACY
 	select CPU_CACHE_VIVT
-	select CPU_CP15_MMU
 	select CPU_COPY_V4WB if MMU
+	select CPU_CP15_MMU
+	select CPU_PABRT_LEGACY
 	select CPU_TLB_V4WBI if MMU
 	help
 	  This is a variant of the ARM920.  It has slightly different
@@ -148,11 +148,11 @@ config CPU_FA526
 	bool
 	select CPU_32v4
 	select CPU_ABRT_EV4
-	select CPU_PABRT_LEGACY
-	select CPU_CACHE_VIVT
-	select CPU_CP15_MMU
 	select CPU_CACHE_FA
+	select CPU_CACHE_VIVT
 	select CPU_COPY_FA if MMU
+	select CPU_CP15_MMU
+	select CPU_PABRT_LEGACY
 	select CPU_TLB_FA if MMU
 	help
 	  The FA526 is a version of the ARMv4 compatible processor with
@@ -167,9 +167,9 @@ config CPU_ARM940T
 	depends on !MMU
 	select CPU_32v4T
 	select CPU_ABRT_NOMMU
-	select CPU_PABRT_LEGACY
 	select CPU_CACHE_VIVT
 	select CPU_CP15_MPU
+	select CPU_PABRT_LEGACY
 	help
 	  ARM940T is a member of the ARM9TDMI family of general-
 	  purpose microprocessors with MPU and separate 4KB
@@ -185,9 +185,9 @@ config CPU_ARM946E
 	depends on !MMU
 	select CPU_32v5
 	select CPU_ABRT_NOMMU
-	select CPU_PABRT_LEGACY
 	select CPU_CACHE_VIVT
 	select CPU_CP15_MPU
+	select CPU_PABRT_LEGACY
 	help
 	  ARM946E-S is a member of the ARM9E-S family of high-
 	  performance, 32-bit system-on-chip processor solutions.
@@ -201,11 +201,11 @@ config CPU_ARM1020
 	bool "Support ARM1020T (rev 0) processor" if ARCH_INTEGRATOR
 	select CPU_32v5
 	select CPU_ABRT_EV4T
-	select CPU_PABRT_LEGACY
 	select CPU_CACHE_V4WT
 	select CPU_CACHE_VIVT
-	select CPU_CP15_MMU
 	select CPU_COPY_V4WB if MMU
+	select CPU_CP15_MMU
+	select CPU_PABRT_LEGACY
 	select CPU_TLB_V4WBI if MMU
 	help
 	  The ARM1020 is the 32K cached version of the ARM10 processor,
@@ -217,25 +217,25 @@ config CPU_ARM1020
 # ARM1020E - needs validating
 config CPU_ARM1020E
 	bool "Support ARM1020E processor" if ARCH_INTEGRATOR
+	depends on n
 	select CPU_32v5
 	select CPU_ABRT_EV4T
-	select CPU_PABRT_LEGACY
 	select CPU_CACHE_V4WT
 	select CPU_CACHE_VIVT
-	select CPU_CP15_MMU
 	select CPU_COPY_V4WB if MMU
+	select CPU_CP15_MMU
+	select CPU_PABRT_LEGACY
 	select CPU_TLB_V4WBI if MMU
-	depends on n
 
 # ARM1022E
 config CPU_ARM1022
 	bool "Support ARM1022E processor" if ARCH_INTEGRATOR
 	select CPU_32v5
 	select CPU_ABRT_EV4T
-	select CPU_PABRT_LEGACY
 	select CPU_CACHE_VIVT
-	select CPU_CP15_MMU
 	select CPU_COPY_V4WB if MMU # can probably do better
+	select CPU_CP15_MMU
+	select CPU_PABRT_LEGACY
 	select CPU_TLB_V4WBI if MMU
 	help
 	  The ARM1022E is an implementation of the ARMv5TE architecture
@@ -250,10 +250,10 @@ config CPU_ARM1026
 	bool "Support ARM1026EJ-S processor" if ARCH_INTEGRATOR
 	select CPU_32v5
 	select CPU_ABRT_EV5T # But need Jazelle, but EV5TJ ignores bit 10
-	select CPU_PABRT_LEGACY
 	select CPU_CACHE_VIVT
-	select CPU_CP15_MMU
 	select CPU_COPY_V4WB if MMU # can probably do better
+	select CPU_CP15_MMU
+	select CPU_PABRT_LEGACY
 	select CPU_TLB_V4WBI if MMU
 	help
 	  The ARM1026EJ-S is an implementation of the ARMv5TEJ architecture
@@ -268,11 +268,11 @@ config CPU_SA110
 	select CPU_32v3 if ARCH_RPC
 	select CPU_32v4 if !ARCH_RPC
 	select CPU_ABRT_EV4
-	select CPU_PABRT_LEGACY
 	select CPU_CACHE_V4WB
 	select CPU_CACHE_VIVT
-	select CPU_CP15_MMU
 	select CPU_COPY_V4WB if MMU
+	select CPU_CP15_MMU
+	select CPU_PABRT_LEGACY
 	select CPU_TLB_V4WB if MMU
 	help
 	  The Intel StrongARM(R) SA-110 is a 32-bit microprocessor and
@@ -288,10 +288,10 @@ config CPU_SA1100
 	bool
 	select CPU_32v4
 	select CPU_ABRT_EV4
-	select CPU_PABRT_LEGACY
 	select CPU_CACHE_V4WB
 	select CPU_CACHE_VIVT
 	select CPU_CP15_MMU
+	select CPU_PABRT_LEGACY
 	select CPU_TLB_V4WB if MMU
 
 # XScale
@@ -299,9 +299,9 @@ config CPU_XSCALE
 	bool
 	select CPU_32v5
 	select CPU_ABRT_EV5T
-	select CPU_PABRT_LEGACY
 	select CPU_CACHE_VIVT
 	select CPU_CP15_MMU
+	select CPU_PABRT_LEGACY
 	select CPU_TLB_V4WBI if MMU
 
 # XScale Core Version 3
@@ -309,9 +309,9 @@ config CPU_XSC3
 	bool
 	select CPU_32v5
 	select CPU_ABRT_EV5T
-	select CPU_PABRT_LEGACY
 	select CPU_CACHE_VIVT
 	select CPU_CP15_MMU
+	select CPU_PABRT_LEGACY
 	select CPU_TLB_V4WBI if MMU
 	select IO_36
 
@@ -320,21 +320,21 @@ config CPU_MOHAWK
 	bool
 	select CPU_32v5
 	select CPU_ABRT_EV5T
-	select CPU_PABRT_LEGACY
 	select CPU_CACHE_VIVT
+	select CPU_COPY_V4WB if MMU
 	select CPU_CP15_MMU
+	select CPU_PABRT_LEGACY
 	select CPU_TLB_V4WBI if MMU
-	select CPU_COPY_V4WB if MMU
 
 # Feroceon
 config CPU_FEROCEON
 	bool
 	select CPU_32v5
 	select CPU_ABRT_EV5T
-	select CPU_PABRT_LEGACY
 	select CPU_CACHE_VIVT
-	select CPU_CP15_MMU
 	select CPU_COPY_FEROCEON if MMU
+	select CPU_CP15_MMU
+	select CPU_PABRT_LEGACY
 	select CPU_TLB_FEROCEON if MMU
 
 config CPU_FEROCEON_OLD_ID
@@ -349,20 +349,20 @@ config CPU_FEROCEON_OLD_ID
 # Marvell PJ4
 config CPU_PJ4
 	bool
-	select CPU_V7
 	select ARM_THUMBEE
+	select CPU_V7
 
 # ARMv6
 config CPU_V6
 	bool "Support ARM V6 processor" if ARCH_INTEGRATOR || MACH_REALVIEW_EB || MACH_REALVIEW_PBX
 	select CPU_32v6
 	select CPU_ABRT_EV6
-	select CPU_PABRT_V6
 	select CPU_CACHE_V6
 	select CPU_CACHE_VIPT
+	select CPU_COPY_V6 if MMU
 	select CPU_CP15_MMU
 	select CPU_HAS_ASID if MMU
-	select CPU_COPY_V6 if MMU
+	select CPU_PABRT_V6
 	select CPU_TLB_V6 if MMU
 
 # ARMv6k
@@ -371,12 +371,12 @@ config CPU_V6K
 	select CPU_32v6
 	select CPU_32v6K
 	select CPU_ABRT_EV6
-	select CPU_PABRT_V6
 	select CPU_CACHE_V6
 	select CPU_CACHE_VIPT
+	select CPU_COPY_V6 if MMU
 	select CPU_CP15_MMU
 	select CPU_HAS_ASID if MMU
-	select CPU_COPY_V6 if MMU
+	select CPU_PABRT_V6
 	select CPU_TLB_V6 if MMU
 
 # ARMv7
@@ -385,44 +385,44 @@ config CPU_V7
 	select CPU_32v6K
 	select CPU_32v7
 	select CPU_ABRT_EV7
-	select CPU_PABRT_V7
 	select CPU_CACHE_V7
 	select CPU_CACHE_VIPT
+	select CPU_COPY_V6 if MMU
 	select CPU_CP15_MMU
 	select CPU_HAS_ASID if MMU
-	select CPU_COPY_V6 if MMU
+	select CPU_PABRT_V7
 	select CPU_TLB_V7 if MMU
 
 # Figure out what processor architecture version we should be using.
 # This defines the compiler instruction set which depends on the machine type.
 config CPU_32v3
 	bool
-	select TLS_REG_EMUL if SMP || !MMU
-	select NEEDS_SYSCALL_FOR_CMPXCHG if SMP
 	select CPU_USE_DOMAINS if MMU
+	select NEEDS_SYSCALL_FOR_CMPXCHG if SMP
+	select TLS_REG_EMUL if SMP || !MMU
 
 config CPU_32v4
 	bool
-	select TLS_REG_EMUL if SMP || !MMU
-	select NEEDS_SYSCALL_FOR_CMPXCHG if SMP
 	select CPU_USE_DOMAINS if MMU
+	select NEEDS_SYSCALL_FOR_CMPXCHG if SMP
+	select TLS_REG_EMUL if SMP || !MMU
 
 config CPU_32v4T
 	bool
-	select TLS_REG_EMUL if SMP || !MMU
-	select NEEDS_SYSCALL_FOR_CMPXCHG if SMP
 	select CPU_USE_DOMAINS if MMU
+	select NEEDS_SYSCALL_FOR_CMPXCHG if SMP
+	select TLS_REG_EMUL if SMP || !MMU
 
 config CPU_32v5
 	bool
-	select TLS_REG_EMUL if SMP || !MMU
-	select NEEDS_SYSCALL_FOR_CMPXCHG if SMP
 	select CPU_USE_DOMAINS if MMU
+	select NEEDS_SYSCALL_FOR_CMPXCHG if SMP
+	select TLS_REG_EMUL if SMP || !MMU
 
 config CPU_32v6
 	bool
-	select TLS_REG_EMUL if !CPU_32v6K && !MMU
 	select CPU_USE_DOMAINS if CPU_V6 && MMU
+	select TLS_REG_EMUL if !CPU_32v6K && !MMU
 
 config CPU_32v6K
 	bool
@@ -644,8 +644,8 @@ config ARM_VIRT_EXT
 config SWP_EMULATE
 	bool "Emulate SWP/SWPB instructions"
 	depends on !CPU_USE_DOMAINS && CPU_V7
-	select HAVE_PROC_CPU if PROC_FS
 	default y if SMP
+	select HAVE_PROC_CPU if PROC_FS
 	help
 	  ARMv6 architecture deprecates use of the SWP/SWPB instructions.
 	  ARMv7 multiprocessing extensions introduce the ability to disable
diff --git a/arch/arm/plat-mxc/Kconfig b/arch/arm/plat-mxc/Kconfig
index baf9064..88e1e2e 100644
--- a/arch/arm/plat-mxc/Kconfig
+++ b/arch/arm/plat-mxc/Kconfig
@@ -10,16 +10,16 @@ choice
 
 config ARCH_IMX_V4_V5
 	bool "i.MX1, i.MX21, i.MX25, i.MX27"
-	select AUTO_ZRELADDR if !ZBOOT_ROM
 	select ARM_PATCH_PHYS_VIRT
+	select AUTO_ZRELADDR if !ZBOOT_ROM
 	help
 	  This enables support for systems based on the Freescale i.MX ARMv4
 	  and ARMv5 SoCs
 
 config ARCH_IMX_V6_V7
 	bool "i.MX3, i.MX5, i.MX6"
-	select AUTO_ZRELADDR if !ZBOOT_ROM
 	select ARM_PATCH_PHYS_VIRT
+	select AUTO_ZRELADDR if !ZBOOT_ROM
 	select MIGHT_HAVE_CACHE_L2X0
 	help
 	  This enables support for systems based on the Freescale i.MX3, i.MX5
diff --git a/arch/arm/plat-mxc/devices/Kconfig b/arch/arm/plat-mxc/devices/Kconfig
index 6b46cee..a35d984 100644
--- a/arch/arm/plat-mxc/devices/Kconfig
+++ b/arch/arm/plat-mxc/devices/Kconfig
@@ -3,8 +3,8 @@ config IMX_HAVE_PLATFORM_FEC
 	default y if ARCH_MX25 || SOC_IMX27 || SOC_IMX35 || SOC_IMX50 || SOC_IMX51 || SOC_IMX53
 
 config IMX_HAVE_PLATFORM_FLEXCAN
-	select HAVE_CAN_FLEXCAN if CAN
 	bool
+	select HAVE_CAN_FLEXCAN if CAN
 
 config IMX_HAVE_PLATFORM_FSL_USB2_UDC
 	bool
diff --git a/arch/arm/plat-nomadik/Kconfig b/arch/arm/plat-nomadik/Kconfig
index 4c48c8b..19f55ca 100644
--- a/arch/arm/plat-nomadik/Kconfig
+++ b/arch/arm/plat-nomadik/Kconfig
@@ -5,8 +5,8 @@
 config PLAT_NOMADIK
 	bool
 	depends on ARCH_NOMADIK || ARCH_U8500
-	select CLKSRC_MMIO
 	default y
+	select CLKSRC_MMIO
 	help
 	  Common platform code for Nomadik and other ST-Ericsson
 	  platforms.
diff --git a/arch/arm/plat-omap/Kconfig b/arch/arm/plat-omap/Kconfig
index c9d1c36..7cd56ed 100644
--- a/arch/arm/plat-omap/Kconfig
+++ b/arch/arm/plat-omap/Kconfig
@@ -14,10 +14,10 @@ config ARCH_OMAP1
 	select CLKDEV_LOOKUP
 	select CLKSRC_MMIO
 	select GENERIC_IRQ_CHIP
-	select IRQ_DOMAIN
 	select HAVE_IDE
-	select NEED_MACH_MEMORY_H
+	select IRQ_DOMAIN
 	select NEED_MACH_IO_H if PCCARD
+	select NEED_MACH_MEMORY_H
 	help
 	  "Systems based on omap7xx, omap15xx or omap16xx"
 
@@ -25,10 +25,10 @@ config ARCH_OMAP2PLUS
 	bool "TI OMAP2/3/4"
 	select CLKDEV_LOOKUP
 	select GENERIC_IRQ_CHIP
-	select SPARSE_IRQ
 	select OMAP_DM_TIMER
-	select USE_OF
 	select PROC_DEVICETREE if PROC_FS
+	select SPARSE_IRQ
+	select USE_OF
 	help
 	  "Systems based on OMAP2, OMAP3, OMAP4 or OMAP5"
 
@@ -43,8 +43,8 @@ config OMAP_DEBUG_DEVICES
 
 config OMAP_DEBUG_LEDS
 	def_bool y if NEW_LEDS
-	select LEDS_CLASS
 	depends on OMAP_DEBUG_DEVICES
+	select LEDS_CLASS
 
 config POWER_AVS_OMAP
 	bool "AVS(Adaptive Voltage Scaling) support for OMAP IP versions 1&2"
diff --git a/arch/arm/plat-s3c24xx/Kconfig b/arch/arm/plat-s3c24xx/Kconfig
index 21bf6ad..eef3b6a 100644
--- a/arch/arm/plat-s3c24xx/Kconfig
+++ b/arch/arm/plat-s3c24xx/Kconfig
@@ -6,8 +6,8 @@ config PLAT_S3C24XX
 	bool
 	depends on ARCH_S3C24XX
 	default y
-	select NO_IOPORT
 	select ARCH_REQUIRE_GPIOLIB
+	select NO_IOPORT
 	select S3C_DEV_NAND
 	help
 	  Base platform code for any Samsung S3C24XX device
diff --git a/arch/arm/plat-samsung/Kconfig b/arch/arm/plat-samsung/Kconfig
index 9c3b90c..59401e1 100644
--- a/arch/arm/plat-samsung/Kconfig
+++ b/arch/arm/plat-samsung/Kconfig
@@ -7,9 +7,9 @@
 config PLAT_SAMSUNG
 	bool
 	depends on PLAT_S3C24XX || ARCH_S3C64XX || PLAT_S5P
-	select NO_IOPORT
-	select GENERIC_IRQ_CHIP
 	default y
+	select GENERIC_IRQ_CHIP
+	select NO_IOPORT
 	help
 	  Base platform code for all Samsung SoC based systems
 
@@ -17,16 +17,16 @@ config PLAT_S5P
 	bool
 	depends on (ARCH_S5P64X0 || ARCH_S5PC100 || ARCH_S5PV210 || ARCH_EXYNOS)
 	default y
-	select ARM_VIC if !ARCH_EXYNOS
+	select ARCH_REQUIRE_GPIOLIB
 	select ARM_GIC if ARCH_EXYNOS
+	select ARM_VIC if !ARCH_EXYNOS
 	select GIC_NON_BANKED if ARCH_EXYNOS4
 	select NO_IOPORT
-	select ARCH_REQUIRE_GPIOLIB
+	select PLAT_SAMSUNG
 	select S3C_GPIO_TRACK
 	select S5P_GPIO_DRVSTR
-	select SAMSUNG_GPIOLIB_4BIT
-	select PLAT_SAMSUNG
 	select SAMSUNG_CLKSRC
+	select SAMSUNG_GPIOLIB_4BIT
 	select SAMSUNG_IRQ_VIC_TIMER
 	help
 	  Base platform code for Samsung's S5P series SoC.
@@ -423,10 +423,10 @@ config S3C_DMA
 
 config SAMSUNG_DMADEV
 	bool
+	select ARM_AMBA
 	select DMADEVICES
 	select PL330_DMA if (ARCH_EXYNOS5 || ARCH_EXYNOS4 || CPU_S5PV210 || CPU_S5PC100 || \
 					CPU_S5P6450 || CPU_S5P6440)
-	select ARM_AMBA
 	help
 	  Use DMA device engine for PL330 DMAC.
 
diff --git a/arch/arm/plat-spear/Kconfig b/arch/arm/plat-spear/Kconfig
index 4404f82..f8db7b2 100644
--- a/arch/arm/plat-spear/Kconfig
+++ b/arch/arm/plat-spear/Kconfig
@@ -12,10 +12,10 @@ config ARCH_SPEAR13XX
 	bool "ST SPEAr13xx with Device Tree"
 	select ARM_GIC
 	select CPU_V7
-	select USE_OF
 	select HAVE_SMP
 	select MIGHT_HAVE_CACHE_L2X0
 	select PINCTRL
+	select USE_OF
 	help
 	  Supports for ARM's SPEAR13XX family
 
@@ -23,8 +23,8 @@ config ARCH_SPEAR3XX
 	bool "ST SPEAr3xx with Device Tree"
 	select ARM_VIC
 	select CPU_ARM926T
-	select USE_OF
 	select PINCTRL
+	select USE_OF
 	help
 	  Supports for ARM's SPEAR3XX family
 
-- 
1.7.4.4
