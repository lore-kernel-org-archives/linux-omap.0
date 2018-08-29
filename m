From: Tony Lindgren <tony@atomide.com>
Subject: [GIT PULL] omap fixes for v4.19-rc cycle
Date: Wed, 29 Aug 2018 14:30:49 -0700
Message-ID: <pull-1535578186-113331@atomide.com>
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
Cc: Tony Lindgren <tony@atomide.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

From: "Tony Lindgren" <tony@atomide.com>

The following changes since commit 5b394b2ddf0347bef56e50c69a58773c94343ff3:

  Linux 4.19-rc1 (2018-08-26 14:11:59 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap tags/omap-for-v4.19/fixes-v2-signed

for you to fetch changes up to 2d59bb602314a4b2593fde267734266b5e872dd0:

  ARM: dts: omap4-droid4: Fix emmc errors seen on some devices (2018-08-28 09:59:46 -0700)

----------------------------------------------------------------
Fixes for omap variants against v4.19-rc1

These are mostly fixes related to using ti-sysc interconnect target module
driver for accessing right register offsets for sgx and cpsw and for
no_console_suspend regression.

There is also a droid4 emmc fix where emmc may not get detected for some
models, and vibrator dts mismerge fix.

And we have a file permission fix for am335x-osd3358-sm-red.dts that
just got added. And we must tag RTC as system-power-controller for
am437x for PMIC to shut down during poweroff.

----------------------------------------------------------------
Keerthy (1):
      arm: dts: am4372: setup rtc as system-power-controller

Neeraj Dantu (1):
      ARM: dts: Fix file permission for am335x-osd3358-sm-red.dts

Pavel Machek (1):
      ARM: dts: omap4-droid4: fix vibrations on Droid 4

Tony Lindgren (6):
      ARM: OMAP2+: Fix null hwmod for ti-sysc debug
      ARM: OMAP2+: Fix module address for modules using mpu_rt_idx
      bus: ti-sysc: Fix module register ioremap for larger offsets
      bus: ti-sysc: Fix no_console_suspend handling
      Merge branch 'perm-fix' into omap-for-v4.19/fixes-v2
      ARM: dts: omap4-droid4: Fix emmc errors seen on some devices

 arch/arm/boot/dts/am335x-osd3358-sm-red.dts |  0
 arch/arm/boot/dts/am4372.dtsi               |  1 +
 arch/arm/boot/dts/omap4-droid4-xt894.dts    | 20 +++++++--------
 arch/arm/mach-omap2/omap_hwmod.c            | 39 ++++++++++++++++++++++++++++-
 drivers/bus/ti-sysc.c                       | 37 +++++++++++++--------------
 5 files changed, 66 insertions(+), 31 deletions(-)
 mode change 100755 => 100644 arch/arm/boot/dts/am335x-osd3358-sm-red.dts
