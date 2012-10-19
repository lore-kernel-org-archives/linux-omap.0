From: Jon Hunter <jon-hunter@ti.com>
Subject: [PATCH V2 0/2] ARM: OMAP2+: Add device-tree support for 32kHz counter
Date: Fri, 19 Oct 2012 10:05:49 -0500
Message-ID: <1350659151-13898-1-git-send-email-jon-hunter@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:47180 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751997Ab2JSPGE (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 19 Oct 2012 11:06:04 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Benoit Cousson <b-cousson@ti.com>, Tony Lindgren <tony@atomide.com>, Rob Herring <rob.herring@calxeda.com>, Grant Likely <grant.likely@secretlab.ca>
Cc: device-tree <devicetree-discuss@lists.ozlabs.org>, linux-omap <linux-omap@vger.kernel.org>, linux-arm <linux-arm-kernel@lists.infradead.org>, Jon Hunter <jon-hunter@ti.com>

This series adds device-tree support for the 32kHz counter on OMAP2+ devices,
which is used as the default kernel clock-source for OMAP devices.

Boot tested on OMAP2420 H4, OMAP3430 Beagle Board and OMAP4430 Panda Board
with and without device-tree present.

Based and dependent upon OMAP2+ series that adds device-tree support for
DMTIMERs [1].

V2 changes:
- Updated counter name in binding per Benoit Cousson's feedback

[1] http://marc.info/?l=linux-omap&m=135065875808614&w=2

Jon Hunter (2):
  ARM: dts: OMAP: Add counter-32k nodes
  ARM: OMAP2+: Add device-tree support for 32kHz counter

 .../devicetree/bindings/arm/omap/counter.txt       |   15 +++++++++++
 arch/arm/boot/dts/omap2420.dtsi                    |    6 +++++
 arch/arm/boot/dts/omap2430.dtsi                    |    6 +++++
 arch/arm/boot/dts/omap3.dtsi                       |    6 +++++
 arch/arm/boot/dts/omap4.dtsi                       |    6 +++++
 arch/arm/mach-omap2/timer.c                        |   28 +++++++++++++++++++-
 6 files changed, 66 insertions(+), 1 deletion(-)
 create mode 100644 Documentation/devicetree/bindings/arm/omap/counter.txt

-- 
1.7.9.5

