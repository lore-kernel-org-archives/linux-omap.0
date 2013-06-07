From: Eduardo Valentin <eduardo.valentin@ti.com>
Subject: [PATCHv3 0/6] arm: enable TI SoC thermal driver
Date: Fri, 7 Jun 2013 16:46:02 -0400
Message-ID: <1370637968-23299-1-git-send-email-eduardo.valentin@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
Return-path: <linux-pm-owner@vger.kernel.org>
Sender: linux-pm-owner@vger.kernel.org
To: tony@atomide.com, grant.likely@linaro.org
Cc: linux-pm@vger.kernel.org, linux-omap@vger.kernel.org, linux@arm.linux.org.uk, Eduardo Valentin <eduardo.valentin@ti.com>
List-Id: linux-omap@vger.kernel.org

Hello,

Idea is to add the missing bits under arch/arm/*omap* required
to enable by default the ti-soc-thermal driver. I am planing to
move it out of staging tree. This has been scheduled to 3.11.

It would be interesting to get
feedback from other ppl. By enabling it by default we could reach
more ppl for testing it across the supported chips.

The difference from v2 is that now the driver is changed to use
GPIO bindings for Tshut as suggested by Benoit and I added
a simple description what is bandgap.

The difference from v1 is just that patch 01 doe snot include the
dts prefix, as it is not supposed to be DTS related.


Eduardo Valentin (6):
  thermal: ti-soc-thermal: use standard GPIO DT bindings
  arm: introduce config HAS_BANDGAP
  arm: dts: add bandgap entry for OMAP443x devices
  arm: dts: add bandgap entry for OMAP4460 devices
  arm: omap2plus_defconfig: enable TI bandgap driver
  arm: omap2plus_defconfig: enable DRA752 thermal support by default

 arch/arm/Kconfig                                  |  3 +++
 arch/arm/boot/dts/omap443x.dtsi                   |  4 ++++
 arch/arm/boot/dts/omap4460.dtsi                   |  9 +++++++++
 arch/arm/configs/omap2plus_defconfig              | 12 ++++++++++++
 arch/arm/mach-omap2/Kconfig                       |  1 +
 drivers/staging/ti-soc-thermal/ti-bandgap.c       |  8 ++------
 drivers/staging/ti-soc-thermal/ti_soc_thermal.txt |  9 +++++----
 7 files changed, 36 insertions(+), 10 deletions(-)

-- 
1.8.2.1.342.gfa7285d

