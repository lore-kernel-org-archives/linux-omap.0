From: Tony Lindgren <tony@atomide.com>
Subject: [GIT PULL 3/6] am335x and am437x pm for v4.17
Date: Mon,  5 Mar 2018 10:11:03 -0800
Message-ID: <pull-1520273005-304551@atomide.com-3>
References: <pull-1520273005-304551@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <pull-1520273005-304551@atomide.com>
In-Reply-To: <pull-1520273005-304551@atomide.com>
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
Cc: Tony Lindgren <tony@atomide.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

From: "Tony Lindgren" <tony@atomide.com>

The following changes since commit 7928b2cbe55b2a410a0f5c1f154610059c57b1b2:

  Linux 4.16-rc1 (2018-02-11 15:04:29 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap tags/omap-for-v4.17/am-pm-signed

for you to fetch changes up to afe761f8d3e99155b76833421e76553a3ac69577:

  soc: ti: Add pm33xx driver for basic suspend support (2018-02-27 08:53:46 -0800)

----------------------------------------------------------------
Add am335x and am437x PM code for v4.17

This series of changes from Dave Gerlach adds the PM related
code to allow low-power suspend states. The code consists of
the SoC specific assembly code and a related PM driver.

----------------------------------------------------------------
Dave Gerlach (4):
      ARM: OMAP2+: Introduce low-level suspend code for AM33XX
      ARM: OMAP2+: Introduce low-level suspend code for AM43XX
      ARM: OMAP2+: pm33xx-core: Add platform code needed for PM
      soc: ti: Add pm33xx driver for basic suspend support

 Documentation/devicetree/bindings/arm/omap/mpu.txt |  16 +
 arch/arm/mach-omap2/Kconfig                        |   1 +
 arch/arm/mach-omap2/Makefile                       |  16 +
 arch/arm/mach-omap2/common.h                       |   7 +
 arch/arm/mach-omap2/io.c                           |   2 +
 arch/arm/mach-omap2/pm-asm-offsets.c               |  31 ++
 arch/arm/mach-omap2/pm.h                           |   3 +
 arch/arm/mach-omap2/pm33xx-core.c                  | 189 ++++++++++
 arch/arm/mach-omap2/sleep33xx.S                    | 214 ++++++++++++
 arch/arm/mach-omap2/sleep43xx.S                    | 387 +++++++++++++++++++++
 drivers/soc/ti/Kconfig                             |   9 +
 drivers/soc/ti/Makefile                            |   1 +
 drivers/soc/ti/pm33xx.c                            | 349 +++++++++++++++++++
 include/linux/platform_data/pm33xx.h               |  42 +++
 14 files changed, 1267 insertions(+)
 create mode 100644 arch/arm/mach-omap2/pm-asm-offsets.c
 create mode 100644 arch/arm/mach-omap2/pm33xx-core.c
 create mode 100644 arch/arm/mach-omap2/sleep33xx.S
 create mode 100644 arch/arm/mach-omap2/sleep43xx.S
 create mode 100644 drivers/soc/ti/pm33xx.c
 create mode 100644 include/linux/platform_data/pm33xx.h
