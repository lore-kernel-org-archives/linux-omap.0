From: Nishanth Menon <nm@ti.com>
Subject: [PATCH 0/8] ARM: OMAP3+: Switch to use DT based cpu0-cpufreq driver
Date: Thu, 14 Mar 2013 15:58:07 -0500
Message-ID: <1363294695-658-1-git-send-email-nm@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <cpufreq-owner@vger.kernel.org>
Sender: cpufreq-owner@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Nishanth Menon <nm@ti.com>, Kevin Hilman <khilman@deeprootsystems.com>, =?UTF-8?q?Beno=C3=AEt=20Cousson?= <b-cousson@ti.com>, Santosh Shilimkar <santosh.shilimkar@ti.com>, Shawn Guo <shawn.guo@linaro.org>, Keerthy <j-keerthy@ti.com>, devicetree-discuss@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org, cpufreq@vger.kernel.org, linux-pm@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

The following series arose from trying to use BeagleBoard-XM (OMAP3 var=
iant)
for doing CPU DVFS using cpufreq-cpu0. This series will eventually resu=
lt in
migrating the cpufreq support only through device tree (part of the eff=
ort
to migrate away from non-DT configurations for OMAP). Unfortunately, as=
 already
known, we have a bunch of legacy code and mutually dependent device tre=
e
conversion that is pending.
Key features pending:
A) clock framework transition to DT - this should happen soon, so this =
series hacks
the clock node for the time being as suggested in review of original se=
ries
B) on processors that use voltage controller, voltage processor (VC/VP =
hardware
loop using I2C_SR path) - we have started work on transitioning them to=
 regulator
framework driven by DT.
C) Adaptive Body Bias and SmartReflex AVS conversion to DT.

As a result of these pending features:
- OMAP4 TWL6030 and TPS62361 which set voltage ONLY over I2C_SR have no=
 regulators
associated at the moment - fortunately, we boot at highest voltage, so =
things still
work.
- Missing ABB and AVS implies that for few of the SoCs (3630, OMAP4), I=
 have not added
those OPPs in DT yet - this also needs alignment with iMX, AM series li=
ke pending work,
where certain OPPs need enabling based on efuse programmed bit sequence=
s - since it
is an add-on work, it is not addressed here.

Note: Somewhere in the future, when we have regulators driven off CCF a=
nd OMAP
converted to CCF, we could remove the DT regulator requirements there a=
s well.

Key benefit of the series is to allow all relevant TI platforms now to =
use a single
cpufreq driver and equivalent frameworks in addition be part of the tra=
nsition to
DT. As a result of this series, CPUFreq feature will not be available f=
or non-DT
boot systems.

Original discussion thread which triggered this series:
	http://marc.info/?l=3Dlinux-pm&m=3D136304313700602&w=3D2
	https://patchwork.kernel.org/patch/2251841/
	https://patchwork.kernel.org/patch/2251851/

Test coverage:
	test script: http://pastebin.com/MpCRY0SB
Platforms verified:
	beaglebone(rev A6a) - AM33xx compatible
	beagleboard (rev C1D) - OMAP3430 compatible
	omap3-beagle-xm -OMAP3630 compatible
	Pandaboard -(OMAP4430 ES2.3) verified with omapconf
	Pandaboard-ES -(OMAP4460 ES1.1) verified with omapconf

Series is based on v3.9-rc2 tag

Also available at:
	https://github.com/nmenon/linux-2.6-playground/commits/push/cpufreq-cp=
u0-omap-all-v1
	git link: git://github.com/nmenon/linux-2.6-playground.git
	branch: cpufreq-cpu0-omap-all-v1

