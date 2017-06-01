From: SF Markus Elfring <elfring@users.sourceforge.net>
Subject: [PATCH 0/5] ARM-OMAP1: Adjustments for three function implementations
Date: Thu, 1 Jun 2017 22:46:28 +0200
Message-ID: <85e2ec7f-f650-28a2-6cc5-0b4b52e44183@users.sourceforge.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Language: en-GB
Sender: linux-kernel-owner@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Aaro Koskinen <aaro.koskinen@iki.fi>, Russell King <linux@armlinux.org.uk>, Tony Lindgren <tony@atomide.com>
Cc: LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Thu, 1 Jun 2017 22:40:04 +0200

A few update suggestions were taken into account
from static source code analysis.

Markus Elfring (5):
  Improve a size determination in omap1_system_dma_init()
  Delete an error message for a failed memory allocation in omap1_system_dma_init()
  Delete an unnecessary return statement in omap1_show_dma_caps()
  Delete an error message for a failed memory allocation in omap1_dm_timer_init()
  Fix a typo in a comment line

 arch/arm/mach-omap1/dma.c   | 5 +----
 arch/arm/mach-omap1/timer.c | 4 +---
 2 files changed, 2 insertions(+), 7 deletions(-)

-- 
2.13.0
