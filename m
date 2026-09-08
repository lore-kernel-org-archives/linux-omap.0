Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01BB2548576;
	Tue,  8 Sep 2026 15:28:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788881350; cv=none; b=LydR8QK0wWN9EMmq0Pomrp7x1VbpEsz90FSyOwL7WAsEsWOwV7+7XfYTa0aBEeSSnwhhzY/7RFnUS8iHQGIlqcErNvvjIbyx/llicNzqG9FSuhFP10hWaw1CRAb0DV5+S0FGU3upZu+ipotRZDhcqNLH3eipdU8Jivkb7Y50JvE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788881350; c=relaxed/simple;
	bh=vFfgjr6ltCBelkiWp2GoC1nGJ3emYI0GnknKdNkUWdY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OqRxpk0NWN8pL+3HoZHt1B/winKL9ETMAzTCWdUrvTDsEBGD3AtuHNiAk7DcxlvNr2JEBH+t9BBDUVFt9ZrPSt4RpJM9J74O+BR9rlOu3n2p9nTX95Ra63VTmuCEWMiebQv/Qiy07+oprW7YCrRGREME9uTHWdceUzO8VgMOM1k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RIQLr6Ac; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RIQLr6Ac"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 78F921F00A3E;
	Tue,  8 Sep 2026 15:28:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788881334;
	bh=B6MPXxVgkUk6FY+h8Jyr5b4zEhvKeVnYuus9oQC0Eyc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=RIQLr6Acl55qaF2GYejnmnw9Xe/62W286Tcb+npGet2lFUmSPok1OcOUKtMn744zZ
	 JOB1RQeawdAmY9Xw6c/XAXrfJDwEwhs5eknNnFKeUV58nAukWYdYoPlJDeqJDZCS/k
	 lscGKZqkb0e+6imYyik9DgmONoAO1K6dybV9drkTznk7htFkYDDzdBhDVLLYI0mtF/
	 Bm0eJeAXNho6WYTW48Z65vZC65IEDVVVZcVjV9rpf5S887LZ34Mu93Ltf3GlQkei4O
	 bNGTCFe8nMKij2Opp/VEmoME6aWjVTZUSpeezgCUTVG+JySOAuaD1fAOG0yhMoXLkD
	 iIPTfOUURgiGA==
From: Arnd Bergmann <arnd@kernel.org>
To: Krzysztof Kozlowski <krzk@kernel.org>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	Linus Walleij <linusw@kernel.org>,
	Russell King <linux@armlinux.org.uk>
Cc: Drew Fustini <fustini@kernel.org>,
	Arnd Bergmann <arnd@arndb.de>,
	Rob Herring <robh@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Liviu Dudau <liviu.dudau@arm.com>,
	Sudeep Holla <sudeep.holla@kernel.org>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Frank Li <Frank.Li@nxp.com>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	Vladimir Zapolskiy <vz@mleia.com>,
	Stefan Agner <stefan@agner.ch>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Aaro Koskinen <aaro.koskinen@iki.fi>,
	Andreas Kemnade <andreas@kemnade.info>,
	Kevin Hilman <khilman@baylibre.com>,
	Roger Quadros <rogerq@kernel.org>,
	Tony Lindgren <tony@atomide.com>,
	Nicolas Ferre <nicolas.ferre@microchip.com>,
	Claudiu Beznea <claudiu.beznea@tuxon.dev>,
	Andrew Lunn <andrew@lunn.ch>,
	Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
	Gregory Clement <gregory.clement@bootlin.com>,
	Robert Jarzmik <robert.jarzmik@free.fr>,
	Kristoffer Ericson <kristoffer.ericson@gmail.com>,
	Ethan Nelson-Moore <enelsonmoore@gmail.com>,
	Geert Uytterhoeven <geert@linux-m68k.org>,
	Alexander Sverdlin <alexander.sverdlin@siemens.com>,
	Shawn Guo <shawnguo@kernel.org>,
	Karl Mehltretter <kmehltretter@gmail.com>,
	"David Hildenbrand (Arm)" <david@kernel.org>,
	Nicolas Pitre <npitre@baylibre.com>,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	devicetree@vger.kernel.org,
	imx@lists.linux.dev,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-omap@vger.kernel.org,
	Ralph Siemsen <ralphs@netwinder.org>,
	Helge Deller <deller@gmx.de>,
	dri-devel@lists.freedesktop.org
Subject: [PATCH 02/13] ARM: remove footbridge
Date: Tue,  8 Sep 2026 17:27:52 +0200
Message-ID: <20260908152808.3928630-3-arnd@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260908152808.3928630-1-arnd@kernel.org>
References: <20260908152808.3928630-1-arnd@kernel.org>
Precedence: bulk
X-Mailing-List: linux-omap@vger.kernel.org
List-Id: <linux-omap.vger.kernel.org>
List-Subscribe: <mailto:linux-omap+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-omap+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Arnd Bergmann <arnd@arndb.de>

Footbridge was deprecated in 7.3 to be removed along with the other
StrongARM platforms and most remaining board files.

The main machine here is the NetWinder, which was a popular Arm based
desktop PC in the late 1990s and contributed to Arm's later success as
an embedded Linux platform, but was discontinued over 25 years ago and
is no longer all that useful.

I previously tried to convert this to devicetree in a sensible way but
gave up due to the platform being too different from modern SoC based
targets.

Cc: Russell King <linux@armlinux.org.uk>
Cc: Ralph Siemsen <ralphs@netwinder.org>
Cc: Helge Deller <deller@gmx.de>
Cc: dri-devel@lists.freedesktop.org
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 Documentation/arch/arm/index.rst              |   1 -
 Documentation/arch/arm/netwinder.rst          |  85 --
 MAINTAINERS                                   |   8 -
 arch/arm/Kconfig                              |  17 +-
 arch/arm/Kconfig.debug                        |  27 +-
 arch/arm/Makefile                             |   2 -
 arch/arm/boot/bootp/Makefile                  |   1 -
 arch/arm/configs/footbridge_defconfig         | 114 ---
 arch/arm/configs/netwinder_defconfig          |  88 --
 arch/arm/include/asm/hardware/dec21285.h      | 138 ----
 arch/arm/include/asm/mach/pci.h               |  14 -
 arch/arm/include/debug/dc21285.S              |  41 -
 arch/arm/kernel/atags_parse.c                 |  18 -
 arch/arm/kernel/bios32.c                      |  12 -
 arch/arm/kernel/head.S                        |  10 -
 arch/arm/mach-footbridge/Kconfig              |  57 --
 arch/arm/mach-footbridge/Makefile             |  18 -
 arch/arm/mach-footbridge/common.c             | 280 -------
 arch/arm/mach-footbridge/common.h             |  15 -
 arch/arm/mach-footbridge/dc21285-timer.c      | 136 ---
 arch/arm/mach-footbridge/dc21285.c            | 360 --------
 arch/arm/mach-footbridge/dma-isa.c            | 230 ------
 arch/arm/mach-footbridge/ebsa285-pci.c        |  48 --
 arch/arm/mach-footbridge/ebsa285.c            | 124 ---
 .../mach-footbridge/include/mach/hardware.h   |  90 --
 arch/arm/mach-footbridge/include/mach/irqs.h  |  97 ---
 .../mach-footbridge/include/mach/isa-dma.h    |  18 -
 .../arm/mach-footbridge/include/mach/memory.h |  26 -
 .../mach-footbridge/include/mach/uncompress.h |  34 -
 arch/arm/mach-footbridge/isa-irq.c            | 177 ----
 arch/arm/mach-footbridge/isa-rtc.c            |  57 --
 arch/arm/mach-footbridge/isa-timer.c          |  36 -
 arch/arm/mach-footbridge/isa.c                |  94 ---
 arch/arm/mach-footbridge/netwinder-hw.c       | 772 ------------------
 arch/arm/mach-footbridge/netwinder-pci.c      |  62 --
 drivers/video/console/Kconfig                 |   6 +-
 drivers/video/console/dummycon.c              |   6 -
 drivers/video/fbdev/cyber2000fb.c             |  10 -
 38 files changed, 12 insertions(+), 3317 deletions(-)
 delete mode 100644 Documentation/arch/arm/netwinder.rst
 delete mode 100644 arch/arm/configs/footbridge_defconfig
 delete mode 100644 arch/arm/configs/netwinder_defconfig
 delete mode 100644 arch/arm/include/asm/hardware/dec21285.h
 delete mode 100644 arch/arm/include/debug/dc21285.S
 delete mode 100644 arch/arm/mach-footbridge/Kconfig
 delete mode 100644 arch/arm/mach-footbridge/Makefile
 delete mode 100644 arch/arm/mach-footbridge/common.c
 delete mode 100644 arch/arm/mach-footbridge/common.h
 delete mode 100644 arch/arm/mach-footbridge/dc21285-timer.c
 delete mode 100644 arch/arm/mach-footbridge/dc21285.c
 delete mode 100644 arch/arm/mach-footbridge/dma-isa.c
 delete mode 100644 arch/arm/mach-footbridge/ebsa285-pci.c
 delete mode 100644 arch/arm/mach-footbridge/ebsa285.c
 delete mode 100644 arch/arm/mach-footbridge/include/mach/hardware.h
 delete mode 100644 arch/arm/mach-footbridge/include/mach/irqs.h
 delete mode 100644 arch/arm/mach-footbridge/include/mach/isa-dma.h
 delete mode 100644 arch/arm/mach-footbridge/include/mach/memory.h
 delete mode 100644 arch/arm/mach-footbridge/include/mach/uncompress.h
 delete mode 100644 arch/arm/mach-footbridge/isa-irq.c
 delete mode 100644 arch/arm/mach-footbridge/isa-rtc.c
 delete mode 100644 arch/arm/mach-footbridge/isa-timer.c
 delete mode 100644 arch/arm/mach-footbridge/isa.c
 delete mode 100644 arch/arm/mach-footbridge/netwinder-hw.c
 delete mode 100644 arch/arm/mach-footbridge/netwinder-pci.c

diff --git a/Documentation/arch/arm/index.rst b/Documentation/arch/arm/index.rst
index a292b8ac41ce..17d6a5bbfc26 100644
--- a/Documentation/arch/arm/index.rst
+++ b/Documentation/arch/arm/index.rst
@@ -38,7 +38,6 @@ SoC-specific documents
    marvell
    microchip
 
-   netwinder
    nwfpe/index
 
    keystone/overview
