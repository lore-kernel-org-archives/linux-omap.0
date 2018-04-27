From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: [PATCH v2 0/6] ARM/ASoC: omap: n810 audio support
Date: Fri, 27 Apr 2018 11:17:09 +0300
Message-ID: <20180427081715.28791-1-peter.ujfalusi@ti.com>
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
To: Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, jarkko.nikula@bitmer.com, tony@atomide.com
Cc: alsa-devel@alsa-project.org, linux-omap@vger.kernel.org, aaro.koskinen@iki.fi
List-Id: linux-omap@vger.kernel.org

Hi,

Changes since v1:
- Fixed up the aic33 dts patch with missing entries needed for capture
- Added comment and new widget for the non working HS Mic

The verification of the sdma-pcm on OMAP2 got delayed by non working audio on
n810.

With the following patches audio works on n810 (both with the old omap-pcm and
the new sdma-pcm).

I believe the DTS and ASoC patches are fine to go via different tree, but I
wanted to keep the patches together for easier testing.

The series does not have any dependencies, I will rebase the sdma-pcm series on
top of this and resend.

Playback to Speaker, Headset is working.
Capture from DMIC is working.
Capture from HS mic is not working due to missing mic bias (from Retu/Vilma).

Regards,
Peter
---
Jarkko Nikula (1):
  ASoC: omap: Remove OMAP_MUX dependency from Nokia N810 audio support

Peter Ujfalusi (5):
  ARM: dts: omap2420-n810: Enable McBSP2 for audio
  ARM: dts: omap2420-n810: Correct the audio codec (tlv320aic33) node
  ASoC: omap: n810: Correct the card level dapm_route
  ASoC: omap: n810: Correct the cpu_dai, platform and codec name
  ASoC: omap: n810: HS mic is not working, add a widget for it with
    comment

 arch/arm/boot/dts/omap2420-n810.dts | 63 ++++++++++++++++++++++++++++-
 sound/soc/omap/Kconfig              |  1 -
 sound/soc/omap/n810.c               | 21 ++++++----
 3 files changed, 75 insertions(+), 10 deletions(-)

-- 
Peter

Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki
