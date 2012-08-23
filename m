From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: [PATCH 0/6] ARM/dts: omap McBSP and audio support for BeagleBoard
Date: Thu, 23 Aug 2012 12:29:07 +0300
Message-ID: <1345714153-13094-1-git-send-email-peter.ujfalusi@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog127.obsmtp.com ([74.125.149.107]:48514 "EHLO
	na3sys009aog127.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1757160Ab2HWJ3Z (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Thu, 23 Aug 2012 05:29:25 -0400
Received: by obbta17 with SMTP id ta17so1185488obb.8
        for <linux-omap@vger.kernel.org>; Thu, 23 Aug 2012 02:29:22 -0700 (PDT)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, devicetree-discuss@lists.ozlabs.org, Benoit Cousson <b-cousson@ti.com>

Hello,

The following series will add the needed entries for OMAP McBSP for DeviceTree
and enable the audio support on BeagleBoard when booted with DT.

Regards,
Peter
---
Peter Ujfalusi (6):
  ARM/dts: OMAP2: Add McBSP entries for OMAP2420 and OMAP2430 SoC
  ARM/dts: omap2420-h4: Include omap2420.dtsi file instead the common
    omap2
  ARM/dts: OMAP3: Add McBSP entries
  ARM/dts: OMAP4: Add McBSP entries
  ARM/dts: OMAP5: Add McBSP entries
  ARM/dts: omap3-beagle: Enable audio support

 arch/arm/boot/dts/omap2420-h4.dts  |    2 +-
 arch/arm/boot/dts/omap2420.dtsi    |   39 +++++++++++++++++
 arch/arm/boot/dts/omap2430.dtsi    |   83 ++++++++++++++++++++++++++++++++++++
 arch/arm/boot/dts/omap3-beagle.dts |   14 ++++++
 arch/arm/boot/dts/omap3.dtsi       |   69 ++++++++++++++++++++++++++++++
 arch/arm/boot/dts/omap4.dtsi       |   47 ++++++++++++++++++++
 arch/arm/boot/dts/omap5.dtsi       |   36 +++++++++++++++
 7 files changed, 289 insertions(+), 1 deletions(-)
 create mode 100644 arch/arm/boot/dts/omap2420.dtsi
 create mode 100644 arch/arm/boot/dts/omap2430.dtsi

-- 
1.7.8.6

