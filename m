From: Tony Lindgren <tony@atomide.com>
Subject: [GIT PULL] omap fixes against v4.5-rc3
Date: Fri, 12 Feb 2016 14:50:18 -0800
Message-ID: <20160212225018.GA3500@atomide.com>
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

The following changes since commit 388f7b1d6e8ca06762e2454d28d6c3c55ad0fe95:

  Linux 4.5-rc3 (2016-02-07 15:38:30 -0800)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap tags/omap-for-v4.5/fixes-rc3-v2

for you to fetch changes up to cf26f1137333251f3515dea31f95775b99df0fd5:

  ARM: OMAP2+: Fix omap_device for module reload on PM runtime forbid (2016-02-12 08:56:52 -0800)

----------------------------------------------------------------
Few fixes for omaps against v4.5-rc3:

- Improve omap_device error message to tell driver writers what is
  wrong after commit 5de85b9d57ab ("PM / runtime: Re-init runtime PM
  states at probe error and driver unbind"). There will be also a
  handful of driver related fixes also queued separately. But adding
  this error message makes it easy to fix any omap_device using
  drivers suffering from this issue so I think it's important to
  have.

- Also related to commit 5de85b9d57ab discussion, let's fix a bug
  where disabling PM runtime via sysfs will also cause the hardware
  state to be different from PM runtime state.

- Fix audio clocks for beagle-x15.

- Use wakeup-source instead of gpio-key,wakeup for the new entries
  that sneaked in during the merge window.

- Fix a legacy booting vs device tree based booting regression for
  n900 where the legacy user space expects to have the device
  revision available in /proc/atags also when booted with device
  tree.

----------------------------------------------------------------
Ivaylo Dimitrov (1):
      ARM: OMAP2+: Set system_rev from ATAGS for n900

Peter Ujfalusi (1):
      ARM: DTS: am57xx-beagle-x15: Select SYS_CLK2 for audio clocks

Sudeep Holla (1):
      ARM: dts: am335x/am57xx: replace gpio-key,wakeup with wakeup-source property

Tony Lindgren (2):
      ARM: OMAP2+: Improve omap_device error for driver writers
      ARM: OMAP2+: Fix omap_device for module reload on PM runtime forbid

 arch/arm/boot/dts/am335x-shc.dts          |  4 ++--
 arch/arm/boot/dts/am57xx-beagle-x15.dts   |  4 ++++
 arch/arm/boot/dts/am57xx-cl-som-am57x.dts |  2 +-
 arch/arm/mach-omap2/board-generic.c       | 22 +++++++++++++++++++++-
 arch/arm/mach-omap2/omap_device.c         | 14 +++++++++++++-
 5 files changed, 41 insertions(+), 5 deletions(-)
