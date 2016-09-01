From: Tony Lindgren <tony@atomide.com>
Subject: [GIT PULL 1/3] omap soc updates for v4.9 merge window
Date: Thu,  1 Sep 2016 08:45:19 -0700
Message-ID: <8841.51185532591$1505291658@news.gmane.org>
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
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

The following changes since commit 29b4817d4018df78086157ea3a55c1d9424a7cfc:

  Linux 4.8-rc1 (2016-08-07 18:18:00 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap tags/omap-for-v4.9/soc-signed

for you to fetch changes up to 502ad2a669f146e0801973c42e55478322f2d382:

  ARM: OMAP2+: use IS_ENABLED() instead of checking for built-in or module (2016-08-26 08:42:35 -0700)

----------------------------------------------------------------
Two patches from Javier Martinez Canillas <javier@osg.samsung.com>
to update mach-omap1 and mach-oamp2 to use IS_ENABLED macro.

----------------------------------------------------------------
Javier Martinez Canillas (2):
      ARM: OMAP1: use IS_ENABLED() instead of checking for built-in or module
      ARM: OMAP2+: use IS_ENABLED() instead of checking for built-in or module

 arch/arm/mach-omap1/board-h2-mmc.c           |  2 +-
 arch/arm/mach-omap1/board-h2.c               |  2 +-
 arch/arm/mach-omap1/board-h3-mmc.c           |  2 +-
 arch/arm/mach-omap1/board-h3.c               |  2 +-
 arch/arm/mach-omap1/board-htcherald.c        |  4 ++--
 arch/arm/mach-omap1/board-innovator.c        |  4 ++--
 arch/arm/mach-omap1/board-nokia770.c         |  4 ++--
 arch/arm/mach-omap1/board-sx1-mmc.c          |  2 +-
 arch/arm/mach-omap1/devices.c                | 10 +++++-----
 arch/arm/mach-omap1/fb.c                     |  2 +-
 arch/arm/mach-omap1/include/mach/usb.h       |  2 +-
 arch/arm/mach-omap1/mmc.h                    |  2 +-
 arch/arm/mach-omap1/usb.c                    |  6 +++---
 arch/arm/mach-omap2/board-flash.c            | 10 ++++------
 arch/arm/mach-omap2/board-flash.h            | 11 +++--------
 arch/arm/mach-omap2/board-n8x0.c             |  5 ++---
 arch/arm/mach-omap2/board-rx51-peripherals.c | 23 +++++++++++------------
 arch/arm/mach-omap2/board-rx51-video.c       |  4 ++--
 arch/arm/mach-omap2/common-board-devices.c   |  3 +--
 arch/arm/mach-omap2/devices.c                |  7 +++----
 arch/arm/mach-omap2/drm.c                    |  2 +-
 arch/arm/mach-omap2/fb.c                     |  2 +-
 arch/arm/mach-omap2/gpmc-smsc911x.h          |  2 +-
 arch/arm/mach-omap2/hsmmc.c                  |  2 +-
 arch/arm/mach-omap2/hsmmc.h                  |  2 +-
 arch/arm/mach-omap2/twl-common.c             |  3 +--
 26 files changed, 54 insertions(+), 66 deletions(-)
