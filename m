From: Rajendra Nayak <rnayak@ti.com>
Subject: [PATCH v2 0/4] OMAP serial device tree support
Date: Tue, 22 Nov 2011 19:14:12 +0530
Message-ID: <1321969456-24266-1-git-send-email-rnayak@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:48688 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754244Ab1KVNpC (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 22 Nov 2011 08:45:02 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-serial@vger.kernel.org, linux-omap@vger.kernel.org, devicetree-discuss@lists.ozlabs.org
Cc: tony@atomide.com, khilman@ti.com, govindraj.raja@ti.com, b-cousson@ti.com, linux-arm-kernel@lists.infradead.org, linaro-dev@lists.linaro.org, patches@linaro.org, robherring2@gmail.com, Rajendra Nayak <rnayak@ti.com>

v2 is based on the latest omap-serial runtime patches, which
can be found here[1]

The series passes minimal data that allows serial console
boot, with UART's initialised from device tree.
However some of low power support for UART and remote
wakeup needs more work.
Boot tested on OMAP4 panda and OMAP4 sdp boards.

Patches can be found here..
git://gitorious.org/omap-pm/linux.git for-dt/serial

Changes in v2:
-1- Got rid of binding to define which uart is console
-2- Added checks to default clock speed to 48Mhz
-3- Added compatible for each OMAP family
-4- Used of_alias_get_id to populate port.line

regards,
Rajendra

[1] git://gitorious.org/runtime_3-0/runtime_3-0.git 3.2-rc2_uart_runtime

Rajendra Nayak (4):
  omap-serial: Get rid of all pdev->id usage
  omap-serial: Use default clock speed (48Mhz) if not specified
  omap-serial: Add minimal device tree support
  ARM: omap: pass minimal SoC/board data for UART from dt

 .../devicetree/bindings/serial/omap_serial.txt     |   10 +++
 arch/arm/boot/dts/omap3.dtsi                       |   31 ++++++++
 arch/arm/boot/dts/omap4.dtsi                       |   28 +++++++
 arch/arm/mach-omap2/board-generic.c                |    1 -
 drivers/tty/serial/omap-serial.c                   |   80 +++++++++++++++----
 5 files changed, 132 insertions(+), 18 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/serial/omap_serial.txt

