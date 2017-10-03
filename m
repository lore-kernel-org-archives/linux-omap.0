From: SF Markus Elfring <elfring@users.sourceforge.net>
Subject: [PATCH 0/4] ARM-OMAP: Adjustments for three function implementations
Date: Tue, 3 Oct 2017 22:12:01 +0200
Message-ID: <b196ffac-4bd1-4465-cee9-e46b7405633d@users.sourceforge.net>
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
Date: Tue, 3 Oct 2017 22:04:22 +0200

A few update suggestions were taken into account
from static source code analysis.

Markus Elfring (4):
  Delete an error message for a failed memory allocation in two functions
  Improve a size determination in two functions
  Use kcalloc() in omap_system_dma_probe()
  Fix typos in two comment lines in _omap_dm_timer_request()

 arch/arm/plat-omap/dma.c     | 12 +++++-------
 arch/arm/plat-omap/dmtimer.c | 10 ++++------
 2 files changed, 9 insertions(+), 13 deletions(-)

-- 
2.14.2
