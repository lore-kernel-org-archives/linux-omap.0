From: Jyri Sarha <jsarha@ti.com>
Subject: [PATCH RFC v2 0/2] Move dai-link level properties away from dai subnodes
Date: Mon, 24 Mar 2014 11:16:05 +0200
Message-ID: <cover.1395651862.git.jsarha@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:32986 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752221AbaCXJQX (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 24 Mar 2014 05:16:23 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: alsa-devel@alsa-project.org, devicetree@vger.kernel.org, linux-omap@vger.kernel.org
Cc: peter.ujfalusi@ti.com, broonie@kernel.org, liam.r.girdwood@linux.intel.com, bcousson@baylibre.com, detheridge@ti.com, moinejf@free.fr, Li.Xiubo@freescale.com, kuninori.morimoto.gx@renesas.com, Jyri Sarha <jsarha@ti.com>

This patch is implemented on top of late patches from Jean-Francois
Moine [1].

These patches implement the main part of the simple-card changes
discussed in alsa-devel mailing list [2].

Since RFC version of the patches:
- ASoC: core: Update snd_soc_of_parse_daifmt() interface
  - Make minimal changes to simple-card for it to work with the updated
    snd_soc_of_parse_daifmt(). (Kuninori Morimoto's comment [3]).
- ASoC: simple-card: Move dai-link level properties away from dai subnodes
  - Fix typo in DT binding document (Jean-Francois Moine's comment [4]).
  - Remove #define DEBUG
  - Remove accidental line wrap at simple-audio-card,name property descripition
    in the DT binding document

[1] http://mailman.alsa-project.org/pipermail/alsa-devel/2014-March/074592.html
[2] http://mailman.alsa-project.org/pipermail/alsa-devel/2014-March/074388.html
[3] http://mailman.alsa-project.org/pipermail/alsa-devel/2014-March/074699.html
[4] http://mailman.alsa-project.org/pipermail/alsa-devel/2014-March/074697.html

Best regards,
Jyri

Jyri Sarha (2):
  ASoC: core: Update snd_soc_of_parse_daifmt() interface
  ASoC: simple-card: Move dai-link level properties away from dai
    subnodes

 .../devicetree/bindings/sound/simple-card.txt      |   88 ++++----
 include/sound/soc.h                                |    4 +-
 sound/soc/generic/simple-card.c                    |  236 ++++++++++++--------
 sound/soc/soc-core.c                               |    8 +-
 4 files changed, 198 insertions(+), 138 deletions(-)

-- 
1.7.9.5

