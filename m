From: Ezequiel Garcia <ezequiel.garcia@free-electrons.com>
Subject: [RFC 0/1] ARM: omap2: gpmc: Move binding documentation
Date: Wed, 13 Feb 2013 08:13:22 -0300
Message-ID: <1360754003-3988-1-git-send-email-ezequiel.garcia@free-electrons.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail.free-electrons.com ([94.23.35.102]:49957 "EHLO
	mail.free-electrons.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932536Ab3BMLNg (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 13 Feb 2013 06:13:36 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: Jon Hunter <jon-hunter@ti.com>, Felipe Balbi <balbi@ti.com>, Tony Lindgren <tony@atomide.com>, Afzal Mohammed <afzal@ti.com>, Thomas Petazzoni <thomas.petazzoni@free-electrons.com>, Gregory Clement <gregory.clement@free-electrons.com>, Ezequiel Garcia <ezequiel.garcia@free-electrons.com>

Following current trend of placing memory controllers drivers under
drivers/memory, this patch anticipates this by moving the binding
documentation to Documentation/devicetree/bindings/memory-controller.

Some other SoCs will have similar memory controllers placed under
drivers/memory and it seems a bit strange to put GPMC under drivers/bus.

Ezequiel Garcia (1):
  ARM: omap2: gpmc: Move binding documentation to memory-controller

 .../ti-gpmc.txt => memory-controllers/ti/gpmc.txt} |    0
 1 files changed, 0 insertions(+), 0 deletions(-)
 rename Documentation/devicetree/bindings/{bus/ti-gpmc.txt => memory-controllers/ti/gpmc.txt} (100%)

-- 
1.7.8.6

