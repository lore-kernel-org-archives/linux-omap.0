From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 0/4] Regmap IRQ fix and related changes CPCAP
Date: Thu, 16 Mar 2017 17:36:29 -0700
Message-ID: <20170317003633.7361-1-tony@atomide.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Mark Brown <broonie@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

Hi all,

Here are few fixes to make CPCAP PMIC interrupts work reliably when
used with multiple drivers. While working on the ADC, charger and
USB PHY drivers I noticed that the PMIC interrupt to the SoC would
eventually stop working.

All these can wait for v4.12 merge window as these issues don't show
up currently. Two of the patches are also harmless currently, so I've
kept them in this series to avoid pointless merge conflicts.

Regards,

Tony


Tony Lindgren (4):
  regmap: irq: Fix lost interrupts by introducing handle_reread
  mfd: cpcap: Use handle_reread flag for interrupts
  mfd: cpcap: Use ack_invert interrupts
  mfd: cpcap: Fix bad use of IRQ sense register

 drivers/base/regmap/regmap-irq.c | 77 ++++++++++++++++++++++++++++------------
 drivers/mfd/motorola-cpcap.c     |  7 +++-
 include/linux/regmap.h           |  2 ++
 3 files changed, 62 insertions(+), 24 deletions(-)

-- 
2.11.1
