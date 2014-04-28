From: Sebastian Reichel <sre-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: [PATCHv2 0/9] DT support for N900 soundcard (rx51-audio)
Date: Mon, 28 Apr 2014 16:07:18 +0200
Message-ID: <1398694047-28596-1-git-send-email-sre@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Sebastian Reichel <sre-GFxCN5SEZAc@public.gmane.org>, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Peter Ujfalusi <peter.ujfalusi-l0cyMroinI0@public.gmane.org>
Cc: Rob Herring <rob.herring-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org>, Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Ian Campbell <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>, Kumar Gala <galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, Liam Girdwood <lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Jarkko Nikula <jarkko.nikula-FVTvWyuFUl3QT0dZR+AlfA@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org, Sebastian Reichel <sre-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

Hi,

This patchset adds DT support in rx51-audio. I tested it on my
Nokia N900 and was able to play a wav file using aplay. I have
not tested the whole functionality, but output via speakers,
headphones and the related enable controls seem to work.

Changes since PATCHv1 [0]:
 * drop "ASoC: tlv320aic3x: fix shared reset pin for DT"
   (already applied)
 * drop "ASoC: RX-51: Convert to table based DAPM setup"
   (similar patch was applied to -next)
 * remove useless "card->dev = NULL;" from first patch
 * split patches from into smaller chunks
 * introduce new patch, which fixes a checkpatch warning
 * use gpiod API, which reduces the DT specific bits of
   the driver
 * rebase to newer -next checkout

[0] https://lkml.org/lkml/2014/4/5/92

-- Sebastian

Sebastian Reichel (9):
  ASoC: omap: rx51: Use static const char * const arrays
  ASoC: omap: rx51: Add module alias
  ASoC: omap: rx51: Use devm_snd_soc_register_card
  ASoC: Allow Aux Codecs to be specified using DT
  ASoC: omap: rx51: omap_mcbsp_st_add_controls: add id parameter
  ASoC: omap: rx51: get GPIO numbers via gpiod API
  ASoC: omap: rx51: Add some error messages
  ASoC: omap: rx51: Add DT support
  DTS: OMAP3-N900: Add sound support

 .../devicetree/bindings/sound/nokia,rx51.txt       |  27 +++
 arch/arm/boot/dts/omap3-n900.dts                   |  17 ++
 include/sound/soc.h                                |  13 +-
 sound/soc/omap/omap-mcbsp.c                        |   5 +-
 sound/soc/omap/omap-mcbsp.h                        |   2 +-
 sound/soc/omap/rx51.c                              | 226 +++++++++++++++------
 sound/soc/soc-core.c                               |  68 ++++---
 7 files changed, 271 insertions(+), 87 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/sound/nokia,rx51.txt

-- 
1.9.2

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
