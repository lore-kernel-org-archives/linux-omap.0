From: AnilKumar Ch <anilkumar@ti.com>
Subject: [PATCH v7 0/3] arm/dts: Add device tree data for AM33XX devices
Date: Thu, 6 Sep 2012 15:08:21 +0530
Message-ID: <1346924304-27425-1-git-send-email-anilkumar@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:56827 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751352Ab2IFJjP (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 6 Sep 2012 05:39:15 -0400
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

Changes from v6:
	- Incorporated Tony's comments on v5
	  * Moved am3358_pinmux to am33xx_pinmux

Changes from v5:
	- Incorporated Koen's comments on v5 series, user leds
	  trigger modifications.
	- Dropped 4th and 5th patches, submitted v2 versions of
	  those in their corresponding mailing lists.

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

AnilKumar Ch (3):
  arm/dts: AM33XX: Add basic pinctrl device tree data
  arm/dts: AM33XX: Configure pinmuxs for user leds control on Bone
  arm/dts: AM33XX: Add D_CAN device tree data

 arch/arm/boot/dts/am335x-bone.dts |   43 +++++++++++++++++++++++++++++++++++++
 arch/arm/boot/dts/am33xx.dtsi     |   27 +++++++++++++++++++++++
 2 files changed, 70 insertions(+)

-- 
1.7.9.5

