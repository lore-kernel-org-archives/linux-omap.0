From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 0/4] OMAPDSS: Add support for panel ls037v7dw01
Date: Tue, 29 Apr 2014 16:52:38 -0700
Message-ID: <1398815562-24113-1-git-send-email-tony@atomide.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:38157 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750756AbaD2Xws (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 29 Apr 2014 19:52:48 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org, linux-fbdev@vger.kernel.org, devicetree@vger.kernel.org, linux-omap@vger.kernel.org
Cc: tomi.valkeinen@ti.com

Hi all,

Here are few patches to add devicetree support for panel ls037v7dw01
that's found on many omap3 boards. They seem to be often mis-configured
as various panel dpi entries, but really should be move to use panel
ls037v7dw01 instead. This panel is found at least on the omap3 sdp,
ldp, omap3 evm and few other development boards.

Regards,

Tony

Tony Lindgren (4):
  OMAPDSS: Fix DSS clock multiplier issue on 3703 and probably 3630
  OMAPDSS: panel-sharp-ls037v7dw01: update to use gpiod
  OMAPDSS: panel-sharp-ls037v7dw01: add device tree support
  ARM: dts: Add LCD panel sharp ls037v7dw01 support for omap3-evm and
    ldp

 .../bindings/panel/sharp,ls037v7dw01.txt           |  53 +++++++
 .../arm/boot/dts/omap-panel-sharp-ls037v7dw01.dtsi |  82 ++++++++++
 arch/arm/boot/dts/omap3-evm-37xx.dts               |  50 ++++++
 arch/arm/boot/dts/omap3-evm-common.dtsi            |  47 ++++++
 arch/arm/boot/dts/omap3-ldp.dts                    |  31 +++-
 .../omap2/displays-new/panel-sharp-ls037v7dw01.c   | 176 ++++++++++++++-------
 drivers/video/fbdev/omap2/dss/dss.c                |   5 +-
 7 files changed, 379 insertions(+), 65 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/panel/sharp,ls037v7dw01.txt
 create mode 100644 arch/arm/boot/dts/omap-panel-sharp-ls037v7dw01.dtsi

-- 
1.8.1.1

