From: Daniel Mack <zonque@gmail.com>
Subject: [PATCH] ARM: omap: edma: add suspend suspend/resume hooks
Date: Tue,  1 Oct 2013 15:51:32 +0200
Message-ID: <1380635493-31040-1-git-send-email-zonque@gmail.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from svenfoo.org ([82.94.215.22]:51065 "EHLO mail.zonque.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753181Ab3JANvp (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 1 Oct 2013 09:51:45 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: s.neumann@raumfeld.com, mporter@ti.com, nsekhar@ti.com, alsa-devel@alsa-project.org, gururaja.hebbar@ti.com, linux-arm-kernel@lists.infradead.org, Daniel Mack <zonque@gmail.com>

This patch adds support for edma driver.

I know the intermediate code in arch/arm/common is going to be purged
eventually when the real dma-engine driver lands, so I don't know
whether it's reasonable to include my patch after all. It might just
server as template for the suspend/resume functions in the final
driver, or maybe anyone wants to include that intermediate hack for the
time being.

Successfully tested on an AM335x board with davinci-mcasp enabled
audio. A patch to make the latter work after suspend has been posted
on alsa-devel.


Thanks,
Dainel


Daniel Mack (1):
  ARM: omap: edma: add suspend suspend/resume hooks

 arch/arm/common/edma.c | 133 +++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 133 insertions(+)

-- 
1.8.3.1

