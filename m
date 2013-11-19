From: Tony Lindgren <tony@atomide.com>
Subject: [GIT PULL] few more omap fixes for v3.13 merge window
Date: Tue, 19 Nov 2013 11:48:26 -0800
Message-ID: <10445.3890621246$1384890545@news.gmane.org>
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

The following changes since commit 26273e02a0cf18eb72416559310d3294390a9024:

  ARM: OMAP2+: Fix build for dra7xx without omap4 and 5 (2013-11-15 08:27:29 -0800)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap tags/omap-for-v3.13/more-fixes-for-merge-window-take2

for you to fetch changes up to b2ff4790612bbfa3433cc92e56445c2a40098e2c:

  ARM: OMAP2+: Remove legacy omap4_twl6030_hsmmc_init (2013-11-18 16:24:58 -0800)

----------------------------------------------------------------
Few more fixes for issues found booting older omaps using device tree.
Also few randconfig build fixes and removal of some dead code for omap4
as it no longer has legacy platform data based booting support.

----------------------------------------------------------------
Tony Lindgren (9):
      i2c: omap: Fix missing device tree flags for omap2
      ARM: OMAP2+: Fix GPMC and simplify bootloader timings for 8250 and smc91x
      ARM: dts: Fix omap2 specific dtsi files by adding the missing entries
      ARM: OMAP2+: More randconfig fixes for reconfigure_io_chain
      gpio: twl4030: Fix regression for twl gpio output
      gpio: twl4030: Fix passing of pdata in the device tree case
      ARM: OMAP2+: Fix undefined reference to set_cntfreq
      ARM: OMAP2+: Remove legacy mux code for display.c
      ARM: OMAP2+: Remove legacy omap4_twl6030_hsmmc_init

 Documentation/devicetree/bindings/i2c/i2c-omap.txt |  3 +-
 arch/arm/boot/dts/omap-zoom-common.dtsi            |  2 +-
 arch/arm/boot/dts/omap2.dtsi                       | 96 ++++++++++++++++++++++
 arch/arm/boot/dts/omap2420.dtsi                    | 23 ++++++
 arch/arm/boot/dts/omap2430.dtsi                    | 49 +++++++++++
 arch/arm/mach-omap2/Makefile                       |  6 +-
 arch/arm/mach-omap2/common.h                       |  1 -
 arch/arm/mach-omap2/display.c                      | 78 ------------------
 arch/arm/mach-omap2/gpmc.c                         | 58 +++++--------
 arch/arm/mach-omap2/omap-secure.h                  |  7 ++
 arch/arm/mach-omap2/omap4-common.c                 | 57 -------------
 arch/arm/mach-omap2/prm44xx_54xx.h                 |  2 +-
 drivers/gpio/gpio-twl4030.c                        | 13 ++-
 drivers/i2c/busses/i2c-omap.c                      | 22 +++++
 14 files changed, 232 insertions(+), 185 deletions(-)
