From: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Subject: [PATCH 0/2] Add PWM polarity flag macros for DT
Date: Thu, 11 Jul 2013 16:37:46 +0200
Message-ID: <1373553468-6564-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from perceval.ideasonboard.com ([95.142.166.194]:48320 "EHLO
	perceval.ideasonboard.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932980Ab3GKOhQ (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 11 Jul 2013 10:37:16 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Thierry Reding <thierry.reding@gmail.com>
Cc: Shawn Guo <shawn.guo@linaro.org>, Steffen Trumtrar <s.trumtrar@pengutronix.de>, Boris BREZILLON <linux-arm@overkiz.com>, Tomasz Figa <t.figa@samsung.com>, Philip Avinash <avinashphilip@ti.com>, Tony Prisk <linux@prisktech.co.nz>, linux-pwm@vger.kernel.org, devicetree-discuss@lists.ozlabs.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

Hello,

Here's a small patch set that replaces PWM polarity numerical constants with
macros in DT. The series starts with a fix for an error in the i.MX53 mba53 DT,
and the second patch then introduces the macros and update both bindings
documentation and existing DT.

Laurent Pinchart (2):
  ARM i.MX53: mba53: Fix PWM backlight DT node
  pwm: Add PWM polarity flag macros for DT

 Documentation/devicetree/bindings/pwm/atmel-tcb-pwm.txt |  6 +++---
 Documentation/devicetree/bindings/pwm/pwm-samsung.txt   |  5 +++--
 Documentation/devicetree/bindings/pwm/pwm-tiehrpwm.txt  |  5 +++--
 Documentation/devicetree/bindings/pwm/pwm.txt           |  8 +++++---
 Documentation/devicetree/bindings/pwm/vt8500-pwm.txt    |  5 +++--
 arch/arm/boot/dts/am335x-evm.dts                        |  3 ++-
 arch/arm/boot/dts/am335x-evmsk.dts                      |  3 ++-
 arch/arm/boot/dts/imx53-mba53.dts                       |  2 +-
 arch/arm/boot/dts/wm8850-w70v2.dts                      |  3 ++-
 include/dt-bindings/pwm/pwm.h                           | 15 +++++++++++++++
 include/linux/pwm.h                                     |  4 ++--
 11 files changed, 41 insertions(+), 18 deletions(-)
 create mode 100644 include/dt-bindings/pwm/pwm.h

-- 
Regards,

Laurent Pinchart

