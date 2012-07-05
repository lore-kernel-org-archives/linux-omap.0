From: AnilKumar Ch <anilkumar@ti.com>
Subject: [PATCH 0/2] Add pinctrl support to AM33XX family of devices
Date: Thu, 5 Jul 2012 14:43:34 +0530
Message-ID: <1341479616-18630-1-git-send-email-anilkumar@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:53166 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750770Ab2GEJOF (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 5 Jul 2012 05:14:05 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: tony@atomide.com, b-cousson@ti.com, linux-arm-kernel@lists.infradead.org, devicetree-discuss@lists.ozlabs.org, grant.likely@secretlab.ca, AnilKumar Ch <anilkumar@ti.com>

Adds pinctrl support to AM33XX family of devices. This patch is
based on the pinctrl-simple driver submitted by Tony L
here: http://lwn.net/Articles/496075/

These patches were tested on AM335x-Bone and AM335x-EVM

AnilKumar Ch (2):
  arm/dts: Add AM33XX basic pinctrl support
  arm/dts: Configure pinmuxs for user leds control on Bone

 arch/arm/boot/dts/am335x-bone.dts |   24 ++++++++++++++++++++++++
 arch/arm/boot/dts/am33xx.dtsi     |   12 ++++++++++++
 2 files changed, 36 insertions(+)

-- 
1.7.9.5

