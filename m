From: Vignesh R <vigneshr@ti.com>
Subject: [PATCH 0/5] Add support for PWMSS on DRA7
Date: Mon, 1 Jun 2015 17:23:29 +0530
Message-ID: <1433159614-437-1-git-send-email-vigneshr@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:58685 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752416AbbFALz0 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 1 Jun 2015 07:55:26 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>, Tero Kristo <t-kristo@ti.com>, Thierry Reding <thierry.reding@gmail.com>, Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, Benoit Cousson <bcousson@baylibre.com>, Tony Lindgren <tony@atomide.com>, Russell King <linux@arm.linux.org.uk>, Mike Turquette <mturquette@linaro.org>, Stephen Boyd <sboyd@codeaurora.org>
Cc: linux-pwm@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-clk@vger.kernel.org, Vignesh R <vigneshr@ti.com>



Hi,

This patch series adds support for PWMSS on DRA7. The IP is same as that
present in AM33XX and AM43XX.
The first patch changes clock domain in which PWMSS is present
(l4per2_7xx_clkdm) to SW_WKUP. This is because legacy IPs like PWM
does'nt support HW_AUTO prorperly. Hence, switch clock domain to
SW_WKUP. This is based on the input from the hardware team.
The rest of the patches add hwmod and dt entries and enable PWMSS on
DRA7 based SoCs.


Vignesh R (5):
  ARM: OMAP2+: DRA7: clockdomain: change l4per2_7xx_clkdm to SW_WKUP
  ARM: OMAP2+: DRA7: Add hwmod entries for PWMSS
  ARM: dts: DRA7: Add TBCLK for PWMSS
  clk: ti: DRA7: Add tbclk data for ehrpwm
  ARM: dts: DRA7: Add dt nodes for PWMSS

 .../devicetree/bindings/pwm/pwm-tiehrpwm.txt       |   8 +
 .../devicetree/bindings/pwm/pwm-tipwmss.txt        |  17 +-
 arch/arm/boot/dts/dra7.dtsi                        |  69 ++++++
 arch/arm/boot/dts/dra7xx-clocks.dtsi               |  26 +++
 arch/arm/mach-omap2/clockdomains7xx_data.c         |   2 +-
 arch/arm/mach-omap2/omap_hwmod_7xx_data.c          | 239 +++++++++++++++++++++
 drivers/clk/ti/clk-7xx.c                           |   3 +
 7 files changed, 362 insertions(+), 2 deletions(-)

-- 
2.4.1

