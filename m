From: Felipe Balbi <balbi@ti.com>
Subject: [RESEND PATCH 0/2] ARM IRQ Kconfig patches
Date: Wed, 15 Jun 2011 16:02:38 +0300
Message-ID: <1308142960-20767-1-git-send-email-balbi@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog115.obsmtp.com ([74.125.149.238]:42299 "EHLO
	na3sys009aog115.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753764Ab1FONCw (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Wed, 15 Jun 2011 09:02:52 -0400
Received: by fxm17 with SMTP id 17so375771fxm.19
        for <linux-omap@vger.kernel.org>; Wed, 15 Jun 2011 06:02:44 -0700 (PDT)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Russell King <linux@arm.linux.org.uk>
Cc: Linux ARM Kernel Mailing List <linux-arm-kernel@lists.infradead.org>, Linux OMAP Mailing List <linux-omap@vger.kernel.org>, Andrew Morton <akpm@linux-foundation.org>, Felipe Balbi <balbi@ti.com>

I have lost count how many times I have sent
these patches. Will someone either take them
in or NAK them so I stop sending ??

Felipe Balbi (2):
  arm: Kconfig: select correct HAVE_SPARSE_IRQ symbol
  arm: Kconfig: allow OMAP to use sparse IRQ numbering

 arch/arm/Kconfig |    5 +++--
 1 files changed, 3 insertions(+), 2 deletions(-)

-- 
1.7.6.rc1

