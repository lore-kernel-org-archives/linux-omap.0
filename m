From: Omar Ramirez Luna <omar.ramirez@ti.com>
Subject: [PATCH 00/02] staging: tidspbridge: 2.6.37-rcX fixes
Date: Wed, 10 Nov 2010 19:50:23 -0600
Message-ID: <1289440225-27221-1-git-send-email-omar.ramirez@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <devel-bounces@linuxdriverproject.org>
List-Unsubscribe: <http://driverdev.linuxdriverproject.org/mailman/options/devel>,
	<mailto:devel-request@linuxdriverproject.org?subject=unsubscribe>
List-Archive: <http://driverdev.linuxdriverproject.org/pipermail/devel>
List-Post: <mailto:devel@linuxdriverproject.org>
List-Help: <mailto:devel-request@linuxdriverproject.org?subject=help>
List-Subscribe: <http://driverdev.linuxdriverproject.org/mailman/listinfo/devel>,
	<mailto:devel-request@linuxdriverproject.org?subject=subscribe>
Sender: devel-bounces@linuxdriverproject.org
Errors-To: devel-bounces@linuxdriverproject.org
To: Greg Kroah-Hartman <gregkh@suse.de>
Cc: devel@driverdev.osuosl.org, Omar Ramirez Luna <omar.ramirez@ti.com>, Russell King <linux@arm.linux.org.uk>, Tony Lindgren <tony@atomide.com>, Felipe Contreras <felipe.contreras@gmail.com>, linux-kernel@vger.kernel.org, Fernando Guzman Lugo <x0095840@ti.com>, linux-omap@vger.kernel.org, Rene Sapiens <rene.sapiens@ti.com>, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

Hi Greg,

Please consider the following patch set for tidspbridge driver in
staging tree, the following has been tested on an omap3430 based board
+ gst-dsp environment. Many thanks to Felipe Contreras for piling this up,
as I'm just propagating his patches.

First two patches:
1. omap: dsp: remove shm from normal memory
2. staging: tidspbridge: hardcode SCM macros while fix is upstreamed

Resolve a couple of build breaks due to adaptations for memblock
and SCM layer.

(2) Is meant as a temporary fix, until the patches to fix this
    (currently in review) are upstreamed. [1]

The rest of the series, is the revert of iommu migration changes. These
are needed because, without modifications made to iommu module, they do not
work; these modifications (on iommu code) didn't make it for the previous
merge window either.

I will avoid posting the reverts (unless required), they can be found
(along with the two patches of this series) at:

git://dev.omapzoom.org/pub/scm/tidspbridge/kernel-dspbridge.git 
	tidspbridge-2.6.37-rc1

Felipe Contreras (14):
  omap: dsp: remove shm from normal memory
  staging: tidspbridge: hardcode SCM macros while fix is upstreamed

  Revert "staging: tidspbridge - update Kconfig to select IOMMU module"
  Revert "staging: tidspbridge - remove dmm custom module"
  Revert "staging: tidspbridge - deprecate reserve/unreserve_memory
    funtions"
  Revert "staging: tidspbridge - remove reserved memory clean up"
  Revert "staging: tidspbridge: remove dw_dmmu_base from cfg_hostres
    struct"
  Revert "staging: tidspbridge - move all iommu related code to a new
    file"
  Revert "staging: tidspbridge - remove hw directory"
  Revert "staging: tidspbridge - fix mmufault support"
  Revert "staging: tidspbridge - remove custom mmu code from
    tiomap3430.c"
  Revert "staging: tidspbridge - rename bridge_brd_mem_map/unmap to a
    proper name"
  Revert "staging: tidspbridge - move shared memory iommu maps to
    tiomap3430.c"
  Revert "staging: tidspbridge: replace iommu custom for opensource
    implementation"

 arch/arm/plat-omap/devices.c                       |    4 +-
 drivers/staging/tidspbridge/Kconfig                |    1 -
 drivers/staging/tidspbridge/Makefile               |    7 +-
 drivers/staging/tidspbridge/core/_deh.h            |    5 +-
 drivers/staging/tidspbridge/core/_tiomap.h         |   19 +-
 drivers/staging/tidspbridge/core/dsp-mmu.c         |  317 ------
 drivers/staging/tidspbridge/core/io_sm.c           |  180 +++-
 drivers/staging/tidspbridge/core/tiomap3430.c      | 1083 ++++++++++++++++++--
 drivers/staging/tidspbridge/core/tiomap3430_pwr.c  |    4 +
 drivers/staging/tidspbridge/core/tiomap_io.c       |   17 +-
 drivers/staging/tidspbridge/core/ue_deh.c          |  115 ++-
 drivers/staging/tidspbridge/hw/EasiGlobal.h        |   41 +
 drivers/staging/tidspbridge/hw/MMUAccInt.h         |   76 ++
 drivers/staging/tidspbridge/hw/MMURegAcM.h         |  225 ++++
 drivers/staging/tidspbridge/hw/hw_defs.h           |   58 ++
 drivers/staging/tidspbridge/hw/hw_mmu.c            |  562 ++++++++++
 drivers/staging/tidspbridge/hw/hw_mmu.h            |  163 +++
 .../tidspbridge/include/dspbridge/cfgdefs.h        |    1 +
 .../staging/tidspbridge/include/dspbridge/dev.h    |   24 +
 .../staging/tidspbridge/include/dspbridge/dmm.h    |   75 ++
 .../staging/tidspbridge/include/dspbridge/drv.h    |   10 +
 .../tidspbridge/include/dspbridge/dsp-mmu.h        |   67 --
 .../tidspbridge/include/dspbridge/dspdefs.h        |   44 +
 .../tidspbridge/include/dspbridge/dspioctl.h       |    7 +
 .../staging/tidspbridge/include/dspbridge/proc.h   |   46 +
 drivers/staging/tidspbridge/pmgr/dev.c             |   63 ++-
 drivers/staging/tidspbridge/pmgr/dmm.c             |  533 ++++++++++
 drivers/staging/tidspbridge/pmgr/dspapi.c          |   34 +-
 drivers/staging/tidspbridge/rmgr/drv.c             |   15 +
 drivers/staging/tidspbridge/rmgr/drv_interface.c   |    2 +
 drivers/staging/tidspbridge/rmgr/node.c            |   48 +-
 drivers/staging/tidspbridge/rmgr/proc.c            |  197 ++++-
 32 files changed, 3471 insertions(+), 572 deletions(-)
 delete mode 100644 drivers/staging/tidspbridge/core/dsp-mmu.c
 create mode 100644 drivers/staging/tidspbridge/hw/EasiGlobal.h
 create mode 100644 drivers/staging/tidspbridge/hw/MMUAccInt.h
 create mode 100644 drivers/staging/tidspbridge/hw/MMURegAcM.h
 create mode 100644 drivers/staging/tidspbridge/hw/hw_defs.h
 create mode 100644 drivers/staging/tidspbridge/hw/hw_mmu.c
 create mode 100644 drivers/staging/tidspbridge/hw/hw_mmu.h
 create mode 100644 drivers/staging/tidspbridge/include/dspbridge/dmm.h
 delete mode 100644 drivers/staging/tidspbridge/include/dspbridge/dsp-mmu.h
 create mode 100644 drivers/staging/tidspbridge/pmgr/dmm.c
