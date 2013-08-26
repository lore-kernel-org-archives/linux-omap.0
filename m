From: Tony Lindgren <tony@atomide.com>
Subject: [GIT PULL 2/2] late dra7xx PRCM and hwmod support for v3.12 merge
 window
Date: Mon, 26 Aug 2013 07:21:36 -0700
Message-ID: <E1VDxgO-0000AP-NK@merlin.infradead.org>
References: <pull-1377526896-974252>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <pull-1377526896-974252>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: arm@kernel.org, Arnd Bergmann <arnd@arndb.de>, Kevin Hilman <khilman@linaro.org>, Olof Johansson <olof@lixom.net>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

The following changes since commit cf470a1b1a741bca00080ebc70968b4f22d9b1ea:

  Merge tag 'dra7-core-support-minus-dt' of git://github.com/rrnayak/linux into omap-for-v3.12/soc (2013-08-14 01:01:41 -0700)

are available in the git repository at:


  git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap tags/omap-for-v3.12/dra7xx-prcm

for you to fetch changes up to e3e1970f892d873e0f01c4516eaf986ae3a91e13:

  Merge tag 'for-v3.12/dra7xx' of git://git.kernel.org/pub/scm/linux/kernel/git/pjw/omap-pending into omap-for-v3.12/soc (2013-08-26 02:53:05 -0700)

----------------------------------------------------------------

Add basic support for devices on dra7xx by adding the PRCM and hwmod
parts the same way as for other omaps. This is still needed in
addition to device tree support for things like power management.

Via Paul Walmsley <paul@pwsan.com>:

This series adds basic TI DRA7xx PRCM and hwmod support.

Basic test logs are available here:

http://www.pwsan.com/omap/testlogs/dra7xx_prcm_devel_v3.12/20130823050445/

Note that DRA7xx could not be tested locally, since I don't have a board.

----------------------------------------------------------------
Ambresh K (7):
      ARM: OMAP: DRA7: PRM: Add DRA7XX register definitions
      ARM: OMAP: DRA7: CM: Add DRA7XX register defines
      ARM: OMAP: DRA7: PRCM: Add DRA7XX local MPU PRCM regsiters
      ARM: OMAP: DRA7: clockdomain: Add DRA7XX data and update header
      ARM: OMAP: DRA7: powerdomain: Add DRA7XX data and update header
      ARM: OMAP: DRA7: hwmod: Create initial DRA7XX SoC data
      ARM: OMAP: DRA7: Enable PM framework initializations

Rajendra Nayak (3):
      ARM: OMAP: DRA7: CM: Add minimal regbit shifts
      ARM: OMAP: DRA7: powerdomain: Handle missing vc/vp
      ARM: OMAP: DRA7: Reuse the omap44xx_restart and fix the device instance

Tony Lindgren (1):
      Merge tag 'for-v3.12/dra7xx' of git://git.kernel.org/.../pjw/omap-pending into omap-for-v3.12/soc

 arch/arm/mach-omap2/Makefile               |    4 +
 arch/arm/mach-omap2/board-generic.c        |    1 +
 arch/arm/mach-omap2/clockdomain.h          |    1 +
 arch/arm/mach-omap2/clockdomains7xx_data.c |  740 ++++++++
 arch/arm/mach-omap2/cm-regbits-7xx.h       |   51 +
 arch/arm/mach-omap2/cm1_7xx.h              |  324 ++++
 arch/arm/mach-omap2/cm2_7xx.h              |  513 ++++++
 arch/arm/mach-omap2/io.c                   |    5 +
 arch/arm/mach-omap2/omap_hwmod.h           |    1 +
 arch/arm/mach-omap2/omap_hwmod_7xx_data.c  | 2724 ++++++++++++++++++++++++++++
 arch/arm/mach-omap2/powerdomain.h          |    1 +
 arch/arm/mach-omap2/powerdomains7xx_data.c |  454 +++++
 arch/arm/mach-omap2/prcm44xx.h             |    5 +
 arch/arm/mach-omap2/prcm_mpu7xx.h          |   78 +
 arch/arm/mach-omap2/prm44xx.c              |   12 +-
 arch/arm/mach-omap2/prm7xx.h               |  678 +++++++
 arch/arm/mach-omap2/prminst44xx.c          |   20 +-
 17 files changed, 5607 insertions(+), 5 deletions(-)
 create mode 100644 arch/arm/mach-omap2/clockdomains7xx_data.c
 create mode 100644 arch/arm/mach-omap2/cm-regbits-7xx.h
 create mode 100644 arch/arm/mach-omap2/cm1_7xx.h
 create mode 100644 arch/arm/mach-omap2/cm2_7xx.h
 create mode 100644 arch/arm/mach-omap2/omap_hwmod_7xx_data.c
 create mode 100644 arch/arm/mach-omap2/powerdomains7xx_data.c
 create mode 100644 arch/arm/mach-omap2/prcm_mpu7xx.h
 create mode 100644 arch/arm/mach-omap2/prm7xx.h
