From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: [PATCH 0/2] ASoC: omap-mcpdm: Support for handling
	pdmclk
Date: Wed, 14 Nov 2018 14:46:29 +0200
Message-ID: <20181114124631.4586-1-peter.ujfalusi@ti.com>
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
To: Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, jarkko.nikula@bitmer.com
Cc: tony@atomide.com, alsa-devel@alsa-project.org, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

Hi,

This series is on top of the pm_qos changes I have sent earlier today.

I have sent this originally two years ago:
https://patchwork.kernel.org/patch/9119551/

But needed to revert it as the MFD and clk changes were not merged in time:
https://patchwork.kernel.org/patch/9287431/

The dts patches are already upstream, only the patch for McPDM is missing.

I have separated the binding document update and the driver patch and also
added the return value check for the clk_prepare_enable() as per Mark's comment.

Regards,
Peter
---
Peter Ujfalusi (2):
  dt-bindings: sound: omap-mcpdm: Update documentation for pdmclk
  ASoC: omap-mcpdm: Add support for pdmclk clock handling

 .../devicetree/bindings/sound/omap-mcpdm.txt  | 10 ++++++++
 sound/soc/omap/omap-mcpdm.c                   | 23 +++++++++++++++++++
 2 files changed, 33 insertions(+)

-- 
Peter

Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki
