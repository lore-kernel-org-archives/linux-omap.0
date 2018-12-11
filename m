From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 0/2] Graph fixes for using multiple endpoints per port
Date: Mon, 10 Dec 2018 18:05:55 -0800
Message-ID: <20181211020557.61783-1-tony@atomide.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Mark Brown <broonie@kernel.org>
Cc: Liam Girdwood <lgirdwood@gmail.com>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
List-Id: linux-omap@vger.kernel.org

Hi all,

Here are two fixes that allow me to have multiple endpoints defined in
the dts file for audio-graph-card. To do that, we need to fix up few
issues as the graph binding Documentation/devicetree/bindings/graph.txt
allows multiple endpoints per port. This allows configuring TDM codecs
for I2S for example.

Kuninori-san, can you please check if this makes sense to you and
compare against the graph binding?

Cheers,

Tony


Tony Lindgren (2):
  ASoC: simple-card-utils: revert port changes to follow graph binding
  ASoC: audio-graph-card: Fix parsing of multiple endpoints

 sound/soc/generic/audio-graph-card.c  | 41 +++++++++++++++++++++++----
 sound/soc/generic/simple-card-utils.c | 22 ++++++++++++--
 2 files changed, 55 insertions(+), 8 deletions(-)

-- 
2.19.2