Nishanth Menon (8):
  ARM: dts: OMAP34xx: move CPU OPP tables to device tree
  ARM: dts: OMAP36xx: move CPU OPP tables to device tree
  ARM: dts: OMAP3: use twl4030 vdd1 regulator for CPU
  ARM: dts: OMAP443x: move CPU OPP tables to device tree
  ARM: dts: omap4-panda: move generic sections to panda-common
  ARM: dts: OMAP446x: move CPU OPP tables to device tree
  ARM: OMAP3+: use cpu0-cpufreq driver
  cpufreq: omap: remove omap-cpufreq

 MAINTAINERS                               |    1 -
 arch/arm/boot/dts/omap3-beagle-xm.dts     |    6 +
 arch/arm/boot/dts/omap3-beagle.dts        |    6 +
 arch/arm/boot/dts/omap3-evm.dts           |    6 +
 arch/arm/boot/dts/omap3.dtsi              |   10 +
 arch/arm/boot/dts/omap36xx.dtsi           |   12 ++
 arch/arm/boot/dts/omap4-panda-a4.dts      |    5 +-
 arch/arm/boot/dts/omap4-panda-common.dtsi |  205 ++++++++++++++++++++
 arch/arm/boot/dts/omap4-panda-es.dts      |    5 +-
 arch/arm/boot/dts/omap4-panda.dts         |  200 +-------------------
 arch/arm/boot/dts/omap4.dtsi              |   10 +
 arch/arm/boot/dts/omap446x.dtsi           |   27 +++
 arch/arm/boot/dts/twl4030.dtsi            |    6 +
 arch/arm/mach-omap2/board-generic.c       |    4 +
 arch/arm/mach-omap2/cclock33xx_data.c     |    2 +-
 arch/arm/mach-omap2/cclock3xxx_data.c     |    2 +-
 arch/arm/mach-omap2/cclock44xx_data.c     |    2 +-
 arch/arm/mach-omap2/opp3xxx_data.c        |   20 --
 arch/arm/mach-omap2/opp4xxx_data.c        |   23 ---
 drivers/cpufreq/Kconfig.arm               |    6 -
 drivers/cpufreq/Makefile                  |    1 -
 drivers/cpufreq/omap-cpufreq.c            |  291 ---------------------=
--------
 22 files changed, 305 insertions(+), 545 deletions(-)
 create mode 100644 arch/arm/boot/dts/omap4-panda-common.dtsi
 create mode 100644 arch/arm/boot/dts/omap446x.dtsi
 delete mode 100644 drivers/cpufreq/omap-cpufreq.c

Size change information:
add/remove: 0/0 grow/shrink: 3/5 up/down: 74/-291 (-217)
function                                     old     new   delta
omap_generic_init                             96     140     +44
vermagic                                      49      64     +15
linux_banner                                 130     145     +15
kernel_config_data                         18333   18330      -3
omap443x_opp_def_list                        144      80     -64
omap36xx_opp_def_list                        160      96     -64
omap446x_opp_def_list                        192     112     -80
omap34xx_opp_def_list                        208     128     -80

non-zero DTB size deltas(bytes):
old	new	delta	 filename
8068	8311	+243	omap3-beagle.dtb
8647	8874	+227	omap3-beagle-xm.dtb
7783	8026	+243	omap3-evm.dtb
8000	8183	+183	omap3-tobi.dtb
13646	13771	+125	omap4-panda-a4.dtb
13646	13771	+125	omap4-panda.dtb
13602	13719	+117	omap4-panda-es.dtb
16256	16381	+125	omap4-sdp.dtb
10889	11014	+125	omap4-var-som.dtb

Cc: Kevin Hilman <khilman@deeprootsystems.com>
Cc: "Beno=C3=AEt Cousson" <b-cousson@ti.com>
Cc: Santosh Shilimkar <santosh.shilimkar@ti.com>
Cc: Shawn Guo <shawn.guo@linaro.org>
Cc: Keerthy <j-keerthy@ti.com>
Cc: linux-omap@vger.kernel.org
Cc: devicetree-discuss@lists.ozlabs.org
Cc: linux-arm-kernel@lists.infradead.org
Cc: cpufreq@vger.kernel.org
Cc: linux-pm@vger.kernel.org

Regards,
Nishanth Menon
--=20
1.7.9.5

