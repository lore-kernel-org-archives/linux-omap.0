From: Nishanth Menon <nm@ti.com>
Subject: [PATCH V2 0/8] ARM: OMAP3+: support cpufreq-cpu0 for device tree boot
Date: Tue, 19 Mar 2013 12:53:02 -0500
Message-ID: <1363715590-5131-1-git-send-email-nm@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pm-owner@vger.kernel.org>
Sender: linux-pm-owner@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Nishanth Menon <nm@ti.com>, Kevin Hilman <khilman@deeprootsystems.com>, Jon Hunter <jon-hunter@ti.com>, =?UTF-8?q?Beno=C3=AEt=20Cousson?= <b-cousson@ti.com>, Santosh Shilimkar <santosh.shilimkar@ti.com>, Shawn Guo <shawn.guo@linaro.org>, Keerthy <j-keerthy@ti.com>, devicetree-discuss@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org, cpufreq@vger.kernel.org, linux-pm@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

Hi,
The following version 2 of the series arose from trying to use BeagleBo=
ard-XM
(OMAP3 variant) for doing CPU DVFS using cpufreq-cpu0. This series enab=
les the
generic cpufreq-cpu0 driver to be used in device tree enabled boot whil=
e
maintaining support of the legacy omap-cpufreq driver when used in non =
device
tree enabled boot.

However, in order to enable complete SoC entitlement for OMAP platforms=
, with
this series, key features are still pending on device tree adaptation f=
or OMAP:
A) clock framework data transition to DT - this should happen soon, so =
this
series hacks the clock node for the time being as suggested in review o=
f
original series[1].
B) On processors that use voltage controller, voltage processor (VC/VP =
hardware
loop using I2C_SR path) - we have started work on transitioning them to
regulator framework driven by DT.
C) Adaptive Body Bias and SmartReflex AVS conversion to DT.

As a result of these pending features:
- OMAP4 TWL6030 and TPS62361 which set voltage ONLY over I2C_SR have no
regulators associated at the moment - fortunately, we boot at highest v=
oltage,
so things still work.
- Missing ABB and AVS implies that for few of the SoCs (3630, OMAP4), I=
 have
not added those OPPs in DT yet - this also needs alignment with iMX, AM=
 series
pending work, where certain OPPs need enabling based on efuse programme=
d
bit sequences - since it is an add-on work, it is not addressed here.

Note: At this point in time, we do not have DT entries for clock on OMA=
P
platforms. Common Clock Framework(CCF) could also control regulators[2]=
=2E
Once these conversions are complete, there will be minimal cleanup work=
 to
switch to the new data structure changes.

Key benefit of the series is to allow all relevant TI platforms now to =
use a
single cpufreq driver and equivalent frameworks in addition be part of =
the
transition to device tree.
NOTE: As a result of this series:
1. omap-cpufreq will be used only in non device tree boot scenario. we =
should
   delete this driver once the 100% DT conversion is complete.
2. Generic cpufreq-cpu0 will be used only in device tree boot scenario.
boot systems.

Key changes in version 2:
	- series now rebased on Device tree patches queued for OMAP 3.10
	- cpufreq-cpu0 and omap_cpufreq will co-exist and used depending on
	  usage of device tree.
	- minor wording, cleanups for the same.
	- omap3.dtsi and omap4.dtsi now become common dtsi which is used by
	  omap34xx.dtsi, omap36xx.dtsi, omap443x.dtsi, omap4460.dtsi as needed=
=2E

version 1 of the series:
	http://marc.info/?t=3D136329485400005&r=3D1&w=3D2
	available at:
	https://github.com/nmenon/linux-2.6-playground/commits/push/cpufreq-cp=
u0-omap-all-v1

[1] Original discussion thread which triggered this series:
	http://marc.info/?l=3Dlinux-pm&m=3D136304313700602&w=3D2
	https://patchwork.kernel.org/patch/2251841/
	https://patchwork.kernel.org/patch/2251851/
[2] CCF DVFS patches:
https://patchwork.kernel.org/patch/2195431/
https://patchwork.kernel.org/patch/2195421/
https://patchwork.kernel.org/patch/2195451/
https://patchwork.kernel.org/patch/2195441/
https://patchwork.kernel.org/patch/2195461/

Version 2 is now based on for-3.10/dts branch from Benoit:
	http://git.kernel.org/cgit/linux/kernel/git/bcousson/linux-omap-dt.git=
/log/?h=3Dfor_3.10/dts
	44fab7a ARM: dts: omap3-devkit8000: Add NAND DT node

Version 2 is also available at:
	https://github.com/nmenon/linux-2.6-playground/commits/push/cpufreq-cp=
u0-omap-all-v2
	git link: git://github.com/nmenon/linux-2.6-playground.git
	branch: cpufreq-cpu0-omap-all-v2

Test coverage:
	test script: http://pastebin.com/zrr8ptge
