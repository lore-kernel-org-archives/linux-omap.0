From: Felipe Balbi <balbi@ti.com>
Subject: [RESEND PATCH 0/3] ARM IRQ patches
Date: Thu, 20 Jan 2011 08:43:29 +0200
Message-ID: <1295505812-5062-1-git-send-email-balbi@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog108.obsmtp.com ([74.125.149.199]:53841 "EHLO
	na3sys009aog108.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754668Ab1ATGnl (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Thu, 20 Jan 2011 01:43:41 -0500
Received: by gwb10 with SMTP id 10so69770gwb.12
        for <linux-omap@vger.kernel.org>; Wed, 19 Jan 2011 22:43:40 -0800 (PST)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Russell King <linux@arm.linux.org.uk>
Cc: Tony Lindgren <tony@atomide.com>, Linux OMAP Mailing List <linux-omap@vger.kernel.org>, Linux ARM Kernel Mailing List <linux-arm-kernel@lists.infradead.org>, Felipe Balbi <balbi@ti.com>

Hi Russell,

I'm resending these patches as they were not taken previously.

If you want me to wait until closer to next merge window, let
me know and I'll re-send when we get to -rc4.

Felipe Balbi (3):
  arm: Kconfig: remove duplicated GENERIC_HARDIRQS entry
  arm: Kconfig: remove duplicated SPARSE_IRQ entry
  arm: Kconfig: allow OMAP to use sparse IRQ numbering

 arch/arm/Kconfig |    6 ++++--
 1 files changed, 4 insertions(+), 2 deletions(-)

-- 
1.7.4.rc2

