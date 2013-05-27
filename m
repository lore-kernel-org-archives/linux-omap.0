From: Afzal Mohammed <afzal-l0cyMroinI0@public.gmane.org>
Subject: [PATCH v2 00/14] ARM: OMAP2+: AM43x initial support
Date: Mon, 27 May 2013 20:03:27 +0530
Message-ID: <cover.1369658705.git.afzal@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/devicetree-discuss>,
 <mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/devicetree-discuss/>
List-Post: <mailto:devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
List-Help: <mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/devicetree-discuss>,
 <mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=subscribe>
Errors-To: devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org
Sender: "devicetree-discuss"
 <devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
To: linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org, linux-doc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: Russell King <linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>, Rob Herring <rob.herring-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org>, Grant Likely <grant.likely-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Benoit Cousson <benoit.cousson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

Hi,

This series adds initial support for AM43x based SoC's. To boot
AM43x, in addition to these patches, PRCM support is also needed,
which would be posted later as a separate series. DT sources doesn't
have "ti,hwmod" entry - this would be added along with PRCM support.

AM43x SoC's are based on ARM Cortex-A9 with one core. AM43x is similar
to AM335x in it's peripheral capabilities, except a few additional
ones, with many of the peripheral register mapping's similar. AM43x
has a sync timer, which is being used as clocksource. Clockevent used
is 1ms dmtimer.

SoC has PL310 L2 cache, support for it would be added later.

soc_is_am43xx() is introduced to handle AM43x specific details and
soc_is_am437x() is a subclass of it - first member of the class.

AM43x is currently in pre-silicon stage and currently there are no
public documents.

This has been tested on a pre-silicon platform that emulates AM43x SoC
with additional changes on top of this.

AM335x based board (AM335x EVM) has been verfied to boot as earlier
with this series.

Baseline: v3.10-rc3
Dependency: "ARM: OMAP3+: am33xx id: Add new am33xx specific function to check dev_feature"
		by Vaibhav Hiremath <hvaibhav-l0cyMroinI0@public.gmane.org>

Regards
Afzal

v2: Major change - use SoC timer's outside of ARM instead of depending
	on ARM SMP local timer for clockevent/source.

Afzal Mohammed (13):
  ARM: OMAP2+: separate out OMAP4 restart
  ARM: OMAP2+: AM43x: Kconfig
  ARM: OMAP2+: AM43x: kbuild
  ARM: OMAP2+: AM43x: soc_is support
  ARM: OMAP2+: AM437x: SoC revision detection
  ARM: OMAP2+: AM43x: static mapping
  ARM: OMAP2+: AM43x: early init
  ARM: OMAP2+: AM43x: GP or HS ?
  ARM: OMAP2+: AM43x: basic dt support
  Documentation: dt: binding: omap: am43x timer
  Documentation: dt: binding: omap: am43x counter
  Documentation: dt: binding: serial: omap: am43x
  ARM: dts: AM43x: initial support

Sanjeev Premi (1):
  ARM: OMAP2+: AM43x: SRAM base and size

 .../devicetree/bindings/arm/omap/counter.txt       |  1 +
 .../devicetree/bindings/arm/omap/timer.txt         |  2 +
 .../devicetree/bindings/serial/omap_serial.txt     |  1 +
 arch/arm/boot/dts/am4372.dtsi                      | 66 ++++++++++++++++++++++
 arch/arm/mach-omap2/Kconfig                        | 10 ++++
 arch/arm/mach-omap2/Makefile                       |  8 +++
 arch/arm/mach-omap2/am33xx.h                       |  1 +
 arch/arm/mach-omap2/board-generic.c                | 16 ++++++
 arch/arm/mach-omap2/cm33xx.h                       |  2 +-
 arch/arm/mach-omap2/common.h                       |  1 +
 arch/arm/mach-omap2/id.c                           |  8 ++-
 arch/arm/mach-omap2/io.c                           | 18 +++++-
 arch/arm/mach-omap2/omap4-common.c                 | 16 ------
 arch/arm/mach-omap2/omap4-restart.c                | 27 +++++++++
 arch/arm/mach-omap2/soc.h                          | 23 ++++++++
 arch/arm/mach-omap2/sram.c                         |  3 +
 arch/arm/mach-omap2/timer.c                        |  2 +-
 17 files changed, 184 insertions(+), 21 deletions(-)
 create mode 100644 arch/arm/boot/dts/am4372.dtsi
 create mode 100644 arch/arm/mach-omap2/omap4-restart.c

-- 
1.7.12
