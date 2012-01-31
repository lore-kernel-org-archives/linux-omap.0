From: Omar Ramirez Luna <omar.ramirez@ti.com>
Subject: [PATCH 0/2] staging: tidspbridge: memory leak fixes
Date: Mon, 30 Jan 2012 19:20:16 -0600
Message-ID: <1327972818-30993-1-git-send-email-omar.ramirez@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog121.obsmtp.com ([74.125.149.145]:37591 "EHLO
	na3sys009aog121.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752514Ab2AaBU1 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Mon, 30 Jan 2012 20:20:27 -0500
Received: by mail-gx0-f177.google.com with SMTP id l4so40105ggn.8
        for <linux-omap@vger.kernel.org>; Mon, 30 Jan 2012 17:20:26 -0800 (PST)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@suse.de>
Cc: Omar Ramirez Luna <omar.ramirez@ti.com>, Felipe Contreras <felipe.contreras@gmail.com>, devel@driverdev.osuosl.org, linux-omap@vger.kernel.org

These patches solve two lingering memory leak scenarios introduced
in tidspbridge code.

1. Due to missing balanced calls during bridge_release deallocation, and
   a potential leak in bridge_open because of missing cleanup path.
2. Leaks because of a misuse of an already freed pointer, which triggered
   error paths during module removal leaking some memory.

When accepted they must be propagated to stable kernel releases.

Omar Ramirez Luna (2):
  staging: tidspbridge: fix bridge_open memory leaks
  staging: tidspbridge: fix incorrect free to drv_datap

 drivers/staging/tidspbridge/core/tiomap3430.c    |    2 -
 drivers/staging/tidspbridge/rmgr/drv_interface.c |   58 +++++++++++++---------
 2 files changed, 35 insertions(+), 25 deletions(-)

-- 
1.7.4.1

