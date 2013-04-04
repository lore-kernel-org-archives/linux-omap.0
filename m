From: Tony Lindgren <tony@atomide.com>
Subject: [GIT PULL 3/3] omap gpmc changes for v3.10 merge window
Date: Thu, 4 Apr 2013 12:39:56 -0700
Message-ID: <E1UNq1I-0001gH-Ie@merlin.infradead.org>
References: <pull-1365104396-577667>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <pull-1365104396-577667>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

The following changes since commit dca3a783400a18e2bf4503b1d4a85c4d0ca1a7e4:

  Merge commit '31d9adca82ce65e5c99d045b5fd917c702b6fce3' into tmp (2013-04-01 14:33:50 -0500)

are available in the git repository at:


  git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap tags/omap-for-v3.10/gpmc-signed

for you to fetch changes up to aecb65a34a780cd07fbaa652cc5d640f13f3ed5f:

  Merge branch 'omap-gpmc-for-v3.10-take2' of git://github.com/jonhunter/linux into omap-for-v3.10/gpmc (2013-04-04 11:22:33 -0700)

----------------------------------------------------------------

GPMC updates from Jon Hunter <jon-hunter@ti.com>:

Adds GPMC (General Purpose Memory Controller) DT support for
NOR flash and Ethernet and includes various GPMC cleans-up
and fixes.

This series is dependent on commit 7185684 (ARM: OMAP: use
consistent error checking) from RMK's clean-up branch and commit
31d9adc (ARM: OMAP2+: Fix broken gpmc support).

----------------------------------------------------------------
Ezequiel Garcia (8):
      ARM: omap2: gpmc: Mark local scoped functions static
      ARM: omap2: gpmc: Remove unused gpmc_round_ns_to_ticks() function
      ARM: omap2: gpmc: Fix gpmc_cs_reserved() return value
      ARM: omap2: gpmc-nand: Print something useful on CS request failure
      ARM: omap2: gpmc-onenand: Print something useful on CS request failure
      ARM: omap2: gpmc-onenand: Replace pr_err() with dev_err()
      ARM: omap2: gpmc-onenand: Replace printk KERN_ERR with dev_warn()
      ARM: omap2: gpmc: Remove redundant chip select out of range check

Javier Martinez Canillas (3):
      ARM: OMAP2+: return -ENODEV if GPMC child device creation fails
      ARM: OMAP2+: rename gpmc_probe_nor_child() to gpmc_probe_generic_child()
      ARM: OMAP2+: Add GPMC DT support for Ethernet child nodes

Jon Hunter (17):
      ARM: OMAP2+: Simplify code configuring ONENAND devices
      ARM: OMAP2+: Add variable to store number of GPMC waitpins
      ARM: OMAP2+: Add structure for storing GPMC settings
      ARM: OMAP2+: Add function for configuring GPMC settings
      ARM: OMAP2+: Convert ONENAND to use gpmc_cs_program_settings()
      ARM: OMAP2+: Convert NAND to use gpmc_cs_program_settings()
      ARM: OMAP2+: Convert SMC91x to use gpmc_cs_program_settings()
      ARM: OMAP2+: Convert TUSB to use gpmc_cs_program_settings()
      ARM: OMAP2+: Don't configure of chip-select options in gpmc_cs_configure()
      ARM: OMAP2+: Add function to read GPMC settings from device-tree
      ARM: OMAP2+: Add additional GPMC timing parameters
      ARM: OMAP2+: Add device-tree support for NOR flash
      ARM: OMAP2+: Convert NAND to retrieve GPMC settings from DT
      ARM: OMAP2+: Convert ONENAND to retrieve GPMC settings from DT
      ARM: OMAP2+: Detect incorrectly aligned GPMC base address
      ARM: OMAP2+: Remove unnecesssary GPMC definitions and variable
      ARM: OMAP2+: Allow GPMC probe to complete even if CS mapping fails

Mark Jackson (1):
      ARM: OMAP: Clear GPMC bits when applying new setting.

Tony Lindgren (1):
      Merge branch 'omap-gpmc-for-v3.10-take2' of git://github.com/jonhunter/linux into omap-for-v3.10/gpmc

 Documentation/devicetree/bindings/bus/ti-gpmc.txt  | 103 ++--
 Documentation/devicetree/bindings/mtd/gpmc-nor.txt |  98 ++++
 .../devicetree/bindings/mtd/gpmc-onenand.txt       |   3 +
 Documentation/devicetree/bindings/net/gpmc-eth.txt |  97 ++++
 arch/arm/mach-omap2/gpmc-nand.c                    |  42 +-
 arch/arm/mach-omap2/gpmc-onenand.c                 | 118 ++---
 arch/arm/mach-omap2/gpmc-smc91x.c                  |  30 +-
 arch/arm/mach-omap2/gpmc.c                         | 544 +++++++++++++++------
 arch/arm/mach-omap2/gpmc.h                         |  43 +-
 arch/arm/mach-omap2/usb-tusb6010.c                 |  62 ++-
 10 files changed, 831 insertions(+), 309 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/mtd/gpmc-nor.txt
 create mode 100644 Documentation/devicetree/bindings/net/gpmc-eth.txt
