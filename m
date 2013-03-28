From: Nishanth Menon <nm@ti.com>
Subject: [PATCH V3 0/2] ARM: OMAP3+: support cpufreq-cpu0 for device tree boot
Date: Thu, 28 Mar 2013 16:52:54 -0500
Message-ID: <1364507576-19345-1-git-send-email-nm@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:59195 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753786Ab3C1VxE (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 28 Mar 2013 17:53:04 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Rob Herring <robherring2@gmail.com>, cpufreq@vger.kernel.org, linux-pm@vger.kernel.org, Nishanth Menon <nm@ti.com>, Kevin Hilman <khilman@linaro.org>, Rajendra Nayak <rnayak@ti.com>, Paul Walmsley <paul@pwsan.com>, =?UTF-8?q?Beno=C3=AEt=20Cousson?= <b-cousson@ti.com>, Jon Hunter <jon-hunter@ti.com>, Keerthy <j-keerthy@ti.com>, Santosh Shilimkar <santosh.shilimkar@ti.com>, Shawn Guo <shawn.guo@linaro.org>

The following version 3 of the series arose from trying to use BeagleBo=
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
C) Adaptive Body Bias and SmartReflex AVS conversion to DT. [2]

Note: At this point in time, we do not have DT entries for clock on OMA=
P
platforms. Common Clock Framework(CCF) could also control regulators[3]=
=2E
Once these conversions are complete, there might be minimal cleanup wor=
k to
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

Key changes in version 3:
	- series now rebased on Device tree patches queued for OMAP 3.10
	- DT patches introducing OPPs are now merged, so pending patches alone
	  are part of the new series.
	- omap-cpufreq is now converted to platform_device to address:
		http://marc.info/?t=3D136434901900001&r=3D1&w=3D2

version 2 of the series:
	http://marc.info/?t=3D136371570200003&r=3D1&w=3D2
	available at:
	https://github.com/nmenon/linux-2.6-playground/commits/push/cpufreq-cp=
u0-omap-all-v2

version 1 of the series:
	http://marc.info/?t=3D136329485400005&r=3D1&w=3D2
	available at:
	https://github.com/nmenon/linux-2.6-playground/commits/push/cpufreq-cp=
u0-omap-all-v1

[1] Original discussion thread which triggered this series:
	http://marc.info/?l=3Dlinux-pm&m=3D136304313700602&w=3D2
	https://patchwork.kernel.org/patch/2251841/
	https://patchwork.kernel.org/patch/2251851/
[2] ABB RFC: http://marc.info/?l=3Dlinux-omap&m=3D136449099409794&w=3D2=
=20
[3] CCF DVFS patches:
https://patchwork.kernel.org/patch/2195431/
https://patchwork.kernel.org/patch/2195421/
https://patchwork.kernel.org/patch/2195451/
https://patchwork.kernel.org/patch/2195441/
https://patchwork.kernel.org/patch/2195461/

Version 3 is now based on for-3.10/dts branch from Benoit:
	http://git.kernel.org/cgit/linux/kernel/git/bcousson/linux-omap-dt.git=
/log/?h=3Dfor_3.10/dts
	d114294 ARM: dts: AM33XX: Corrects typo in interrupt field in SPI node

Version 3 is also available at:
	https://github.com/nmenon/linux-2.6-playground/commits/push/cpufreq-cp=
u0-omap-all-v3
	git link: git://github.com/nmenon/linux-2.6-playground.git
	branch: cpufreq-cpu0-omap-all-v3

Test coverage:
	test script: http://pastebin.com/zrr8ptge
Platforms verified:
	beaglebone(rev A6a) - AM33xx compatible - http://pastebin.com/GVP2wDVr
	beagleboard (rev C1D) - OMAP3430 compatible
		- DT enabled boot: http://pastebin.com/2AY1F5Qa
		- No DT enabled boot: http://pastebin.com/hDk0gbpU
	omap3-beagle-xm -OMAP3630 compatible - http://pastebin.com/5tHAQcLZ
	Pandaboard -(OMAP4430 ES2.2) - http://pastebin.com/6D9aDPXT
	Pandaboard-ES -(OMAP4460 ES1.1) - http://pastebin.com/ExrBEczr

Nishanth Menon (2):
  ARM: OMAP3+: use cpu0-cpufreq driver in device tree supported boot
  cpufreq: OMAP: instantiate omap-cpufreq as a platform_driver

 arch/arm/mach-omap2/board-generic.c   |    5 +++++
 arch/arm/mach-omap2/cclock33xx_data.c |    2 +-
 arch/arm/mach-omap2/cclock3xxx_data.c |    3 ++-
 arch/arm/mach-omap2/cclock44xx_data.c |    3 ++-
 arch/arm/mach-omap2/pm.c              |    9 +++++++++
 drivers/cpufreq/omap-cpufreq.c        |   19 ++++++++++++++-----
 6 files changed, 33 insertions(+), 8 deletions(-)

Cc: Kevin Hilman <khilman@linaro.org>
Cc: Rajendra Nayak <rnayak@ti.com>
Cc: Paul Walmsley <paul@pwsan.com>
Cc: "Beno=C3=AEt Cousson" <b-cousson@ti.com>
Cc: Jon Hunter <jon-hunter@ti.com>
Cc: Keerthy <j-keerthy@ti.com>
Cc: Santosh Shilimkar <santosh.shilimkar@ti.com>
Cc: Shawn Guo <shawn.guo@linaro.org>

Regards,
Nishanth Menon
--=20
1.7.9.5

--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
