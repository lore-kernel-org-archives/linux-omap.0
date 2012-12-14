From: AnilKumar Ch <anilkumar@ti.com>
Subject: [PATCH v4 0/4] pm: Add power off control
Date: Fri, 14 Dec 2012 11:33:13 +0530
Message-ID: <1355464997-19367-1-git-send-email-anilkumar@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:46266 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751218Ab2LNGEG (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 14 Dec 2012 01:04:06 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: a.zummo@towertech.it, sameo@linux.intel.com, tony@atomide.com
Cc: grant.likely@secretlab.ca, broonie@opensource.wolfsonmicro.com, rob.herring@calxeda.com, rtc-linux@googlegroups.com, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, devicetree-discuss@lists.ozlabs.org, AnilKumar Ch <anilkumar@ti.com>

Add PM power_off control to rtc driver and PMIC status is set to
STATUS_OFF to shutdown PMIC if PWR_EN is toggled by RTC module.

System power off sequence:-
* Set PMIC STATUS_OFF when PMIC_POWER_EN is pulled low
* Enable PMIC_POWER_EN in rtc module
* Set rtc ALARM2 time
* Enable ALARM2 interrupt

These patches were tested on am335x-bone (BeagleBone). These patchs
are based on linux-next.

Changes from v3:
	- TPS65217 mfd driver changes are accepted so dropped
	  from this series.
	- With recent changes in the kernel, reboot_mutex held BUG()
	  is not seen so removed while(1); from rtc_power_off.
	- Removed spinlock before while(1); which is not necessary.

Changes from v2:
	- Incorporated Kevin's comment on v2
	  * Enabled RTC in ompa2plus_defconfig

Changes from v1:
	- Incorporated Vaibhav's comments on v1
	  * Changed the time rollover logic with the help of
	    rtc-lib APIs

AnilKumar Ch (3):
  ARM: dts: AM33XX: Set pmic-shutdown-controller for BeagleBone
  ARM: dts: AM33XX: Enable system power off control in am335x-bone
  ARM: OMAP2+: omap2plus_defconfig: Enable RTC support

Colin Foe-Parker (1):
  rtc: OMAP: Add system pm_power_off to rtc driver

 Documentation/devicetree/bindings/rtc/rtc-omap.txt |    5 ++
 arch/arm/boot/dts/am335x-bone.dts                  |    6 ++
 arch/arm/configs/omap2plus_defconfig               |    1 +
 drivers/rtc/rtc-omap.c                             |   74 +++++++++++++++++++-
 4 files changed, 85 insertions(+), 1 deletion(-)

-- 
1.7.9.5