Platforms verified:
	beaglebone(rev A6a) - AM33xx compatible - http://pastebin.com/PUx5h6Jy
	beagleboard (rev C1D) - OMAP3430 compatible - http://pastebin.com/SycC=
inFb (DT) http://pastebin.com/qwJHw9Ev (no DT)
	omap3-beagle-xm -OMAP3630 compatible - http://pastebin.com/tVEXeVZC
	Pandaboard -(OMAP4430 ES2.2) verified with omapconf - http://pastebin.=
com/cAtytfW0
	Pandaboard-ES -(OMAP4460 ES1.1) verified with omapconf - http://pasteb=
in.com/3EymNTMp

Nishanth Menon (8):
  ARM: dts: OMAP34xx/35xx: Add CPU OPP table
  ARM: dts: OMAP36xx: Add CPU OPP table
  ARM: dts: OMAP3: use twl4030 vdd1 regulator for CPU
  ARM: dts: OMAP443x: Add CPU OPP table
  ARM: dts: omap4-panda: move generic sections to panda-common
  ARM: dts: OMAP4460: Add CPU OPP table
  ARM: OMAP3+: use cpu0-cpufreq driver in device tree supported boot
  cpufreq: OMAP: donot allow to be used with device tree

 arch/arm/boot/dts/am3517-evm.dts          |    2 +-
 arch/arm/boot/dts/am3517_mt_ventoux.dts   |    2 +-
 arch/arm/boot/dts/omap3-beagle-xm.dts     |    6 +
 arch/arm/boot/dts/omap3-beagle.dts        |    8 +-
 arch/arm/boot/dts/omap3-devkit8000.dts    |    2 +-
 arch/arm/boot/dts/omap3-evm.dts           |    8 +-
 arch/arm/boot/dts/omap3-igep.dtsi         |    2 +-
 arch/arm/boot/dts/omap3-overo.dtsi        |    2 +-
 arch/arm/boot/dts/omap3430-sdp.dts        |    2 +-
 arch/arm/boot/dts/omap34xx.dtsi           |   28 ++++
 arch/arm/boot/dts/omap36xx.dtsi           |   13 ++
 arch/arm/boot/dts/omap4-panda-a4.dts      |    5 +-
 arch/arm/boot/dts/omap4-panda-common.dtsi |  251 +++++++++++++++++++++=
++++++++
 arch/arm/boot/dts/omap4-panda-es.dts      |    3 +-
 arch/arm/boot/dts/omap4-panda.dts         |  247 +--------------------=
-------
 arch/arm/boot/dts/omap4-sdp.dts           |    2 +-
 arch/arm/boot/dts/omap4-var-som.dts       |    2 +-
 arch/arm/boot/dts/omap443x.dtsi           |   27 ++++
 arch/arm/boot/dts/omap4460.dtsi           |   14 ++
 arch/arm/boot/dts/twl4030.dtsi            |    6 +
 arch/arm/mach-omap2/board-generic.c       |    5 +
 arch/arm/mach-omap2/cclock33xx_data.c     |    2 +-
 arch/arm/mach-omap2/cclock3xxx_data.c     |    3 +-
 arch/arm/mach-omap2/cclock44xx_data.c     |    3 +-
 drivers/cpufreq/omap-cpufreq.c            |   14 ++
 25 files changed, 399 insertions(+), 260 deletions(-)
 create mode 100644 arch/arm/boot/dts/omap34xx.dtsi
 create mode 100644 arch/arm/boot/dts/omap4-panda-common.dtsi
 create mode 100644 arch/arm/boot/dts/omap443x.dtsi

vmlinux size change information (omap2plus_defconfig + CPUFREQ enabled)=
:
add/remove: 0/0 grow/shrink: 5/0 up/down: 208/0 (208)
function                                     old     new   delta
omap_cpu_init                                360     472    +112
omap_generic_init                             96     140     +44
omap44xx_clks                               5832    5856     +24
omap3xxx_clks                               6720    6744     +24
omap3xxx_clk_init                           1072    1076      +4

non-zero DTB size deltas(bytes):
old	new	delta	 filename
10671	10898	+227	omap3-beagle-xm.dtb
9947	10190	+243	omap3-beagle.dtb
11399	11582	+183	omap3-devkit8000.dtb
9731	9974	+243	omap3-evm.dtb
10958	11141	+183	omap3-igep0020.dtb
10906	11089	+183	omap3-igep0030.dtb
10255	10438	+183	omap3-tobi.dtb
11361	11544	+183	omap3430-sdp.dtb
16270	16361	+91	omap4-panda-a4.dtb
16326	16409	+83	omap4-panda-es.dtb
16270	16361	+91	omap4-panda.dtb
19379	19470	+91	omap4-sdp.dtb
12943	13034	+91	omap4-var-som.dtb

Cc: Kevin Hilman <khilman@deeprootsystems.com>
Cc: Jon Hunter <jon-hunter@ti.com>
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

