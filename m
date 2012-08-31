From: AnilKumar Ch <anilkumar@ti.com>
Subject: [PATCH v5 0/5] Add device tree data for AM33XX devices
Date: Fri, 31 Aug 2012 14:59:16 +0530
Message-ID: <1346405361-29711-1-git-send-email-anilkumar@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:44887 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752686Ab2HaJa2 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 31 Aug 2012 05:30:28 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tony@atomide.com
Cc: wg@grandegger.com, mkl@pengutronix.de, bryan.wu@canonical.com, rpurdie@rpsys.net, linux-leds@vger.kernel.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, devicetree-discuss@lists.ozlabs.org, grant.likely@secretlab.ca, AnilKumar Ch <anilkumar@ti.com>

Add pinctrl and d_can device tree data to AM33XX family of devices.
First two patches add support for pinctrl DT data and third one
adds dcan DT data.

Reason behind combining these patches is to apply cleanly on
linux-omap tree, because these are sequential patches.

These patches were tested on AM335x-Bone, AM335x-EVM and based
on linux-omap:master with this patch
http://www.mail-archive.com/linux-omap@vger.kernel.org/msg74393.html

d_can:
  Changes from v4:
	- Incorporated Tony's comments on v4
	  * Converted all hex numbers to lower-case.
	- Updated C_CAN bindings documentation according to recent
	  changes.

  Changes from v3:
	- Removed d_can1 node from am335x-evm.dts file. Instance
	  one of CAN (d_can1) is available on AM335x-EVM only under
	  a specific CPLD mode selection. am335x-evm.dts does not
          support this mode so remove the d_can1 node.
	- Dropped d_can pinmux settings patch, above comment
	  applies here as well.

  Changes from v2:
	- Incorporated Vaibhav H's comments on v2
	  * Added dcan0 instances to am33xx.dtsi file

  Changes from v1:
	- These two patches separated from c_can DT support
	  patch series.

pinctrl:
  Changes from v4:
	- Incorporated Tony's comments on v4
	  * Converted all hex numbers to lower-case.
	- Added pinctrl api to leds-gpio driver to configure led
	  pins to GPIO mode.

  Changes from v3:
	- Updated the reg length based on latest AM335x TRM.

  Changes from v2:
	- user led pinmux comments updated according to Tony's
	  comment.

  Changes from v1:
	- Rebased the patches based on latest pinctrl-single driver

AnilKumar Ch (5):
  arm/dts: AM33XX: Add basic pinctrl device tree data
  arm/dts: AM33XX: Configure pinmuxs for user leds control on Bone
  arm/dts: AM33XX: Add D_CAN device tree data
  leds: leds-gpio: adopt pinctrl support
  of: Modify c_can binding documentation

 .../devicetree/bindings/net/can/c_can.txt          |   25 +++++++++---
 arch/arm/boot/dts/am335x-bone.dts                  |   41 ++++++++++++++++++++
 arch/arm/boot/dts/am33xx.dtsi                      |   27 +++++++++++++
 drivers/leds/leds-gpio.c                           |   31 +++++++++++----
 4 files changed, 112 insertions(+), 12 deletions(-)

-- 
1.7.9.5

