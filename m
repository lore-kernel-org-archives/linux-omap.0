From: Tony Lindgren <tony@atomide.com>
Subject: [GIT PULL] omap legacy boot vs dt boot fixes for v4.7 merge window
Date: Wed, 4 May 2016 10:31:53 -0700
Message-ID: <20160504173153.GT5995@atomide.com>
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

  git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap tags/omap-for-v4.7/legacy-signed

for you to fetch changes up to 10c1f7d32bf451d4309850c15ab1fdadccf92620:

  ARM: OMAP2+: n900 needs MMC slot names for legacy user space (2016-04-28 14:26:33 -0700)

----------------------------------------------------------------
Legacy booting vs device tree booting fixes for omaps for
v4.7 merge window. These are not considered urgent fixes enough
for the v4.6-rc cycle, but we need them in v4.7 in order to drop
the last remaining board-*.c files for omap3 for v4.8 merge window.

On Nokia N900, we need to pass the MMC slot names for the legacy
user space to work. Let's do that using auxdata as the driver is
setting up things already with the pdata for legacy booting. Then
we can later on discuss if we may want to have some generic binding
describing where the MMC slots are on the device.

N900 also has had the ir-rx51 device driver unusable with multiarch
for a long time. Let's pass the dmtimer data in pdata for the driver
to get it going again. Then once things are working, we can eventually
change the driver to use just hrtimer and PWM framework. The driver
changes will be queued separately.

----------------------------------------------------------------
Tony Lindgren (2):
      ARM: OMAP2+: Add more functions to pwm pdata for ir-rx51
      ARM: OMAP2+: n900 needs MMC slot names for legacy user space

 arch/arm/mach-omap2/board-rx51-peripherals.c   | 35 ++++++++++++++++++++--
 arch/arm/mach-omap2/pdata-quirks.c             | 40 +++++++++++++++++++++++++-
 include/linux/platform_data/media/ir-rx51.h    |  1 +
 include/linux/platform_data/pwm_omap_dmtimer.h | 21 ++++++++++++++
 4 files changed, 94 insertions(+), 3 deletions(-)
