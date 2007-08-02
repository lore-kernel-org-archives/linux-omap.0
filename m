From: Paul Walmsley <paul@pwsan.com>
Subject: [PATCH 00/22] omap2 clock: Bugfixes and cleanups in OMAP2 clock
	framework
Date: Thu, 02 Aug 2007 12:10:02 -0600
Message-ID: <20070802181002.792550043@pwsan.com>
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

Hello,

this patch series contains bugfixes and code cleanups for the OMAP2
clock framework.  Highlights include:

- VLYNQ clock fixes

- Addition of "fixed divisor" clock setup, for clocks that follow their
  parents' rates divided by a fixed divisor, like iva1_mpu_int_ifck and
  func_12m_ck

- Removal of several 2420-only clocks from 2430

- Fix "clock.c: Enable for dpll_ck without enable code" boot message

- osc_ck/sys_ck rate initialization fixes in omap2_get_crystal_rate()

- And many other minor fixes

These patches have been boot-tested on N800.  Comments, review, and
further testing are welcome.

- Paul


diffstat:

 arch/arm/mach-omap2/clock.c                      |  777 +++++++++++------------
 arch/arm/mach-omap2/clock.h                      |  362 ++++------
 include/asm-arm/arch-omap/clock.h                |    7
 linux-omap/arch/arm/mach-omap2/clock.c           |    5
 linux-omap/arch/arm/mach-omap2/clock.h           |   10
 linux-omap/arch/arm/mach-omap2/cm_regbits_24xx.h |    4
 linux-omap/arch/arm/mach-omap2/memory.c          |   50 +
 linux-omap/arch/arm/mach-omap2/memory.h          |    2
 linux-omap/include/asm-arm/arch-omap/clock.h     |    7
 9 files changed, 635 insertions(+), 589 deletions(-)

Object size change:

  text    data     bss     dec     hex filename
2839692  142692  138404 3120788  2f9e94 vmlinux.orig
2840280  143180  138404 3121864  2fa2c8 vmlinux.patched

--
