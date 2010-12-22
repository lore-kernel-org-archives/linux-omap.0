From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: [GIT PULL v2] OMAP SmartReflex/voltage core for 2.6.38
Date: Wed, 22 Dec 2010 14:51:38 -0800
Message-ID: <87mxnxmnet.fsf@deeprootsystems.com>
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
Sender: linux-arm-kernel-bounces@lists.infradead.org
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Tony Lindgren <tony@atomide.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

Tony,

The following pull request is for the SmartReflex/voltage core for
2.6.38.  

It is updated to include a build fix and exclude a boot breakage on
OMAP2.

Kevin

The following changes since commit f17f9726c27c3921e00a5750e85070e6dd7e1ff7:

  OMAP4: clock data: Add missing fixed divisors (2010-12-22 10:12:46 -0700)

are available in the git repository at:
  ssh://master.kernel.org/pub/scm/linux/kernel/git/khilman/linux-omap-pm.git pm-sr

Benoit Cousson (1):
      OMAP4: hwmod: Add inital data for smartreflex modules.

Thara Gopinath (13):
      OMAP3: PM: Adding voltage driver support.
      OMAP: Introduce voltage domain information in the hwmod structures
      OMAP3: PM: Adding smartreflex driver support.
      OMAP3: PM: Adding smartreflex device file.
      OMAP3: PM: Adding smartreflex hwmod data
      OMAP3: PM: Adding smartreflex class3 driver
      OMAP3: PM: Register TWL4030 pmic info with the voltage driver.
      OMAP3: PM: Adding debug support to Voltage and Smartreflex drivers
      OMAP3: PM: Program correct init voltages for VDD1 and VDD2
      OMAP4: Register voltage PMIC parameters with the voltage layer
      OMAP4: Adding voltage driver support
      OMAP4: PM: Program correct init voltages for scalable VDDs
      OMAP4: Smartreflex framework extensions

 arch/arm/mach-omap2/Makefile                  |   11 +-
 arch/arm/mach-omap2/control.h                 |   29 +
 arch/arm/mach-omap2/omap_hwmod_3xxx_data.c    |  175 +++
 arch/arm/mach-omap2/omap_hwmod_44xx_data.c    |  168 +++
 arch/arm/mach-omap2/omap_twl.c                |  277 +++++
 arch/arm/mach-omap2/pm.c                      |  102 ++
 arch/arm/mach-omap2/pm.h                      |   28 +
 arch/arm/mach-omap2/smartreflex-class3.c      |   59 +
 arch/arm/mach-omap2/smartreflex.c             | 1029 ++++++++++++++++
 arch/arm/mach-omap2/sr_device.c               |  146 +++
 arch/arm/mach-omap2/voltage.c                 | 1571 +++++++++++++++++++++++++
 arch/arm/plat-omap/Kconfig                    |   31 +
 arch/arm/plat-omap/include/plat/omap_hwmod.h  |    5 +
 arch/arm/plat-omap/include/plat/smartreflex.h |  245 ++++
 arch/arm/plat-omap/include/plat/voltage.h     |  146 +++
 15 files changed, 4019 insertions(+), 3 deletions(-)
 create mode 100644 arch/arm/mach-omap2/omap_twl.c
 create mode 100644 arch/arm/mach-omap2/smartreflex-class3.c
 create mode 100644 arch/arm/mach-omap2/smartreflex.c
 create mode 100644 arch/arm/mach-omap2/sr_device.c
 create mode 100644 arch/arm/mach-omap2/voltage.c
 create mode 100644 arch/arm/plat-omap/include/plat/smartreflex.h
 create mode 100644 arch/arm/plat-omap/include/plat/voltage.h
