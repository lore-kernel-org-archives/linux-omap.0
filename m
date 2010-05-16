From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v2] dspbridge: fix memory corruption on faults
Date: Sun, 16 May 2010 18:44:27 +0300
Message-ID: <1274024668-20899-1-git-send-email-felipe.contreras@gmail.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from fg-out-1718.google.com ([72.14.220.153]:43223 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751809Ab0EPPoo (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sun, 16 May 2010 11:44:44 -0400
Received: by fg-out-1718.google.com with SMTP id 22so178133fge.1
        for <linux-omap@vger.kernel.org>; Sun, 16 May 2010 08:44:41 -0700 (PDT)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap <linux-omap@vger.kernel.org>
Cc: Omar Ramirez Luna <omar.ramirez@ti.com>, Fernando Guzman Lugo <fernando.lugo@ti.com>, Deepak Chitriki <deepak.chitriki@ti.com>, Felipe Contreras <felipe.contreras@gmail.com>

Hi,

Long story short: we shouldn't send buffers that are not page-aligned for MMU
fault recovery.

For more information, see:
http://thread.gmane.org/gmane.linux.ports.arm.omap/33926/focus=34207

v2: Incuding comments from Fernando Lugo to keep stack dump functionality

Felipe Contreras (1):
  dspbridge: deh: fix corruption on MMU fault

 drivers/dsp/bridge/core/ue_deh.c |   11 +++--------
 1 files changed, 3 insertions(+), 8 deletions(-)

