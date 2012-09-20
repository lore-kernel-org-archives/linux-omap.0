From: Jean Pihet <jean.pihet@newoldbits.com>
Subject: [PATCH 0/2] ARM: OMAP: SmartReflex: pass device dependent data via platform data
Date: Thu, 20 Sep 2012 16:47:31 +0200
Message-ID: <1348152453-30532-1-git-send-email-j-pihet@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-wg0-f44.google.com ([74.125.82.44]:58594 "EHLO
	mail-wg0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932091Ab2ITOrp (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 20 Sep 2012 10:47:45 -0400
Received: by wgbdr13 with SMTP id dr13so529872wgb.1
        for <linux-omap@vger.kernel.org>; Thu, 20 Sep 2012 07:47:44 -0700 (PDT)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, tony@atomide.com, Anton Vorontsov <cbou@mail.ru>, Kevin Hilman <khilman@ti.com>, J Keerthy <j-keerthy@ti.com>
Cc: Jean Pihet <j-pihet@ti.com>

Remove the device dependent settings (cpu_is_xxx(), IP fck etc.)
from the driver code and pass them instead via the platform
data.
This allows a clean separation of the driver code and the platform
code, as required by the recent re-org of the platform data header
files.

The patch also includes a fix of the error handling path in omap_sr_probe
to correctly de-allocate resources in case of problems. $SUBJECT requires
this change.

Jean Pihet (2):
  ARM: OMAP: SmartReflex: fix error path in init function
  ARM: OMAP: SmartReflex: pass device dependent data via platform data

 arch/arm/mach-omap2/sr_device.c   |   14 +++++++++
 drivers/power/avs/smartreflex.c   |   57 +++++++++++++++---------------------
 include/linux/power/smartreflex.h |   17 ++++++++++-
 3 files changed, 53 insertions(+), 35 deletions(-)

-- 
1.7.7.6

