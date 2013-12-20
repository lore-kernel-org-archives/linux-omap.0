From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Subject: [PATCH v2 0/2] ARM: omap3: Split the pinmux core device
Date: Fri, 20 Dec 2013 16:51:15 +0100
Message-ID: <1387554677-21100-1-git-send-email-laurent.pinchart@ideasonboard.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from perceval.ideasonboard.com ([95.142.166.194]:53448 "EHLO
	perceval.ideasonboard.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752700Ab3LTPu6 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 20 Dec 2013 10:50:58 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, Tony Lindgren <tony@atomide.com>, Linus Walleij <linus.walleij@linaro.org>, Sebastian Reichel <sre@debian.org>, Sakari Ailus <sakari.ailus@iki.fi>

Hello,

While working on the OMAP3 ISP driver I've run into a failure to request a
memory region already requested by the pinctrl-single driver. This patch set
is an attempt to fix the problem.

Changes since v1:

- Rebased on top of Tony's master branch
- Handle IGEP LEDs
- Added Tony's PINCTRL macros
- Fixed unbalanced parentheses in Tony's PINCTRL macros ;-)

Laurent Pinchart (1):
  ARM: omap3: Split the pinmux core device

Tony Lindgren (1):
  ARM: dts: Add omap specific pinctrl defines to use padconf addresses

 arch/arm/boot/dts/omap3-beagle-xm.dts | 40 +++++++++++++++++----------
 arch/arm/boot/dts/omap3-beagle.dts    | 40 +++++++++++++++++----------
 arch/arm/boot/dts/omap3-igep.dtsi     |  2 --
 arch/arm/boot/dts/omap3-igep0020.dts  | 52 +++++++++++++++++++----------------
 arch/arm/boot/dts/omap3-igep0030.dts  | 10 ++++---
 arch/arm/boot/dts/omap3-zoom3.dts     | 23 ++++++++++------
 arch/arm/boot/dts/omap3.dtsi          | 13 ++++++++-
 include/dt-bindings/pinctrl/omap.h    | 19 +++++++++++++
 8 files changed, 133 insertions(+), 66 deletions(-)

-- 
Regards,

Laurent Pinchart

