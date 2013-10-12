From: Tony Lindgren <tony@atomide.com>
Subject: [GIT PULL 5/6] omap display and board pdata changes for v3.13 merge
 window
Date: Fri, 11 Oct 2013 18:44:59 -0700
Message-ID: <E1VUoH9-0004ep-7I@merlin.infradead.org>
References: <pull-1381542299-305003>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <pull-1381542299-305003>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: arm@kernel.org, Arnd Bergmann <arnd@arndb.de>, Kevin Hilman <khilman@linaro.org>, Olof Johansson <olof@lixom.net>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

The following changes since commit d0e639c9e06d44e713170031fe05fb60ebe680af:

  Linux 3.12-rc4 (2013-10-06 14:00:20 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap tags/omap-for-v3.13/board-signed

for you to fetch changes up to 9e490f486ea9ce7644be913e03ee5ccdf1be20f7:

  Merge branch 'omap-for-v3.13/n900' into omap-for-v3.13/board (2013-10-11 16:14:23 -0700)

----------------------------------------------------------------

Platform data changes for omaps for the display subsystem and
n900 secure mode changes. Note that the n900 secure mode changes
will still be needed for device tree based booting also.

----------------------------------------------------------------
Archit Taneja (4):
      ARM: OMAP2+: drm: Don't build device for DMM
      ARM: OMAP2+: display: Create omapdrm device inside omap_display_init
      ARM: OMAP2+: display: Create omapvrfb and omapfb devices inside omap_display_init
      ARM: OMAP2+: display: Create omap_vout device inside omap_display_init

Pali Rohr (3):
      ARM: OMAP3: Add secure function omap_smc3() which calling instruction smc #1
      ARM: OMAP3: RX-51: ARM errata 430973 workaround
      RX-51: Add support for OMAP3 ROM Random Number Generator

Tony Lindgren (1):
      Merge branch 'omap-for-v3.13/n900' into omap-for-v3.13/board

 arch/arm/mach-omap2/Makefile                 |  6 +--
 arch/arm/mach-omap2/board-rx51-peripherals.c | 19 +++++++
 arch/arm/mach-omap2/board-rx51.c             | 12 +++++
 arch/arm/mach-omap2/cclock3xxx_data.c        |  1 +
 arch/arm/mach-omap2/devices.c                | 10 ++--
 arch/arm/mach-omap2/display.c                | 28 ++++++++++
 arch/arm/mach-omap2/display.h                |  4 ++
 arch/arm/mach-omap2/drm.c                    | 24 ++-------
 arch/arm/mach-omap2/fb.c                     | 14 ++---
 arch/arm/mach-omap2/omap-secure.c            | 76 ++++++++++++++++++++++++++++
 arch/arm/mach-omap2/omap-secure.h            | 13 +++++
 arch/arm/mach-omap2/omap-smc.S               | 21 +++++++-
 12 files changed, 191 insertions(+), 37 deletions(-)
