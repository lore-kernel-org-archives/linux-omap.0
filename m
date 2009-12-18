From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH 0/2] dsp-bridge: PM cleanups
Date: Fri, 18 Dec 2009 19:44:35 +0200
Message-ID: <1261158277-26402-1-git-send-email-felipe.contreras@gmail.com>
References: <1261016163-11091-19-git-send-email-omar.ramirez@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from ey-out-2122.google.com ([74.125.78.24]:61919 "EHLO
	ey-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932316AbZLRRoy (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 18 Dec 2009 12:44:54 -0500
Received: by ey-out-2122.google.com with SMTP id d26so843128eyd.19
        for <linux-omap@vger.kernel.org>; Fri, 18 Dec 2009 09:44:52 -0800 (PST)
In-Reply-To: <1261016163-11091-19-git-send-email-omar.ramirez@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap <linux-omap@vger.kernel.org>
Cc: Omar Ramirez Luna <omar.ramirez@ti.com>, Ameya Palande <ameya.palande@nokia.com>, Felipe Contreras <felipe.contreras@nokia.com>

From: Felipe Contreras <felipe.contreras@nokia.com>

These patches apply on top of a commit in Omar's wip dspbridge-baseline:
cd0c004e5c6bc9da58d03931766115ec1e8bcaaf

They are supposed to replace "Compilation fixes 2.6.31".

Felipe Contreras (2):
  dsp-bridge: improve PM conditional code
  dsp-bridge: remove unused includes

 arch/arm/mach-omap2/dspbridge.c         |    2 ++
 drivers/dsp/bridge/rmgr/drv_interface.c |    8 ++++----
 drivers/dsp/bridge/rmgr/proc.c          |    1 -
 drivers/dsp/bridge/wmd/tiomap3430_pwr.c |    3 +--
 4 files changed, 7 insertions(+), 7 deletions(-)

