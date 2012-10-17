From: Jon Hunter <jon-hunter@ti.com>
Subject: [PATCH V3 0/5] ARM: OMAP2+: Add device-tree support for timers
Date: Wed, 17 Oct 2012 13:01:08 -0500
Message-ID: <1350496873-21337-1-git-send-email-jon-hunter@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:56886 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932098Ab2JQSBk (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 17 Oct 2012 14:01:40 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Benoit Cousson <b-cousson@ti.com>, Tony Lindgren <tony@atomide.com>, Paul Walmsley <paul@pwsan.com>, Rob Herring <rob.herring@calxeda.com>, Grant Likely <grant.likely@secretlab.ca>
Cc: device-tree <devicetree-discuss@lists.ozlabs.org>, linux-omap <linux-omap@vger.kernel.org>, linux-arm <linux-arm-kernel@lists.infradead.org>, Vaibhav Hiremath <hvaibhav@ti.com>, Jon Hunter <jon-hunter@ti.com>

This series adds device-tree support for the timers on OMAP2+ devices
including AM33xx.

Testing:
1. I have booted tested this series on OMAP2420 H4, OMAP3430 Beagle, OMAP4430
   Panda and AM335x Beagle Bone with/without ...
   a). device-tree present
   b). CONFIG_OMAP_32K_TIMER set
   c). kernel boot parameter "clocksource=gp_timer" present
2. I have tested the all the timers (not used by the kernel as sys-timers) on
   OMAP2420 H4, OMAP3430 Beagle and OMAP4430 Panda with/without device-tree with
   this series. The testing includes ...
   a. Configuring, starting a timer and checking the counter value is
      incrementing.
   b. Testing timer overflow interrupt when timer expires.
   c. Using different clock sources to operate the timer with.

V3 changes:
- Removed definition "TIMER_PROP_ALWON" per Rob Herring's feedback
- Updated OMAP system timer (clock-events and clock-source) code so that
  HWMOD is NOT used for getting resource (memory and interrupt) information
  when device-tree is present.

V2 changes:
- Remove use of device-tree alias property
- Migrate OMAP timers to request timers by property instead of device ID
- Include OMAP2 support

Jon Hunter (5):
  ARM: dts: OMAP: Add timer nodes
  ARM: OMAP3: Dynamically disable secure timer nodes for secure devices
  ARM: OMAP: Add function to request a timer by capability
  ARM: OMAP3: Add generic machine descriptor for boards with OMAP3 GP
    devices
  ARM: OMAP: Add DT support for timer driver

 .../devicetree/bindings/arm/omap/timer.txt         |   29 ++++
 arch/arm/boot/dts/am33xx.dtsi                      |   61 +++++++
 arch/arm/boot/dts/omap2.dtsi                       |   86 ++++++++++
 arch/arm/boot/dts/omap2420.dtsi                    |    8 +
 arch/arm/boot/dts/omap2430.dtsi                    |    8 +
 arch/arm/boot/dts/omap3.dtsi                       |   96 +++++++++++
 arch/arm/boot/dts/omap4.dtsi                       |   86 ++++++++++
 arch/arm/mach-omap2/board-generic.c                |   17 ++
 arch/arm/mach-omap2/timer.c                        |  174 ++++++++++++++++----
 arch/arm/plat-omap/dmtimer.c                       |   93 ++++++++++-
 arch/arm/plat-omap/include/plat/dmtimer.h          |    1 +
 11 files changed, 622 insertions(+), 37 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/arm/omap/timer.txt

-- 
1.7.9.5

