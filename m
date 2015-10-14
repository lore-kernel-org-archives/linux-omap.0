From: Tony Lindgren <tony@atomide.com>
Subject: [GIT PULL 1/2] omap clean-up for v4.4
Date: Wed, 14 Oct 2015 14:38:58 -0700
Message-ID: <48138.5306724862$1444858815@news.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: arm@kernel.org
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

The following changes since commit 049e6dde7e57f0054fdc49102e7ef4830c698b46:

  Linux 4.3-rc4 (2015-10-04 16:57:17 +0100)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap tags/omap-for-v4.4/cleanup-pt1

for you to fetch changes up to d42f265a5d7a352d40fa2911666cd5236bc3ccaf:

  ARM: OMAP3: clock: remove un-used core dpll re-program code (2015-10-14 12:35:27 -0700)

----------------------------------------------------------------
Clean-up for omaps for v4.4 merge window:

- Remove legacy omap3 ISP code as the driver is DT only

- Remove VoiceBlue board support as it's been unused over
  10 years now

- Remove unused polarity control macros for TWL

- Remove two unneeded semicolons

- Remove unused core dpll code for reprogramming the rates

Note that this branch is against v4.3-rc4 as that contains critical
MMC related fixes to boot with MMC working on most omaps.

----------------------------------------------------------------
Javier Martinez Canillas (2):
      ARM: OMAP3: vc: Remove unused macros
      ARM: OMAP2+: Remove unneeded semicolons

Ladislav Michl (1):
      ARM: OMAP1: Remove board support for VoiceBlue board

Laurent Pinchart (1):
      ARM: OMAP2+: Remove legacy OMAP3 ISP instantiation

Tero Kristo (1):
      ARM: OMAP3: clock: remove un-used core dpll re-program code

 arch/arm/mach-omap1/Kconfig                        |   7 -
 arch/arm/mach-omap1/Makefile                       |   1 -
 arch/arm/mach-omap1/board-voiceblue.c              | 296 ------------------
 arch/arm/mach-omap1/include/mach/board-voiceblue.h |  19 --
 arch/arm/mach-omap2/Makefile                       |   3 -
 arch/arm/mach-omap2/clkt34xx_dpll3m2.c             | 122 --------
 arch/arm/mach-omap2/devices.c                      |  53 ----
 arch/arm/mach-omap2/devices.h                      |  19 --
 arch/arm/mach-omap2/pm44xx.c                       |   2 +-
 arch/arm/mach-omap2/powerdomains3xxx_data.c        |   2 +-
 arch/arm/mach-omap2/sram.c                         |  25 --
 arch/arm/mach-omap2/sram.h                         |  14 -
 arch/arm/mach-omap2/sram34xx.S                     | 346 ---------------------
 arch/arm/mach-omap2/vc.c                           |   4 -
 14 files changed, 2 insertions(+), 911 deletions(-)
 delete mode 100644 arch/arm/mach-omap1/board-voiceblue.c
 delete mode 100644 arch/arm/mach-omap1/include/mach/board-voiceblue.h
 delete mode 100644 arch/arm/mach-omap2/clkt34xx_dpll3m2.c
 delete mode 100644 arch/arm/mach-omap2/devices.h
 delete mode 100644 arch/arm/mach-omap2/sram34xx.S
