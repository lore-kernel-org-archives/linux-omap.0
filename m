From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: [PATCH v2 0/8] ARM/dts: OMAP audio related updates for OMAP2/3/4/5
Date: Wed, 29 Aug 2012 16:30:59 +0300
Message-ID: <1346247067-9632-1-git-send-email-peter.ujfalusi@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog112.obsmtp.com ([74.125.149.207]:57443 "EHLO
	na3sys009aog112.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753214Ab2H2NbF (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Wed, 29 Aug 2012 09:31:05 -0400
Received: by obbuo13 with SMTP id uo13so911610obb.19
        for <linux-omap@vger.kernel.org>; Wed, 29 Aug 2012 06:31:03 -0700 (PDT)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Benoit Cousson <b-cousson@ti.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, devicetree-discuss@lists.ozlabs.org

Hello,

I have extended and rebased the previous set:
'ARM/dts: omap McBSP and audio support for BeagleBoard'

Changes since v1:
- Rebased on current l-o:devel-dt branch
- Two new patch, one for OMAP4 to add reg-names for the mem areas, one for OMAP5
  to add McPDM and DMIC section

The rest of the series remaind the same: adds the McBSP sections to OMAP2/3/4/5
and also enable the audio support for BeagleBoard when booting with DT.

Regards,
Peter
---
Peter Ujfalusi (8):
  ARM/dts: OMAP2: Add McBSP entries for OMAP2420 and OMAP2430 SoC
  ARM/dts: omap2420-h4: Include omap2420.dtsi file instead the common
    omap2
  ARM/dts: OMAP3: Add McBSP entries
  ARM/dts: OMAP4: Add McBSP entries
  ARM/dts: OMAP5: Add McBSP entries
  ARM/dts: omap3-beagle: Enable audio support
  ARM/dts: omap4: Add reg-names for McPDM and DMIC
  ARM/dts: omap5: Add McPDM and DMIC section to the dtsi file

 arch/arm/boot/dts/omap2420-h4.dts  |    2 +-
 arch/arm/boot/dts/omap2420.dtsi    |   39 +++++++++++++++++
 arch/arm/boot/dts/omap2430.dtsi    |   83 ++++++++++++++++++++++++++++++++++++
 arch/arm/boot/dts/omap3-beagle.dts |   14 ++++++
 arch/arm/boot/dts/omap3.dtsi       |   69 ++++++++++++++++++++++++++++++
 arch/arm/boot/dts/omap4.dtsi       |   49 +++++++++++++++++++++
 arch/arm/boot/dts/omap5.dtsi       |   56 ++++++++++++++++++++++++
 7 files changed, 311 insertions(+), 1 deletions(-)
 create mode 100644 arch/arm/boot/dts/omap2420.dtsi
 create mode 100644 arch/arm/boot/dts/omap2430.dtsi

-- 
1.7.8.6

