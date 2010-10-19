From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH] omap: dsp: fix for ioremap()
Date: Tue, 19 Oct 2010 10:37:23 +0300
Message-ID: <1287473844-6228-1-git-send-email-felipe.contreras@gmail.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-bw0-f46.google.com ([209.85.214.46]:58656 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755871Ab0JSHhl (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 19 Oct 2010 03:37:41 -0400
Received: by bwz10 with SMTP id 10so56549bwz.19
        for <linux-omap@vger.kernel.org>; Tue, 19 Oct 2010 00:37:40 -0700 (PDT)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap <linux-omap@vger.kernel.org>
Cc: Greg KH <greg@kroah.com>, Omar Ramirez Luna <omar.ramirez@ti.com>, Tony Lindgren <tony@atomide.com>, Russell King <linux@arm.linux.org.uk>, Felipe Contreras <felipe.contreras@gmail.com>

Since ioremap() on RAM will be soon disallowed, this is required.

This also requires a patch like:
http://article.gmane.org/gmane.linux.kernel/1047146

Felipe Contreras (1):
  omap: dsp: remove shm from normal memory

 arch/arm/plat-omap/devices.c |    4 +++-
 1 files changed, 3 insertions(+), 1 deletions(-)

-- 
1.7.3.1.2.g7fe2b