diff --git a/Documentation/arch/arm/netwinder.rst b/Documentation/arch/arm/netwinder.rst
deleted file mode 100644
index 8eab66caa2ac..000000000000
--- a/Documentation/arch/arm/netwinder.rst
+++ /dev/null
@@ -1,85 +0,0 @@
-================================
-NetWinder specific documentation
-================================
-
-The NetWinder is a small low-power computer, primarily designed
-to run Linux.  It is based around the StrongARM RISC processor,
-DC21285 PCI bridge, with PC-type hardware glued around it.
-
-Port usage
-==========
-
-=======  ====== ===============================
-Min      Max	Description
-=======  ====== ===============================
-0x0000   0x000f	DMA1
-0x0020   0x0021	PIC1
-0x0060   0x006f	Keyboard
-0x0070   0x007f	RTC
-0x0080   0x0087	DMA1
-0x0088   0x008f	DMA2
-0x00a0   0x00a3	PIC2
-0x00c0   0x00df	DMA2
-0x0180   0x0187	IRDA
-0x01f0   0x01f6	ide0
-0x0201		Game port
-0x0203		RWA010 configuration read
-0x0220   ?	SoundBlaster
-0x0250   ?	WaveArtist
-0x0279		RWA010 configuration index
-0x02f8   0x02ff	Serial ttyS1
-0x0300   0x031f	Ether10
-0x0338		GPIO1
-0x033a		GPIO2
-0x0370   0x0371	W83977F configuration registers
-0x0388   ?	AdLib
-0x03c0   0x03df	VGA
-0x03f6		ide0
-0x03f8   0x03ff	Serial ttyS0
-0x0400   0x0408	DC21143
-0x0480   0x0487	DMA1
-0x0488   0x048f	DMA2
-0x0a79		RWA010 configuration write
-0xe800   0xe80f	ide0/ide1 BM DMA
-=======  ====== ===============================
-
-
-Interrupt usage
-===============
-
-======= ======= ========================
-IRQ	type	Description
-======= ======= ========================
- 0	ISA	100Hz timer
- 1	ISA	Keyboard
- 2	ISA	cascade
- 3	ISA	Serial ttyS1
- 4	ISA	Serial ttyS0
- 5	ISA	PS/2 mouse
- 6	ISA	IRDA
- 7	ISA	Printer
- 8	ISA	RTC alarm
- 9	ISA
-10	ISA	GP10 (Orange reset button)
-11	ISA
-12	ISA	WaveArtist
-13	ISA
-14	ISA	hda1
-15	ISA
-======= ======= ========================
-
-DMA usage
-=========
-
-======= ======= ===========
-DMA	type	Description
-======= ======= ===========
- 0	ISA	IRDA
- 1	ISA
- 2	ISA	cascade
- 3	ISA	WaveArtist
- 4	ISA
- 5	ISA
- 6	ISA
- 7	ISA	WaveArtist
-======= ======= ===========
diff --git a/MAINTAINERS b/MAINTAINERS
index fd213c4bc257..4380d5660402 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -2924,14 +2924,6 @@ S:	Maintained
 T:	git git://git.berlios.de/gemini-board
 F:	arch/arm/mm/*-fa*
 
-ARM/FOOTBRIDGE ARCHITECTURE
-M:	Russell King <linux@armlinux.org.uk>
-L:	linux-arm-kernel@lists.infradead.org (moderated for non-subscribers)
-S:	Maintained
-W:	http://www.armlinux.org.uk/
-F:	arch/arm/include/asm/hardware/dec21285.h
-F:	arch/arm/mach-footbridge/
-
 ARM/FREESCALE IMX / MXC / LAYERSCAPE ARM ARCHITECTURE
 M:	Frank Li <Frank.Li@nxp.com>
 M:	Sascha Hauer <s.hauer@pengutronix.de>
diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index 7f4c2973d630..c3d6b8abc815 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -55,7 +55,7 @@ config ARM
 	select ARCH_WANT_LD_ORPHAN_WARN
 	select BINFMT_FLAT_ARGVP_ENVP_ON_STACK
 	select BUILDTIME_TABLE_SORT if MMU
-	select COMMON_CLK if !(ARCH_RPC || ARCH_FOOTBRIDGE)
+	select COMMON_CLK if !ARCH_RPC
 	select CLONE_BACKWARDS
 	select CPU_PM if SUSPEND || CPU_IDLE
 	select DCACHE_WORD_ACCESS if HAVE_EFFICIENT_UNALIGNED_ACCESS
@@ -155,13 +155,13 @@ config ARM
 	select PCI_SYSCALL if PCI
 	select PERF_USE_VMALLOC
 	select RTC_LIB
-	select SPARSE_IRQ if !(ARCH_FOOTBRIDGE || ARCH_RPC)
+	select SPARSE_IRQ if !ARCH_RPC
 	select SYS_SUPPORTS_APM_EMULATION
 	select THREAD_INFO_IN_TASK
 	select TIMER_OF if OF
 	select HAVE_ARCH_VMAP_STACK if MMU && ARM_HAS_GROUP_RELOCS
 	select TRACE_IRQFLAGS_SUPPORT if !CPU_V7M
-	select USE_OF if !(ARCH_FOOTBRIDGE || ARCH_RPC)
+	select USE_OF if !ARCH_RPC
 	# Above selects are sorted alphabetically; please add new ones
 	# according to that.  Thanks.
 	help
@@ -295,7 +295,6 @@ config PHYS_OFFSET
 	hex "Physical address of main memory" if MMU
 	depends on !ARM_PATCH_PHYS_VIRT || !AUTO_ZRELADDR
 	default DRAM_BASE if !MMU
-	default 0x00000000 if ARCH_FOOTBRIDGE
 	default 0x10000000 if ARCH_OMAP1 || ARCH_RPC
 	default 0xa0000000 if ARCH_PXA
 	default 0xc0000000 if ARCH_EP93XX
@@ -338,7 +337,7 @@ config ARCH_MMAP_RND_BITS_MAX
 
 config ARCH_MULTIPLATFORM
 	bool "Require kernel to be portable to multiple machines" if EXPERT
-	depends on MMU && !(ARCH_FOOTBRIDGE || ARCH_RPC)
+	depends on MMU && !ARCH_RPC
 	default y
 	help
 	  In general, all Arm machines can be supported in a single
@@ -380,14 +379,10 @@ source "arch/arm/mach-davinci/Kconfig"
 
 source "arch/arm/mach-digicolor/Kconfig"
 
-source "arch/arm/mach-dove/Kconfig"
-
 source "arch/arm/mach-ep93xx/Kconfig"
 
 source "arch/arm/mach-exynos/Kconfig"
 
-source "arch/arm/mach-footbridge/Kconfig"
-
 source "arch/arm/mach-gemini/Kconfig"
 
 source "arch/arm/mach-highbank/Kconfig"
@@ -1199,7 +1194,7 @@ config ARCH_FLATMEM_ENABLE
 	def_bool !ARCH_RPC
 
 config ARCH_SPARSEMEM_ENABLE
-	def_bool !ARCH_FOOTBRIDGE
+	def_bool y
 	select SPARSEMEM_STATIC if SPARSEMEM
 
 config HIGHMEM
@@ -1599,7 +1594,7 @@ config ARCH_DEFAULT_CRASH_DUMP
 
 config AUTO_ZRELADDR
 	bool "Auto calculation of the decompressed kernel image address" if !ARCH_MULTIPLATFORM
-	default !(ARCH_FOOTBRIDGE || ARCH_RPC)
+	default !ARCH_RPC
 	help
 	  ZRELADDR is the physical address where the decompressed kernel
 	  image will be placed. If AUTO_ZRELADDR is selected, the address
diff --git a/arch/arm/Kconfig.debug b/arch/arm/Kconfig.debug
index ad0feced4369..f2a80955b7a0 100644
--- a/arch/arm/Kconfig.debug
+++ b/arch/arm/Kconfig.debug
@@ -324,13 +324,6 @@ choice
 		  Say Y here if you want the debug print routines to direct
 		  their output to UART2 serial port on DaVinci DA8XX devices.
 
-	config DEBUG_DC21285_PORT
-		bool "Kernel low-level debugging messages via footbridge serial port"
-		depends on FOOTBRIDGE
-		help
-		  Say Y here if you want the debug print routines to direct
-		  their output to the serial port in the DC21285 (Footbridge).
-
 	config DEBUG_DIGICOLOR_UA0
 		bool "Kernel low-level debugging messages via Digicolor UA0"
 		depends on ARCH_DIGICOLOR
@@ -346,14 +339,6 @@ choice
 		  Say Y here if you want kernel low-level debugging support
 		  on Cirrus Logic EP93xx based platforms.
 
-	config DEBUG_FOOTBRIDGE_COM1
-		bool "Kernel low-level debugging messages via footbridge 8250 at PCI COM1"
-		depends on FOOTBRIDGE
-		select DEBUG_UART_8250
-		help
-		  Say Y here if you want the debug print routines to direct
-		  their output to the 8250 at PCI COM1.
-
 	config DEBUG_GEMINI
 		bool "Kernel low-level debugging messages via Cortina Systems Gemini UART"
 		depends on ARCH_GEMINI
@@ -1461,7 +1446,7 @@ config DEBUG_STM32_UART
 config DEBUG_UART_FLOW_CONTROL
 	bool "Enable flow control (CTS) for the debug UART"
 	depends on DEBUG_LL
-	default y if DEBUG_FOOTBRIDGE_COM1 || DEBUG_GEMINI || ARCH_RPC
+	default y if DEBUG_GEMINI || ARCH_RPC
 	help
 	  Some UART ports are connected to terminals that will use modem
 	  control signals to indicate whether they are ready to receive text.
@@ -1476,7 +1461,6 @@ config DEBUG_LL_INCLUDE
 	default "debug/at91.S" if DEBUG_AT91_UART
 	default "debug/asm9260.S" if DEBUG_ASM9260_UART
 	default "debug/clps711x.S" if DEBUG_CLPS711X_UART1 || DEBUG_CLPS711X_UART2
-	default "debug/dc21285.S" if DEBUG_DC21285_PORT
 	default "debug/meson.S" if DEBUG_MESON_UARTAO
 	default "debug/pl01x.S" if DEBUG_LL_UART_PL01X || DEBUG_UART_PL01X
 	default "debug/exynos.S" if DEBUG_EXYNOS_UART
@@ -1590,7 +1574,6 @@ config DEBUG_UART_PHYS
 	default 0x4806e000 if DEBUG_OMAP2UART3 || DEBUG_OMAP4UART4
 	default 0x49020000 if DEBUG_OMAP3UART3
 	default 0x49042000 if DEBUG_OMAP3UART4
-	default 0x7c0003f8 if DEBUG_FOOTBRIDGE_COM1
 	default 0x7f005000 if DEBUG_S3C64XX_UART && DEBUG_S3C_UART0
 	default 0x7f005400 if DEBUG_S3C64XX_UART && DEBUG_S3C_UART1
 	default 0x7f005800 if DEBUG_S3C64XX_UART && DEBUG_S3C_UART2
@@ -1748,7 +1731,6 @@ config DEBUG_UART_VIRT
 	default 0xfed64000 if DEBUG_RK29_UART1 || DEBUG_RK3X_UART2
 	default 0xfed68000 if DEBUG_RK29_UART2 || DEBUG_RK3X_UART3
 	default 0xfedc0000 if DEBUG_EP93XX
-	default 0xfee003f8 if DEBUG_FOOTBRIDGE_COM1
 	default 0xfee20000 if DEBUG_NSPIRE_CLASSIC_UART || DEBUG_NSPIRE_CX_UART
 	default 0xfec00000 if ARCH_IXP4XX && !CPU_BIG_ENDIAN
 	default 0xfec00003 if ARCH_IXP4XX && CPU_BIG_ENDIAN
@@ -1771,8 +1753,7 @@ config DEBUG_UART_VIRT
 config DEBUG_UART_8250_SHIFT
 	int "Register offset shift for the 8250 debug UART"
 	depends on DEBUG_LL_UART_8250 || DEBUG_UART_8250
-	default 0 if DEBUG_FOOTBRIDGE_COM1 || DEBUG_BCM_5301X || \
-		DEBUG_BCM_HR2
+	default 0 if DEBUG_BCM_5301X || DEBUG_BCM_HR2
 	default 3 if DEBUG_MSTARV7_PMUART
 	default 2
 
@@ -1798,7 +1779,7 @@ config DEBUG_UART_8250_PALMCHIP
 config DEBUG_UNCOMPRESS
 	bool "Enable decompressor debugging via DEBUG_LL output"
 	depends on !ARCH_MULTIPLATFORM
-	depends on !(ARCH_FOOTBRIDGE || ARCH_RPC)
+	depends on !ARCH_RPC
 	depends on DEBUG_LL && !DEBUG_OMAP2PLUS_UART && \
 		     (!DEBUG_TEGRA_UART || !ZBOOT_ROM) && \
 		     !DEBUG_BRCMSTB_UART && !DEBUG_SEMIHOSTING
@@ -1808,7 +1789,7 @@ config DEBUG_UNCOMPRESS
 
 config UNCOMPRESS_INCLUDE
 	string
-	default "mach/uncompress.h" if ARCH_FOOTBRIDGE || ARCH_RPC
+	default "mach/uncompress.h" if ARCH_RPC
 	default "debug/uncompress.h"
 
 config EARLY_PRINTK
diff --git a/arch/arm/Makefile b/arch/arm/Makefile
index ea3da21202c8..f5bc9ad7f6f5 100644
--- a/arch/arm/Makefile
+++ b/arch/arm/Makefile
@@ -181,7 +181,6 @@ machine-$(CONFIG_ARCH_DAVINCI)		+= davinci
 machine-$(CONFIG_ARCH_DIGICOLOR)	+= digicolor
 machine-$(CONFIG_ARCH_DOVE)		+= dove
 machine-$(CONFIG_ARCH_EXYNOS)		+= exynos
-machine-$(CONFIG_ARCH_FOOTBRIDGE)	+= footbridge
 machine-$(CONFIG_ARCH_GEMINI)		+= gemini
 machine-$(CONFIG_ARCH_HIGHBANK)		+= highbank
 machine-$(CONFIG_ARCH_HISI)		+= hisi
@@ -225,7 +224,6 @@ machine-$(CONFIG_PLAT_SPEAR)		+= spear
 
 # legacy platforms provide their own mach/*.h headers globally,
 # these three are mutually exclusive
-machdirs-$(CONFIG_ARCH_FOOTBRIDGE)	+= arch/arm/mach-footbridge
 machdirs-$(CONFIG_ARCH_RPC)		+= arch/arm/mach-rpc
 KBUILD_CPPFLAGS += $(patsubst %,-I$(srctree)/%/include,$(machdirs-y))
 
diff --git a/arch/arm/boot/bootp/Makefile b/arch/arm/boot/bootp/Makefile
index a1a1f4bec783..12c61684b97f 100644
--- a/arch/arm/boot/bootp/Makefile
+++ b/arch/arm/boot/bootp/Makefile
@@ -19,7 +19,6 @@ add_hex = $(shell printf 0x%x $$(( $(1) + $(2) )) )
 PARAMS_PHYS := $(call add_hex, $(PHYS_OFFSET), 0x100)
 
 # guess an initrd location if possible
-initrd_offset-$(CONFIG_ARCH_FOOTBRIDGE)	+= 0x00800000
 initrd_offset-$(CONFIG_ARCH_RPC)	+= 0x08000000
 INITRD_OFFSET := $(initrd_offset-y)
 ifdef INITRD_OFFSET
diff --git a/arch/arm/configs/footbridge_defconfig b/arch/arm/configs/footbridge_defconfig
deleted file mode 100644
index 7fa556fb6cf4..000000000000
--- a/arch/arm/configs/footbridge_defconfig
+++ /dev/null
@@ -1,114 +0,0 @@
-CONFIG_SYSVIPC=y
-CONFIG_BSD_PROCESS_ACCT=y
-CONFIG_LOG_BUF_SHIFT=14
-CONFIG_BLK_DEV_INITRD=y
-CONFIG_EXPERT=y
-# CONFIG_HOTPLUG is not set
-CONFIG_ARCH_MULTI_V4=y
-# CONFIG_ARCH_MULTI_V7 is not set
-CONFIG_ARCH_FOOTBRIDGE=y
-CONFIG_ARCH_EBSA285_HOST=y
-CONFIG_ARCH_NETWINDER=y
-CONFIG_ATAGS=y
-CONFIG_FPE_NWFPE=y
-CONFIG_FPE_NWFPE_XP=y
-# CONFIG_AEABI is not set
-CONFIG_MODULES=y
-CONFIG_PARTITION_ADVANCED=y
-CONFIG_ACORN_PARTITION=y
-CONFIG_ACORN_PARTITION_ADFS=y
-CONFIG_NET=y
-CONFIG_PACKET=y
-CONFIG_UNIX=y
-CONFIG_INET=y
-CONFIG_IP_MULTICAST=y
-CONFIG_IP_PNP=y
-CONFIG_IP_PNP_BOOTP=y
-CONFIG_SYN_COOKIES=y
-# CONFIG_IPV6 is not set
-CONFIG_ATM=y
-CONFIG_PARPORT=y
-CONFIG_PARPORT_PC=y
-CONFIG_PARPORT_PC_FIFO=y
-CONFIG_PARPORT_1284=y
-CONFIG_PNP=y
-CONFIG_ISAPNP=y
-CONFIG_PARIDE=m
-CONFIG_PARIDE_PD=m
-CONFIG_PARIDE_PCD=m
-CONFIG_PARIDE_PF=m
-CONFIG_PARIDE_PT=m
-CONFIG_PARIDE_PG=m
-CONFIG_PARIDE_ATEN=m
-CONFIG_PARIDE_BPCK=m
-CONFIG_PARIDE_COMM=m
-CONFIG_PARIDE_DSTR=m
-CONFIG_PARIDE_FIT2=m
-CONFIG_PARIDE_FIT3=m
-CONFIG_PARIDE_EPAT=m
-CONFIG_PARIDE_EPIA=m
-CONFIG_PARIDE_FRIQ=m
-CONFIG_PARIDE_FRPW=m
-CONFIG_PARIDE_KBIC=m
-CONFIG_PARIDE_KTTI=m
-CONFIG_PARIDE_ON20=m
-CONFIG_PARIDE_ON26=m
-CONFIG_BLK_DEV_LOOP=m
-CONFIG_BLK_DEV_NBD=m
-CONFIG_BLK_DEV_RAM=y
-CONFIG_NETDEVICES=y
-CONFIG_NET_VENDOR_3COM=y
-CONFIG_VORTEX=y
-CONFIG_NET_PCI=y
-CONFIG_NE2K_PCI=y
-CONFIG_PPP=m
-CONFIG_PPP_BSDCOMP=m
-CONFIG_PPP_DEFLATE=m
-CONFIG_PPPOE=m
-CONFIG_PPP_ASYNC=m
-CONFIG_SLIP=m
-CONFIG_SLIP_COMPRESSED=y
-CONFIG_SLIP_SMART=y
-CONFIG_SLIP_MODE_SLIP6=y
-CONFIG_SERIAL_21285=y
-CONFIG_SERIAL_21285_CONSOLE=y
-CONFIG_SERIAL_NONSTANDARD=y
-CONFIG_PRINTER=m
-CONFIG_DS1620=y
-CONFIG_NWBUTTON=y
-CONFIG_NWBUTTON_REBOOT=y
-CONFIG_NWFLASH=m
-CONFIG_I2C=m
-CONFIG_WATCHDOG=y
-CONFIG_SOFT_WATCHDOG=y
-CONFIG_21285_WATCHDOG=m
-CONFIG_977_WATCHDOG=m
-CONFIG_FB=y
-CONFIG_FB_CYBER2000=y
-CONFIG_SOUND=m
-# CONFIG_USB_HID is not set
-CONFIG_USB=m
-CONFIG_USB_MON=m
-CONFIG_USB_PRINTER=m
-CONFIG_NEW_LEDS=y
-CONFIG_LEDS_CLASS=y
-CONFIG_LEDS_TRIGGERS=y
-CONFIG_LEDS_TRIGGER_TIMER=y
-CONFIG_EXT2_FS=y
-CONFIG_AUTOFS_FS=y
-CONFIG_ISO9660_FS=m
-CONFIG_JOLIET=y
-CONFIG_MSDOS_FS=m
-CONFIG_VFAT_FS=m
-CONFIG_ADFS_FS=m
-CONFIG_NFS_FS=y
-CONFIG_ROOT_NFS=y
-CONFIG_NFSD=m
-CONFIG_NLS=y
-CONFIG_NLS_CODEPAGE_437=m
-CONFIG_NLS_CODEPAGE_850=m
-CONFIG_NLS_CODEPAGE_852=m
-CONFIG_NLS_ISO8859_1=m
-CONFIG_NLS_ISO8859_2=m
-CONFIG_NLS_ISO8859_15=m
-CONFIG_DEBUG_USER=y
diff --git a/arch/arm/configs/netwinder_defconfig b/arch/arm/configs/netwinder_defconfig
deleted file mode 100644
index 77d4a2b5916b..000000000000
--- a/arch/arm/configs/netwinder_defconfig
+++ /dev/null
@@ -1,88 +0,0 @@
-CONFIG_SYSVIPC=y
-CONFIG_LOG_BUF_SHIFT=14
-CONFIG_EXPERT=y
-CONFIG_ARCH_MULTI_V4=y
-# CONFIG_ARCH_MULTI_V7 is not set
-CONFIG_ARCH_FOOTBRIDGE=y
-CONFIG_ARCH_NETWINDER=y
-# CONFIG_AEABI is not set
-CONFIG_ATAGS=y
-CONFIG_DEPRECATED_PARAM_STRUCT=y
-CONFIG_CMDLINE="root=0x801"
-CONFIG_FPE_NWFPE=y
-CONFIG_PARTITION_ADVANCED=y
-CONFIG_NET=y
-CONFIG_PACKET=y
-CONFIG_UNIX=y
-CONFIG_INET=y
-CONFIG_IP_PNP=y
-CONFIG_IP_PNP_DHCP=y
-CONFIG_IP_PNP_BOOTP=y
-CONFIG_IP_PNP_RARP=y
-# CONFIG_IPV6 is not set
-CONFIG_NETFILTER=y
-CONFIG_IP_NF_IPTABLES=y
-CONFIG_PARPORT=y
-CONFIG_PARPORT_PC=y
-CONFIG_PARPORT_PC_SUPERIO=y
-CONFIG_BLK_DEV_LOOP=y
-CONFIG_BLK_DEV_SD=y
-CONFIG_ATA=y
-CONFIG_PATA_WINBOND=y
-CONFIG_NETDEVICES=y
-CONFIG_MII=y
-CONFIG_NET_TULIP=y
-CONFIG_TULIP=y
-CONFIG_TULIP_MMIO=y
-CONFIG_NET_PCI=y
-CONFIG_NE2K_PCI=y
-CONFIG_MOUSE_SERIAL=y
-CONFIG_INPUT_MISC=y
-CONFIG_INPUT_UINPUT=y
-CONFIG_SERIAL_8250=y
-CONFIG_SERIAL_8250_CONSOLE=y
-CONFIG_PRINTER=y
-CONFIG_DS1620=y
-CONFIG_NWBUTTON=y
-CONFIG_NWBUTTON_REBOOT=y
-CONFIG_NWFLASH=y
-CONFIG_WATCHDOG=y
-CONFIG_977_WATCHDOG=y
-CONFIG_FB=y
-CONFIG_FB_CYBER2000=y
-CONFIG_FRAMEBUFFER_CONSOLE=y
-CONFIG_LOGO=y
-CONFIG_SOUND=y
-CONFIG_SOUND_PRIME=y
-CONFIG_SOUND_OSS=y
-CONFIG_SOUND_TRACEINIT=y
-CONFIG_SOUND_DMAP=y
-CONFIG_SOUND_YM3812=y
-CONFIG_SOUND_WAVEARTIST=y
-CONFIG_NEW_LEDS=y
-CONFIG_LEDS_CLASS=y
-CONFIG_LEDS_TRIGGERS=y
-CONFIG_LEDS_TRIGGER_CPU=y
-CONFIG_EXT2_FS=y
-CONFIG_ISO9660_FS=y
-CONFIG_JOLIET=y
-CONFIG_TMPFS=y
-CONFIG_NFS_FS=y
-CONFIG_NFS_V3=y
-CONFIG_NFS_V4=y
-CONFIG_ROOT_NFS=y
-CONFIG_NFSD=y
-CONFIG_SMB_FS=y
-CONFIG_NLS_CODEPAGE_437=y
-CONFIG_NLS_CODEPAGE_850=y
-CONFIG_NLS_CODEPAGE_852=y
-CONFIG_NLS_ISO8859_1=y
-CONFIG_NLS_ISO8859_2=y
-CONFIG_NLS_ISO8859_15=y
-CONFIG_NLS_UTF8=y
-CONFIG_FONTS=y
-CONFIG_FONT_8x8=y
-CONFIG_FONT_8x16=y
-CONFIG_DEBUG_KERNEL=y
-CONFIG_MAGIC_SYSRQ=y
-CONFIG_DEBUG_USER=y
diff --git a/arch/arm/include/asm/hardware/dec21285.h b/arch/arm/include/asm/hardware/dec21285.h
deleted file mode 100644
index 894f2a635cbb..000000000000
--- a/arch/arm/include/asm/hardware/dec21285.h
+++ /dev/null
@@ -1,138 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0-only */
-/*
- *  arch/arm/include/asm/hardware/dec21285.h
- *
- *  Copyright (C) 1998 Russell King
- *
- *  DC21285 registers
- */
-#define DC21285_PCI_IACK		0x79000000
-#define DC21285_ARMCSR_BASE		0x42000000
-#define DC21285_PCI_TYPE_0_CONFIG	0x7b000000
-#define DC21285_PCI_TYPE_1_CONFIG	0x7a000000
-#define DC21285_OUTBOUND_WRITE_FLUSH	0x78000000
-#define DC21285_FLASH			0x41000000
-#define DC21285_PCI_IO			0x7c000000
-#define DC21285_PCI_MEM			0x80000000
-
-#ifndef __ASSEMBLY__
-#include <mach/hardware.h>
-#define DC21285_IO(x)		((volatile unsigned long *)(ARMCSR_BASE+(x)))
-#else
-#define DC21285_IO(x)		(x)
-#endif
-
-/*
- * The footbridge is programmed to expose the system RAM at 0xe0000000.
- * The requirement is that the RAM isn't placed at bus address 0, which
- * would clash with VGA cards.
- */
-#define BUS_OFFSET 0xe0000000
-
-#define CSR_PCICMD		DC21285_IO(0x0004)
-#define CSR_CLASSREV		DC21285_IO(0x0008)
-#define CSR_PCICACHELINESIZE	DC21285_IO(0x000c)
-#define CSR_PCICSRBASE		DC21285_IO(0x0010)
-#define CSR_PCICSRIOBASE	DC21285_IO(0x0014)
-#define CSR_PCISDRAMBASE	DC21285_IO(0x0018)
-#define CSR_PCIROMBASE		DC21285_IO(0x0030)
-#define CSR_MBOX0		DC21285_IO(0x0050)
-#define CSR_MBOX1		DC21285_IO(0x0054)
-#define CSR_MBOX2		DC21285_IO(0x0058)
-#define CSR_MBOX3		DC21285_IO(0x005c)
-#define CSR_DOORBELL		DC21285_IO(0x0060)
-#define CSR_DOORBELL_SETUP	DC21285_IO(0x0064)
-#define CSR_ROMWRITEREG		DC21285_IO(0x0068)
-#define CSR_CSRBASEMASK		DC21285_IO(0x00f8)
-#define CSR_CSRBASEOFFSET	DC21285_IO(0x00fc)
-#define CSR_SDRAMBASEMASK	DC21285_IO(0x0100)
-#define CSR_SDRAMBASEOFFSET	DC21285_IO(0x0104)
-#define CSR_ROMBASEMASK		DC21285_IO(0x0108)
-#define CSR_SDRAMTIMING		DC21285_IO(0x010c)
-#define CSR_SDRAMADDRSIZE0	DC21285_IO(0x0110)
-#define CSR_SDRAMADDRSIZE1	DC21285_IO(0x0114)
-#define CSR_SDRAMADDRSIZE2	DC21285_IO(0x0118)
-#define CSR_SDRAMADDRSIZE3	DC21285_IO(0x011c)
-#define CSR_I2O_INFREEHEAD	DC21285_IO(0x0120)
-#define CSR_I2O_INPOSTTAIL	DC21285_IO(0x0124)
-#define CSR_I2O_OUTPOSTHEAD	DC21285_IO(0x0128)
-#define CSR_I2O_OUTFREETAIL	DC21285_IO(0x012c)
-#define CSR_I2O_INFREECOUNT	DC21285_IO(0x0130)
-#define CSR_I2O_OUTPOSTCOUNT	DC21285_IO(0x0134)
-#define CSR_I2O_INPOSTCOUNT	DC21285_IO(0x0138)
-#define CSR_SA110_CNTL		DC21285_IO(0x013c)
-#define SA110_CNTL_INITCMPLETE		(1 << 0)
-#define SA110_CNTL_ASSERTSERR		(1 << 1)
-#define SA110_CNTL_RXSERR		(1 << 3)
-#define SA110_CNTL_SA110DRAMPARITY	(1 << 4)
-#define SA110_CNTL_PCISDRAMPARITY	(1 << 5)
-#define SA110_CNTL_DMASDRAMPARITY	(1 << 6)
-#define SA110_CNTL_DISCARDTIMER		(1 << 8)
-#define SA110_CNTL_PCINRESET		(1 << 9)
-#define SA110_CNTL_I2O_256		(0 << 10)
-#define SA110_CNTL_I20_512		(1 << 10)
-#define SA110_CNTL_I2O_1024		(2 << 10)
-#define SA110_CNTL_I2O_2048		(3 << 10)
-#define SA110_CNTL_I2O_4096		(4 << 10)
-#define SA110_CNTL_I2O_8192		(5 << 10)
-#define SA110_CNTL_I2O_16384		(6 << 10)
-#define SA110_CNTL_I2O_32768		(7 << 10)
-#define SA110_CNTL_WATCHDOG		(1 << 13)
-#define SA110_CNTL_ROMWIDTH_UNDEF	(0 << 14)
-#define SA110_CNTL_ROMWIDTH_16		(1 << 14)
-#define SA110_CNTL_ROMWIDTH_32		(2 << 14)
-#define SA110_CNTL_ROMWIDTH_8		(3 << 14)
-#define SA110_CNTL_ROMACCESSTIME(x)	((x)<<16)
-#define SA110_CNTL_ROMBURSTTIME(x)	((x)<<20)
-#define SA110_CNTL_ROMTRISTATETIME(x)	((x)<<24)
-#define SA110_CNTL_XCSDIR(x)		((x)<<28)
-#define SA110_CNTL_PCICFN		(1 << 31)
-
-#define CSR_PCIADDR_EXTN	DC21285_IO(0x0140)
-#define CSR_PREFETCHMEMRANGE	DC21285_IO(0x0144)
-#define CSR_XBUS_CYCLE		DC21285_IO(0x0148)
-#define CSR_XBUS_IOSTROBE	DC21285_IO(0x014c)
-#define CSR_DOORBELL_PCI	DC21285_IO(0x0150)
-#define CSR_DOORBELL_SA110	DC21285_IO(0x0154)
-#define CSR_UARTDR		DC21285_IO(0x0160)
-#define CSR_RXSTAT		DC21285_IO(0x0164)
-#define CSR_H_UBRLCR		DC21285_IO(0x0168)
-#define CSR_M_UBRLCR		DC21285_IO(0x016c)
-#define CSR_L_UBRLCR		DC21285_IO(0x0170)
-#define CSR_UARTCON		DC21285_IO(0x0174)
-#define CSR_UARTFLG		DC21285_IO(0x0178)
-#define CSR_IRQ_STATUS		DC21285_IO(0x0180)
-#define CSR_IRQ_RAWSTATUS	DC21285_IO(0x0184)
-#define CSR_IRQ_ENABLE		DC21285_IO(0x0188)
-#define CSR_IRQ_DISABLE		DC21285_IO(0x018c)
-#define CSR_IRQ_SOFT		DC21285_IO(0x0190)
-#define CSR_FIQ_STATUS		DC21285_IO(0x0280)
-#define CSR_FIQ_RAWSTATUS	DC21285_IO(0x0284)
-#define CSR_FIQ_ENABLE		DC21285_IO(0x0288)
-#define CSR_FIQ_DISABLE		DC21285_IO(0x028c)
-#define CSR_FIQ_SOFT		DC21285_IO(0x0290)
-#define CSR_TIMER1_LOAD		DC21285_IO(0x0300)
-#define CSR_TIMER1_VALUE	DC21285_IO(0x0304)
-#define CSR_TIMER1_CNTL		DC21285_IO(0x0308)
-#define CSR_TIMER1_CLR		DC21285_IO(0x030c)
-#define CSR_TIMER2_LOAD		DC21285_IO(0x0320)
-#define CSR_TIMER2_VALUE	DC21285_IO(0x0324)
-#define CSR_TIMER2_CNTL		DC21285_IO(0x0328)
-#define CSR_TIMER2_CLR		DC21285_IO(0x032c)
-#define CSR_TIMER3_LOAD		DC21285_IO(0x0340)
-#define CSR_TIMER3_VALUE	DC21285_IO(0x0344)
-#define CSR_TIMER3_CNTL		DC21285_IO(0x0348)
-#define CSR_TIMER3_CLR		DC21285_IO(0x034c)
-#define CSR_TIMER4_LOAD		DC21285_IO(0x0360)
-#define CSR_TIMER4_VALUE	DC21285_IO(0x0364)
-#define CSR_TIMER4_CNTL		DC21285_IO(0x0368)
-#define CSR_TIMER4_CLR		DC21285_IO(0x036c)
-
-#define TIMER_CNTL_ENABLE	(1 << 7)
-#define TIMER_CNTL_AUTORELOAD	(1 << 6)
-#define TIMER_CNTL_DIV1		(0)
-#define TIMER_CNTL_DIV16	(1 << 2)
-#define TIMER_CNTL_DIV256	(2 << 2)
-#define TIMER_CNTL_CNTEXT	(3 << 2)
-
-
diff --git a/arch/arm/include/asm/mach/pci.h b/arch/arm/include/asm/mach/pci.h
index ea9bd08895b7..78f2318ed000 100644
--- a/arch/arm/include/asm/mach/pci.h
+++ b/arch/arm/include/asm/mach/pci.h
@@ -61,15 +61,6 @@ static inline void pci_common_init(struct hw_pci *hw)
 	pci_common_init_dev(NULL, hw);
 }
 
