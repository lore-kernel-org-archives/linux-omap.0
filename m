From: Jyri Sarha <jsarha@ti.com>
Subject: [PATCH RFC 0/2] Fix simple-card *-master DT parameter
	handling
Date: Mon, 10 Mar 2014 13:28:36 +0200
Message-ID: <cover.1394450178.git.jsarha@ti.com>
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
Cc: liam.r.girdwood@linux.intel.com, detheridge@ti.com, Jyri Sarha <jsarha@ti.com>, peter.ujfalusi@ti.com, broonie@kernel.org, bcousson@baylibre.com
List-Id: linux-omap@vger.kernel.org

The schematics of bitclock-master and frame-master DT parameters
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

 sound/soc/generic/simple-card.c |   13 ++++++++-----
 sound/soc/soc-core.c            |    8 +++++++-
 2 files changed, 15 insertions(+), 6 deletions(-)

-- 
1.7.9.5
