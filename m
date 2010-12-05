From: Janusz Krzysztofik <jkrzyszt@tis.icnet.pl>
Subject: [PATCH 0/2] OMAP1: amsdelta: reserve memory for videobuf_contig
Date: Sun, 5 Dec 2010 19:29:05 +0100
Message-ID: <201012051929.07220.jkrzyszt@tis.icnet.pl>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from d1.icnet.pl ([212.160.220.21]:53299 "EHLO d1.icnet.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754162Ab0LES3x (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Sun, 5 Dec 2010 13:29:53 -0500
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>
Cc: Tony Lindgren <tony@atomide.com>, Linux Media Mailing List <linux-media@vger.kernel.org>, Guennadi Liakhovetski <g.liakhovetski@gmx.de>

Latest developements seem to allow for reserving a block of memory on boot to 
be used as a device dedicated dma coherent memory. This may be required for 
videobuf_config based video drivers avoid problems with allocating dma 
coherent memory after system memory gets fragmented.

This set extends the OMAP1 camera resource initialization code with a function 
that can be used for reserving a block of memory early, then declared as the 
camera device dedicated dma coherent memory.

An example use case is provided for Amstrad Delta camera.

 arch/arm/mach-omap1/board-ams-delta.c     |   12 +++++++++-
 arch/arm/mach-omap1/devices.c             |   36 ++++++++++++++++++++++++++++++
 arch/arm/mach-omap1/include/mach/camera.h |    1
 3 files changed, 48 insertions(+), 1 deletion(-)


Thanks,
Janusz
