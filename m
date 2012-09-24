From: Jean Pihet <jean.pihet@newoldbits.com>
Subject: [PATCH 0/2] ARM: OMAP: SmartReflex: pass device dependent data via platform data
Date: Mon, 24 Sep 2012 16:16:39 +0200
Message-ID: <1348496201-6378-1-git-send-email-j-pihet@ti.com>
References: <1348152453-30532-1-git-send-email-j-pihet@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-wi0-f178.google.com ([209.85.212.178]:60904 "EHLO
	mail-wi0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755650Ab2IXORA (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 24 Sep 2012 10:17:00 -0400
Received: by wibhr14 with SMTP id hr14so4930816wib.1
        for <linux-omap@vger.kernel.org>; Mon, 24 Sep 2012 07:16:59 -0700 (PDT)
In-Reply-To: <1348152453-30532-1-git-send-email-j-pihet@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, tony@atomide.com, Anton Vorontsov <cbou@mail.ru>
Cc: Kevin Hilman <khilman@ti.com>, J Keerthy <j-keerthy@ti.com>, Jean Pihet <j-pihet@ti.com>

Remove the device dependent settings (cpu_is_xxx(), IP fck etc.)
from the driver code and pass them instead via the platform
data.
This allows a clean separation of the driver code and the platform
code, as required by the move of the platform header files to
include/linux/platform_data.

The patch also includes a fix of the error handling path in omap_sr_probe
to correctly de-allocate resources in case of problems. $SUBJECT requires
this change.

Jean Pihet (2):
  ARM: OMAP: SmartReflex: fix error path in init function
  ARM: OMAP: SmartReflex: pass device dependent data via platform data

 arch/arm/mach-omap2/sr_device.c   |   13 ++++++++++
 drivers/power/avs/smartreflex.c   |   48 +++++++++++-------------------------
 include/linux/power/smartreflex.h |   14 +++++++++-
 3 files changed, 40 insertions(+), 35 deletions(-)

-- 
1.7.7.6

