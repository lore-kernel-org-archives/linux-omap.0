From: Tony Lindgren <tony@atomide.com>
Subject: [GIT PULL] omap fixes for v4.6-rc cycle
Date: Thu, 28 Apr 2016 07:50:48 -0700
Message-ID: <20160428145047.GE5995@atomide.com>
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

  git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap tags/omap-for-v4.6/fixes-rc5-signed

for you to fetch changes up to 7472931f7f1e9d91f761dce30107ae345b61a5c3:

  ARM: dts: omap5: fix range of permitted wakeup pinmux registers (2016-04-26 10:16:12 -0700)

----------------------------------------------------------------
Fixes for omaps for v4.6-rc cycle. All dts fixes, mostly
affecting voltages and pinctrl for various device drivers:

- Regulator minimum voltage fixes for omap5

- ISP syscon register offset fix for omap3

- Fix regulator initial modes for n900

- Fix omap5 pinctrl wkup instance size

----------------------------------------------------------------
H. Nikolaus Schaller (1):
      ARM: dts: omap5: fix range of permitted wakeup pinmux registers

Ivaylo Dimitrov (2):
      ARM: dts: omap3: Fix ISP syscon register offset
      ARM: dts: omap3-n900: Specify peripherals LDO regulators initial mode

Tomi Valkeinen (2):
      ARM: dts: omap5-board-common: fix ldo1_reg and ldo4_reg ranges
      ARM: dts: omap5-cm-t54: fix ldo1_reg and ldo4_reg ranges

 arch/arm/boot/dts/omap3-n900.dts          | 9 +++++++++
 arch/arm/boot/dts/omap34xx.dtsi           | 2 +-
 arch/arm/boot/dts/omap5-board-common.dtsi | 4 ++--
 arch/arm/boot/dts/omap5-cm-t54.dts        | 4 ++--
 arch/arm/boot/dts/omap5.dtsi              | 2 +-
 5 files changed, 15 insertions(+), 6 deletions(-)
