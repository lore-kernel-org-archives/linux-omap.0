From: AnilKumar Ch <anilkumar@ti.com>
Subject: [PATCH v3 0/2] Add pinctrl support to AM33XX family of devices
Date: Tue, 24 Jul 2012 21:15:17 +0530
Message-ID: <1343144719-26352-1-git-send-email-anilkumar@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:41279 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752288Ab2GXPps (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 24 Jul 2012 11:45:48 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: tony@atomide.com, b-cousson@ti.com, linux-arm-kernel@lists.infradead.org, devicetree-discuss@lists.ozlabs.org, grant.likely@secretlab.ca, AnilKumar Ch <anilkumar@ti.com>

Adds pinctrl support to AM33XX family of devices. These patches were
tested on AM335x-Bone and AM335x-EVM 

Changes from v2:
	- user led pinmux comments updated according to Tony's
	  comment.

Changes from v1:
	- Rebased the patches based on latest pinctrl-single driver

AnilKumar Ch (2):
  arm/dts: Add AM33XX basic pinctrl support
  arm/dts: Configure pinmuxs for user leds control on Bone

 arch/arm/boot/dts/am335x-bone.dts |   15 +++++++++++++++
 arch/arm/boot/dts/am33xx.dtsi     |    9 +++++++++
 2 files changed, 24 insertions(+)

-- 
1.7.9.5

