From: Tony Lindgren <tony@atomide.com>
Subject: [GIT PULL 2/6] omap cleanup for v3.6 merge window
Date: Sun, 1 Jul 2012 02:01:16 -0700
Message-ID: <E1SlGGO-0003tf-Jx@merlin.infradead.org>
References: <pull-1341133277-501333>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <pull-1341133277-501333>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.infradead.org
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

The following changes since commit 6b16351acbd415e66ba16bf7d473ece1574cf0bc:

  Linux 3.5-rc4 (2012-06-24 12:53:04 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap tags/omap-cleanup-for-v3.6

for you to fetch changes up to 472fd5401561f94698f4c8f9dbbbfbf76ab55626:

  Merge branch 'cleanup-hwmod' into cleanup (2012-06-28 05:47:01 -0700)

----------------------------------------------------------------

Here is some more omap clean-up. The biggest changes are
hwmod, clock, and System Control Module cleanup, and the removal
of the last instance of omap_read/write usage for omap2+ with
the removal of unused USB OHCI Full Speed driver support. The
removed OHCI is only currently used for omap1 as the actively
used omap2+ boards have either MUSB or another instance of
OHCI+EHCI that's more usable.

----------------------------------------------------------------
Kevin Hilman (7):
      ARM: OMAP4: hwmod: rename _enable_module to _omap4_enable_module()
      ARM: OMAP2+: hwmod: use init-time function ptrs for enable/disable module
      ARM: OMAP4: hwmod: drop extra cpu_is check from _wait_target_disable()
      ARM: OMAP2+: hwmod: use init-time function pointer for wait_target_ready
      ARM: OMAP2+: hwmod: use init-time function pointer for hardreset
      ARM: OMAP2+: hwmod: use init-time function pointer for _init_clkdm
      ARM: OMAP2+: CLEANUP: Remove ARCH_OMAPx ifdef from struct dpll_data

Oleg Matcovschi (1):
      ARM: OMAP: dma: Clear status registers on enable/disable irq

Omar Ramirez Luna (2):
      ARM: OMAP2+: control: new APIs to configure boot address and mode
      ARM: OMAP: dsp: interface to control module functions

Paul Walmsley (2):
      ARM: OMAP2+: hwmod: remove prm_clkdm, cm_clkdm; allow hwmods to have no clockdomain
      Merge branches 'clock_cleanup_misc_3.6', 'control_clean_dspbridge_writes_cleanup_3.6', 'hwmod_soc_conditional_cleanup_3.6', 'mcbsp_clock_aliases_cleanup_3.6' and 'remove_clkdm_requirement_from_hwmod_3.6' into omap_cleanup_a_3.6

Peter Ujfalusi (3):
      ARM: OMAP2: Move McBSP fck clock alias to hwmod data for OMAP2420
      ARM: OMAP2: Move McBSP fck clock alias to hwmod data for OMAP2430
      ARM: OMAP3: Move McBSP fck clock alias to hwmod data

Tony Lindgren (6):
      ARM: OMAP3: There is no FS USB controller on omap3
      ARM: OMAP2: Remove legacy USB FS support
      ARM: OMAP: Make FS USB omap1 only
      Merge tag 'omap-cleanup-a-for-3.6' of git://git.kernel.org/.../pjw/omap-pending into cleanup-hwmod
      Merge branches 'cleanup-udc' and 'cleanup-dma' into cleanup
      Merge branch 'cleanup-hwmod' into cleanup

 arch/arm/mach-omap1/board-ams-delta.c              |    2 +-
 arch/arm/mach-omap1/board-generic.c                |    4 +-
 arch/arm/mach-omap1/board-h2.c                     |    2 +-
 arch/arm/mach-omap1/board-h3.c                     |    2 +-
 arch/arm/mach-omap1/board-htcherald.c              |    2 +-
 arch/arm/mach-omap1/board-innovator.c              |    2 +-
 arch/arm/mach-omap1/board-nokia770.c               |    2 +-
 arch/arm/mach-omap1/board-osk.c                    |    2 +-
 arch/arm/mach-omap1/board-palmte.c                 |    2 +-
 arch/arm/mach-omap1/board-palmtt.c                 |    2 +-
 arch/arm/mach-omap1/board-palmz71.c                |    2 +-
 arch/arm/mach-omap1/board-sx1.c                    |    2 +-
 arch/arm/mach-omap1/board-voiceblue.c              |    3 +-
 arch/arm/mach-omap1/clock_data.c                   |    3 +-
 arch/arm/mach-omap1/include/mach/usb.h             |  165 ++++++++
 arch/arm/mach-omap1/usb.c                          |  116 +++++-
 arch/arm/mach-omap2/Kconfig                        |    3 -
 arch/arm/mach-omap2/Makefile                       |    4 -
 arch/arm/mach-omap2/board-2430sdp.c                |   11 -
 arch/arm/mach-omap2/board-apollon.c                |   18 -
 arch/arm/mach-omap2/board-h4.c                     |   13 -
 arch/arm/mach-omap2/clock2420_data.c               |    4 -
 arch/arm/mach-omap2/clock2430_data.c               |   10 -
 arch/arm/mach-omap2/clock3xxx_data.c               |   10 -
 arch/arm/mach-omap2/clockdomain.h                  |    2 -
 arch/arm/mach-omap2/clockdomains2420_data.c        |    2 -
 arch/arm/mach-omap2/clockdomains2430_data.c        |    2 -
 arch/arm/mach-omap2/clockdomains3xxx_data.c        |    2 -
 arch/arm/mach-omap2/clockdomains44xx_data.c        |    2 -
 arch/arm/mach-omap2/clockdomains_common_data.c     |   24 --
 arch/arm/mach-omap2/control.c                      |   43 ++
 arch/arm/mach-omap2/control.h                      |    2 +
 arch/arm/mach-omap2/dsp.c                          |    4 +
 .../include/mach/ctrl_module_core_44xx.h           |    1 +
 arch/arm/mach-omap2/omap_hwmod.c                   |  427 ++++++++++++++------
 arch/arm/mach-omap2/omap_hwmod_2420_data.c         |   10 +
 arch/arm/mach-omap2/omap_hwmod_2430_data.c         |   16 +
 arch/arm/mach-omap2/omap_hwmod_3xxx_data.c         |   23 ++
 arch/arm/mach-omap2/omap_hwmod_44xx_data.c         |    4 +-
 arch/arm/mach-omap2/usb-fs.c                       |  359 ----------------
 arch/arm/plat-omap/Makefile                        |    2 +-
 arch/arm/plat-omap/dma.c                           |   59 ++-
 arch/arm/plat-omap/include/plat/board.h            |   38 --
 arch/arm/plat-omap/include/plat/clock.h            |    2 -
 arch/arm/plat-omap/include/plat/dsp.h              |    3 +
 arch/arm/plat-omap/include/plat/omap_hwmod.h       |    2 +
 arch/arm/plat-omap/include/plat/usb.h              |  196 +--------
 arch/arm/plat-omap/usb.c                           |  145 -------
 drivers/usb/gadget/Kconfig                         |    2 +-
 drivers/usb/gadget/omap_udc.c                      |    3 +-
 drivers/usb/host/Kconfig                           |    2 +-
 drivers/usb/host/ohci-omap.c                       |    7 +-
 drivers/usb/otg/isp1301_omap.c                     |    2 +-
 53 files changed, 747 insertions(+), 1025 deletions(-)
 create mode 100644 arch/arm/mach-omap1/include/mach/usb.h
 delete mode 100644 arch/arm/mach-omap2/clockdomains_common_data.c
 delete mode 100644 arch/arm/mach-omap2/usb-fs.c
 delete mode 100644 arch/arm/plat-omap/usb.c
