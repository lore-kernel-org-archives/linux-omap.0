From: Omar Ramirez Luna <omar.ramirez@ti.com>
Subject: [PATCH 0/2] Cleanup for handle constraint from DSP
Date: Tue, 22 Dec 2009 00:11:41 -0600
Message-ID: <1261462303-29437-1-git-send-email-omar.ramirez@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:40462 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751721AbZLVGEB (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 22 Dec 2009 01:04:01 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap <linux-omap@vger.kernel.org>
Cc: Hiroshi Doyu <Hiroshi.DOYU@nokia.com>, Ameya Palande <ameya.palande@nokia.com>, Felipe Contreras <felipe.contreras@nokia.com>, Fernando Guzman <x0095840@ti.com>, Ernesto Ramos <ernesto@ti.com>, Omar Ramirez Luna <omar.ramirez@ti.com>

Omar Ramirez Luna (2):
  DSPBRIDGE: Avoid saving mailbox settings on constraint request
  DSPBRIDGE: remove useless return statement

 drivers/dsp/bridge/wmd/tiomap3430_pwr.c |    6 ------
 1 files changed, 0 insertions(+), 6 deletions(-)

