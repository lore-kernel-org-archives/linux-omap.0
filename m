From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: [PATCH 0/5] drivers: bus: omap_l3: Conversion to devm_*
Date: Thu, 2 May 2013 14:09:42 +0200
Message-ID: <1367496587-6210-1-git-send-email-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Santosh Shilimkar <santosh.shilimkar@ti.com>, Tony Lindgren <tony@atomide.com>
Cc: Olof Johansson <olof@lixom.net>, Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

Hi,

Cleanup of platform probe and remove (removing the remove function at the end)
with converting the driver to use the devm_* versions kzalloc, ioremap and
request_irq.

Regards,
Peter
---
Peter Ujfalusi (5):
  drivers: bus: omap_l3: Convert to use devm_kzalloc
  drivers: bus: omap_l3: Convert to use devm_request_and_ioremap()
  drivers: bus: omap_l3: Convert to use devm_request_irq()
  drivers: bus: omap_l3: Remove the platform driver's remove function
  drivers: bus: omap_l3: Change pr_crit() to dev_err() when IRQ request
    fails

 drivers/bus/omap_l3_noc.c | 106 +++++++++++-----------------------------------
 1 file changed, 24 insertions(+), 82 deletions(-)

-- 
1.8.2.1
