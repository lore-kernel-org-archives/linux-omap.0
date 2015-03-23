From: Nishanth Menon <nm@ti.com>
Subject: [PATCH V2 0/2] DRA7/X15: Thermal dts patches
Date: Mon, 23 Mar 2015 14:39:37 -0500
Message-ID: <1427139579-4215-1-git-send-email-nm@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:59465 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752214AbbCWTkO (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 23 Mar 2015 15:40:14 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tony@atomide.com, bcousson@baylibre.com, edubezval@gmail.com
Cc: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, linux-omap@vger.kernel.org, j-keerthy@ti.com, t-kristo@ti.com, nm@ti.com

Hi
Here are a few pending patches for DRA7 and patch hooking the
GPIO fan to the thermal framework.

Tested on BeagleBoard-X15, uEVM with next-20150320. (just load up
cpufreq_dt and gpio_fan modules with omap2plus_defconfig, run cpuburn
to generate thermal and just wait for the fan to trigger - and it
does- we dont hit the frequency throttling temps) (next-20150323 is
broken for build currently).

The patches are based on
git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap.git
branch: omap-for-v4.1/dt-v2 10709c0858d8 ARM: dts: Update Nanobone dts file

Changes since V1:
Based on review comments:
	- patches 1/3 and 2/3 has been squashed up to introduce zone and bandgap
	  information
	- Dropped the entire omap5-cpu-thermal.dtsi idea. done the same way as
	  omap5.
	- minor updates to fan - so, all patches have been modified.
	- Not carrying forward ack due to changes

V1: http://marc.info/?l=devicetree&m=142688089417731&w=2

Keerthy (1):
  ARM: dts: DRA7: Add bandgap and related thermal nodes

Nishanth Menon (1):
  ARM: dts: am57xx-beagle-x15: Add thermal map to include fan and
    tmp102

 arch/arm/boot/dts/am57xx-beagle-x15.dts  |   49 ++++++++++++++++++++++++++++++
 arch/arm/boot/dts/dra7.dtsi              |   23 ++++++++++++++
 arch/arm/boot/dts/dra72x.dtsi            |    5 +++
 arch/arm/boot/dts/dra74x.dtsi            |    5 +++
 arch/arm/boot/dts/omap4-cpu-thermal.dtsi |    4 +--
 5 files changed, 84 insertions(+), 2 deletions(-)

-- 
1.7.9.5

