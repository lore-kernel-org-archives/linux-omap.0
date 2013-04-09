From: Tony Lindgren <tony@atomide.com>
Subject: [GIT PULL 3/5] omap board changes for v3.10 merge window
Date: Mon, 8 Apr 2013 21:51:02 -0700
Message-ID: <E1UPQWi-0007xc-Kz@merlin.infradead.org>
References: <pull-1365483063-475562>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <pull-1365483063-475562>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

The following changes since commit 31880c37c11e28cb81c70757e38392b42e695dc6:

  Linux 3.9-rc6 (2013-04-07 20:49:54 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap tags/omap-for-v3.10/board-signed

for you to fetch changes up to 06993d6a8a51b90fc78c8c3cb7a81c9b4b88c683:

  ARM: OMAP: board-4430sdp: Provide regulator to pwm-backlight (2013-04-08 14:01:05 -0700)

----------------------------------------------------------------
Board related changes for v3.10 merge window. These are pretty
much all non-critical fixes for platform device initialization
that will be needed until we can drop the board-*.c files and
move to DT based boot.

----------------------------------------------------------------
Aaro Koskinen (2):
      ARM: OMAP1: fix omap_udc registration
      ARM: OMAP: RX-51: add missing regulator supply definitions for lis3lv02d

Andrew Chew (1):
      ARM: OMAP: board-4430sdp: Provide regulator to pwm-backlight

Paul Bolle (2):
      omap2+: Remove useless Makefile line
      omap2+: Remove useless Makefile line

Peter Ujfalusi (1):
      ARM: OMAP: zoom: Use pwm stack for lcd and keyboard backlight

Ruslan Bilovol (1):
      ARM: OMAP2+: omap2plus_defconfig: Add support for BMP085 pressure sensor

 arch/arm/configs/omap2plus_defconfig         |  1 +
 arch/arm/mach-omap1/include/mach/usb.h       |  2 +-
 arch/arm/mach-omap1/usb.c                    |  6 +--
 arch/arm/mach-omap2/Makefile                 |  3 --
 arch/arm/mach-omap2/board-4430sdp.c          |  6 +++
 arch/arm/mach-omap2/board-rx51-peripherals.c |  4 ++
 arch/arm/mach-omap2/board-zoom-display.c     | 56 ----------------------------
 arch/arm/mach-omap2/board-zoom-peripherals.c | 53 +++++++++++++++++++++++++-
 8 files changed, 67 insertions(+), 64 deletions(-)
