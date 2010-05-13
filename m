From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH 0/2] dspbridge: deh: fix memory corruption on faults
Date: Thu, 13 May 2010 23:46:39 +0300
Message-ID: <1273783601-13472-1-git-send-email-felipe.contreras@gmail.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from fg-out-1718.google.com ([72.14.220.153]:37070 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751667Ab0EMUqt (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 13 May 2010 16:46:49 -0400
Received: by fg-out-1718.google.com with SMTP id 19so2706902fgg.1
        for <linux-omap@vger.kernel.org>; Thu, 13 May 2010 13:46:47 -0700 (PDT)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap <linux-omap@vger.kernel.org>
Cc: Omar Ramirez Luna <omar.ramirez@ti.com>, Fernando Guzman Lugo <x0095840@ti.com>, Hiroshi Doyu <hiroshi.doyu@nokia.com>, Felipe Contreras <felipe.contreras@gmail.com>

Hi,

Long story short: we shouldn't send buffers that are not page-aligned for MMU
fault recovery. In fact, there's no need to send anything at all.

For more information, see:
http://thread.gmane.org/gmane.linux.ports.arm.omap/33926/focus=34207

Felipe Contreras (2):
  dspbridge: deh: fix corruption on MMU fault
  dspbridge: deh: remove unused code

 arch/arm/plat-omap/include/dspbridge/wmddeh.h |    1 -
 drivers/dsp/bridge/rmgr/proc.c                |    7 +---
 drivers/dsp/bridge/wmd/_tiomap.h              |    4 --
 drivers/dsp/bridge/wmd/tiomap3430.c           |    2 -
 drivers/dsp/bridge/wmd/ue_deh.c               |   48 +------------------------
 5 files changed, 2 insertions(+), 60 deletions(-)

