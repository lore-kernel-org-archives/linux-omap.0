From: Tony Lindgren <tony@atomide.com>
Subject: [GIT PULL 4/5] First round of DT related omap changes
Date: Wed, 29 Feb 2012 12:15:06 -0800
Message-ID: <E1S2pwR-0004lT-RP@merlin.infradead.org>
References: <pull-1330546506-268554>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <pull-1330546506-268554>
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

This contains first set of DT related changes.

Regards,

Tony


The following changes since commit b01543dfe67bb1d191998e90d20534dc354de059:
  Linus Torvalds (1):
        Linux 3.3-rc4

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap dt

Benoit Cousson (10):
      arm/dts: OMAP: Remove bootargs node from board files
      ARM: OMAP2+: kconfig: Enable devicetree by default for OMAP2+ systems
      ARM: OMAP2+: board-generic: Remove un-needed .atag_offset for DT_MACHINE
      ARM: OMAP2+: omap_device: Replace dev_warn by dev_dbg in omap_device_build_from_dt
      ARM: OMAP2+: pm: Do not init statically the SR and voltage layer with DT
      ARM: OMAP1: kconfig: Enable IRQ_DOMAIN by default for OMAP1 platforms
      arm/dts: OMAP3&4: Remove the '0x' prefix for serial nodes
      arm/dts: OMAP4: Add i2c controller nodes
      arm/dts: OMAP3: Add i2c controller nodes
      arm/dts: OMAP4: Update DTS file with new GIC bindings

Tony Lindgren (3):
      Merge branch 'for_3.4/dt_base' of git://git.kernel.org/.../bcousson/linux-omap-dt into dt
      ARM: OMAP2+: Set Kconfig dependencies for PROC_DEVICETREE
      Merge branch 'for_3.4/dts_updates' of git://git.kernel.org/.../bcousson/linux-omap-dt into dt

Vaibhav Hiremath (1):
      arm/dts: Add support for TI OMAP3 EVM board

 arch/arm/boot/dts/omap3-beagle.dts  |    9 --------
 arch/arm/boot/dts/omap3-evm.dts     |   20 ++++++++++++++++++
 arch/arm/boot/dts/omap3.dtsi        |   29 +++++++++++++++++++++++---
 arch/arm/boot/dts/omap4-panda.dts   |    9 --------
 arch/arm/boot/dts/omap4-sdp.dts     |    9 --------
 arch/arm/boot/dts/omap4.dtsi        |   38 ++++++++++++++++++++++++++++++----
 arch/arm/mach-omap2/Kconfig         |    1 -
 arch/arm/mach-omap2/board-generic.c |   12 +++-------
 arch/arm/mach-omap2/pm.c            |    8 +++++++
 arch/arm/plat-omap/Kconfig          |    3 ++
 arch/arm/plat-omap/omap_device.c    |    2 +-
 11 files changed, 94 insertions(+), 46 deletions(-)
 create mode 100644 arch/arm/boot/dts/omap3-evm.dts
