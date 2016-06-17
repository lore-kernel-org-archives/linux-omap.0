From: Tony Lindgren <tony@atomide.com>
Subject: [GIT PULL] omap rcu and fiq fixes for v4.7 merge window
Date: Fri, 17 Jun 2016 09:07:54 -0700
Message-ID: <20160617160754.GF22406@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
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

The following changes since commit f55532a0c0b8bb6148f4e07853b876ef73bc69ca:

  Linux 4.6-rc1 (2016-03-26 16:03:24 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap tags/fixes-rcu-fiq-signed

for you to fetch changes up to d279f7a7e95af6bb4b5eaea3527d1f85a28c5cf6:

  ARM: dts: am437x-sk-evm: Reduce i2c0 bus speed for tps65218 (2016-06-17 02:59:04 -0700)

----------------------------------------------------------------
Fixes for omaps for v4.7-rc cycle:

- Two boot warning fixes from the RCU tree that should have gotten
  merged several weeks ago already but did not because of issues
  with who merges them. Paul has now split the RCU warning fixes into
  sets for various maintainers.

- Fix ams-delta FIQ regression caused by omap1 sparse IRQ changes

- Fix PM for omap3 boards using timer12 and gptimer, like the
  original beagleboard

- Fix hangs on am437x-sk-evm by lowering the I2C bus speed

----------------------------------------------------------------
Dave Gerlach (1):
      ARM: dts: am437x-sk-evm: Reduce i2c0 bus speed for tps65218

Janusz Krzysztofik (1):
      ARM: OMAP1: fix ams-delta FIQ handler to work with sparse IRQ

Paul E. McKenney (2):
      arm: Use _rcuidle tracepoint to allow use from idle
      arm: Use _rcuidle for smp_cross_call() tracepoints

Tero Kristo (1):
      ARM: OMAP2+: timer: add probe for clocksources

 arch/arm/boot/dts/am437x-sk-evm.dts              | 2 +-
 arch/arm/kernel/smp.c                            | 2 +-
 arch/arm/mach-omap1/ams-delta-fiq-handler.S      | 6 +++---
 arch/arm/mach-omap1/ams-delta-fiq.c              | 5 +++--
 arch/arm/mach-omap1/include/mach/ams-delta-fiq.h | 2 ++
 arch/arm/mach-omap2/powerdomain.c                | 9 +++++----
 arch/arm/mach-omap2/timer.c                      | 7 +++++--
 7 files changed, 20 insertions(+), 13 deletions(-)
