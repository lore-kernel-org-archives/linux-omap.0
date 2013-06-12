From: Tony Lindgren <tony@atomide.com>
Subject: [GIT PULL 1/6] non-critical omap fixes for v3.11 merge window
Date: Wed, 12 Jun 2013 11:24:33 -0700
Message-ID: <23292.6883771599$1371061534@news.gmane.org>
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
To: Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

The following changes since commit 317ddd256b9c24b0d78fa8018f80f1e495481a10:

  Linux 3.10-rc5 (2013-06-08 17:41:04 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap tags/omap-for-v3.11/fixes-non-critical-signed

for you to fetch changes up to e41a5f88b374f7b1d87a72740d186be20cae4aa8:

  ARM: OMAP2+: omap-usb-host: Fix memory leaks (2013-06-12 10:04:10 -0700)

----------------------------------------------------------------
Non-critical fixes for omaps for v3.11 merge window.

----------------------------------------------------------------
Peter Ujfalusi (3):
      ARM: OMAP2+: devices: Do not print error when McPDM hwmod lookup fails
      ARM: OMAP2+: devices: Do not print error when DMIC hwmod lookup fails
      ARM: OMAP2+: devices: Do not print error when dss_hdmi hwmod lookup fails

Roger Quadros (1):
      ARM: OMAP2+: omap-usb-host: Fix memory leaks

Sebastian Andrzej Siewior (1):
      arm/omap: use const char properly

Suman Anna (1):
      ARM: OMAP2+: control: add OMAP5 support for dsp boot programming

Tomi Valkeinen (3):
      ARM: OMAP: fix dsi regulator names
      ARM: OMAP: add vdds_dsi supply for omapdss_dpi.0
      ARM: OMAP: add vdds_sdi supply for omapdss_sdi.0

Tony Lindgren (2):
      Merge branch 'dss-regulator' into omap-for-v3.11/fixes-non-critical
      ARM: OMAP2+: Fix serial init for device tree based booting

 arch/arm/mach-omap2/board-cm-t35.c           |   3 +-
 arch/arm/mach-omap2/board-devkit8000.c       |   1 +
 arch/arm/mach-omap2/board-ldp.c              |   3 +-
 arch/arm/mach-omap2/board-omap3pandora.c     |   1 +
 arch/arm/mach-omap2/board-rx51-peripherals.c |   1 +
 arch/arm/mach-omap2/control.c                |   1 +
 arch/arm/mach-omap2/devices.c                |  12 +--
 arch/arm/mach-omap2/id.c                     |   2 +-
 arch/arm/mach-omap2/serial.c                 |   3 +
 arch/arm/mach-omap2/twl-common.c             |   1 +
 arch/arm/mach-omap2/usb-host.c               | 106 ++++++++++++++-------------
 11 files changed, 72 insertions(+), 62 deletions(-)
