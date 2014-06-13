From: Jyri Sarha <jsarha@ti.com>
Subject: [PATCH 0/2] Couple of fixes to davinci-mcasp driver
Date: Fri, 13 Jun 2014 12:49:58 +0300
Message-ID: <cover.1402652359.git.jsarha@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:51523 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751300AbaFMJuL (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 13 Jun 2014 05:50:11 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: alsa-devel@alsa-project.org, linux-omap@vger.kernel.org
Cc: peter.ujfalusi@ti.com, broonie@kernel.org, liam.r.girdwood@linux.intel.com, detheridge@ti.com, Jyri Sarha <jsarha@ti.com>

These changes target to sii9022 HDMI audio support, but are
independent fixes.

Jyri Sarha (2):
  ASoC: davinci-mcasp: Add dependecy to SND_DAVINCI_SOC or SND_OMAP_SOC
  ASoC: davinci-mcasp: Allow best effort in selecting BCLK divider

 sound/soc/davinci/Kconfig         |    1 +
 sound/soc/davinci/davinci-mcasp.c |   22 +++++++++++++++++-----
 2 files changed, 18 insertions(+), 5 deletions(-)

-- 
1.7.9.5

