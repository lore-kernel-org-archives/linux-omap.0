From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Build error: undefined reference to `snd_soc_unregister_codec'
Date: Fri, 27 Apr 2012 14:28:18 +0100
Message-ID: <20120427132818.GO24211@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([78.32.30.218]:38265 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760139Ab2D0N2Y (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 27 Apr 2012 09:28:24 -0400
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, Peter Ujfalusi <peter.ujfalusi@ti.com>, Jarkko Nikula <jarkko.nikula@bitmer.com>, Tomi Valkeinen <tomi.valkeinen@ti.com>

When building ALSA as modules:

drivers/built-in.o: In function `omapdss_hdmihw_remove':
omap_hwspinlock.c:(.text+0x23da8): undefined reference to `snd_soc_unregister_codec'
drivers/built-in.o: In function `omapdss_hdmihw_probe':
omap_hwspinlock.c:(.text+0x24248): undefined reference to `snd_soc_register_codec'

(the filename is inaccurate).

This happens because drivers/video/omap2/dss/hdmi.c is built-in and uses
ASoC services, but ASoC and ALSA are modular.
