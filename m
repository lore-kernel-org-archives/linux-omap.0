From: Liam Girdwood <lrg@slimlogic.co.uk>
Subject: [PATCH 0/4] McBSP smart idle and DMA op mode updates for ASoC
Date: Tue, 18 May 2010 21:13:10 +0100
Message-ID: <1274213594-26554-1-git-send-email-lrg@slimlogic.co.uk>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-wy0-f174.google.com ([74.125.82.174]:48480 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753751Ab0ERUNs (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 18 May 2010 16:13:48 -0400
Received: by wyb39 with SMTP id 39so1699320wyb.19
        for <linux-omap@vger.kernel.org>; Tue, 18 May 2010 13:13:46 -0700 (PDT)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: alsa-devel@alsa-project.org, linux-omap@vger.kernel.org
Cc: Liam Girdwood <lrg@slimlogic.co.uk>, Mark Brown <broonie@opensource.wolfsonmicro.com>, Peter Ujfalusi <peter.ujfalusi@nokia.com>, Jarkko Nikula <jhnikula@gmail.com>, Tony Lindgren <tony@atomide.com>

This series expands the OMAP mcbsp driver to support changing it's DMA operating
mode and smart idle mode from client drivers. It's primarily aimed at lowering
the power consumption for OMAP ASoC drivers by providing methods to gate clocks
on the mcbsp interface at runtime.

I've also added a patch to remove the mcbsp DMA op mode sysfs set functionality.
I think DMA op mode is very specific to the mcbsp client driver _only_ and
shouldn't really be changed by userspace. Please let me know if you use this
feature and I'll drop this patch.

Tony, can I get your ack to upstream via ALSA if it's ok

Thanks

Liam

 arch/arm/plat-omap/include/plat/mcbsp.h |   17 +++
 arch/arm/plat-omap/mcbsp.c              |  183 ++++++++++++++++++++++++++-----
 sound/soc/omap/omap-mcbsp.c             |   22 ++++-
 sound/soc/omap/omap-mcbsp.h             |    2 +
 4 files changed, 194 insertions(+), 30 deletions(-)

