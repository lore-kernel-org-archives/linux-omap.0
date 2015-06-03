From: Vignesh R <vigneshr@ti.com>
Subject: [PATCH v2 0/5] Add support for PWMSS on DRA7
Date: Wed, 3 Jun 2015 17:21:19 +0530
Message-ID: <1433332284-10766-1-git-send-email-vigneshr@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Paul Walmsley <paul@pwsan.com>, Tero Kristo <t-kristo@ti.com>, Thierry Reding <thierry.reding@gmail.com>, Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, Benoit Cousson <bcousson@baylibre.com>, Tony Lindgren <tony@atomide.com>, Russell King <linux@arm.linux.org.uk>, Mike Turquette <mturquette@linaro.org>, Stephen Boyd <sboyd@codeaurora.org>
Cc: linux-pwm@vger.kernel.org, Vignesh R <vigneshr@ti.com>, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org


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
 arch/arm/mach-omap2/omap_hwmod_7xx_data.c          | 239 +++++++++++++++++++
 drivers/clk/ti/clk-7xx.c                           |   3 +
 7 files changed, 362 insertions(+), 2 deletions(-)

-- 
2.4.1