-/*
- * Setup early fixed I/O mapping.
- */
-#if defined(CONFIG_PCI)
-extern void pci_map_io_early(unsigned long pfn);
-#else
-static inline void pci_map_io_early(unsigned long pfn) {}
-#endif
-
 /*
  * PCI controllers
  */
@@ -78,9 +69,4 @@ extern int iop3xx_pci_setup(int nr, struct pci_sys_data *);
 extern void iop3xx_pci_preinit(void);
 extern void iop3xx_pci_preinit_cond(void);
 
-extern struct pci_ops dc21285_ops;
-extern int dc21285_setup(int nr, struct pci_sys_data *);
-extern void dc21285_preinit(void);
-extern void dc21285_postinit(void);
-
 #endif /* __ASM_MACH_PCI_H */
diff --git a/arch/arm/include/debug/dc21285.S b/arch/arm/include/debug/dc21285.S
deleted file mode 100644
index 4ec0e5e31704..000000000000
--- a/arch/arm/include/debug/dc21285.S
+++ /dev/null
@@ -1,41 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0-only */
-/* arch/arm/mach-footbridge/include/mach/debug-macro.S
- *
- * Debugging macro include header
- *
- *  Copyright (C) 1994-1999 Russell King
- *  Moved from linux/arch/arm/kernel/debug.S by Ben Dooks
-*/
-
-#include <asm/hardware/dec21285.h>
-
-#include <mach/hardware.h>
-	/* For EBSA285 debugging */
-		.equ	dc21285_high, ARMCSR_BASE & 0xff000000
-		.equ	dc21285_low,  ARMCSR_BASE & 0x00ffffff
-
-		.macro	addruart, rp, rv, tmp
-		.if	dc21285_low
-		mov	\rp, #dc21285_low
-		.else
-		mov	\rp, #0
-		.endif
-		orr	\rv, \rp, #dc21285_high
-		orr	\rp, \rp, #0x42000000
-		.endm
-
-		.macro	senduart,rd,rx
-		str	\rd, [\rx, #0x160]	@ UARTDR
-		.endm
-
-		.macro	busyuart,rd,rx
-1001:		ldr	\rd, [\rx, #0x178]	@ UARTFLG
-		tst	\rd, #1 << 3
-		bne	1001b
-		.endm
-
-		.macro	waituartcts,rd,rx
-		.endm
-
-		.macro	waituarttxrdy,rd,rx
-		.endm
diff --git a/arch/arm/kernel/atags_parse.c b/arch/arm/kernel/atags_parse.c
index 4ec591bde3df..9865ec7f90d9 100644
--- a/arch/arm/kernel/atags_parse.c
+++ b/arch/arm/kernel/atags_parse.c
@@ -69,24 +69,6 @@ static int __init parse_tag_mem32(const struct tag *tag)
 
 __tagtable(ATAG_MEM, parse_tag_mem32);
 
-#if defined(CONFIG_ARCH_FOOTBRIDGE) && defined(CONFIG_VGA_CONSOLE)
-static int __init parse_tag_videotext(const struct tag *tag)
-{
-	vgacon_screen_info.orig_x            = tag->u.videotext.x;
-	vgacon_screen_info.orig_y            = tag->u.videotext.y;
-	vgacon_screen_info.orig_video_page   = tag->u.videotext.video_page;
-	vgacon_screen_info.orig_video_mode   = tag->u.videotext.video_mode;
-	vgacon_screen_info.orig_video_cols   = tag->u.videotext.video_cols;
-	vgacon_screen_info.orig_video_ega_bx = tag->u.videotext.video_ega_bx;
-	vgacon_screen_info.orig_video_lines  = tag->u.videotext.video_lines;
-	vgacon_screen_info.orig_video_isVGA  = tag->u.videotext.video_isvga;
-	vgacon_screen_info.orig_video_points = tag->u.videotext.video_points;
-	return 0;
-}
-
-__tagtable(ATAG_VIDEOTEXT, parse_tag_videotext);
-#endif
-
 #ifdef CONFIG_BLK_DEV_RAM
 static int __init parse_tag_ramdisk(const struct tag *tag)
 {
diff --git a/arch/arm/kernel/bios32.c b/arch/arm/kernel/bios32.c
index ac0e890510da..6256b75f8285 100644
--- a/arch/arm/kernel/bios32.c
+++ b/arch/arm/kernel/bios32.c
@@ -582,15 +582,3 @@ resource_size_t pcibios_align_resource(void *data, const struct resource *res,
 
 	return start;
 }
-
-void __init pci_map_io_early(unsigned long pfn)
-{
-	struct map_desc pci_io_desc = {
-		.virtual	= PCI_IO_VIRT_BASE,
-		.type		= MT_DEVICE,
-		.length		= SZ_64K,
-	};
-
-	pci_io_desc.pfn = pfn;
-	iotable_init(&pci_io_desc, 1);
-}
diff --git a/arch/arm/kernel/head.S b/arch/arm/kernel/head.S
index f22c50d4bd41..b12fe41e579b 100644
--- a/arch/arm/kernel/head.S
+++ b/arch/arm/kernel/head.S
@@ -347,16 +347,6 @@ __create_page_tables:
 	/* we don't need any serial debugging mappings */
 	ldr	r7, [r10, #PROCINFO_IO_MMUFLAGS] @ io_mmuflags
 #endif
-
-#if defined(CONFIG_ARCH_NETWINDER)
-	/*
-	 * If we're using the NetWinder or CATS, we also need to map
-	 * in the 16550-type serial port for the debug messages
-	 */
-	add	r0, r4, #0xff000000 >> (SECTION_SHIFT - PMD_ENTRY_ORDER)
-	orr	r3, r7, #0x7c000000
-	str	r3, [r0]
-#endif
 #ifdef CONFIG_ARCH_RPC
 	/*
 	 * Map in screen at 0x02000000 & SCREEN2_BASE
diff --git a/arch/arm/mach-footbridge/Kconfig b/arch/arm/mach-footbridge/Kconfig
deleted file mode 100644
index 96a74d447028..000000000000
--- a/arch/arm/mach-footbridge/Kconfig
+++ /dev/null
@@ -1,57 +0,0 @@
-# SPDX-License-Identifier: GPL-2.0-only
-menuconfig ARCH_FOOTBRIDGE
-	bool "FootBridge Implementations (DEPRECATED)"
-	depends on ARCH_MULTI_V4 && !(ARCH_MULTI_V4T || ARCH_MULTI_V5)
-	depends on !(ARCH_MOXART || ARCH_GEMINI || ARCH_SA1100)
-	depends on ATAGS
-	depends on CPU_LITTLE_ENDIAN
-	depends on MMU
-	select ARCH_NO_SG_CHAIN
-	select CPU_SA110
-	select FOOTBRIDGE
-	select NEED_MACH_MEMORY_H
-	help
-	  Support for systems based on the DC21285 companion chip
-	  ("FootBridge"), used in the EBSA285 and the Rebel NetWinder.
-
-	  Support for these machines will go away in 2027,
-	  unless there are any remaining users that speak up.
-
-if ARCH_FOOTBRIDGE
-
-config ARCH_EBSA285_HOST
-	bool "EBSA285 (host mode)"
-	select ARCH_EBSA285
-	select ISA
-	select ARCH_MAY_HAVE_PC_FDC
-	select FORCE_PCI
-	help
-	  Say Y here if you intend to run this kernel on the EBSA285 card
-	  in host ("central function") mode.
-
-	  Saying N will reduce the size of the Footbridge kernel.
-
-config ARCH_NETWINDER
-	bool "NetWinder"
-	select CLKEVT_I8253
-	select CLKSRC_I8253
-	select ISA
-	select FORCE_PCI
-	help
-	  Say Y here if you intend to run this kernel on the Rebel.COM
-	  NetWinder.  Information about this machine can be found at:
-
-	  <http://www.netwinder.org/>
-
-	  Saying N will reduce the size of the Footbridge kernel.
-
-# Footbridge support
-config FOOTBRIDGE
-	def_bool y
-	select ARCH_MIGHT_HAVE_PC_SERIO
-	select ISA_DMA_API
-
-config ARCH_EBSA285
-	bool
-
-endif
diff --git a/arch/arm/mach-footbridge/Makefile b/arch/arm/mach-footbridge/Makefile
deleted file mode 100644
index 1553cc01b45c..000000000000
--- a/arch/arm/mach-footbridge/Makefile
+++ /dev/null
@@ -1,18 +0,0 @@
-# SPDX-License-Identifier: GPL-2.0
-#
-# Makefile for the linux kernel.
-#
-
-# Object file lists.
-
-obj-y			:= common.o isa-irq.o isa.o isa-rtc.o dma-isa.o
-
-pci-y			+= dc21285.o
-pci-$(CONFIG_ARCH_EBSA285) += ebsa285-pci.o
-pci-$(CONFIG_ARCH_NETWINDER) += netwinder-pci.o
-
-obj-$(CONFIG_ARCH_EBSA285) += ebsa285.o dc21285-timer.o
-obj-$(CONFIG_ARCH_NETWINDER) += netwinder-hw.o isa-timer.o
-
-obj-$(CONFIG_PCI)	+=$(pci-y)
-
diff --git a/arch/arm/mach-footbridge/common.c b/arch/arm/mach-footbridge/common.c
deleted file mode 100644
index 85c598708c10..000000000000
--- a/arch/arm/mach-footbridge/common.c
+++ /dev/null
@@ -1,280 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0-only
-/*
- *  linux/arch/arm/mach-footbridge/common.c
- *
- *  Copyright (C) 1998-2000 Russell King, Dave Gilbert.
- */
-#include <linux/module.h>
-#include <linux/types.h>
-#include <linux/mm.h>
-#include <linux/ioport.h>
-#include <linux/list.h>
-#include <linux/init.h>
-#include <linux/io.h>
-#include <linux/spinlock.h>
-#include <linux/dma-direct.h>
-#include <video/vga.h>
-
-#include <asm/page.h>
-#include <asm/irq.h>
-#include <asm/mach-types.h>
-#include <asm/setup.h>
-#include <asm/system_misc.h>
-#include <asm/hardware/dec21285.h>
-
-#include <asm/mach/irq.h>
-#include <asm/mach/map.h>
-#include <asm/mach/pci.h>
-
-#include "common.h"
-
-#include <mach/hardware.h>
-#include <mach/irqs.h>
-#include <asm/hardware/dec21285.h>
-
-static int dc21285_get_irq(void)
-{
-	void __iomem *irqstatus = (void __iomem *)CSR_IRQ_STATUS;
-	u32 mask = readl(irqstatus);
-
-	if (mask & IRQ_MASK_SDRAMPARITY)
-		return IRQ_SDRAMPARITY;
-
-	if (mask & IRQ_MASK_UART_RX)
-		return IRQ_CONRX;
-
-	if (mask & IRQ_MASK_DMA1)
-		return IRQ_DMA1;
-
-	if (mask & IRQ_MASK_DMA2)
-		return IRQ_DMA2;
-
-	if (mask & IRQ_MASK_IN0)
-		return IRQ_IN0;
-
-	if (mask & IRQ_MASK_IN1)
-		return IRQ_IN1;
-
-	if (mask & IRQ_MASK_IN2)
-		return IRQ_IN2;
-
-	if (mask & IRQ_MASK_IN3)
-		return IRQ_IN3;
-
-	if (mask & IRQ_MASK_PCI)
-		return IRQ_PCI;
-
-	if (mask & IRQ_MASK_DOORBELLHOST)
-		return IRQ_DOORBELLHOST;
-
-	if (mask & IRQ_MASK_I2OINPOST)
-		return IRQ_I2OINPOST;
-
-	if (mask & IRQ_MASK_TIMER1)
-		return IRQ_TIMER1;
-
-	if (mask & IRQ_MASK_TIMER2)
-		return IRQ_TIMER2;
-
-	if (mask & IRQ_MASK_TIMER3)
-		return IRQ_TIMER3;
-
-	if (mask & IRQ_MASK_UART_TX)
-		return IRQ_CONTX;
-
-	if (mask & IRQ_MASK_PCI_ABORT)
-		return IRQ_PCI_ABORT;
-
-	if (mask & IRQ_MASK_PCI_SERR)
-		return IRQ_PCI_SERR;
-
-	if (mask & IRQ_MASK_DISCARD_TIMER)
-		return IRQ_DISCARD_TIMER;
-
-	if (mask & IRQ_MASK_PCI_DPERR)
-		return IRQ_PCI_DPERR;
-
-	if (mask & IRQ_MASK_PCI_PERR)
-		return IRQ_PCI_PERR;
-
-	return 0;
-}
-
-static void dc21285_handle_irq(struct pt_regs *regs)
-{
-	int irq;
-	do {
-		irq = dc21285_get_irq();
-		if (!irq)
-			break;
-
-		generic_handle_irq(irq);
-	} while (1);
-}
-
-
-unsigned int mem_fclk_21285 = 50000000;
-
-EXPORT_SYMBOL(mem_fclk_21285);
-
-static int __init early_fclk(char *arg)
-{
-	mem_fclk_21285 = simple_strtoul(arg, NULL, 0);
-	return 0;
-}
-
-early_param("mem_fclk_21285", early_fclk);
-
-static int __init parse_tag_memclk(const struct tag *tag)
-{
-	mem_fclk_21285 = tag->u.memclk.fmemclk;
-	return 0;
-}
-
-__tagtable(ATAG_MEMCLK, parse_tag_memclk);
-
-/*
- * Footbridge IRQ translation table
- *  Converts from our IRQ numbers into FootBridge masks
- */
-static const int fb_irq_mask[] = {
-	IRQ_MASK_UART_RX,	/*  0 */
-	IRQ_MASK_UART_TX,	/*  1 */
-	IRQ_MASK_TIMER1,	/*  2 */
-	IRQ_MASK_TIMER2,	/*  3 */
-	IRQ_MASK_TIMER3,	/*  4 */
-	IRQ_MASK_IN0,		/*  5 */
-	IRQ_MASK_IN1,		/*  6 */
-	IRQ_MASK_IN2,		/*  7 */
-	IRQ_MASK_IN3,		/*  8 */
-	IRQ_MASK_DOORBELLHOST,	/*  9 */
-	IRQ_MASK_DMA1,		/* 10 */
-	IRQ_MASK_DMA2,		/* 11 */
-	IRQ_MASK_PCI,		/* 12 */
-	IRQ_MASK_SDRAMPARITY,	/* 13 */
-	IRQ_MASK_I2OINPOST,	/* 14 */
-	IRQ_MASK_PCI_ABORT,	/* 15 */
-	IRQ_MASK_PCI_SERR,	/* 16 */
-	IRQ_MASK_DISCARD_TIMER,	/* 17 */
-	IRQ_MASK_PCI_DPERR,	/* 18 */
-	IRQ_MASK_PCI_PERR,	/* 19 */
-};
-
-static void fb_mask_irq(struct irq_data *d)
-{
-	*CSR_IRQ_DISABLE = fb_irq_mask[_DC21285_INR(d->irq)];
-}
-
-static void fb_unmask_irq(struct irq_data *d)
-{
-	*CSR_IRQ_ENABLE = fb_irq_mask[_DC21285_INR(d->irq)];
-}
-
-static struct irq_chip fb_chip = {
-	.irq_ack	= fb_mask_irq,
-	.irq_mask	= fb_mask_irq,
-	.irq_unmask	= fb_unmask_irq,
-};
-
-static void __init __fb_init_irq(void)
-{
-	unsigned int irq;
-
-	/*
-	 * setup DC21285 IRQs
-	 */
-	*CSR_IRQ_DISABLE = -1;
-	*CSR_FIQ_DISABLE = -1;
-
-	for (irq = _DC21285_IRQ(0); irq < _DC21285_IRQ(20); irq++) {
-		irq_set_chip_and_handler(irq, &fb_chip, handle_level_irq);
-		irq_clear_status_flags(irq, IRQ_NOREQUEST | IRQ_NOPROBE);
-	}
-}
-
-void __init footbridge_init_irq(void)
-{
-	set_handle_irq(dc21285_handle_irq);
-
-	__fb_init_irq();
-
-	if (machine_is_ebsa285())
-		/* The following is dependent on which slot
-		 * you plug the Southbridge card into.  We
-		 * currently assume that you plug it into
-		 * the right-hand most slot.
-		 */
-		isa_init_irq(IRQ_PCI);
-
-	if (machine_is_netwinder())
-		isa_init_irq(IRQ_IN3);
-}
-
-/*
- * Common mapping for all systems.  Note that the outbound write flush is
- * commented out since there is a "No Fix" problem with it.  Not mapping
- * it means that we have extra bullet protection on our feet.
- */
-static struct map_desc ebsa285_host_io_desc[] __initdata = {
-	{
-		.virtual	= ARMCSR_BASE,
-		.pfn		= __phys_to_pfn(DC21285_ARMCSR_BASE),
-		.length		= ARMCSR_SIZE,
-		.type		= MT_DEVICE,
-	},
-	{
-		.virtual	= PCIMEM_BASE,
-		.pfn		= __phys_to_pfn(DC21285_PCI_MEM),
-		.length		= PCIMEM_SIZE,
-		.type		= MT_DEVICE,
-	}, {
-		.virtual	= PCICFG0_BASE,
-		.pfn		= __phys_to_pfn(DC21285_PCI_TYPE_0_CONFIG),
-		.length		= PCICFG0_SIZE,
-		.type		= MT_DEVICE,
-	}, {
-		.virtual	= PCICFG1_BASE,
-		.pfn		= __phys_to_pfn(DC21285_PCI_TYPE_1_CONFIG),
-		.length		= PCICFG1_SIZE,
-		.type		= MT_DEVICE,
-	}, {
-		.virtual	= PCIIACK_BASE,
-		.pfn		= __phys_to_pfn(DC21285_PCI_IACK),
-		.length		= PCIIACK_SIZE,
-		.type		= MT_DEVICE,
-	},
-};
-
-void __init footbridge_map_io(void)
-{
-	iotable_init(ebsa285_host_io_desc, ARRAY_SIZE(ebsa285_host_io_desc));
-	pci_map_io_early(__phys_to_pfn(DC21285_PCI_IO));
-	vga_base = PCIMEM_BASE;
-}
-
-void footbridge_restart(enum reboot_mode mode, const char *cmd)
-{
-	if (mode == REBOOT_SOFT) {
-		/* Jump into the ROM */
-		soft_restart(0x41000000);
-	} else {
-		/*
-		 * Force the watchdog to do a CPU reset.
-		 *
-		 * After making sure that the watchdog is disabled
-		 * (so we can change the timer registers) we first
-		 * enable the timer to autoreload itself.  Next, the
-		 * timer interval is set really short and any
-		 * current interrupt request is cleared (so we can
-		 * see an edge transition).  Finally, TIMER4 is
-		 * enabled as the watchdog.
-		 */
-		*CSR_SA110_CNTL &= ~(1 << 13);
-		*CSR_TIMER4_CNTL = TIMER_CNTL_ENABLE |
-				   TIMER_CNTL_AUTORELOAD |
-				   TIMER_CNTL_DIV16;
-		*CSR_TIMER4_LOAD = 0x2;
-		*CSR_TIMER4_CLR  = 0;
-		*CSR_SA110_CNTL |= (1 << 13);
-	}
-}
diff --git a/arch/arm/mach-footbridge/common.h b/arch/arm/mach-footbridge/common.h
deleted file mode 100644
index e12587db59c4..000000000000
--- a/arch/arm/mach-footbridge/common.h
+++ /dev/null
@@ -1,15 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0 */
-#include <linux/reboot.h>
-
-extern void footbridge_timer_init(void);
-extern void isa_timer_init(void);
-
-extern void isa_rtc_init(void);
-
-extern void footbridge_map_io(void);
-extern void footbridge_init_irq(void);
-
-extern void isa_init_irq(unsigned int irq);
-extern void footbridge_restart(enum reboot_mode, const char *);
-
-extern void footbridge_sched_clock(void);
diff --git a/arch/arm/mach-footbridge/dc21285-timer.c b/arch/arm/mach-footbridge/dc21285-timer.c
deleted file mode 100644
index 2908c9ef3c9b..000000000000
--- a/arch/arm/mach-footbridge/dc21285-timer.c
+++ /dev/null
@@ -1,136 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0
-/*
- *  linux/arch/arm/mach-footbridge/dc21285-timer.c
- *
- *  Copyright (C) 1998 Russell King.
- *  Copyright (C) 1998 Phil Blundell
- */
-#include <linux/clockchips.h>
-#include <linux/clocksource.h>
-#include <linux/init.h>
-#include <linux/interrupt.h>
-#include <linux/irq.h>
-#include <linux/sched_clock.h>
-
-#include <asm/irq.h>
-
-#include <asm/hardware/dec21285.h>
-#include <asm/mach/time.h>
-#include <asm/system_info.h>
-
-#include "common.h"
-
-static u64 cksrc_dc21285_read(struct clocksource *cs)
-{
-	return cs->mask - *CSR_TIMER2_VALUE;
-}
-
-static int cksrc_dc21285_enable(struct clocksource *cs)
-{
-	*CSR_TIMER2_LOAD = cs->mask;
-	*CSR_TIMER2_CLR = 0;
-	*CSR_TIMER2_CNTL = TIMER_CNTL_ENABLE | TIMER_CNTL_DIV16;
-	return 0;
-}
-
-static void cksrc_dc21285_disable(struct clocksource *cs)
-{
-	*CSR_TIMER2_CNTL = 0;
-}
-
-static struct clocksource cksrc_dc21285 = {
-	.name		= "dc21285_timer2",
-	.rating		= 200,
-	.read		= cksrc_dc21285_read,
-	.enable		= cksrc_dc21285_enable,
-	.disable	= cksrc_dc21285_disable,
-	.mask		= CLOCKSOURCE_MASK(24),
-	.flags		= CLOCK_SOURCE_IS_CONTINUOUS,
-};
-
-static int ckevt_dc21285_set_next_event(unsigned long delta,
-	struct clock_event_device *c)
-{
-	*CSR_TIMER1_CLR = 0;
-	*CSR_TIMER1_LOAD = delta;
-	*CSR_TIMER1_CNTL = TIMER_CNTL_ENABLE | TIMER_CNTL_DIV16;
-
-	return 0;
-}
-
-static int ckevt_dc21285_shutdown(struct clock_event_device *c)
-{
-	*CSR_TIMER1_CNTL = 0;
-	return 0;
-}
-
-static int ckevt_dc21285_set_periodic(struct clock_event_device *c)
-{
-	*CSR_TIMER1_CLR = 0;
-	*CSR_TIMER1_LOAD = (mem_fclk_21285 + 8 * HZ) / (16 * HZ);
-	*CSR_TIMER1_CNTL = TIMER_CNTL_ENABLE | TIMER_CNTL_AUTORELOAD |
-			   TIMER_CNTL_DIV16;
-	return 0;
-}
-
-static struct clock_event_device ckevt_dc21285 = {
-	.name			= "dc21285_timer1",
-	.features		= CLOCK_EVT_FEAT_PERIODIC |
-				  CLOCK_EVT_FEAT_ONESHOT,
-	.rating			= 200,
-	.irq			= IRQ_TIMER1,
-	.set_next_event		= ckevt_dc21285_set_next_event,
-	.set_state_shutdown	= ckevt_dc21285_shutdown,
-	.set_state_periodic	= ckevt_dc21285_set_periodic,
-	.set_state_oneshot	= ckevt_dc21285_shutdown,
-	.tick_resume		= ckevt_dc21285_set_periodic,
-};
-
-static irqreturn_t timer1_interrupt(int irq, void *dev_id)
-{
-	struct clock_event_device *ce = dev_id;
-
-	*CSR_TIMER1_CLR = 0;
-
-	/* Stop the timer if in one-shot mode */
-	if (clockevent_state_oneshot(ce))
-		*CSR_TIMER1_CNTL = 0;
-
-	ce->event_handler(ce);
-
-	return IRQ_HANDLED;
-}
-
-/*
- * Set up timer interrupt.
- */
-void __init footbridge_timer_init(void)
-{
-	struct clock_event_device *ce = &ckevt_dc21285;
-	unsigned rate = DIV_ROUND_CLOSEST(mem_fclk_21285, 16);
-
-	clocksource_register_hz(&cksrc_dc21285, rate);
-
-	if (request_irq(ce->irq, timer1_interrupt, IRQF_TIMER | IRQF_IRQPOLL,
-			"dc21285_timer1", &ckevt_dc21285))
-		pr_err("Failed to request irq %d (dc21285_timer1)", ce->irq);
-
-	ce->cpumask = cpumask_of(smp_processor_id());
-	clockevents_config_and_register(ce, rate, 0x4, 0xffffff);
-}
-
-static u64 notrace footbridge_read_sched_clock(void)
-{
-	return ~*CSR_TIMER3_VALUE;
-}
-
-void __init footbridge_sched_clock(void)
-{
-	unsigned rate = DIV_ROUND_CLOSEST(mem_fclk_21285, 16);
-
-	*CSR_TIMER3_LOAD = 0;
-	*CSR_TIMER3_CLR = 0;
-	*CSR_TIMER3_CNTL = TIMER_CNTL_ENABLE | TIMER_CNTL_DIV16;
-
-	sched_clock_register(footbridge_read_sched_clock, 24, rate);
-}
diff --git a/arch/arm/mach-footbridge/dc21285.c b/arch/arm/mach-footbridge/dc21285.c
deleted file mode 100644
index e1b336624883..000000000000
--- a/arch/arm/mach-footbridge/dc21285.c
+++ /dev/null
@@ -1,360 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0-only
-/*
- *  linux/arch/arm/kernel/dec21285.c: PCI functions for DC21285
- *
- *  Copyright (C) 1998-2001 Russell King
- *  Copyright (C) 1998-2000 Phil Blundell
- */
-#include <linux/dma-map-ops.h>
-#include <linux/kernel.h>
-#include <linux/pci.h>
-#include <linux/interrupt.h>
-#include <linux/mm.h>
-#include <linux/slab.h>
-#include <linux/init.h>
-#include <linux/ioport.h>
-#include <linux/irq.h>
-#include <linux/io.h>
-#include <linux/spinlock.h>
-
-#include <asm/irq.h>
-#include <asm/mach/pci.h>
-#include <asm/hardware/dec21285.h>
-
-#define MAX_SLOTS		21
-
-#define PCICMD_ABORT		((PCI_STATUS_REC_MASTER_ABORT| \
-				  PCI_STATUS_REC_TARGET_ABORT)<<16)
-
-#define PCICMD_ERROR_BITS	((PCI_STATUS_DETECTED_PARITY | \
-				  PCI_STATUS_REC_MASTER_ABORT | \
-				  PCI_STATUS_REC_TARGET_ABORT | \
-				  PCI_STATUS_PARITY) << 16)
-
-extern int setup_arm_irq(int, struct irqaction *);
-
-static unsigned long
-dc21285_base_address(struct pci_bus *bus, unsigned int devfn)
-{
-	unsigned long addr = 0;
-
-	if (bus->number == 0) {
-		if (PCI_SLOT(devfn) == 0)
-			/*
-			 * For devfn 0, point at the 21285
-			 */
-			addr = ARMCSR_BASE;
-		else {
-			devfn -= 1 << 3;
-
-			if (devfn < PCI_DEVFN(MAX_SLOTS, 0))
-				addr = PCICFG0_BASE | 0xc00000 | (devfn << 8);
-		}
-	} else
-		addr = PCICFG1_BASE | (bus->number << 16) | (devfn << 8);
-
-	return addr;
-}
-
-static int
-dc21285_read_config(struct pci_bus *bus, unsigned int devfn, int where,
-		    int size, u32 *value)
-{
-	unsigned long addr = dc21285_base_address(bus, devfn);
-	u32 v = 0xffffffff;
-
-	if (addr)
-		switch (size) {
-		case 1:
-			asm volatile("ldrb	%0, [%1, %2]"
-				: "=r" (v) : "r" (addr), "r" (where) : "cc");
-			break;
-		case 2:
-			asm volatile("ldrh	%0, [%1, %2]"
-				: "=r" (v) : "r" (addr), "r" (where) : "cc");
-			break;
-		case 4:
-			asm volatile("ldr	%0, [%1, %2]"
-				: "=r" (v) : "r" (addr), "r" (where) : "cc");
-			break;
-		}
-
-	*value = v;
-
-	v = *CSR_PCICMD;
-	if (v & PCICMD_ABORT) {
-		*CSR_PCICMD = v & (0xffff|PCICMD_ABORT);
-		return -1;
-	}
-
-	return PCIBIOS_SUCCESSFUL;
-}
-
-static int
-dc21285_write_config(struct pci_bus *bus, unsigned int devfn, int where,
-		     int size, u32 value)
-{
-	unsigned long addr = dc21285_base_address(bus, devfn);
-	u32 v;
-
-	if (addr)
-		switch (size) {
-		case 1:
-			asm volatile("strb	%0, [%1, %2]"
-				: : "r" (value), "r" (addr), "r" (where)
-				: "cc");
-			break;
-		case 2:
-			asm volatile("strh	%0, [%1, %2]"
-				: : "r" (value), "r" (addr), "r" (where)
-				: "cc");
-			break;
-		case 4:
-			asm volatile("str	%0, [%1, %2]"
-				: : "r" (value), "r" (addr), "r" (where)
-				: "cc");
-			break;
-		}
-
-	v = *CSR_PCICMD;
-	if (v & PCICMD_ABORT) {
-		*CSR_PCICMD = v & (0xffff|PCICMD_ABORT);
-		return -1;
-	}
-
-	return PCIBIOS_SUCCESSFUL;
-}
-
-struct pci_ops dc21285_ops = {
-	.read	= dc21285_read_config,
-	.write	= dc21285_write_config,
-};
-
-static struct timer_list serr_timer;
-static struct timer_list perr_timer;
-
-static void dc21285_enable_error(struct timer_list *timer)
-{
-	timer_delete(timer);
-
-	if (timer == &serr_timer)
-		enable_irq(IRQ_PCI_SERR);
-	else if (timer == &perr_timer)
-		enable_irq(IRQ_PCI_PERR);
-}
-
-/*
- * Warn on PCI errors.
- */
-static irqreturn_t dc21285_abort_irq(int irq, void *dev_id)
-{
-	unsigned int cmd;
-	unsigned int status;
-
-	cmd = *CSR_PCICMD;
-	status = cmd >> 16;
-	cmd = cmd & 0xffff;
-
-	if (status & PCI_STATUS_REC_MASTER_ABORT) {
-		printk(KERN_DEBUG "PCI: master abort, pc=0x%08lx\n",
-			instruction_pointer(get_irq_regs()));
-		cmd |= PCI_STATUS_REC_MASTER_ABORT << 16;
-	}
-
-	if (status & PCI_STATUS_REC_TARGET_ABORT) {
-		printk(KERN_DEBUG "PCI: target abort: ");
-		pcibios_report_status(PCI_STATUS_REC_MASTER_ABORT |
-				      PCI_STATUS_SIG_TARGET_ABORT |
-				      PCI_STATUS_REC_TARGET_ABORT, 1);
-		printk("\n");
-
-		cmd |= PCI_STATUS_REC_TARGET_ABORT << 16;
-	}
-
-	*CSR_PCICMD = cmd;
-
-	return IRQ_HANDLED;
-}
-
-static irqreturn_t dc21285_serr_irq(int irq, void *dev_id)
-{
-	struct timer_list *timer = dev_id;
-	unsigned int cntl;
-
-	printk(KERN_DEBUG "PCI: system error received: ");
-	pcibios_report_status(PCI_STATUS_SIG_SYSTEM_ERROR, 1);
-	printk("\n");
-
-	cntl = *CSR_SA110_CNTL & 0xffffdf07;
-	*CSR_SA110_CNTL = cntl | SA110_CNTL_RXSERR;
-
-	/*
-	 * back off this interrupt
-	 */
-	disable_irq(irq);
-	timer->expires = jiffies + HZ;
-	add_timer(timer);
-
-	return IRQ_HANDLED;
-}
-
-static irqreturn_t dc21285_discard_irq(int irq, void *dev_id)
-{
-	printk(KERN_DEBUG "PCI: discard timer expired\n");
-	*CSR_SA110_CNTL &= 0xffffde07;
-
-	return IRQ_HANDLED;
-}
-
-static irqreturn_t dc21285_dparity_irq(int irq, void *dev_id)
-{
-	unsigned int cmd;
-
-	printk(KERN_DEBUG "PCI: data parity error detected: ");
-	pcibios_report_status(PCI_STATUS_PARITY | PCI_STATUS_DETECTED_PARITY, 1);
-	printk("\n");
-
-	cmd = *CSR_PCICMD & 0xffff;
-	*CSR_PCICMD = cmd | 1 << 24;
-
-	return IRQ_HANDLED;
-}
-
-static irqreturn_t dc21285_parity_irq(int irq, void *dev_id)
-{
-	struct timer_list *timer = dev_id;
-	unsigned int cmd;
-
-	printk(KERN_DEBUG "PCI: parity error detected: ");
-	pcibios_report_status(PCI_STATUS_PARITY | PCI_STATUS_DETECTED_PARITY, 1);
-	printk("\n");
-
-	cmd = *CSR_PCICMD & 0xffff;
-	*CSR_PCICMD = cmd | 1 << 31;
-
-	/*
-	 * back off this interrupt
-	 */
-	disable_irq(irq);
-	timer->expires = jiffies + HZ;
-	add_timer(timer);
-
-	return IRQ_HANDLED;
-}
-
-static int dc21285_pci_bus_notifier(struct notifier_block *nb,
-				    unsigned long action,
-				    void *data)
-{
-	if (action != BUS_NOTIFY_ADD_DEVICE)
-		return NOTIFY_DONE;
-
-	dma_direct_set_offset(data, PHYS_OFFSET, BUS_OFFSET, SZ_256M);
-
-	return NOTIFY_OK;
-}
-
-static struct notifier_block dc21285_pci_bus_nb = {
-	.notifier_call = dc21285_pci_bus_notifier,
-};
-
-int __init dc21285_setup(int nr, struct pci_sys_data *sys)
-{
-	struct resource *res;
-
-	res = kzalloc_objs(struct resource, 2);
-	if (!res) {
-		printk("out of memory for root bus resources");
-		return 0;
-	}
-
-	res[0].flags = IORESOURCE_MEM;
-	res[0].name  = "Footbridge non-prefetch";
-	res[1].flags = IORESOURCE_MEM | IORESOURCE_PREFETCH;
-	res[1].name  = "Footbridge prefetch";
-
-	allocate_resource(&iomem_resource, &res[1], 0x20000000,
-			  0xa0000000, 0xffffffff, 0x20000000, NULL, NULL);
-	allocate_resource(&iomem_resource, &res[0], 0x40000000,
-			  0x80000000, 0xffffffff, 0x40000000, NULL, NULL);
-
-	sys->mem_offset  = DC21285_PCI_MEM;
-
-	pci_add_resource_offset(&sys->resources, &res[0], sys->mem_offset);
-	pci_add_resource_offset(&sys->resources, &res[1], sys->mem_offset);
-
-	bus_register_notifier(&pci_bus_type, &dc21285_pci_bus_nb);
-
-	return 1;
-}
-
-#define dc21285_request_irq(_a, _b, _c, _d, _e) \
-	WARN_ON(request_irq(_a, _b, _c, _d, _e) < 0)
-
-void __init dc21285_preinit(void)
-{
-	unsigned int mem_size, mem_mask;
-
-	pcibios_min_mem = 0x81000000;
-
-	mem_size = (unsigned int)high_memory - PAGE_OFFSET;
-	for (mem_mask = 0x00100000; mem_mask < 0x10000000; mem_mask <<= 1)
-		if (mem_mask >= mem_size)
-			break;
-
-	/*
-	 * These registers need to be set up whether we're the
-	 * central function or not.
-	 */
-	*CSR_SDRAMBASEMASK    = (mem_mask - 1) & 0x0ffc0000;
-	*CSR_SDRAMBASEOFFSET  = 0;
-	*CSR_ROMBASEMASK      = 0x80000000;
-	*CSR_CSRBASEMASK      = 0;
-	*CSR_CSRBASEOFFSET    = 0;
-	*CSR_PCIADDR_EXTN     = 0;
-
-	printk(KERN_INFO "PCI: DC21285 footbridge, revision %02lX, in "
-		"central function mode\n", *CSR_CLASSREV & 0xff);
-
-	/*
-	 * Clear any existing errors - we aren't
-	 * interested in historical data...
-	 */
-	*CSR_SA110_CNTL	= (*CSR_SA110_CNTL & 0xffffde07) | SA110_CNTL_RXSERR;
-	*CSR_PCICMD = (*CSR_PCICMD & 0xffff) | PCICMD_ERROR_BITS;
-
-	timer_setup(&serr_timer, dc21285_enable_error, 0);
-	timer_setup(&perr_timer, dc21285_enable_error, 0);
-
-	/*
-	 * We don't care if these fail.
-	 */
-	dc21285_request_irq(IRQ_PCI_SERR, dc21285_serr_irq, 0,
-			    "PCI system error", &serr_timer);
-	dc21285_request_irq(IRQ_PCI_PERR, dc21285_parity_irq, 0,
-			    "PCI parity error", &perr_timer);
-	dc21285_request_irq(IRQ_PCI_ABORT, dc21285_abort_irq, 0,
-			    "PCI abort", NULL);
-	dc21285_request_irq(IRQ_DISCARD_TIMER, dc21285_discard_irq, 0,
-			    "Discard timer", NULL);
-	dc21285_request_irq(IRQ_PCI_DPERR, dc21285_dparity_irq, 0,
-			    "PCI data parity", NULL);
-
-	/*
-	 * Map our SDRAM at a known address in PCI space, just in case
-	 * the firmware had other ideas.  Using a nonzero base is
-	 * necessary, since some VGA cards forcefully use PCI addresses
-	 * in the range 0x000a0000 to 0x000c0000. (eg, S3 cards).
-	 */
-	*CSR_PCICSRBASE       = 0xf4000000;
-	*CSR_PCICSRIOBASE     = 0;
-	*CSR_PCISDRAMBASE     = BUS_OFFSET;
-	*CSR_PCIROMBASE       = 0;
-	*CSR_PCICMD = PCI_COMMAND_MEMORY | PCI_COMMAND_MASTER |
-		      PCI_COMMAND_INVALIDATE | PCICMD_ERROR_BITS;
-}
-
-void __init dc21285_postinit(void)
-{
-	register_isa_ports(DC21285_PCI_MEM, DC21285_PCI_IO, 0);
-}
diff --git a/arch/arm/mach-footbridge/dma-isa.c b/arch/arm/mach-footbridge/dma-isa.c
deleted file mode 100644
index 937f5376d5e7..000000000000
--- a/arch/arm/mach-footbridge/dma-isa.c
+++ /dev/null
@@ -1,230 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0-only
-/*
- *  Copyright (C) 1999-2000 Russell King
- *
- *  ISA DMA primitives
- *  Taken from various sources, including:
- *   linux/include/asm/dma.h: Defines for using and allocating dma channels.
- *     Written by Hennus Bergman, 1992.
- *     High DMA channel support & info by Hannu Savolainen and John Boyd,
- *     Nov. 1992.
- *   arch/arm/kernel/dma-ebsa285.c
- *   Copyright (C) 1998 Phil Blundell
- */
-#include <linux/dma-map-ops.h>
-#include <linux/ioport.h>
-#include <linux/init.h>
-#include <linux/dma-mapping.h>
-#include <linux/io.h>
-
-#include <asm/dma.h>
-#include <asm/mach/dma.h>
-#include <asm/hardware/dec21285.h>
-
-#define ISA_DMA_MASK		0
-#define ISA_DMA_MODE		1
-#define ISA_DMA_CLRFF		2
-#define ISA_DMA_PGHI		3
-#define ISA_DMA_PGLO		4
-#define ISA_DMA_ADDR		5
-#define ISA_DMA_COUNT		6
-
-static unsigned int isa_dma_port[8][7] = {
-	/* MASK   MODE   CLRFF  PAGE_HI PAGE_LO ADDR COUNT */
-	{  0x0a,  0x0b,  0x0c,  0x487,  0x087,  0x00, 0x01 },
-	{  0x0a,  0x0b,  0x0c,  0x483,  0x083,  0x02, 0x03 },
-	{  0x0a,  0x0b,  0x0c,  0x481,  0x081,  0x04, 0x05 },
-	{  0x0a,  0x0b,  0x0c,  0x482,  0x082,  0x06, 0x07 },
-	{  0xd4,  0xd6,  0xd8,  0x000,  0x000,  0xc0, 0xc2 },
-	{  0xd4,  0xd6,  0xd8,  0x48b,  0x08b,  0xc4, 0xc6 },
-	{  0xd4,  0xd6,  0xd8,  0x489,  0x089,  0xc8, 0xca },
-	{  0xd4,  0xd6,  0xd8,  0x48a,  0x08a,  0xcc, 0xce }
-};
-
-static int isa_get_dma_residue(unsigned int chan, dma_t *dma)
-{
-	unsigned int io_port = isa_dma_port[chan][ISA_DMA_COUNT];
-	int count;
-
-	count = 1 + inb(io_port);
-	count |= inb(io_port) << 8;
-
-	return chan < 4 ? count : (count << 1);
-}
-
-static struct device isa_dma_dev = {
-	.init_name		= "fallback device",
-	.coherent_dma_mask	= ~(dma_addr_t)0,
-	.dma_mask		= &isa_dma_dev.coherent_dma_mask,
-};
-
-static void isa_enable_dma(unsigned int chan, dma_t *dma)
-{
-	if (dma->invalid) {
-		unsigned long address, length;
-		unsigned int mode;
-		enum dma_data_direction direction;
-
-		mode = (chan & 3) | dma->dma_mode;
-		switch (dma->dma_mode & DMA_MODE_MASK) {
-		case DMA_MODE_READ:
-			direction = DMA_FROM_DEVICE;
-			break;
-
-		case DMA_MODE_WRITE:
-			direction = DMA_TO_DEVICE;
-			break;
-
-		case DMA_MODE_CASCADE:
-			direction = DMA_BIDIRECTIONAL;
-			break;
-
-		default:
-			direction = DMA_NONE;
-			break;
-		}
-
-		if (!dma->sg) {
-			/*
-			 * Cope with ISA-style drivers which expect cache
-			 * coherence.
-			 */
-			dma->sg = &dma->buf;
-			dma->sgcount = 1;
-			dma->buf.length = dma->count;
-			dma->buf.dma_address = dma_map_single(&isa_dma_dev,
-				dma->addr, dma->count,
-				direction);
-		}
-
-		address = dma->buf.dma_address;
-		length  = dma->buf.length - 1;
-
-		outb(address >> 16, isa_dma_port[chan][ISA_DMA_PGLO]);
-		outb(address >> 24, isa_dma_port[chan][ISA_DMA_PGHI]);
-
-		if (chan >= 4) {
-			address >>= 1;
-			length >>= 1;
-		}
-
-		outb(0, isa_dma_port[chan][ISA_DMA_CLRFF]);
-
-		outb(address, isa_dma_port[chan][ISA_DMA_ADDR]);
-		outb(address >> 8, isa_dma_port[chan][ISA_DMA_ADDR]);
-
-		outb(length, isa_dma_port[chan][ISA_DMA_COUNT]);
-		outb(length >> 8, isa_dma_port[chan][ISA_DMA_COUNT]);
-
-		outb(mode, isa_dma_port[chan][ISA_DMA_MODE]);
-		dma->invalid = 0;
-	}
-	outb(chan & 3, isa_dma_port[chan][ISA_DMA_MASK]);
-}
-
-static void isa_disable_dma(unsigned int chan, dma_t *dma)
-{
-	outb(chan | 4, isa_dma_port[chan][ISA_DMA_MASK]);
-}
-
-static struct dma_ops isa_dma_ops = {
-	.type		= "ISA",
-	.enable		= isa_enable_dma,
-	.disable	= isa_disable_dma,
-	.residue	= isa_get_dma_residue,
-};
-
-static struct resource dma_resources[] = { {
-	.name	= "dma1",
-	.start	= 0x0000,
-	.end	= 0x000f
-}, {
-	.name	= "dma low page",
-	.start	= 0x0080,
-	.end 	= 0x008f
-}, {
-	.name	= "dma2",
-	.start	= 0x00c0,
-	.end	= 0x00df
-}, {
-	.name	= "dma high page",
-	.start	= 0x0480,
-	.end	= 0x048f
-} };
-
-static dma_t isa_dma[8];
-
-/*
- * ISA DMA always starts at channel 0
- */
-static int __init isa_dma_init(void)
-{
-	/*
-	 * Try to autodetect presence of an ISA DMA controller.
-	 * We do some minimal initialisation, and check that
-	 * channel 0's DMA address registers are writeable.
-	 */
-	outb(0xff, 0x0d);
-	outb(0xff, 0xda);
-
-	/*
-	 * Write high and low address, and then read them back
-	 * in the same order.
-	 */
-	outb(0x55, 0x00);
-	outb(0xaa, 0x00);
-
-	if (inb(0) == 0x55 && inb(0) == 0xaa) {
-		unsigned int chan, i;
-
-		for (chan = 0; chan < 8; chan++) {
-			isa_dma[chan].d_ops = &isa_dma_ops;
-			isa_disable_dma(chan, NULL);
-		}
-
-		outb(0x40, 0x0b);
-		outb(0x41, 0x0b);
-		outb(0x42, 0x0b);
-		outb(0x43, 0x0b);
-
-		outb(0xc0, 0xd6);
-		outb(0x41, 0xd6);
-		outb(0x42, 0xd6);
-		outb(0x43, 0xd6);
-
-		outb(0, 0xd4);
-
-		outb(0x10, 0x08);
-		outb(0x10, 0xd0);
-
-		/*
-		 * Is this correct?  According to my documentation, it
-		 * doesn't appear to be.  It should be:
-		 *  outb(0x3f, 0x40b); outb(0x3f, 0x4d6);
-		 */
-		outb(0x30, 0x40b);
-		outb(0x31, 0x40b);
-		outb(0x32, 0x40b);
-		outb(0x33, 0x40b);
-		outb(0x31, 0x4d6);
-		outb(0x32, 0x4d6);
-		outb(0x33, 0x4d6);
-
-		for (i = 0; i < ARRAY_SIZE(dma_resources); i++)
-			request_resource(&ioport_resource, dma_resources + i);
-
-		for (chan = 0; chan < 8; chan++) {
-			int ret = isa_dma_add(chan, &isa_dma[chan]);
-			if (ret)
-				pr_err("ISADMA%u: unable to register: %d\n",
-				       chan, ret);
-		}
-
-		request_dma(DMA_ISA_CASCADE, "cascade");
-	}
-
-	dma_direct_set_offset(&isa_dma_dev, PHYS_OFFSET, BUS_OFFSET, SZ_256M);
-
-	return 0;
-}
-core_initcall(isa_dma_init);
diff --git a/arch/arm/mach-footbridge/ebsa285-pci.c b/arch/arm/mach-footbridge/ebsa285-pci.c
deleted file mode 100644
index c3f280d08fa7..000000000000
--- a/arch/arm/mach-footbridge/ebsa285-pci.c
+++ /dev/null
@@ -1,48 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0
-/*
- * linux/arch/arm/mach-footbridge/ebsa285-pci.c
- *
- * PCI bios-type initialisation for PCI machines
- *
- * Bits taken from various places.
- */
-#include <linux/kernel.h>
-#include <linux/pci.h>
-#include <linux/init.h>
-
-#include <asm/irq.h>
-#include <asm/mach/pci.h>
-#include <asm/mach-types.h>
-
-static int irqmap_ebsa285[] = { IRQ_IN3, IRQ_IN1, IRQ_IN0, IRQ_PCI };
-
-static int ebsa285_map_irq(const struct pci_dev *dev, u8 slot, u8 pin)
-{
-	if (dev->vendor == PCI_VENDOR_ID_CONTAQ &&
-	    dev->device == PCI_DEVICE_ID_CONTAQ_82C693)
-		switch (PCI_FUNC(dev->devfn)) {
-		case 1:	return 14;
-		case 2:	return 15;
-		case 3:	return 12;
-		}
-
-	return irqmap_ebsa285[(slot + pin) & 3];
-}
-
-static struct hw_pci ebsa285_pci __initdata = {
-	.map_irq		= ebsa285_map_irq,
-	.nr_controllers		= 1,
-	.ops			= &dc21285_ops,
-	.setup			= dc21285_setup,
-	.preinit		= dc21285_preinit,
-	.postinit		= dc21285_postinit,
-};
-
-static int __init ebsa285_init_pci(void)
-{
-	if (machine_is_ebsa285())
-		pci_common_init(&ebsa285_pci);
-	return 0;
-}
-
-subsys_initcall(ebsa285_init_pci);
diff --git a/arch/arm/mach-footbridge/ebsa285.c b/arch/arm/mach-footbridge/ebsa285.c
deleted file mode 100644
index 1cb7d674bc81..000000000000
--- a/arch/arm/mach-footbridge/ebsa285.c
+++ /dev/null
@@ -1,124 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0
-/*
- * linux/arch/arm/mach-footbridge/ebsa285.c
- *
- * EBSA285 machine fixup
- */
-#include <linux/init.h>
-#include <linux/io.h>
-#include <linux/spinlock.h>
-#include <linux/slab.h>
-#include <linux/leds.h>
-
-#include <asm/hardware/dec21285.h>
-#include <asm/mach-types.h>
-
-#include <asm/mach/arch.h>
-
-#include "common.h"
-
-/* LEDs */
-#if defined(CONFIG_NEW_LEDS) && defined(CONFIG_LEDS_CLASS)
-#define XBUS_AMBER_L	BIT(0)
-#define XBUS_GREEN_L	BIT(1)
-#define XBUS_RED_L	BIT(2)
-#define XBUS_TOGGLE	BIT(7)
-
-struct ebsa285_led {
-	struct led_classdev     cdev;
-	u8                      mask;
-};
-
-/*
- * The triggers lines up below will only be used if the
- * LED triggers are compiled in.
- */
-static const struct {
-	const char *name;
-	const char *trigger;
-} ebsa285_leds[] = {
-	{ "ebsa285:amber", "cpu0", },
-	{ "ebsa285:green", "heartbeat", },
-	{ "ebsa285:red",},
-};
-
-static unsigned char hw_led_state;
-static void __iomem *xbus;
-
-static void ebsa285_led_set(struct led_classdev *cdev,
-		enum led_brightness b)
-{
-	struct ebsa285_led *led = container_of(cdev,
-			struct ebsa285_led, cdev);
-
-	if (b == LED_OFF)
-		hw_led_state |= led->mask;
-	else
-		hw_led_state &= ~led->mask;
-	writeb(hw_led_state, xbus);
-}
-
-static enum led_brightness ebsa285_led_get(struct led_classdev *cdev)
-{
-	struct ebsa285_led *led = container_of(cdev,
-			struct ebsa285_led, cdev);
-
-	return hw_led_state & led->mask ? LED_OFF : LED_FULL;
-}
-
-static int __init ebsa285_leds_init(void)
-{
-	int i;
-
-	if (!machine_is_ebsa285())
-		return -ENODEV;
-
-	xbus = ioremap(XBUS_CS2, SZ_4K);
-	if (!xbus)
-		return -ENOMEM;
-
-	/* 3 LEDS all off */
-	hw_led_state = XBUS_AMBER_L | XBUS_GREEN_L | XBUS_RED_L;
-	writeb(hw_led_state, xbus);
-
-	for (i = 0; i < ARRAY_SIZE(ebsa285_leds); i++) {
-		struct ebsa285_led *led;
-
-		led = kzalloc_obj(*led);
-		if (!led)
-			break;
-
-		led->cdev.name = ebsa285_leds[i].name;
-		led->cdev.brightness_set = ebsa285_led_set;
-		led->cdev.brightness_get = ebsa285_led_get;
-		led->cdev.default_trigger = ebsa285_leds[i].trigger;
-		led->mask = BIT(i);
-
-		if (led_classdev_register(NULL, &led->cdev) < 0) {
-			kfree(led);
-			break;
-		}
-	}
-
-	return 0;
-}
-
-/*
- * Since we may have triggers on any subsystem, defer registration
- * until after subsystem_init.
- */
-fs_initcall(ebsa285_leds_init);
-#endif
-
-MACHINE_START(EBSA285, "EBSA285")
-	/* Maintainer: Russell King */
-	.atag_offset	= 0x100,
-	.video_start	= 0x000a0000,
-	.video_end	= 0x000bffff,
-	.map_io		= footbridge_map_io,
-	.init_early	= footbridge_sched_clock,
-	.init_irq	= footbridge_init_irq,
-	.init_time	= footbridge_timer_init,
-	.restart	= footbridge_restart,
-MACHINE_END
-
diff --git a/arch/arm/mach-footbridge/include/mach/hardware.h b/arch/arm/mach-footbridge/include/mach/hardware.h
deleted file mode 100644
index 985ad3a95671..000000000000
--- a/arch/arm/mach-footbridge/include/mach/hardware.h
+++ /dev/null
@@ -1,90 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0-only */
-/*
- *  arch/arm/mach-footbridge/include/mach/hardware.h
- *
- *  Copyright (C) 1998-1999 Russell King.
- *
- *  This file contains the hardware definitions of the EBSA-285.
- */
-#ifndef __ASM_ARCH_HARDWARE_H
-#define __ASM_ARCH_HARDWARE_H
-
-/*   Virtual      Physical	Size
- * 0xff800000	0x40000000	1MB	X-Bus
- * 0xff000000	0x7c000000	1MB	PCI I/O space
- * 0xfe000000	0x42000000	1MB	CSR
- * 0xfd000000	0x78000000	1MB	Outbound write flush (not supported)
- * 0xfc000000	0x79000000	1MB	PCI IACK/special space
- * 0xfb000000	0x7a000000	16MB	PCI Config type 1
- * 0xfa000000	0x7b000000	16MB	PCI Config type 0
- * 0xf9000000	0x50000000	1MB	Cache flush
- * 0xf0000000	0x80000000	16MB	ISA memory
- */
-
-#define XBUS_SIZE		0x00100000
-#define XBUS_BASE		0xff800000
-
-#define ARMCSR_SIZE		0x00100000
-#define ARMCSR_BASE		0xfe000000
-
-#define WFLUSH_SIZE		0x00100000
-#define WFLUSH_BASE		0xfd000000
-
-#define PCIIACK_SIZE		0x00100000
-#define PCIIACK_BASE		0xfc000000
-
-#define PCICFG1_SIZE		0x01000000
-#define PCICFG1_BASE		0xfb000000
-
-#define PCICFG0_SIZE		0x01000000
-#define PCICFG0_BASE		0xfa000000
-
-#define PCIMEM_SIZE		0x01000000
-#define PCIMEM_BASE		0xf0000000
-
-#define XBUS_CS2		0x40012000
-
-#define XBUS_SWITCH		((volatile unsigned char *)(XBUS_BASE + 0x12000))
-#define XBUS_SWITCH_SWITCH	((*XBUS_SWITCH) & 15)
-#define XBUS_SWITCH_J17_13	((*XBUS_SWITCH) & (1 << 4))
-#define XBUS_SWITCH_J17_11	((*XBUS_SWITCH) & (1 << 5))
-#define XBUS_SWITCH_J17_9	((*XBUS_SWITCH) & (1 << 6))
-
-#define UNCACHEABLE_ADDR	(ARMCSR_BASE + 0x108)	/* CSR_ROMBASEMASK */
-
-
-/* PIC irq control */
-#define PIC_LO			0x20
-#define PIC_MASK_LO		0x21
-#define PIC_HI			0xA0
-#define PIC_MASK_HI		0xA1
-
-/* GPIO pins */
-#define GPIO_CCLK		0x800
-#define GPIO_DSCLK		0x400
-#define GPIO_E2CLK		0x200
-#define GPIO_IOLOAD		0x100
-#define GPIO_RED_LED		0x080
-#define GPIO_WDTIMER		0x040
-#define GPIO_DATA		0x020
-#define GPIO_IOCLK		0x010
-#define GPIO_DONE		0x008
-#define GPIO_FAN		0x004
-#define GPIO_GREEN_LED		0x002
-#define GPIO_RESET		0x001
-
-/* CPLD pins */
-#define CPLD_DS_ENABLE		8
-#define CPLD_7111_DISABLE	4
-#define CPLD_UNMUTE		2
-#define CPLD_FLASH_WR_ENABLE	1
-
-#ifndef __ASSEMBLY__
-extern raw_spinlock_t nw_gpio_lock;
-extern void nw_gpio_modify_op(unsigned int mask, unsigned int set);
-extern void nw_gpio_modify_io(unsigned int mask, unsigned int in);
-extern unsigned int nw_gpio_read(void);
-extern void nw_cpld_modify(unsigned int mask, unsigned int set);
-#endif
-
-#endif
diff --git a/arch/arm/mach-footbridge/include/mach/irqs.h b/arch/arm/mach-footbridge/include/mach/irqs.h
deleted file mode 100644
index a5f41846ab9c..000000000000
--- a/arch/arm/mach-footbridge/include/mach/irqs.h
+++ /dev/null
@@ -1,97 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0 */
-/*
- * arch/arm/mach-footbridge/include/mach/irqs.h
- *
- * Copyright (C) 1998 Russell King
- * Copyright (C) 1998 Phil Blundell
- *
- * Changelog:
- *  20-Jan-1998	RMK	Started merge of EBSA286, CATS and NetWinder
- *  01-Feb-1999	PJB	ISA IRQs start at 0 not 16
- */
-#include <asm/mach-types.h>
-
-#define NR_IRQS			36
-#define NR_DC21285_IRQS		16
-
-#define _ISA_IRQ(x)		(0 + (x))
-#define _ISA_INR(x)		((x) - 0)
-#define _DC21285_IRQ(x)		(16 + (x))
-#define _DC21285_INR(x)		((x) - 16)
-
-/*
- * This is a list of all interrupts that the 21285
- * can generate and we handle.
- */
-#define IRQ_CONRX		_DC21285_IRQ(0)
-#define IRQ_CONTX		_DC21285_IRQ(1)
-#define IRQ_TIMER1		_DC21285_IRQ(2)
-#define IRQ_TIMER2		_DC21285_IRQ(3)
-#define IRQ_TIMER3		_DC21285_IRQ(4)
-#define IRQ_IN0			_DC21285_IRQ(5)
-#define IRQ_IN1			_DC21285_IRQ(6)
-#define IRQ_IN2			_DC21285_IRQ(7)
-#define IRQ_IN3			_DC21285_IRQ(8)
-#define IRQ_DOORBELLHOST	_DC21285_IRQ(9)
-#define IRQ_DMA1		_DC21285_IRQ(10)
-#define IRQ_DMA2		_DC21285_IRQ(11)
-#define IRQ_PCI			_DC21285_IRQ(12)
-#define IRQ_SDRAMPARITY		_DC21285_IRQ(13)
-#define IRQ_I2OINPOST		_DC21285_IRQ(14)
-#define IRQ_PCI_ABORT		_DC21285_IRQ(15)
-#define IRQ_PCI_SERR		_DC21285_IRQ(16)
-#define IRQ_DISCARD_TIMER	_DC21285_IRQ(17)
-#define IRQ_PCI_DPERR		_DC21285_IRQ(18)
-#define IRQ_PCI_PERR		_DC21285_IRQ(19)
-
-#define IRQ_ISA_TIMER		_ISA_IRQ(0)
-#define IRQ_ISA_KEYBOARD	_ISA_IRQ(1)
-#define IRQ_ISA_CASCADE		_ISA_IRQ(2)
-#define IRQ_ISA_UART2		_ISA_IRQ(3)
-#define IRQ_ISA_UART		_ISA_IRQ(4)
-#define IRQ_ISA_FLOPPY		_ISA_IRQ(6)
-#define IRQ_ISA_PRINTER		_ISA_IRQ(7)
-#define IRQ_ISA_RTC_ALARM	_ISA_IRQ(8)
-#define IRQ_ISA_2		_ISA_IRQ(9)
-#define IRQ_ISA_PS2MOUSE	_ISA_IRQ(12)
-#define IRQ_ISA_HARDDISK1	_ISA_IRQ(14)
-#define IRQ_ISA_HARDDISK2	_ISA_IRQ(15)
-
-#define IRQ_MASK_UART_RX	(1 << 2)
-#define IRQ_MASK_UART_TX	(1 << 3)
-#define IRQ_MASK_TIMER1		(1 << 4)
-#define IRQ_MASK_TIMER2		(1 << 5)
-#define IRQ_MASK_TIMER3		(1 << 6)
-#define IRQ_MASK_IN0		(1 << 8)
-#define IRQ_MASK_IN1		(1 << 9)
-#define IRQ_MASK_IN2		(1 << 10)
-#define IRQ_MASK_IN3		(1 << 11)
-#define IRQ_MASK_DOORBELLHOST	(1 << 15)
-#define IRQ_MASK_DMA1		(1 << 16)
-#define IRQ_MASK_DMA2		(1 << 17)
-#define IRQ_MASK_PCI		(1 << 18)
-#define IRQ_MASK_SDRAMPARITY	(1 << 24)
-#define IRQ_MASK_I2OINPOST	(1 << 25)
-#define IRQ_MASK_PCI_ABORT	((1 << 29) | (1 << 30))
-#define IRQ_MASK_PCI_SERR	(1 << 23)
-#define IRQ_MASK_DISCARD_TIMER	(1 << 27)
-#define IRQ_MASK_PCI_DPERR	(1 << 28)
-#define IRQ_MASK_PCI_PERR	(1 << 31)
-
-/*
- * Netwinder interrupt allocations
- */
-#define IRQ_NETWINDER_ETHER10	IRQ_IN0
-#define IRQ_NETWINDER_ETHER100	IRQ_IN1
-#define IRQ_NETWINDER_VIDCOMP	IRQ_IN2
-#define IRQ_NETWINDER_PS2MOUSE	_ISA_IRQ(5)
-#define IRQ_NETWINDER_IR	_ISA_IRQ(6)
-#define IRQ_NETWINDER_BUTTON	_ISA_IRQ(10)
-#define IRQ_NETWINDER_VGA	_ISA_IRQ(11)
-#define IRQ_NETWINDER_SOUND	_ISA_IRQ(12)
-
-#define I8042_KBD_IRQ	IRQ_ISA_KEYBOARD
-#define I8042_AUX_IRQ	(machine_is_netwinder() ? IRQ_NETWINDER_PS2MOUSE : IRQ_ISA_PS2MOUSE)
-#define IRQ_FLOPPYDISK	IRQ_ISA_FLOPPY
-
-#define irq_canonicalize(_i)	(((_i) == IRQ_ISA_CASCADE) ? IRQ_ISA_2 : _i)
diff --git a/arch/arm/mach-footbridge/include/mach/isa-dma.h b/arch/arm/mach-footbridge/include/mach/isa-dma.h
deleted file mode 100644
index b10731a1f66a..000000000000
--- a/arch/arm/mach-footbridge/include/mach/isa-dma.h
+++ /dev/null
@@ -1,18 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0 */
-/*
- *  arch/arm/mach-footbridge/include/mach/isa-dma.h
- *
- *  Architecture DMA routines
- *
- *  Copyright (C) 1998,1999 Russell King
- *  Copyright (C) 1998,1999 Philip Blundell
- */
-#ifndef __ASM_ARCH_DMA_H
-#define __ASM_ARCH_DMA_H
-
-#define MAX_DMA_CHANNELS	8
-
-#define DMA_FLOPPY		(2)
-#define DMA_ISA_CASCADE		(4)
-
-#endif /* _ASM_ARCH_DMA_H */
diff --git a/arch/arm/mach-footbridge/include/mach/memory.h b/arch/arm/mach-footbridge/include/mach/memory.h
deleted file mode 100644
index 9516877667d7..000000000000
--- a/arch/arm/mach-footbridge/include/mach/memory.h
+++ /dev/null
@@ -1,26 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0-only */
-/*
- *  arch/arm/mach-footbridge/include/mach/memory.h
- *
- *  Copyright (C) 1996-1999 Russell King.
- *
- *  Changelog:
- *   20-Oct-1996 RMK	Created
- *   31-Dec-1997 RMK	Fixed definitions to reduce warnings.
- *   17-May-1998 DAG	Added __virt_to_bus and __bus_to_virt functions.
- *   21-Nov-1998 RMK	Changed __virt_to_bus and __bus_to_virt to macros.
- *   21-Mar-1999 RMK	Added PAGE_OFFSET for co285 architecture.
- *			Renamed to memory.h
- *			Moved PAGE_OFFSET and TASK_SIZE here
- */
-#ifndef __ASM_ARCH_MEMORY_H
-#define __ASM_ARCH_MEMORY_H
-
-/*
- * Cache flushing area.
- */
-#define FLUSH_BASE		0xf9000000
-
-#define FLUSH_BASE_PHYS		0x50000000
-
-#endif
diff --git a/arch/arm/mach-footbridge/include/mach/uncompress.h b/arch/arm/mach-footbridge/include/mach/uncompress.h
deleted file mode 100644
index 28b577e29db3..000000000000
--- a/arch/arm/mach-footbridge/include/mach/uncompress.h
+++ /dev/null
@@ -1,34 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0-only */
-/*
- *  arch/arm/mach-footbridge/include/mach/uncompress.h
- *
- *  Copyright (C) 1996-1999 Russell King
- */
-#include <asm/mach-types.h>
-
-/*
- * Note! This could cause problems on the NetWinder
- */
-#define DC21285_BASE ((volatile unsigned int *)0x42000160)
-#define SER0_BASE    ((volatile unsigned char *)0x7c0003f8)
-
-static inline void putc(char c)
-{
-	if (machine_is_netwinder()) {
-		while ((SER0_BASE[5] & 0x60) != 0x60)
-			barrier();
-		SER0_BASE[0] = c;
-	} else {
-		while (DC21285_BASE[6] & 8);
-		DC21285_BASE[0] = c;
-	}
-}
-
-static inline void flush(void)
-{
-}
-
-/*
- * nothing to do
- */
-#define arch_decomp_setup()
diff --git a/arch/arm/mach-footbridge/isa-irq.c b/arch/arm/mach-footbridge/isa-irq.c
deleted file mode 100644
index 48c7b3efd555..000000000000
--- a/arch/arm/mach-footbridge/isa-irq.c
+++ /dev/null
@@ -1,177 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0-only
-/*
- *  linux/arch/arm/mach-footbridge/irq.c
- *
- *  Copyright (C) 1996-2000 Russell King
- *
- *  Changelog:
- *   22-Aug-1998 RMK	Restructured IRQ routines
- *   03-Sep-1998 PJB	Merged CATS support
- *   20-Jan-1998 RMK	Started merge of EBSA286, CATS and NetWinder
- *   26-Jan-1999 PJB	Don't use IACK on CATS
- *   16-Mar-1999 RMK	Added autodetect of ISA PICs
- */
-#include <linux/ioport.h>
-#include <linux/interrupt.h>
-#include <linux/list.h>
-#include <linux/init.h>
-#include <linux/io.h>
-#include <linux/spinlock.h>
-
-#include <asm/mach/irq.h>
-
-#include <mach/hardware.h>
-#include <asm/hardware/dec21285.h>
-#include <asm/irq.h>
-#include <asm/mach-types.h>
-
-#include "common.h"
-
-static void isa_mask_pic_lo_irq(struct irq_data *d)
-{
-	unsigned int mask = 1 << (d->irq & 7);
-
-	outb(inb(PIC_MASK_LO) | mask, PIC_MASK_LO);
-}
-
-static void isa_ack_pic_lo_irq(struct irq_data *d)
-{
-	unsigned int mask = 1 << (d->irq & 7);
-
-	outb(inb(PIC_MASK_LO) | mask, PIC_MASK_LO);
-	outb(0x20, PIC_LO);
-}
-
-static void isa_unmask_pic_lo_irq(struct irq_data *d)
-{
-	unsigned int mask = 1 << (d->irq & 7);
-
-	outb(inb(PIC_MASK_LO) & ~mask, PIC_MASK_LO);
-}
-
-static struct irq_chip isa_lo_chip = {
-	.irq_ack	= isa_ack_pic_lo_irq,
-	.irq_mask	= isa_mask_pic_lo_irq,
-	.irq_unmask	= isa_unmask_pic_lo_irq,
-};
-
-static void isa_mask_pic_hi_irq(struct irq_data *d)
-{
-	unsigned int mask = 1 << (d->irq & 7);
-
-	outb(inb(PIC_MASK_HI) | mask, PIC_MASK_HI);
-}
-
-static void isa_ack_pic_hi_irq(struct irq_data *d)
-{
-	unsigned int mask = 1 << (d->irq & 7);
-
-	outb(inb(PIC_MASK_HI) | mask, PIC_MASK_HI);
-	outb(0x62, PIC_LO);
-	outb(0x20, PIC_HI);
-}
-
-static void isa_unmask_pic_hi_irq(struct irq_data *d)
-{
-	unsigned int mask = 1 << (d->irq & 7);
-
-	outb(inb(PIC_MASK_HI) & ~mask, PIC_MASK_HI);
-}
-
-static struct irq_chip isa_hi_chip = {
-	.irq_ack	= isa_ack_pic_hi_irq,
-	.irq_mask	= isa_mask_pic_hi_irq,
-	.irq_unmask	= isa_unmask_pic_hi_irq,
-};
-
-static void isa_irq_handler(struct irq_desc *desc)
-{
-	unsigned int isa_irq = *(unsigned char *)PCIIACK_BASE;
-
-	if (isa_irq < _ISA_IRQ(0) || isa_irq >= _ISA_IRQ(16)) {
-		handle_bad_irq(desc);
-		return;
-	}
-
-	generic_handle_irq(isa_irq);
-}
-
-static struct resource pic1_resource = {
-	.name	= "pic1",
-	.start	= 0x20,
-	.end	= 0x3f,
-};
-
-static struct resource pic2_resource = {
-	.name	= "pic2",
-	.start	= 0xa0,
-	.end	= 0xbf,
-};
-
-void __init isa_init_irq(unsigned int host_irq)
-{
-	unsigned int irq;
-
-	/*
-	 * Setup, and then probe for an ISA PIC
-	 * If the PIC is not there, then we
-	 * ignore the PIC.
-	 */
-	outb(0x11, PIC_LO);
-	outb(_ISA_IRQ(0), PIC_MASK_LO);	/* IRQ number		*/
-	outb(0x04, PIC_MASK_LO);	/* Slave on Ch2		*/
-	outb(0x01, PIC_MASK_LO);	/* x86			*/
-	outb(0xf5, PIC_MASK_LO);	/* pattern: 11110101	*/
-
-	outb(0x11, PIC_HI);
-	outb(_ISA_IRQ(8), PIC_MASK_HI);	/* IRQ number		*/
-	outb(0x02, PIC_MASK_HI);	/* Slave on Ch1		*/
-	outb(0x01, PIC_MASK_HI);	/* x86			*/
-	outb(0xfa, PIC_MASK_HI);	/* pattern: 11111010	*/
-
-	outb(0x0b, PIC_LO);
-	outb(0x0b, PIC_HI);
-
-	if (inb(PIC_MASK_LO) == 0xf5 && inb(PIC_MASK_HI) == 0xfa) {
-		outb(0xff, PIC_MASK_LO);/* mask all IRQs	*/
-		outb(0xff, PIC_MASK_HI);/* mask all IRQs	*/
-	} else {
-		printk(KERN_INFO "IRQ: ISA PIC not found\n");
-		host_irq = (unsigned int)-1;
-	}
-
-	if (host_irq != (unsigned int)-1) {
-		for (irq = _ISA_IRQ(0); irq < _ISA_IRQ(8); irq++) {
-			irq_set_chip_and_handler(irq, &isa_lo_chip,
-						 handle_level_irq);
-			irq_clear_status_flags(irq, IRQ_NOREQUEST | IRQ_NOPROBE);
-		}
-
-		for (irq = _ISA_IRQ(8); irq < _ISA_IRQ(16); irq++) {
-			irq_set_chip_and_handler(irq, &isa_hi_chip,
-						 handle_level_irq);
-			irq_clear_status_flags(irq, IRQ_NOREQUEST | IRQ_NOPROBE);
-		}
-
-		request_resource(&ioport_resource, &pic1_resource);
-		request_resource(&ioport_resource, &pic2_resource);
-
-		irq = IRQ_ISA_CASCADE;
-		if (request_irq(irq, no_action, 0, "cascade", NULL))
-			pr_err("Failed to request irq %u (cascade)\n", irq);
-
-		irq_set_chained_handler(host_irq, isa_irq_handler);
-
-		/*
-		 * On the NetWinder, don't automatically
-		 * enable ISA IRQ11 when it is requested.
-		 * There appears to be a missing pull-up
-		 * resistor on this line.
-		 */
-		if (machine_is_netwinder())
-			irq_modify_status(_ISA_IRQ(11),
-				IRQ_NOREQUEST | IRQ_NOPROBE, IRQ_NOAUTOEN);
-	}
-}
-
-
diff --git a/arch/arm/mach-footbridge/isa-rtc.c b/arch/arm/mach-footbridge/isa-rtc.c
deleted file mode 100644
index 237b828dd2f1..000000000000
--- a/arch/arm/mach-footbridge/isa-rtc.c
+++ /dev/null
@@ -1,57 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0
-/*
- *  arch/arm/mach-footbridge/isa-rtc.c
- *
- *  Copyright (C) 1998 Russell King.
- *  Copyright (C) 1998 Phil Blundell
- *
- * CATS has a real-time clock, though the evaluation board doesn't.
- *
- * Changelog:
- *  21-Mar-1998	RMK	Created
- *  27-Aug-1998	PJB	CATS support
- *  28-Dec-1998	APH	Made leds optional
- *  20-Jan-1999	RMK	Started merge of EBSA285, CATS and NetWinder
- *  16-Mar-1999	RMK	More support for EBSA285-like machines with RTCs in
- */
-
-#define RTC_PORT(x)		(0x70+(x))
-#define RTC_ALWAYS_BCD		0
-
-#include <linux/init.h>
-#include <linux/mc146818rtc.h>
-#include <linux/io.h>
-
-#include "common.h"
-
-void __init isa_rtc_init(void)
-{
-	int reg_d, reg_b;
-
-	/*
-	 * Probe for the RTC.
-	 */
-	reg_d = CMOS_READ(RTC_REG_D);
-
-	/*
-	 * make sure the divider is set
-	 */
-	CMOS_WRITE(RTC_REF_CLCK_32KHZ, RTC_REG_A);
-
-	/*
-	 * Set control reg B
-	 *   (24 hour mode, update enabled)
-	 */
-	reg_b = CMOS_READ(RTC_REG_B) & 0x7f;
-	reg_b |= 2;
-	CMOS_WRITE(reg_b, RTC_REG_B);
-
-	if ((CMOS_READ(RTC_REG_A) & 0x7f) == RTC_REF_CLCK_32KHZ &&
-	    CMOS_READ(RTC_REG_B) == reg_b) {
-		/*
-		 * We have a RTC.  Check the battery
-		 */
-		if ((reg_d & 0x80) == 0)
-			printk(KERN_WARNING "RTC: *** warning: CMOS battery bad\n");
-	}
-}
diff --git a/arch/arm/mach-footbridge/isa-timer.c b/arch/arm/mach-footbridge/isa-timer.c
deleted file mode 100644
index 723e3eae995d..000000000000
--- a/arch/arm/mach-footbridge/isa-timer.c
+++ /dev/null
@@ -1,36 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0
-/*
- *  linux/arch/arm/mach-footbridge/isa-timer.c
- *
- *  Copyright (C) 1998 Russell King.
- *  Copyright (C) 1998 Phil Blundell
- */
-#include <linux/clockchips.h>
-#include <linux/i8253.h>
-#include <linux/init.h>
-#include <linux/interrupt.h>
-#include <linux/irq.h>
-#include <linux/spinlock.h>
-#include <linux/timex.h>
-
-#include <asm/irq.h>
-#include <asm/mach/time.h>
-
-#include "common.h"
-
-static irqreturn_t pit_timer_interrupt(int irq, void *dev_id)
-{
-	struct clock_event_device *ce = dev_id;
-	ce->event_handler(ce);
-	return IRQ_HANDLED;
-}
-
-void __init isa_timer_init(void)
-{
-	clocksource_i8253_init();
-
-	if (request_irq(i8253_clockevent.irq, pit_timer_interrupt,
-			IRQF_TIMER | IRQF_IRQPOLL, "pit", &i8253_clockevent))
-		pr_err("Failed to request irq %d(pit)\n", i8253_clockevent.irq);
-	clockevent_i8253_init(false);
-}
diff --git a/arch/arm/mach-footbridge/isa.c b/arch/arm/mach-footbridge/isa.c
deleted file mode 100644
index 84caccddce44..000000000000
--- a/arch/arm/mach-footbridge/isa.c
+++ /dev/null
@@ -1,94 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0-only
-/*
- *  linux/arch/arm/mach-footbridge/isa.c
- *
- *  Copyright (C) 2004 Russell King.
- */
-#include <linux/init.h>
-#include <linux/serial_8250.h>
-
-#include <asm/irq.h>
-#include <asm/hardware/dec21285.h>
-
-#include "common.h"
-
-static struct resource rtc_resources[] = {
-	[0] = {
-		.start	= 0x70,
-		.end	= 0x73,
-		.flags	= IORESOURCE_IO,
-	},
-	[1] = {
-		.start	= IRQ_ISA_RTC_ALARM,
-		.end	= IRQ_ISA_RTC_ALARM,
-		.flags	= IORESOURCE_IRQ,
-	}
-};
-
-static struct platform_device rtc_device = {
-	.name		= "rtc_cmos",
-	.id		= -1,
-	.resource	= rtc_resources,
-	.num_resources	= ARRAY_SIZE(rtc_resources),
-};
-
-static struct resource serial_resources[] = {
-	[0] = {
-		.start	= 0x3f8,
-		.end	= 0x3ff,
-		.flags	= IORESOURCE_IO,
-	},
-	[1] = {
-		.start	= 0x2f8,
-		.end	= 0x2ff,
-		.flags	= IORESOURCE_IO,
-	},
-};
-
-static struct plat_serial8250_port serial_platform_data[] = {
-	{
-		.iobase		= 0x3f8,
-		.irq		= IRQ_ISA_UART,
-		.uartclk	= 1843200,
-		.regshift	= 0,
-		.iotype		= UPIO_PORT,
-		.flags		= UPF_BOOT_AUTOCONF | UPF_SKIP_TEST,
-	},
-	{
-		.iobase		= 0x2f8,
-		.irq		= IRQ_ISA_UART2,
-		.uartclk	= 1843200,
-		.regshift	= 0,
-		.iotype		= UPIO_PORT,
-		.flags		= UPF_BOOT_AUTOCONF | UPF_SKIP_TEST,
-	},
-	{ },
-};
-
-static struct platform_device serial_device = {
-	.name			= "serial8250",
-	.id			= PLAT8250_DEV_PLATFORM,
-	.dev			= {
-		.platform_data	= serial_platform_data,
-	},
-	.resource		= serial_resources,
-	.num_resources		= ARRAY_SIZE(serial_resources),
-};
-
-static int __init footbridge_isa_init(void)
-{
-	int err = 0;
-
-	/* Personal server doesn't have RTC */
-	isa_rtc_init();
-	err = platform_device_register(&rtc_device);
-	if (err)
-		printk(KERN_ERR "Unable to register RTC device: %d\n", err);
-
-	err = platform_device_register(&serial_device);
-	if (err)
-		printk(KERN_ERR "Unable to register serial device: %d\n", err);
-	return 0;
-}
-
-arch_initcall(footbridge_isa_init);
diff --git a/arch/arm/mach-footbridge/netwinder-hw.c b/arch/arm/mach-footbridge/netwinder-hw.c
deleted file mode 100644
index c024eefd4978..000000000000
--- a/arch/arm/mach-footbridge/netwinder-hw.c
+++ /dev/null
@@ -1,772 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0
-/*
- * linux/arch/arm/mach-footbridge/netwinder-hw.c
- *
- * Netwinder machine fixup
- *
- * Copyright (C) 1998, 1999 Russell King, Phil Blundell
- */
-#include <linux/module.h>
-#include <linux/ioport.h>
-#include <linux/kernel.h>
-#include <linux/delay.h>
-#include <linux/init.h>
-#include <linux/io.h>
-#include <linux/spinlock.h>
-#include <linux/slab.h>
-#include <linux/leds.h>
-
-#include <asm/hardware/dec21285.h>
-#include <asm/mach-types.h>
-#include <asm/setup.h>
-#include <asm/system_misc.h>
-
-#include <asm/mach/arch.h>
-
-#include "common.h"
-
-#define IRDA_IO_BASE		0x180
-#define GP1_IO_BASE		0x338
-#define GP2_IO_BASE		0x33a
-
-/*
- * Winbond WB83977F accessibility stuff
- */
-static inline void wb977_open(void)
-{
-	outb(0x87, 0x370);
-	outb(0x87, 0x370);
-}
-
-static inline void wb977_close(void)
-{
-	outb(0xaa, 0x370);
-}
-
-static inline void wb977_wb(int reg, int val)
-{
-	outb(reg, 0x370);
-	outb(val, 0x371);
-}
-
-static inline void wb977_ww(int reg, int val)
-{
-	outb(reg, 0x370);
-	outb(val >> 8, 0x371);
-	outb(reg + 1, 0x370);
-	outb(val & 255, 0x371);
-}
-
-#define wb977_device_select(dev)	wb977_wb(0x07, dev)
-#define wb977_device_disable()		wb977_wb(0x30, 0x00)
-#define wb977_device_enable()		wb977_wb(0x30, 0x01)
-
-/*
- * This is a lock for accessing ports GP1_IO_BASE and GP2_IO_BASE
- */
-DEFINE_RAW_SPINLOCK(nw_gpio_lock);
-EXPORT_SYMBOL(nw_gpio_lock);
-
-static unsigned int current_gpio_op;
-static unsigned int current_gpio_io;
-static unsigned int current_cpld;
-
-void nw_gpio_modify_op(unsigned int mask, unsigned int set)
-{
-	unsigned int new_gpio, changed;
-
-	new_gpio = (current_gpio_op & ~mask) | set;
-	changed = new_gpio ^ current_gpio_op;
-	current_gpio_op = new_gpio;
-
-	if (changed & 0xff)
-		outb(new_gpio, GP1_IO_BASE);
-	if (changed & 0xff00)
-		outb(new_gpio >> 8, GP2_IO_BASE);
-}
-EXPORT_SYMBOL(nw_gpio_modify_op);
-
-static inline void __gpio_modify_io(int mask, int in)
-{
-	unsigned int new_gpio, changed;
-	int port;
-
-	new_gpio = (current_gpio_io & ~mask) | in;
-	changed = new_gpio ^ current_gpio_io;
-	current_gpio_io = new_gpio;
-
-	changed >>= 1;
-	new_gpio >>= 1;
-
-	wb977_device_select(7);
-
-	for (port = 0xe1; changed && port < 0xe8; changed >>= 1) {
-		wb977_wb(port, new_gpio & 1);
-
-		port += 1;
-		new_gpio >>= 1;
-	}
-
-	wb977_device_select(8);
-
-	for (port = 0xe8; changed && port < 0xec; changed >>= 1) {
-		wb977_wb(port, new_gpio & 1);
-
-		port += 1;
-		new_gpio >>= 1;
-	}
-}
-
-void nw_gpio_modify_io(unsigned int mask, unsigned int in)
-{
-	/* Open up the SuperIO chip */
-	wb977_open();
-
-	__gpio_modify_io(mask, in);
-
-	/* Close up the EFER gate */
-	wb977_close();
-}
-EXPORT_SYMBOL(nw_gpio_modify_io);
-
-unsigned int nw_gpio_read(void)
-{
-	return inb(GP1_IO_BASE) | inb(GP2_IO_BASE) << 8;
-}
-EXPORT_SYMBOL(nw_gpio_read);
-
-/*
- * Initialise the Winbond W83977F global registers
- */
-static inline void wb977_init_global(void)
-{
-	/*
-	 * Enable R/W config registers
-	 */
-	wb977_wb(0x26, 0x40);
-
-	/*
-	 * Power down FDC (not used)
-	 */
-	wb977_wb(0x22, 0xfe);
-
-	/*
-	 * GP12, GP11, CIRRX, IRRXH, GP10
-	 */
-	wb977_wb(0x2a, 0xc1);
-
-	/*
-	 * GP23, GP22, GP21, GP20, GP13
-	 */
-	wb977_wb(0x2b, 0x6b);
-
-	/*
-	 * GP17, GP16, GP15, GP14
-	 */
-	wb977_wb(0x2c, 0x55);
-}
-
-/*
- * Initialise the Winbond W83977F printer port
- */
-static inline void wb977_init_printer(void)
-{
-	wb977_device_select(1);
-
-	/*
-	 * mode 1 == EPP
-	 */
-	wb977_wb(0xf0, 0x01);
-}
-
-/*
- * Initialise the Winbond W83977F keyboard controller
- */
-static inline void wb977_init_keyboard(void)
-{
-	wb977_device_select(5);
-
-	/*
-	 * Keyboard controller address
-	 */
-	wb977_ww(0x60, 0x0060);
-	wb977_ww(0x62, 0x0064);
-
-	/*
-	 * Keyboard IRQ 1, active high, edge trigger
-	 */
-	wb977_wb(0x70, 1);
-	wb977_wb(0x71, 0x02);
-
-	/*
-	 * Mouse IRQ 5, active high, edge trigger
-	 */
-	wb977_wb(0x72, 5);
-	wb977_wb(0x73, 0x02);
-
-	/*
-	 * KBC 8MHz
-	 */
-	wb977_wb(0xf0, 0x40);
-
-	/*
-	 * Enable device
-	 */
-	wb977_device_enable();
-}
-
-/*
- * Initialise the Winbond W83977F Infra-Red device
- */
-static inline void wb977_init_irda(void)
-{
-	wb977_device_select(6);
-
-	/*
-	 * IR base address
-	 */
-	wb977_ww(0x60, IRDA_IO_BASE);
-
-	/*
-	 * IRDA IRQ 6, active high, edge trigger
-	 */
-	wb977_wb(0x70, 6);
-	wb977_wb(0x71, 0x02);
-
-	/*
-	 * RX DMA - ISA DMA 0
-	 */
-	wb977_wb(0x74, 0x00);
-
-	/*
-	 * TX DMA - Disable Tx DMA
-	 */
-	wb977_wb(0x75, 0x04);
-
-	/*
-	 * Append CRC, Enable bank selection
-	 */
-	wb977_wb(0xf0, 0x03);
-
-	/*
-	 * Enable device
-	 */
-	wb977_device_enable();
-}
-
-/*
- * Initialise Winbond W83977F general purpose IO
- */
-static inline void wb977_init_gpio(void)
-{
-	unsigned long flags;
-
-	/*
-	 * Set up initial I/O definitions
-	 */
-	current_gpio_io = -1;
-	__gpio_modify_io(-1, GPIO_DONE | GPIO_WDTIMER);
-
-	wb977_device_select(7);
-
-	/*
-	 * Group1 base address
-	 */
-	wb977_ww(0x60, GP1_IO_BASE);
-	wb977_ww(0x62, 0);
-	wb977_ww(0x64, 0);
-
-	/*
-	 * GP10 (Orage button) IRQ 10, active high, edge trigger
-	 */
-	wb977_wb(0x70, 10);
-	wb977_wb(0x71, 0x02);
-
-	/*
-	 * GP10: Debounce filter enabled, IRQ, input
-	 */
-	wb977_wb(0xe0, 0x19);
-
-	/*
-	 * Enable Group1
-	 */
-	wb977_device_enable();
-
-	wb977_device_select(8);
-
-	/*
-	 * Group2 base address
-	 */
-	wb977_ww(0x60, GP2_IO_BASE);
-
-	/*
-	 * Clear watchdog timer regs
-	 *  - timer disable
-	 */
-	wb977_wb(0xf2, 0x00);
-
-	/*
-	 *  - disable LED, no mouse nor keyboard IRQ
-	 */
-	wb977_wb(0xf3, 0x00);
-
-	/*
-	 *  - timer counting, disable power LED, disable timeouot
-	 */
-	wb977_wb(0xf4, 0x00);
-
-	/*
-	 * Enable group2
-	 */
-	wb977_device_enable();
-
-	/*
-	 * Set Group1/Group2 outputs
-	 */
-	raw_spin_lock_irqsave(&nw_gpio_lock, flags);
-	nw_gpio_modify_op(-1, GPIO_RED_LED | GPIO_FAN);
-	raw_spin_unlock_irqrestore(&nw_gpio_lock, flags);
-}
-
-/*
- * Initialise the Winbond W83977F chip.
- */
-static void __init wb977_init(void)
-{
-	request_region(0x370, 2, "W83977AF configuration");
-
-	/*
-	 * Open up the SuperIO chip
-	 */
-	wb977_open();
-
-	/*
-	 * Initialise the global registers
-	 */
-	wb977_init_global();
-
-	/*
-	 * Initialise the various devices in
-	 * the multi-IO chip.
-	 */
-	wb977_init_printer();
-	wb977_init_keyboard();
-	wb977_init_irda();
-	wb977_init_gpio();
-
-	/*
-	 * Close up the EFER gate
-	 */
-	wb977_close();
-}
-
-void nw_cpld_modify(unsigned int mask, unsigned int set)
-{
-	int msk;
-
-	current_cpld = (current_cpld & ~mask) | set;
-
-	nw_gpio_modify_io(GPIO_DATA | GPIO_IOCLK | GPIO_IOLOAD, 0);
-	nw_gpio_modify_op(GPIO_IOLOAD, 0);
-
-	for (msk = 8; msk; msk >>= 1) {
-		int bit = current_cpld & msk;
-
-		nw_gpio_modify_op(GPIO_DATA | GPIO_IOCLK, bit ? GPIO_DATA : 0);
-		nw_gpio_modify_op(GPIO_IOCLK, GPIO_IOCLK);
-	}
-
-	nw_gpio_modify_op(GPIO_IOCLK|GPIO_DATA, 0);
-	nw_gpio_modify_op(GPIO_IOLOAD|GPIO_DSCLK, GPIO_IOLOAD|GPIO_DSCLK);
-	nw_gpio_modify_op(GPIO_IOLOAD, 0);
-}
-EXPORT_SYMBOL(nw_cpld_modify);
-
-static void __init cpld_init(void)
-{
-	unsigned long flags;
-
-	raw_spin_lock_irqsave(&nw_gpio_lock, flags);
-	nw_cpld_modify(-1, CPLD_UNMUTE | CPLD_7111_DISABLE);
-	raw_spin_unlock_irqrestore(&nw_gpio_lock, flags);
-}
-
-static unsigned char rwa_unlock[] __initdata =
-{ 0x00, 0x00, 0x6a, 0xb5, 0xda, 0xed, 0xf6, 0xfb, 0x7d, 0xbe, 0xdf, 0x6f, 0x37, 0x1b,
-  0x0d, 0x86, 0xc3, 0x61, 0xb0, 0x58, 0x2c, 0x16, 0x8b, 0x45, 0xa2, 0xd1, 0xe8, 0x74,
-  0x3a, 0x9d, 0xce, 0xe7, 0x73, 0x39 };
-
-#ifndef DEBUG
-#define dprintk(x...)
-#else
-#define dprintk(x...) printk(x)
-#endif
-
-#define WRITE_RWA(r,v) do { outb((r), 0x279); udelay(10); outb((v), 0xa79); } while (0)
-
-static inline void rwa010_unlock(void)
-{
-	int i;
-
-	WRITE_RWA(2, 2);
-	mdelay(10);
-
-	for (i = 0; i < sizeof(rwa_unlock); i++) {
-		outb(rwa_unlock[i], 0x279);
-		udelay(10);
-	}
-}
-
-static inline void rwa010_read_ident(void)
-{
-	unsigned char si[9];
-	int i, j;
-
-	WRITE_RWA(3, 0);
-	WRITE_RWA(0, 128);
-
-	outb(1, 0x279);
-
-	mdelay(1);
-
-	dprintk("Identifier: ");
-	for (i = 0; i < 9; i++) {
-		si[i] = 0;
-		for (j = 0; j < 8; j++) {
-			int bit;
-			udelay(250);
-			inb(0x203);
-			udelay(250);
-			bit = inb(0x203);
-			dprintk("%02X ", bit);
-			bit = (bit == 0xaa) ? 1 : 0;
-			si[i] |= bit << j;
-		}
-		dprintk("(%02X) ", si[i]);
-	}
-	dprintk("\n");
-}
-
-static inline void rwa010_global_init(void)
-{
-	WRITE_RWA(6, 2);	// Assign a card no = 2
-
-	dprintk("Card no = %d\n", inb(0x203));
-
-	/* disable the modem section of the chip */
-	WRITE_RWA(7, 3);
-	WRITE_RWA(0x30, 0);
-
-	/* disable the cdrom section of the chip */
-	WRITE_RWA(7, 4);
-	WRITE_RWA(0x30, 0);
-
-	/* disable the MPU-401 section of the chip */
-	WRITE_RWA(7, 2);
-	WRITE_RWA(0x30, 0);
-}
-
-static inline void rwa010_game_port_init(void)
-{
-	int i;
-
-	WRITE_RWA(7, 5);
-
-	dprintk("Slider base: ");
-	WRITE_RWA(0x61, 1);
-	i = inb(0x203);
-
-	WRITE_RWA(0x60, 2);
-	dprintk("%02X%02X (201)\n", inb(0x203), i);
-
-	WRITE_RWA(0x30, 1);
-}
-
-static inline void rwa010_waveartist_init(int base, int irq, int dma)
-{
-	int i;
-
-	WRITE_RWA(7, 0);
-
-	dprintk("WaveArtist base: ");
-	WRITE_RWA(0x61, base & 255);
-	i = inb(0x203);
-
-	WRITE_RWA(0x60, base >> 8);
-	dprintk("%02X%02X (%X),", inb(0x203), i, base);
-
-	WRITE_RWA(0x70, irq);
-	dprintk(" irq: %d (%d),", inb(0x203), irq);
-
-	WRITE_RWA(0x74, dma);
-	dprintk(" dma: %d (%d)\n", inb(0x203), dma);
-
-	WRITE_RWA(0x30, 1);
-}
-
-static inline void rwa010_soundblaster_init(int sb_base, int al_base, int irq, int dma)
-{
-	int i;
-
-	WRITE_RWA(7, 1);
-
-	dprintk("SoundBlaster base: ");
-	WRITE_RWA(0x61, sb_base & 255);
-	i = inb(0x203);
-
-	WRITE_RWA(0x60, sb_base >> 8);
-	dprintk("%02X%02X (%X),", inb(0x203), i, sb_base);
-
-	dprintk(" irq: ");
-	WRITE_RWA(0x70, irq);
-	dprintk("%d (%d),", inb(0x203), irq);
-
-	dprintk(" 8-bit DMA: ");
-	WRITE_RWA(0x74, dma);
-	dprintk("%d (%d)\n", inb(0x203), dma);
-
-	dprintk("AdLib base: ");
-	WRITE_RWA(0x63, al_base & 255);
-	i = inb(0x203);
-
-	WRITE_RWA(0x62, al_base >> 8);
-	dprintk("%02X%02X (%X)\n", inb(0x203), i, al_base);
-
-	WRITE_RWA(0x30, 1);
-}
-
-static void rwa010_soundblaster_reset(void)
-{
-	int i;
-
-	outb(1, 0x226);
-	udelay(3);
-	outb(0, 0x226);
-
-	for (i = 0; i < 5; i++) {
-		if (inb(0x22e) & 0x80)
-			break;
-		mdelay(1);
-	}
-	if (i == 5)
-		printk("SoundBlaster: DSP reset failed\n");
-
-	dprintk("SoundBlaster DSP reset: %02X (AA)\n", inb(0x22a));
-
-	for (i = 0; i < 5; i++) {
-		if ((inb(0x22c) & 0x80) == 0)
-			break;
-		mdelay(1);
-	}
-
-	if (i == 5)
-		printk("SoundBlaster: DSP not ready\n");
-	else {
-		outb(0xe1, 0x22c);
-
-		dprintk("SoundBlaster DSP id: ");
-		i = inb(0x22a);
-		udelay(1);
-		i |= inb(0x22a) << 8;
-		dprintk("%04X\n", i);
-
-		for (i = 0; i < 5; i++) {
-			if ((inb(0x22c) & 0x80) == 0)
-				break;
-			mdelay(1);
-		}
-
-		if (i == 5)
-			printk("SoundBlaster: could not turn speaker off\n");
-
-		outb(0xd3, 0x22c);
-	}
-
-	/* turn on OPL3 */
-	outb(5, 0x38a);
-	outb(1, 0x38b);
-}
-
-static void __init rwa010_init(void)
-{
-	rwa010_unlock();
-	rwa010_read_ident();
-	rwa010_global_init();
-	rwa010_game_port_init();
-	rwa010_waveartist_init(0x250, 3, 7);
-	rwa010_soundblaster_init(0x220, 0x388, 3, 1);
-	rwa010_soundblaster_reset();
-}
-
-/*
- * Initialise any other hardware after we've got the PCI bus
- * initialised.  We may need the PCI bus to talk to this other
- * hardware.
- */
-static int __init nw_hw_init(void)
-{
-	if (machine_is_netwinder()) {
-		wb977_init();
-		cpld_init();
-		rwa010_init();
-	}
-	return 0;
-}
-
-__initcall(nw_hw_init);
-
-/*
- * Older NeTTroms either do not provide a parameters
- * page, or they don't supply correct information in
- * the parameter page.
- */
-static void __init
-fixup_netwinder(struct tag *tags, char **cmdline)
-{
-#ifdef CONFIG_ISAPNP
-	extern int isapnp_disable;
-
-	/*
-	 * We must not use the kernels ISAPnP code
-	 * on the NetWinder - it will reset the settings
-	 * for the WaveArtist chip and render it inoperable.
-	 */
-	isapnp_disable = 1;
-#endif
-}
-
-static void netwinder_restart(enum reboot_mode mode, const char *cmd)
-{
-	if (mode == REBOOT_SOFT) {
-		/* Jump into the ROM */
-		soft_restart(0x41000000);
-	} else {
-		local_irq_disable();
-		local_fiq_disable();
-
-		/* open up the SuperIO chip */
-		outb(0x87, 0x370);
-		outb(0x87, 0x370);
-
-		/* aux function group 1 (logical device 7) */
-		outb(0x07, 0x370);
-		outb(0x07, 0x371);
-
-		/* set GP16 for WD-TIMER output */
-		outb(0xe6, 0x370);
-		outb(0x00, 0x371);
-
-		/* set a RED LED and toggle WD_TIMER for rebooting */
-		outb(0xc4, 0x338);
-	}
-}
-
-/* LEDs */
-#if defined(CONFIG_NEW_LEDS) && defined(CONFIG_LEDS_CLASS)
-struct netwinder_led {
-	struct led_classdev     cdev;
-	u8                      mask;
-};
-
-/*
- * The triggers lines up below will only be used if the
- * LED triggers are compiled in.
- */
-static const struct {
-	const char *name;
-	const char *trigger;
-} netwinder_leds[] = {
-	{ "netwinder:green", "heartbeat", },
-	{ "netwinder:red", "cpu0", },
-};
-
-/*
- * The LED control in Netwinder is reversed:
- *  - setting bit means turn off LED
- *  - clearing bit means turn on LED
- */
-static void netwinder_led_set(struct led_classdev *cdev,
-		enum led_brightness b)
-{
-	struct netwinder_led *led = container_of(cdev,
-			struct netwinder_led, cdev);
-	unsigned long flags;
-	u32 reg;
-
-	raw_spin_lock_irqsave(&nw_gpio_lock, flags);
-	reg = nw_gpio_read();
-	if (b != LED_OFF)
-		reg &= ~led->mask;
-	else
-		reg |= led->mask;
-	nw_gpio_modify_op(led->mask, reg);
-	raw_spin_unlock_irqrestore(&nw_gpio_lock, flags);
-}
-
-static enum led_brightness netwinder_led_get(struct led_classdev *cdev)
-{
-	struct netwinder_led *led = container_of(cdev,
-			struct netwinder_led, cdev);
-	unsigned long flags;
-	u32 reg;
-
-	raw_spin_lock_irqsave(&nw_gpio_lock, flags);
-	reg = nw_gpio_read();
-	raw_spin_unlock_irqrestore(&nw_gpio_lock, flags);
-
-	return (reg & led->mask) ? LED_OFF : LED_FULL;
-}
-
-static int __init netwinder_leds_init(void)
-{
-	int i;
-
-	if (!machine_is_netwinder())
-		return -ENODEV;
-
-	for (i = 0; i < ARRAY_SIZE(netwinder_leds); i++) {
-		struct netwinder_led *led;
-
-		led = kzalloc_obj(*led);
-		if (!led)
-			break;
-
-		led->cdev.name = netwinder_leds[i].name;
-		led->cdev.brightness_set = netwinder_led_set;
-		led->cdev.brightness_get = netwinder_led_get;
-		led->cdev.default_trigger = netwinder_leds[i].trigger;
-
-		if (i == 0)
-			led->mask = GPIO_GREEN_LED;
-		else
-			led->mask = GPIO_RED_LED;
-
-		if (led_classdev_register(NULL, &led->cdev) < 0) {
-			kfree(led);
-			break;
-		}
-	}
-
-	return 0;
-}
-
-/*
- * Since we may have triggers on any subsystem, defer registration
- * until after subsystem_init.
- */
-fs_initcall(netwinder_leds_init);
-#endif
-
-MACHINE_START(NETWINDER, "Rebel-NetWinder")
-	/* Maintainer: Russell King/Rebel.com */
-	.atag_offset	= 0x100,
-	.video_start	= 0x000a0000,
-	.video_end	= 0x000bffff,
-	.reserve_lp0	= 1,
-	.reserve_lp2	= 1,
-	.fixup		= fixup_netwinder,
-	.map_io		= footbridge_map_io,
-	.init_irq	= footbridge_init_irq,
-	.init_time	= isa_timer_init,
-	.restart	= netwinder_restart,
-MACHINE_END
diff --git a/arch/arm/mach-footbridge/netwinder-pci.c b/arch/arm/mach-footbridge/netwinder-pci.c
deleted file mode 100644
index e8304392074b..000000000000
--- a/arch/arm/mach-footbridge/netwinder-pci.c
+++ /dev/null
@@ -1,62 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0
-/*
- * linux/arch/arm/mach-footbridge/netwinder-pci.c
- *
- * PCI bios-type initialisation for PCI machines
- *
- * Bits taken from various places.
- */
-#include <linux/kernel.h>
-#include <linux/pci.h>
-#include <linux/init.h>
-
-#include <asm/irq.h>
-#include <asm/mach/pci.h>
-#include <asm/mach-types.h>
-
-/*
- * We now use the slot ID instead of the device identifiers to select
- * which interrupt is routed where.
- */
-static int netwinder_map_irq(const struct pci_dev *dev, u8 slot, u8 pin)
-{
-	switch (slot) {
-	case 0:  /* host bridge */
-		return 0;
-
-	case 9:  /* CyberPro */
-		return IRQ_NETWINDER_VGA;
-
-	case 10: /* DC21143 */
-		return IRQ_NETWINDER_ETHER100;
-
-	case 12: /* Winbond 553 */
-		return IRQ_ISA_HARDDISK1;
-
-	case 13: /* Winbond 89C940F */
-		return IRQ_NETWINDER_ETHER10;
-
-	default:
-		printk(KERN_ERR "PCI: unknown device in slot %s\n",
-			pci_name(dev));
-		return 0;
-	}
-}
-
-static struct hw_pci netwinder_pci __initdata = {
-	.map_irq		= netwinder_map_irq,
-	.nr_controllers		= 1,
-	.ops			= &dc21285_ops,
-	.setup			= dc21285_setup,
-	.preinit		= dc21285_preinit,
-	.postinit		= dc21285_postinit,
-};
-
-static int __init netwinder_pci_init(void)
-{
-	if (machine_is_netwinder())
-		pci_common_init(&netwinder_pci);
-	return 0;
-}
-
-subsys_initcall(netwinder_pci_init);
diff --git a/drivers/video/console/Kconfig b/drivers/video/console/Kconfig
index 9f81af3506da..d8e3d307f50f 100644
--- a/drivers/video/console/Kconfig
+++ b/drivers/video/console/Kconfig
@@ -8,7 +8,6 @@ menu "Console display driver support"
 config VGA_CONSOLE
 	bool "VGA text console" if EXPERT || !X86
 	depends on ALPHA || X86 || \
