From: Vignesh R <vigneshr@ti.com>
Subject: [PATCH 0/2] fix ehrpwm tbclk data on am33xx and am43xx
Date: Tue, 10 Feb 2015 11:05:40 +0530
Message-ID: <1423546542-29664-1-git-send-email-vigneshr@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Benoit Cousson <bcousson@baylibre.com>, Tony Lindgren <tony@atomide.com>, Tero Kristo <t-kristo@ti.com>, Russell King <linux@arm.linux.org.uk>
Cc: Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, linux-omap@vger.kernel.org, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, Vignesh R <vigneshr@ti.com>
List-Id: linux-omap@vger.kernel.org

In am33xx and am43xx, ehrpwm tbclk is derived from functional clock of
PWMSS. The schematics and TRMs show that there is only one input clock to
the PWMSS. But currently, tbclk is wrongly shown to be deriving from
dpll_per_m2_ck instead of functional clock l4ls_gclk in the DT.

Fixing ehrpwm tbclk data to reflect the right clk source.
Tested on beaglebone and am437x-gp-evm.

Vignesh R (2):
  ARM: dts: am33xx-clocks: Fix ehrpwm tbclk data on am33xx
  ARM: dts: am43xx-clocks: Fix ehrpwm tbclk data on am43xx

 arch/arm/boot/dts/am33xx-clocks.dtsi |  6 +++---
 arch/arm/boot/dts/am43xx-clocks.dtsi | 12 ++++++------
 2 files changed, 9 insertions(+), 9 deletions(-)

-- 
1.9.1
