From: Tony Lindgren <tony@atomide.com>
Subject: [GIT PULL] omap soc regression fixes for v5.0-rc cycle
Date: Thu, 31 Jan 2019 07:44:37 -0800
Message-ID: <pull-1548949376-511005@atomide.com>
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
To: arm@kernel.org
Cc: Tony Lindgren <tony@atomide.com>, linux-omap@vger.kernel.org, Daniel Lezcano <daniel.lezcano@linaro.org>, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

From: "Tony Lindgren" <tony@atomide.com>

The following changes since commit 063c20e12f8bbbc10cabc2413606b140085beb62:

  ARM: dts: am335x-shc.dts: fix wrong cd pin level (2019-01-23 16:14:33 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap tags/omap-for-v5.0/fixes-rc4

for you to fetch changes up to dc30e70391376ba3987aeb856ae6d9c0706534f1:

  ARM: OMAP2+: Variable "reg" in function omap4_dsi_mux_pads() could be uninitialized (2019-01-29 08:54:22 -0800)

----------------------------------------------------------------
SoC fixes for omaps for v5.0-rc cycle

This series contains two SoC regression fixes and one uninitialized
variable fix:

- Fix inverted nirq pin handling for omap5 that started producing
  warnings with earlier GIC direction checks and took a while to
  understand and confirm. Basically there are two sys_nirq pins
  that are bypassing peripheral modules and inverted automatically
  by the SoC and need to be handled with a custom irq_set_type()

- Recent ti-sysc changes caused a regression to the pwm-omap-dmtimer
  code where the device tree handling code for timer source clock
  gets confused. It looks like we can remove that code eventually,
  but for now we just drop a bogus pm_runtime_irq_safe() for the
  timers with the related quirks caused by pm_runtime_irq_safe(),
  and have the standard assigned-clocks and assigned-clock-parents
  deal with setting the source clock

- Fix potentially uninitialized value for display init code if
  regmap_read() fails

----------------------------------------------------------------
Tony Lindgren (5):
      clocksource: timer-ti-dm: Fix pwm dmtimer usage of fck reparenting
      ARM: OMAP5+: Fix inverted nirq pin interrupts with irq_set_type
      bus: ti-sysc: Fix timer handling with drop pm_runtime_irq_safe()
      ARM: dts: Configure clock parent for pwm vibra
      Merge branch 'pwm-dmtimer-fixes' into omap-for-v5.0/fixes-v2

Yizhuo (1):
      ARM: OMAP2+: Variable "reg" in function omap4_dsi_mux_pads() could be uninitialized

 arch/arm/boot/dts/omap4-droid4-xt894.dts  | 11 ++++++++++
 arch/arm/boot/dts/omap5-board-common.dtsi |  9 +++++---
 arch/arm/boot/dts/omap5-cm-t54.dts        | 12 ++++++++++-
 arch/arm/mach-omap2/display.c             |  7 +++++-
 arch/arm/mach-omap2/omap-wakeupgen.c      | 36 ++++++++++++++++++++++++++++++-
 drivers/bus/ti-sysc.c                     |  6 +++---
 drivers/clocksource/timer-ti-dm.c         |  5 ++++-
 7 files changed, 76 insertions(+), 10 deletions(-)
