From: Felipe Balbi <balbi@ti.com>
Subject: [PATCH v2 0/5] ARM: OMAP: DTS/HWMOD/defconfig changes for USB3
Date: Tue, 16 Jul 2013 15:50:32 +0300
Message-ID: <1373979037-27587-1-git-send-email-balbi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Linux OMAP Mailing List <linux-omap@vger.kernel.org>, Linux ARM Kernel Mailing List <linux-arm-kernel@lists.infradead.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Benoit Cousson <benoit.cousson@linaro.org>, Kishon Vijay Abraham I <kishon@ti.com>, Felipe Balbi <balbi@ti.com>
List-Id: linux-omap@vger.kernel.org

With these patches (plus a few others on the driver side which
will be going upstream soon) I could get functional USB3 with my
omap5-uevm platform.

Changes since v1:
	- split ocp2scp dts and hwmod data into separate patches
	- reorganize the series in order to group DTS, hwmod and defconfig
	  changes

Benoit Cousson (1):
  arm: omap5: hwmod: add missing ocp2scp hwmod data

Felipe Balbi (4):
  arm: omap5: dts: fix reg property size
  arm: omap5: dts: fix ocp2scp DTS data
  arm: omap5: dts: add palmas-usb node
  arm: omap2plus_defconfig: enable dwc3 and dependencies

 arch/arm/boot/dts/omap5-uevm.dts           | 10 +++++++
 arch/arm/boot/dts/omap5.dtsi               |  9 +++---
 arch/arm/configs/omap2plus_defconfig       |  9 ++++++
 arch/arm/mach-omap2/omap_hwmod_54xx_data.c | 45 ++++++++++++++++++++++++++++++
 4 files changed, 69 insertions(+), 4 deletions(-)

-- 
1.8.3.3.754.g9c3c367
