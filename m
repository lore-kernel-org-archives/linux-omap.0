From: Yegor Yefremov <yegor_sub1@visionsystems.de>
Subject: am3517:  geting MMC working
Date: Thu, 19 Jul 2012 08:24:56 +0200
Message-ID: <5007A838.3040309@visionsystems.de>
Reply-To: yegor_sub1@visionsystems.de
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from ns.vscom.de ([62.145.30.242]:59412 "EHLO mail.visionsystems.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751415Ab2GSGZJ (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 19 Jul 2012 02:25:09 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>
Cc: "Mark A. Greer" <mgreer@animalcreek.com>, "Porter, Matt" <mporter@ti.com>

What patches do I need to get MMC working with linux-omap master?

omap_hsmmc omap_hsmmc.0: Failed to get debounce clk
omap-dma-engine omap-dma-engine: allocating channel for 62
omap-dma-engine omap-dma-engine: allocating channel for 61
omap_hsmmc omap_hsmmc.1: Failed to get debounce clk
omap-dma-engine omap-dma-engine: allocating channel for 48
omap-dma-engine omap-dma-engine: allocating channel for 47

I searched for this issue and saw some patches for common clock framework that were scheduled for 3.6, but I'm not sure it's enough or weather they are already incorporated in linux-omap.

Best regards,
Yegor
