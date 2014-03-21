From: Jyri Sarha <jsarha@ti.com>
Subject: [PATCH RFC 0/2] Move dai-link level properties away from dai subnodes
Date: Fri, 21 Mar 2014 18:47:21 +0200
Message-ID: <cover.1395419906.git.jsarha@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:52301 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754472AbaCUQri (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 21 Mar 2014 12:47:38 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: alsa-devel@alsa-project.org, devicetree@vger.kernel.org, linux-omap@vger.kernel.org
Cc: peter.ujfalusi@ti.com, broonie@kernel.org, liam.r.girdwood@linux.intel.com, bcousson@baylibre.com, detheridge@ti.com, moinejf@free.fr, Li.Xiubo@freescale.com, kuninori.morimoto.gx@renesas.com, Jyri Sarha <jsarha@ti.com>

This patch is implemented on top of late patches from Jean-Francois
Moine [1]. 

The patches implement the main part of the simple-card changes
discussed in alsa-devel mailing list.

[1] http://mailman.alsa-project.org/pipermail/alsa-devel/2014-March/074592.html

Best regards,
Jyri

Jyri Sarha (2):
  ASoC: core: Update snd_soc_of_parse_daifmt() interface
  ASoC: simple-card: Move dai-link level properties away from dai
    subnodes

 .../devicetree/bindings/sound/simple-card.txt      |   91 ++++----
 include/sound/soc.h                                |    4 +-
 sound/soc/generic/simple-card.c                    |  237 ++++++++++++--------
 sound/soc/soc-core.c                               |    8 +-
 4 files changed, 201 insertions(+), 139 deletions(-)

-- 
1.7.9.5