-		(ARM && ARCH_FOOTBRIDGE) || \
 		(MIPS && (MIPS_MALTA || SIBYTE_BCM112X || SIBYTE_SB1250 || SIBYTE_BCM1x80 || SNI_RM))
 	select APERTURE_HELPERS if (DRM || FB || VFIO_PCI_CORE)
 	default y
@@ -36,7 +35,7 @@ config DUMMY_CONSOLE
 
 config DUMMY_CONSOLE_COLUMNS
 	int "Initial number of console screen columns"
-	depends on DUMMY_CONSOLE && !(ARCH_FOOTBRIDGE && VGA_CONSOLE)
+	depends on DUMMY_CONSOLE
 	default 160 if PARISC
 	default 80
 	help
@@ -46,9 +45,8 @@ config DUMMY_CONSOLE_COLUMNS
 
 config DUMMY_CONSOLE_ROWS
 	int "Initial number of console screen rows"
-	depends on DUMMY_CONSOLE && !(ARCH_FOOTBRIDGE && VGA_CONSOLE)
+	depends on DUMMY_CONSOLE
 	default 64 if PARISC
-	default 30 if ARM
 	default 25
 	help
 	  On PA-RISC, the default value is 64, which should fit a 1280x1024
diff --git a/drivers/video/console/dummycon.c b/drivers/video/console/dummycon.c
index 7d02470f19b9..48ebbc5bf6a8 100644
--- a/drivers/video/console/dummycon.c
+++ b/drivers/video/console/dummycon.c
@@ -18,15 +18,9 @@
  *  Dummy console driver
  */
 
