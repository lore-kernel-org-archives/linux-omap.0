From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 0/2] Drop last two remaining omap3 legacy board files
Date: Wed, 15 Jun 2016 03:48:07 -0700
Message-ID: <1465987689-14812-1-git-send-email-tony@atomide.com>
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
To: linux-omap@vger.kernel.org
Cc: Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com>, Arnd Bergmann <arnd@arndb.de>, Aaro Koskinen <aaro.koskinen@iki.fi>, Kevin Hilman <khilman@baylibre.com>, Timo Kokkonen <timo.t.kokkonen@iki.fi>, Sebastian Reichel <sre@kernel.org>, Russell King <rmk+kernel@armlinux.org.uk>, Pavel Machek <pavel@ucw.cz>, =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali.rohar@gmail.com>, Olof Johansson <olof@lixom.net>, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

Hi all,

Here are two patches to drop the last remaining omap3 legacy boot
files. We have device tree based booting working for these boards,
and the legacy booting has been mostly kept around to validate
against regressions.

Let's not touch the rest of the platform init code until around
v4.9 so we can revert these two patches if needed.

Cheers,

Tony

Tony Lindgren (2):
  ARM: OMAP2+: Drop legacy board file for n900
  ARM: OMAP2+: Drop legacy board file for LDP

 arch/arm/mach-omap2/Kconfig                  |   12 -
 arch/arm/mach-omap2/Makefile                 |    4 -
 arch/arm/mach-omap2/board-ldp.c              |  429 ---------
 arch/arm/mach-omap2/board-rx51-peripherals.c | 1317 --------------------------
 arch/arm/mach-omap2/board-rx51-video.c       |   67 --
 arch/arm/mach-omap2/board-rx51.c             |  141 ---
 arch/arm/mach-omap2/board-rx51.h             |   11 -
 7 files changed, 1981 deletions(-)
 delete mode 100644 arch/arm/mach-omap2/board-ldp.c
 delete mode 100644 arch/arm/mach-omap2/board-rx51-peripherals.c
 delete mode 100644 arch/arm/mach-omap2/board-rx51-video.c
 delete mode 100644 arch/arm/mach-omap2/board-rx51.c
 delete mode 100644 arch/arm/mach-omap2/board-rx51.h

-- 
2.8.1
