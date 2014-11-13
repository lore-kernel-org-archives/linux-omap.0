From: Marek Szyprowski <m.szyprowski@samsung.com>
Subject: [PATCH v8 0/7] Enable L2 cache support on Exynos4210/4x12 SoCs
Date: Thu, 13 Nov 2014 14:18:07 +0100
Message-ID: <1415884694-5868-1-git-send-email-m.szyprowski@samsung.com>
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
To: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: Mark Rutland <mark.rutland@arm.com>, linux-samsung-soc@vger.kernel.org, Russell King - ARM Linux <linux@arm.linux.org.uk>, Arnd Bergmann <arnd@arndb.de>, tony@atomide.com, linus.walleij@linaro.org, Tomasz Figa <tomasz.figa@gmail.com>, drake@endlessm.com, loeliger@gmail.com, Kyungmin Park <kyungmin.park@samsung.com>, Kukjin Kim <kgene.kim@samsung.com>, Olof Johansson <olof@lixom.net>, lauraa@codeaurora.org, linux-omap@vger.kernel.org, Marek Szyprowski <m.szyprowski@samsung.com>
List-Id: linux-omap@vger.kernel.org

This is an updated patchset, which intends to add support for L2 cache
on Exynos4 SoCs on boards running under secure firmware, which requires
certain initialization steps to be done with help of firmware, as
selected registers are writable only from secure mode.

First four patches extend existing support for secure write in L2C driver
to account for design of secure firmware running on Exynos. Namely:
 1) direct read access to certain registers is needed on Exynos, because
    secure firmware calls set several registers at once,
 2) not all boards are running secure firmware, so .write_sec callback
    needs to be installed in Exynos firmware ops initialization code,
 3) write access to {DATA,TAG}_LATENCY_CTRL registers fron non-secure world
    is not allowed and so must use l2c_write_sec as well,
 4) on certain boards, default value of prefetch register is incorrect
    and must be overridden at L2C initialization.
For boards running with firmware that provides access to individual
L2C registers this series should introduce no functional changes. However
since the driver is widely used on other platforms I'd like to kindly ask
any interested people for testing.

Further three patches add implementation of .write_sec and .configure
callbacks for Exynos secure firmware and necessary DT nodes to enable
L2 cache.

Changes in this version tested on Exynos4412-based TRATS2 and OdroidU3+
boards (both with secure firmware). There should be no functional change
for Exynos boards running without secure firmware. I do not have access
to affected non-Exynos boards, so I could not test on them.


Depends on:
 - [PATCH v3 0/5] Firmware-assisted suspend/resume of Exynos SoCs
   (https://lkml.org/lkml/2014/8/26/445)
   available in samsung/pm2 branch in
   git://git.kernel.org/pub/scm/linux/kernel/git/arm/arm-soc.git
 - L2C patches merged to v3.18-rc3


Changelog:
Changes since v7:
(https://lkml.org/lkml/2014/10/29/158)
- rebased onto arm-soc/for-next kernel tree (depends on patches merged to
  v3.18-rc3 and arm-soc/samsung/pm2 branch)
- removed 'ARM: l2c: unify L2C-310 OF initialization error messages' patch
  (no longer needed)

Changes since v6:
(https://lkml.org/lkml/2014/10/27/233)
- changed PL310 to L2C-310 prefix in error messages
- added patch shortening the error message about incorrect associativity

Changes since v5:
(https://lkml.org/lkml/2014/9/24/364)
- rebased onto v3.18-rc2
- added error message about missing properties values

Changes since v4:
(https://lkml.org/lkml/2014/8/26/461)
 - rewrote the code accessing l2x0_saved_regs from assembly code
 - added comment and reworked unconditional call to SMC_CMD_L2X0INVALL


Patch summary:

Tomasz Figa (7):
  ARM: l2c: Refactor the driver to use commit-like interface
  ARM: l2c: Add interface to ask hypervisor to configure L2C
  ARM: l2c: Get outer cache .write_sec callback from mach_desc only if
    not NULL
  ARM: l2c: Add support for overriding prefetch settings
  ARM: EXYNOS: Add .write_sec outer cache callback for L2C-310
  ARM: EXYNOS: Add support for non-secure L2X0 resume
  ARM: dts: exynos4: Add nodes for L2 cache controller

 Documentation/devicetree/bindings/arm/l2cc.txt |  10 +
 arch/arm/boot/dts/exynos4210.dtsi              |   9 +
 arch/arm/boot/dts/exynos4x12.dtsi              |  14 ++
 arch/arm/include/asm/outercache.h              |   3 +
 arch/arm/kernel/irq.c                          |   3 +-
 arch/arm/mach-exynos/firmware.c                |  50 +++++
 arch/arm/mach-exynos/sleep.S                   |  46 +++++
 arch/arm/mm/cache-l2x0.c                       | 270 ++++++++++++++++---------
 8 files changed, 309 insertions(+), 96 deletions(-)

-- 
1.9.2