-#if defined(CONFIG_ARCH_FOOTBRIDGE) && defined(CONFIG_VGA_CONSOLE)
-#include <asm/vga.h>
-#define DUMMY_COLUMNS	vgacon_screen_info.orig_video_cols
-#define DUMMY_ROWS	vgacon_screen_info.orig_video_lines
-#else
 /* set by Kconfig. Use 80x25 for 640x480 and 160x64 for 1280x1024 */
 #define DUMMY_COLUMNS	CONFIG_DUMMY_CONSOLE_COLUMNS
 #define DUMMY_ROWS	CONFIG_DUMMY_CONSOLE_ROWS
-#endif
 
 #ifdef CONFIG_FRAMEBUFFER_CONSOLE_DEFERRED_TAKEOVER
 /* These are both protected by the console_lock */
diff --git a/drivers/video/fbdev/cyber2000fb.c b/drivers/video/fbdev/cyber2000fb.c
index 5c7349722125..aa15c7be4fa5 100644
--- a/drivers/video/fbdev/cyber2000fb.c
+++ b/drivers/video/fbdev/cyber2000fb.c
@@ -1723,16 +1723,6 @@ static int cyberpro_pci_probe(struct pci_dev *dev,
 	cfb->mclk_mult = cyber2000_grphr(EXT_MCLK_MULT, cfb);
 	cfb->mclk_div  = cyber2000_grphr(EXT_MCLK_DIV, cfb);
 
-#ifdef __arm__
-	/*
-	 * MCLK on the NetWinder and the Shark is fixed at 75MHz
-	 */
-	if (machine_is_netwinder()) {
-		cfb->mclk_mult = 0xdb;
-		cfb->mclk_div  = 0x54;
-	}
-#endif
-
 	err = cyberpro_common_probe(cfb);
 	if (err)
 		goto failed;
-- 
2.53.0

