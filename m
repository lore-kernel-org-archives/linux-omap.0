From: Jyri Sarha <jsarha@ti.com>
Subject: [PATCH RFC v3 0/2] Move dai-link level properties away
	from dai subnodes
Date: Mon, 24 Mar 2014 12:15:23 +0200
Message-ID: <cover.1395655868.git.jsarha@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org, devicetree@vger.kernel.org, linux-omap@vger.kernel.org
Cc: liam.r.girdwood@linux.intel.com, detheridge@ti.com, kuninori.morimoto.gx@renesas.com, moinejf@free.fr, Li.Xiubo@freescale.com, Jyri Sarha <jsarha@ti.com>, peter.ujfalusi@ti.com, broonie@kernel.org, bcousson@baylibre.com
List-Id: linux-omap@vger.kernel.org

This patch is implemented on top of late patches from Jean-Francois
Moine [1].

These patches implement the main part of the simple-card changes
discussed in alsa-devel mailing list [2].

Since RFC v2 version of the patches, address remaining comments from
Jean-Francois Moine [4]:
- ASoC: simple-card: Move dai-link level properties away from dai subnodes
  - Only allow legacy parsing if there is no dai-link node.
  - Fix double unref in of_card parsing loop.

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
 sound/soc/generic/simple-card.c                    |  238 ++++++++++++--------
 sound/soc/soc-core.c                               |    8 +-
 4 files changed, 200 insertions(+), 138 deletions(-)

-- 
1.7.9.5
