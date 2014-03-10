From: Jyri Sarha <jsarha@ti.com>
Subject: [PATCH RFC v2 0/2] Fix simple-card *-master DT parameter handling
Date: Mon, 10 Mar 2014 13:41:14 +0200
Message-ID: <cover.1394451329.git.jsarha@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:46016 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752833AbaCJLlZ (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 10 Mar 2014 07:41:25 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: alsa-devel@alsa-project.org, devicetree@vger.kernel.org, linux-omap@vger.kernel.org
Cc: peter.ujfalusi@ti.com, broonie@kernel.org, liam.r.girdwood@linux.intel.com, bcousson@baylibre.com, detheridge@ti.com, Jyri Sarha <jsarha@ti.com>

Since RFC:
- fixed commit msg typo
- added include/sound/soc.h changes too

The sematics of bitclock-master and frame-master DT parameters
should depend on whether they are found from a cpu-dai or codec
sub-node.

- bitclock-master in cpu-dai node means Codec-Bitclock-Slave
- frame-master in cpu-dai node means Codec-Frame-Slave
- bitclock-master in codec node means Codec-Bitclock-Master
- frame-master in codec node means Codec-Frame-Master

For example in a cpu-dai mode bitclock-master parameter should produce
SND_SOC_DAIFMT_CBS_* daifmt flags and a codec node
SND_SOC_DAIFMT_CBM_* flags.

Best regards,
Jyri

Jyri Sarha (2):
  ASoC: core: Add is_cpu_dai_node-parameter to
    snd_soc_of_parse_daifmt()
  ASoC: simple-card: Take snd_soc_of_parse_daifmt() change in to
    account

 include/sound/soc.h             |    3 ++-
 sound/soc/generic/simple-card.c |   13 ++++++++-----
 sound/soc/soc-core.c            |    8 +++++++-
 3 files changed, 17 insertions(+), 7 deletions(-)

-- 
1.7.9.5

