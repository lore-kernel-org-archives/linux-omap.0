From: Jon Hunter <jon-hunter@ti.com>
Subject: [PATCH 0/2] ARM: OMAP2+: Add device-tree support for 32kHz counter
Date: Wed, 17 Oct 2012 13:33:21 -0500
Message-ID: <1350498803-22150-1-git-send-email-jon-hunter@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:56651 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757623Ab2JQSdj (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 17 Oct 2012 14:33:39 -0400
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

[1] http://marc.info/?l=linux-omap&m=135049690119218&w=2

Jon Hunter (2):
  ARM: dts: OMAP: Add counter-32k nodes
  ARM: OMAP2+: Add device-tree support for 32kHz counter

 .../devicetree/bindings/arm/omap/counter32k.txt    |   15 +++++++++++
 arch/arm/boot/dts/omap2420.dtsi                    |    6 +++++
 arch/arm/boot/dts/omap2430.dtsi                    |    6 +++++
 arch/arm/boot/dts/omap3.dtsi                       |    6 +++++
 arch/arm/boot/dts/omap4.dtsi                       |    6 +++++
 arch/arm/mach-omap2/timer.c                        |   28 +++++++++++++++++++-
 6 files changed, 66 insertions(+), 1 deletion(-)
 create mode 100644 Documentation/devicetree/bindings/arm/omap/counter32k.txt

-- 
1.7.9.5

