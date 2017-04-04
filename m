From: Tony Lindgren <tony@atomide.com>
Subject: [PATCHv3 0/3] CPCAP PMIC IRQ fix and related changes
Date: Mon,  3 Apr 2017 20:15:53 -0700
Message-ID: <20170404031556.5093-1-tony@atomide.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Lee Jones <lee.jones@linaro.org>, Samuel Ortiz <sameo@linux.intel.com>
Cc: linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

Hi all,

Here's v3 set of fixes to make CPCAP PMIC interrupts work reliably when
used with multiple drivers. While working on the ADC, charger and
USB PHY drivers I noticed that the PMIC interrupt to the SoC would
eventually stop working.

All these can wait for v4.12 merge window as these issues don't show
up currently. I'll send the related interrupt triggering dts change
separately.

Regards,

Tony

Changes since v2:

- Replaced first two regmap_irq related patches with proper interrupt
  triggering configuration after noticing the dts configuration did
  not get passed in

- Dropped regmap from the patch series subject line

Changes since v1:

- Updated regap-irq patch to use out_runtime_put in regmap_irq_thread
  also if pm_runtime_get() fails

- Clarify patch description for regmap-irq changes to make clear
  this is an issue with the CPCAP PMIC and not SoC GPIO edge/level
  handling based on comments from Charles Keepax
  <ckeepax@opensource.wolfsonmicro.com>

- Collected acks

Tony Lindgren (3):
  mfd: cpcap: Fix interrupt to use level interrupt
  mfd: cpcap: Use ack_invert interrupts
  mfd: cpcap: Fix bad use of IRQ sense register

 drivers/mfd/motorola-cpcap.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

-- 
2.12.2
