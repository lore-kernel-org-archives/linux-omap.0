From: Jyri Sarha <jsarha@ti.com>
Subject: [PATCH 0/3] More simple-card dai node clock parameters
Date: Fri, 13 Jun 2014 13:04:35 +0300
Message-ID: <cover.1402653217.git.jsarha@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:52018 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752119AbaFMKEr (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 13 Jun 2014 06:04:47 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: alsa-devel@alsa-project.org, linux-omap@vger.kernel.org, devicetree@vger.kernel.org
Cc: bcousson@baylibre.com, peter.ujfalusi@ti.com, broonie@kernel.org, liam.r.girdwood@linux.intel.com, detheridge@ti.com, Jyri Sarha <jsarha@ti.com>

These changes target to sii9022 HDMI audio support, but are
independent fixes and additions.

To cover more cases with simple-card it should be possible to select
all parameters for set_sysclk() callback. The default behavior is not
changed by these patches.

Jyri Sarha (3):
  ASoC: simple-card: Make u32 DT parameter handling 64-bit proof
  ASoC: simple-card: Add system-clock-direction DT parameter to dai
    nodes
  ASoC: simple-card: Add system-clock-id DT parameter to dai nodes

 .../devicetree/bindings/sound/simple-card.txt      |    3 ++
 include/sound/simple_card.h                        |    2 ++
 sound/soc/generic/simple-card.c                    |   31 +++++++++++++++-----
 3 files changed, 29 insertions(+), 7 deletions(-)

-- 
1.7.9.5

