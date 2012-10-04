From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: [PATCH 0/9] ARM: dts/OMAP: Pinmux audio configuration for OMAP4+
Date: Thu,  4 Oct 2012 14:57:19 +0300
Message-ID: <1349351848-12972-1-git-send-email-peter.ujfalusi@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog135.obsmtp.com ([74.125.149.84]:59714 "EHLO
	na3sys009aog135.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755222Ab2JDL4T (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 4 Oct 2012 07:56:19 -0400
Received: by mail-ob0-f174.google.com with SMTP id uo13so333163obb.19
        for <linux-omap@vger.kernel.org>; Thu, 04 Oct 2012 04:56:17 -0700 (PDT)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, devicetree-discuss@lists.ozlabs.org

Hello,

u-boot recently stopped configuring 'non essential' pin mux. This change leaves
the audio essential pins in non configured state which prevents the use of audio.
The following series makes sure that the needed pins are configured correctly by
the kernel on OMAP4 and OMAP5.

Tony: can this series queued for 3.7?

Regards,
Peter
---
Peter Ujfalusi (9):
  ARM: OMAP: board-4430-sdp: Pin mux configuration for audio needs
  ARM: OMAP: board-omap4panda: Pin mux configuration for audio needs
  ARM/dts: omap4-panda: Disable unused audio IPs
  ARM/dts: omap4-sdp: Disable unused McBSP3
  ARM/dts: omap5-evm: Disable unused McBSP3
  ARM/dts: omap4-sdp: pinmux configuration for audio
  ARM/dts: omap4-panda: pinmux configuration for audio
  ARM/dts: Add pinctrl driver entries for omap5
  ARM/dts: omap5-evm: pinmux configuration for audio

 arch/arm/boot/dts/omap4-panda.dts      | 47 +++++++++++++++++++++++++++
 arch/arm/boot/dts/omap4-sdp.dts        | 57 +++++++++++++++++++++++++++++++++
 arch/arm/boot/dts/omap5-evm.dts        | 58 ++++++++++++++++++++++++++++++++++
 arch/arm/boot/dts/omap5.dtsi           | 17 ++++++++++
 arch/arm/mach-omap2/board-4430sdp.c    | 26 +++++++++++++++
 arch/arm/mach-omap2/board-omap4panda.c | 15 +++++++++
 6 files changed, 220 insertions(+)

-- 
1.7.12

