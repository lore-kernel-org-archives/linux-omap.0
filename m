From: Nishanth Menon <nm@ti.com>
Subject: [PATCH 0/2] OMAP3+: PM: SR fixes
Date: Fri, 22 Jul 2011 00:55:51 -0500
Message-ID: <1311314153-23531-1-git-send-email-nm@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog107.obsmtp.com ([74.125.149.197]:56169 "EHLO
	na3sys009aog107.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753196Ab1GVF4H (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Fri, 22 Jul 2011 01:56:07 -0400
Received: by gyg4 with SMTP id 4so1382657gyg.39
        for <linux-omap@vger.kernel.org>; Thu, 21 Jul 2011 22:56:05 -0700 (PDT)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin <khilman@ti.com>
Cc: Colin <ccross@google.com>, linux-arm <linux-arm-kernel@lists.infradead.org>, linux-omap <linux-omap@vger.kernel.org>, Nishanth Menon <nm@ti.com>

Hi Kevin,
Please find attached a couple of patches collected as part of SR stabilization
around idle and a slight improvement for suspend path. The second patch
could probably help at a later date as part of moving the SmartReflex driver
off as a seperate independent driver of it's own.

These are based on Linus master v3.0-rc7

Colin Cross (1):
  OMAP3+: PM: SR: use put_sync_suspend for disabling

Nishanth Menon (1):
  OMAP2+: PM: SR: add suspend/resume handlers

 arch/arm/mach-omap2/smartreflex.c |   89 ++++++++++++++++++++++++++++++++++++-
 1 files changed, 88 insertions(+), 1 deletions(-)

-- 
Regards,
Nishanth Menon
