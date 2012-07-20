From: AnilKumar Ch <anilkumar@ti.com>
Subject: [PATCH v2 0/2] Add pinctrl support to AM33XX family of devices
Date: Fri, 20 Jul 2012 13:01:46 +0530
Message-ID: <1342769508-24810-1-git-send-email-anilkumar@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:59063 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752127Ab2GTHcO (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 20 Jul 2012 03:32:14 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: tony@atomide.com, b-cousson@ti.com, linux-arm-kernel@lists.infradead.org, devicetree-discuss@lists.ozlabs.org, grant.likely@secretlab.ca, AnilKumar Ch <anilkumar@ti.com>

Adds pinctrl support to AM33XX family of devices. These patches were
tested on AM335x-Bone and AM335x-EVM 

Changes from v1:
	- Rebased the patches based on latest pinctrl-single driver

AnilKumar Ch (2):
  arm/dts: Add AM33XX basic pinctrl support
  arm/dts: Configure pinmuxs for user leds control on Bone

 arch/arm/boot/dts/am335x-bone.dts |   15 +++++++++++++++
 arch/arm/boot/dts/am33xx.dtsi     |    9 +++++++++
 2 files changed, 24 insertions(+), 0 deletions(-)

