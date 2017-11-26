From: SF Markus Elfring <elfring@users.sourceforge.net>
Subject: [PATCH 0/3] video/fbdev/omap: Adjustments for two function
 implementations
Date: Sun, 26 Nov 2017 18:40:16 +0100
Message-ID: <1e17c727-884d-5745-2726-48dd3a53c32f@users.sourceforge.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Language: en-GB
Sender: linux-kernel-owner@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Sun, 26 Nov 2017 18:38:48 +0100

Three update suggestions were taken into account
from static source code analysis.

Markus Elfring (3):
  Delete an error message for a failed memory allocation in omapfb_do_probe()
  Improve a size determination in omapfb_do_probe()
  Delete an error message for a failed memory allocation in mipid_spi_probe()

 drivers/video/fbdev/omap/lcd_mipid.c   | 4 +---
 drivers/video/fbdev/omap/omapfb_main.c | 4 +---
 2 files changed, 2 insertions(+), 6 deletions(-)

-- 
2.15.0
