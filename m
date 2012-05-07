From: Tony Lindgren <tony@atomide.com>
Subject: [GIT PULL 2/5] omap hwmod cleanup for v3.5 merge window
Date: Mon, 7 May 2012 15:38:42 -0700
Message-ID: <E1SRWa6-0004bp-SW@merlin.infradead.org>
References: <pull-1336430323-742388>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <pull-1336430323-742388>
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

The following changes since commit e816b57a337ea3b755de72bec38c10c864f23015:

  Linux 3.4-rc3 (2012-04-15 18:28:29 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap tags/omap-cleanup-hwmod-for-v3.5

for you to fetch changes up to 9c3a3009f1c66f4a758b1e5d31b6977185d70a56:

  Merge tag 'omap-cleanup-b-for-3.5' of git://git.kernel.org/pub/scm/linux/kernel/git/pjw/omap-pending into cleanup-hwmod (2012-04-19 17:43:42 -0700)

----------------------------------------------------------------

Clean up of hwmod to shrink down the IP block interconnections

----------------------------------------------------------------
Archit Taneja (1):
      ARM: OMAP2/3: VENC hwmods: Remove OCPIF_SWSUP_IDLE flag from VENC slave interface

Fernando Guzman Lugo (1):
      ARM: OMAP2+: hwmod: add softreset delay field and OMAP4 data

Paul Walmsley (30):
      ARM: OMAP2+: hwmod: Revert "ARM: OMAP2+: hwmod: Make omap_hwmod_softreset wait for reset status"
      ARM: OMAP2+: hwmod: control all hardreset lines attached to a hwmod
      ARM: OMAP4: hwmod data: remove pseudo-hwmods associated with hardreset lines
      ARM: OMAP2+: hwmod: revise the IP block reset process
      ARM: OMAP2+: hwmod: reorganize and document the initialization process
      ARM: OMAP2+: hwmod: reorganize and document the reset and configuration process
      ARM: OMAP2+: hwmod: revise hardreset behavior
      ARM: OMAP2+: hwmod: provide a function to return the address space of the MPU RT
      ARM: OMAP2+: hwmod: add omap_hwmod_get_resource_byname()
      ARM: OMAP2+: timer: use a proper interface to get hwmod data
      ARM: OMAP2/3: hwmod data: update old names
      ARM: OMAP3: hwmod data: fix interfaces for the MMC hwmods
      ARM: OMAP3: hwmod data: add DSS->L3 interconnect for 3430ES1
      ARM: OMAP3: hwmod data: GPTIMER12 is attached to a separate interconnect
      ARM: OMAP4: hwmod data: remove bandgap hwmod
      ARM: OMAP4: hwmod data: add OCP_USER_DSP; mark omap44xx_dsp__iva appropriately
      ARM: OMAP4: hwmod data: uncomment some "excluded" hwmods
      ARM: OMAP2+: hwmod: extend OCP_* register offsets from 16 to 32 bits
      ARM: OMAP2+: hwmod: add _find_mpu_rt_port()
      ARM: OMAP2+: hwmod: add function to iterate over struct omap_hwmod_ocp_if
      ARM: OMAP2+: hwmod: consolidate finding the MPU port index and storing it
      ARM: OMAP2+: hwmod: add support for link registration
      ARM: OMAP2+: hwmod data: convert to link registration
      ARM: OMAP: hwmod: remove code support for direct hwmod registration
      ARM: OMAP2+: hwmod data: remove forward declarations, reorganize
      ARM: OMAP2xxx: hwmod data: share common hwmods between OMAP2420 and OMAP2430
      ARM: OMAP2xxx: hwmod data: share common interface data
      ARM: OMAP3: hwmod data: fix IVA interface clock
      ARM: OMAP3: hwmod data: add IVA hard reset lines, main clock, clockdomain
      ARM: OMAP2xxx: hwmod data: start to fix the IVA1, IVA2 and DSP

Tony Lindgren (1):
      Merge tag 'omap-cleanup-b-for-3.5' of git://git.kernel.org/.../pjw/omap-pending into cleanup-hwmod

 arch/arm/mach-omap2/omap_hwmod.c                   | 1160 +++--
 arch/arm/mach-omap2/omap_hwmod_2420_data.c         | 1563 +-----
 arch/arm/mach-omap2/omap_hwmod_2430_data.c         | 2316 +++------
 .../mach-omap2/omap_hwmod_2xxx_interconnect_data.c |  266 +-
 arch/arm/mach-omap2/omap_hwmod_2xxx_ipblock_data.c |  562 +++
 arch/arm/mach-omap2/omap_hwmod_3xxx_data.c         | 5022 +++++++++----------
 arch/arm/mach-omap2/omap_hwmod_44xx_data.c         | 5066 ++++++++------------
 arch/arm/mach-omap2/omap_hwmod_common_data.h       |   71 +-
 arch/arm/mach-omap2/timer.c                        |   15 +-
 arch/arm/plat-omap/include/plat/omap_hwmod.h       |   44 +-
 10 files changed, 6976 insertions(+), 9109 deletions(-)
