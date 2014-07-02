From: Tomas Novotny <tomas@novotny.cz>
Subject: Pixel clock property from DT is not used in OMAP DRM
Date: Wed, 2 Jul 2014 13:15:17 +0200
Message-ID: <20140702131517.14ec38c0@tomas.local.tbs-biometrics.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from kazi.fit.vutbr.cz ([147.229.8.12]:62945 "EHLO kazi.fit.vutbr.cz"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751381AbaGBLZN (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 2 Jul 2014 07:25:13 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap <linux-omap@vger.kernel.org>, dri-devel@lists.freedesktop.org

	Hi all,

I was trying to bring up parallel LCD on our custom board (similar to
BeagleBoard-xM) and I did it finally - but I needed to tweak hardcoded value
of 'Invert pixel clock'. Maybe I'm doing something wrong, but anyway:
	According to the display-timing.txt doc the 'pixelclk-active' DT
optional property is here. But this is not honored (through IPC bit of
DISPC_POL_FREQ register). The problem is that this property is hardcoded in 
copy_timings_drm_to_omap() in file drivers/gpu/drm/omapdrm/omap_connector.c
on that line:
timings->data_pclk_edge = OMAPDSS_DRIVE_SIG_RISING_EDGE;
	Other optional properties (ie. [hv]sync-active) are taken into the
account.
	I'm using 3.16-rc1 kernel from Tony's OMAP tree.
	Thanks and regards,

	Tomas
	
	
