From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH 00/10] dsp-bridge: deh: general cleanups
Date: Tue, 23 Mar 2010 23:25:32 +0200
Message-ID: <1269379542-11892-1-git-send-email-felipe.contreras@gmail.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-bw0-f209.google.com ([209.85.218.209]:33760 "EHLO
	mail-bw0-f209.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752988Ab0CWV0F (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 23 Mar 2010 17:26:05 -0400
Received: by bwz1 with SMTP id 1so2292169bwz.21
        for <linux-omap@vger.kernel.org>; Tue, 23 Mar 2010 14:26:02 -0700 (PDT)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap <linux-omap@vger.kernel.org>
Cc: Ameya Palande <ameya.palande@nokia.com>, Omar Ramirez Luna <omar.ramirez@ti.com>, Felipe Contreras <felipe.contreras@gmail.com>

Hi,

While trying to fix the recovery feature I stumbled many areas of improvments
in 'deh' (whatever that means).

I quickly tested tesed these changes in Nokia hw, there should be essentially
no functional changes.

Cheers.

Felipe Contreras (10):
  dsp-bridge: deh: remove obvious comments
  dsp-bridge: deh: trivial cleanups
  dsp-bridge: deh: remove unnecessary casts
  dsp-bridge: deh: improve logging stuff
  dsp-bridge: deh: report mmu faults as errors
  dsp-bridge: deh: decrease nesting levels
  dsp-bridge: deh: fix obvious return codes
  dsp-bridge: deh: reorganize create()
  dsp-bridge: deh: fix hdeh_mgr silliness
  dsp-bridge: deh: fix dummy_va_addr

 arch/arm/plat-omap/include/dspbridge/wmddeh.h |   24 +-
 drivers/dsp/bridge/wmd/ue_deh.c               |  392 +++++++++++--------------
 2 files changed, 191 insertions(+), 225 deletions(-)

