From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: [PATCH 00/13] Consolidate simple ARM MMIO clock sources
Date: Tue, 10 May 2011 08:27:00 +0100
Message-ID: <20110510072700.GA29869@n2100.arm.linux.org.uk>
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
Sender: linux-arm-kernel-bounces@lists.infradead.org
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: linux-arm-kernel@lists.infradead.org, John Stultz <johnstul@us.ibm.com>, Thomas Gleixner <tglx@linutronix.de>
Cc: Kukjin Kim <kgene.kim@samsung.com>, Eric Miao <eric.y.miao@gmail.com>, Linus Walleij <linus.walleij@stericsson.com>, Erik Gilling <konkers@android.com>, Nicolas Pitre <nico@fluxnic.net>, Tony Lindgren <tony@atomide.com>, Krzysztof Halasa <khc@pm.waw.pl>, linux-omap@vger.kernel.org, "Hans J. Koch" <hjk@hansjkoch.de>, Sascha Hauer <kernel@pengutronix.de>, Colin Cross <ccross@android.com>, Olof Johansson <olof@lixom.net>, Imre Kaloz <kaloz@openwrt.org>, Wan ZongShun <mcuos.com@gmail.com>, Lennert Buytenhek <kernel@wantstofly.org>, Alessandro Rubini <rubini@unipv.it>
List-Id: linux-omap@vger.kernel.org

In a similar light to the i8253 series, this consolidates 17 ARM
MMIO counter clocksources into a single common implementation.  This
common implementation caters for 32-bit and 16-bit register access
sizes, up and down counters, and various bit sizes of those counters.

Patch 1 is already in John Stultz tree, but is included for
completeness and to get rid of a build warning.

 arch/arm/Kconfig                         |   14 ++++++
 arch/arm/common/timer-sp.c               |   22 +--------
 arch/arm/mach-integrator/Kconfig         |    1 +
 arch/arm/mach-integrator/integrator_ap.c |   21 +-------
 arch/arm/mach-ixp4xx/common.c            |   16 +------
 arch/arm/mach-lpc32xx/timer.c            |   17 +------
 arch/arm/mach-mxs/timer.c                |   20 +++-----
 arch/arm/mach-netx/time.c                |   16 +------
 arch/arm/mach-omap1/time.c               |   69 +++++++++-------------------
 arch/arm/mach-pxa/time.c                 |   17 +------
 arch/arm/mach-sa1100/time.c              |   24 ++--------
 arch/arm/mach-tcc8k/time.c               |   16 +------
 arch/arm/mach-tegra/timer.c              |   16 +------
 arch/arm/mach-u300/timer.c               |   18 +------
 arch/arm/mach-w90x900/time.c             |   17 +------
 arch/arm/plat-mxc/epit.c                 |   18 +-------
 arch/arm/plat-mxc/time.c                 |   38 +++-------------
 arch/arm/plat-nomadik/Kconfig            |    1 +
 arch/arm/plat-nomadik/timer.c            |   31 +------------
 arch/arm/plat-omap/Kconfig               |    1 +
 arch/arm/plat-orion/time.c               |   21 +--------
 arch/arm/plat-s5p/s5p-time.c             |   58 +++++++-----------------
 arch/arm/plat-spear/time.c               |   16 +------
 drivers/Kconfig                          |    3 +
 drivers/clocksource/Kconfig              |    2 +
 drivers/clocksource/Makefile             |    1 +
 drivers/clocksource/mmio.c               |   72 ++++++++++++++++++++++++++++++
 include/linux/clocksource.h              |   10 ++++-
 28 files changed, 194 insertions(+), 382 deletions(-)
