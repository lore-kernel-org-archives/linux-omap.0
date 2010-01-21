From: Nishanth Menon <nm@ti.com>
Subject: [PATCH 0/2] DSPBRIDGE: trivial opp constraint
Date: Wed, 20 Jan 2010 23:45:08 -0600
Message-ID: <1264052710-30337-1-git-send-email-nm@ti.com>
References: <[PATCH 1/2] DSPBRIDGE: remove dependency of mpu freq>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:46606 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751213Ab0AUFpW (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 21 Jan 2010 00:45:22 -0500
In-Reply-To: <[PATCH 1/2] DSPBRIDGE: remove dependency of mpu freq>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap <linux-omap@vger.kernel.org>
Cc: Nishanth Menon <nm@ti.com>, Ameya Palande <ameya.palande@nokia.com>, Deepak Chitriki <deepak.chitriki@ti.com>, Felipe Contreras <felipe.contreras@nokia.com>, Hiroshi Doyu <hiroshi.doyu@nokia.com>, Omar Ramirez Luna <omar.ramirez@ti.com>

in continuation of the discussion in:
http://marc.info/?t=126395196000002&r=1&w=2
patch #2 in this series depends on:
http://marc.info/?l=linux-omap&m=126402596424801&w=2

Nishanth Menon (2):
  DSPBRIDGE: improve constraint_value handling
  DSPBRIDGE: sanitize opp_idx before passing to PM

 drivers/dsp/bridge/wmd/tiomap3430_pwr.c |   16 ++++++++++++----
 1 files changed, 12 insertions(+), 4 deletions(-)

Cc: Ameya Palande <ameya.palande@nokia.com>
Cc: Deepak Chitriki <deepak.chitriki@ti.com>
Cc: Felipe Contreras <felipe.contreras@nokia.com>
Cc: Hiroshi Doyu <hiroshi.doyu@nokia.com>
Cc: Omar Ramirez Luna <omar.ramirez@ti.com>

Regards,
Nishanth Menon
