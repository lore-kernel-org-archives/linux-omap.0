From: Aaro Koskinen <aaro.koskinen@iki.fi>
Subject: [PATCH 0/2] ARM: OMAP: fix USB regression on Nokia boards
Date: Tue,  6 Aug 2013 20:06:14 +0300
Message-ID: <1375808776-14975-1-git-send-email-aaro.koskinen@iki.fi>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from filtteri6.pp.htv.fi ([213.243.153.189]:48692 "EHLO
	filtteri6.pp.htv.fi" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756059Ab3HFRG2 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 6 Aug 2013 13:06:28 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, linux-usb@vger.kernel.org
Cc: Aaro Koskinen <aaro.koskinen@iki.fi>

Hi,

USB subsystem changes broke the USB peripheral/gadget on N800, N810 and
RX-51/N900 during the merge window. We need to fix this in board files. I
tested all these with 3.11-rc4 + g_ether + ssh.

Aaro Koskinen (1):
  ARM: OMAP: rx51: change musb mode to OTG

Daniel Mack (1):
  ARM: omap2: fix musb usage for n8x0

 arch/arm/mach-omap2/board-n8x0.c | 4 ----
 arch/arm/mach-omap2/board-rx51.c | 2 +-
 arch/arm/mach-omap2/usb-musb.c   | 5 +----
 3 files changed, 2 insertions(+), 9 deletions(-)

-- 
1.8.3.2

