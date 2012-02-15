From: Omar Ramirez Luna <omar.ramirez@ti.com>
Subject: [RFC PATCH 0/2] staging: tidspbridge: detecting wdt from baseimage
Date: Tue, 14 Feb 2012 21:00:32 -0600
Message-ID: <1329274834-30154-1-git-send-email-omar.ramirez@ti.com>
Mime-Version: 1.0
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog118.obsmtp.com ([74.125.149.244]:54784 "EHLO
	na3sys009aog118.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1757624Ab2BODAs (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Tue, 14 Feb 2012 22:00:48 -0500
Received: by mail-tul01m020-f172.google.com with SMTP id wd15so1259203obb.17
        for <linux-omap@vger.kernel.org>; Tue, 14 Feb 2012 19:00:47 -0800 (PST)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Felipe Contreras <felipe.contreras@nokia.com>
Cc: linux-omap@vger.kernel.org, "Justin P. Mattock" <justinmattock@gmail.com>, devel@driverdev.osuosl.org, Jiri Kosina <jkosina@suse.cz>, Dan Carpenter <dan.carpenter@oracle.com>, Greg KH <gregkh@linuxfoundation.org>, Omar Ramirez Luna <omar.ramirez@ti.com>

This is an alternate solution for:

WARNING: at arch/arm/mach-omap2/omap_l3_smx.c:162 omap3_l3_app_irq...
In-band Error seen by IVA_SS  at address 0

Instead of setting CONFIG_TIDSPBRIDGE_WDT3 to 'default y', these patches
include the code to be compiled for runtime detection of this feature
based on baseimage symbols.

As mentioned in the description of the first patch, we will lose the option
to set a current overflow timeout and the default will be kept as 5 seconds.
This can be replaced by a debugfs/sysfs entry if needed, I didn't include
such a patch as we first need to decide which fix to take (between this and
default y for CONFIG_TIDSPBRIDGE_WDT3[1]).

[1] http://www.mail-archive.com/linux-omap@vger.kernel.org/msg62119.html

Omar Ramirez Luna (2):
  staging: tidspbridge: always compile dsp wdt code
  staging: tidspbridge: detect wdt3 feature at runtime

 drivers/staging/tidspbridge/Kconfig                |   16 -------------
 drivers/staging/tidspbridge/core/tiomap3430.c      |   10 +++++--
 drivers/staging/tidspbridge/core/wdt.c             |   24 +-------------------
 .../tidspbridge/include/dspbridge/_chnl_sm.h       |    4 ---
 4 files changed, 8 insertions(+), 46 deletions(-)

-- 
1.7.4.1

