From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: [PATCH v3 0/8] ARM/dts: OMAP audio related updates for OMAP2/3/4/5
Date: Wed,  5 Sep 2012 14:58:48 +0300
Message-ID: <1346846336-27321-1-git-send-email-peter.ujfalusi@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog128.obsmtp.com ([74.125.149.141]:53129 "EHLO
	na3sys009aog128.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752223Ab2IEL6n (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 5 Sep 2012 07:58:43 -0400
Received: by ggdk6 with SMTP id k6so50602ggd.19
        for <linux-omap@vger.kernel.org>; Wed, 05 Sep 2012 04:58:42 -0700 (PDT)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>, Benoit Cousson <b-cousson@ti.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, devicetree-discuss@lists.ozlabs.org

Hello,

Changes since v2:
- Fixed the interrupts properties of McBSP for OMAP2/3
- omap2420.dtsi, omap2430.dtsi header date updated to 2012

Changes since v1:
- Rebased on current l-o:devel-dt branch
- Two new patch, one for OMAP4 to add reg-names for the mem areas, one for OMAP5
  to add McPDM and DMIC section

The series adds/fixes the audio related IPs (McBSP, McPDM, DMIC) in the dtsi
files and enable the audio on BeagleBoard when booted with DT.

I have created on top of:
git://git.kernel.org/pub/scm/linux/kernel/git/bcousson/linux-omap-dt.git
for_3.7/dts

Regards,
Peter
---
Peter Ujfalusi (8):
  ARM/dts: omap2: Add McBSP entries for OMAP2420 and OMAP2430 SoC
  ARM/dts: omap2420-h4: Include omap2420.dtsi file instead the common
    omap2
  ARM/dts: omap3: Add McBSP entries
  ARM/dts: omap4: Add McBSP entries
  ARM/dts: omap4: Add reg-names for McPDM and DMIC
  ARM/dts: omap5: Add McBSP entries
  ARM/dts: omap5: Add McPDM and DMIC section to the dtsi file
  ARM/dts: omap3-beagle: Enable audio support

 arch/arm/boot/dts/omap2420-h4.dts  |  2 +-
 arch/arm/boot/dts/omap2420.dtsi    | 39 ++++++++++++++++++
 arch/arm/boot/dts/omap2430.dtsi    | 83 ++++++++++++++++++++++++++++++++++++++
 arch/arm/boot/dts/omap3-beagle.dts | 14 +++++++
 arch/arm/boot/dts/omap3.dtsi       | 69 +++++++++++++++++++++++++++++++
 arch/arm/boot/dts/omap4.dtsi       | 49 ++++++++++++++++++++++
 arch/arm/boot/dts/omap5.dtsi       | 56 +++++++++++++++++++++++++
 7 files changed, 311 insertions(+), 1 deletion(-)
 create mode 100644 arch/arm/boot/dts/omap2420.dtsi
 create mode 100644 arch/arm/boot/dts/omap2430.dtsi

-- 
1.7.12

