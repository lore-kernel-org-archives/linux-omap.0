From: Tony Lindgren <tony@atomide.com>
Subject: [GIT PULL 1/5] omap1 soc changes for v4.19
Date: Wed, 11 Jul 2018 06:19:04 -0700
Message-ID: <pull-1531314878-371161@atomide.com>
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
Cc: Tony Lindgren <tony@atomide.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Aaro Koskinen <aaro.koskinen@iki.fi>
List-Id: linux-omap@vger.kernel.org

From: "Tony Lindgren" <tony@atomide.com>

The following changes since commit ce397d215ccd07b8ae3f71db689aedb85d56ab40:

  Linux 4.18-rc1 (2018-06-17 08:04:49 +0900)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap tags/omap-for-v4.19/omap1-v2-signed

for you to fetch changes up to d08605a64e67944eaecfb0e6340f633e01376951:

  ARM: OMAP1: ams-delta: move late devices back to init_machine (2018-07-02 23:07:54 -0700)

----------------------------------------------------------------
SoC updates for omap1 for v4.19 merge window

Mostly a series by Janusz Krzysztofik to clean up the
GPIO and input handling for ams-delta. Because of the
platform data changes, we decided that it's best to
merge the related input changes also via the arm-soc
tree so Dmitry Torokhov has acked the input changes.

Also included is a change to constify gpio_leds from
Arvind Yadav.

----------------------------------------------------------------
Arvind Yadav (1):
      ARM: OMAP1: constify gpio_led

Janusz Krzysztofik (13):
      ARM: OMAP1: ams-delta: refactor late_init()
      ARM: OMAP1: ams-delta: assign LED GPIO numbers from descriptors
      ARM: OMAP1: ams-delta: drop GPIO lookup table for serio device
      Input: ams_delta_serio: convert to platform driver
      Input: ams_delta_serio: use private structure
      Input: ams_delta_serio: Replace power GPIO with regulator
      ARM: OMAP1: ams-delta: Hog "keybrd_dataout" GPIO pin
      ARM: OMAP1: ams-delta FIQ: don't use static GPIO numbers
      ARM: OMAP1: ams-delta FIQ: Keep serio input GPIOs requested
      ARM: OMAP1: Get rid of <mach/ams-delta-fiq.h>
      Input: ams_delta_serio: use IRQ resource
      Input: ams_delta_serio: Get FIQ buffer from platform_data
      ARM: OMAP1: ams-delta: move late devices back to init_machine

 MAINTAINERS                                        |   1 +
 arch/arm/mach-omap1/ams-delta-fiq-handler.S        |   5 +-
 arch/arm/mach-omap1/ams-delta-fiq.c                | 113 ++++++--
 arch/arm/mach-omap1/ams-delta-fiq.h                |  42 +++
 arch/arm/mach-omap1/board-ams-delta.c              | 301 +++++++++++++++++----
 arch/arm/mach-omap1/board-h2.c                     |   2 +-
 arch/arm/mach-omap1/board-h3.c                     |   2 +-
 arch/arm/mach-omap1/board-htcherald.c              |   2 +-
 arch/arm/mach-omap1/board-osk.c                    |   4 +-
 drivers/input/serio/ams_delta_serio.c              | 198 +++++++-------
 .../linux/platform_data}/ams-delta-fiq.h           |  31 +--
 11 files changed, 494 insertions(+), 207 deletions(-)
 create mode 100644 arch/arm/mach-omap1/ams-delta-fiq.h
 rename {arch/arm/mach-omap1/include/mach => include/linux/platform_data}/ams-delta-fiq.h (68%)
