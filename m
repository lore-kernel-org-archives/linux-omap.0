From: Jyri Sarha <jsarha@ti.com>
Subject: Re: [PATCH v4 00/15] Rework OMAP4+ HDMI audio support
Date: Fri, 29 Aug 2014 14:43:28 +0300
Message-ID: <54006760.2010404@ti.com>
References: <cover.1408993242.git.jsarha@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:43606 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751006AbaH2Lnh (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 29 Aug 2014 07:43:37 -0400
In-Reply-To: <cover.1408993242.git.jsarha@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: alsa-devel@alsa-project.org, linux-fbdev@vger.kernel.org, linux-omap@vger.kernel.org
Cc: peter.ujfalusi@ti.com, broonie@kernel.org, liam.r.girdwood@linux.intel.com, tomi.valkeinen@ti.com, detheridge@ti.com

After discussing with Tomi we decided to turn the omap-hdmi-audio ASoC 
library into a platform device. So do not waste too much time in 
reviewing these patches. I'll mail a new series soon.

Best regards,
Jyri

On 08/25/2014 10:04 PM, Jyri Sarha wrote:
> The patches are based on:
> git://git.kernel.org/pub/scm/linux/kernel/git/tomba/linux.git for-next
>
> The base, the patches, and couple of additional not-to-be-merged
> omap2plus_defconfig patches can be found here:
>
> git://git.ti.com/~jyrisarha/ti-linux-kernel/jyrisarhas-audio-video-linux-feature-tree.git omap-hdmi-audio
>
> Changes since v3:
> - Move ASoC parts into library module under sound/soc/omap
> - Come up with API for the library
> - Some cleaning up
>
> The patch set fixes OMAP4+ HDMI audio. The structure of the
> implementation looks a bit different than before. Instead of creating
> a driver specific API for a separate ASoC component driver to connect
> to, these patches implement a single audio library module under
> sound/soc/omap for ASoC side implementation. The library exports
> omap_hdmi_audio_register() and omap_hdmi_audio_unregister()
> functions. With the functions OMAPDSS HDMI implementation registers
> and unregisters all ASoC components needed for OMAP HDMI audio.
>
> The library implements cpu-dai component using the callbacks provided
> by OMAPDSS. Omap-pcm is registered for platform component, dummy
> hdmi-audio-codec is registered for codec component, and
> asoc-simple-card is registered for machine driver.
>
> Big part of the HDMI audio code is still unchanged and there is a need
> for a cleanup there. Also there is still probably something wrong with
> speaker mapping of multi-channel streams. I will get back to cleaning
> up these issues later.
>
> Best regards,
> Jyri
>
> Jyri Sarha (15):
>    OMAPDSS: hdmi.h: Add HDMI_AUDIO_LAYOUT_6CH enum value
>    OMAPDSS: hdmi: Remove most of OMAP[45]_DSS_HDMI_AUDIO ifdefs
>    OMAPDSS: hdmi4_core: Remove unused hdmi4_audio_get_dma_port()
>    OMAPDSS: hdmi_wp: Add function for getting audio dma address
>    OMAPDSS: hdmi: Make hdmi structure public
>    OMAPDSS: hdmi: Add exported functions for storing HDMI audio data
>    OMAPDSS: hdmi: Make hdmi_mode_has_audio() more user friedly
>    ASoC: omap-hdmi-audio: Add OMAP HDMI audio support library
>    OMAPDSS: Kconfig: Implement options for OMAP4 and OMAP5 HDMI audio
>      support
>    OMAPDSS: hdmi4: Register HDMI audio with omap_hdmi_audio_register()
>    OMAPDSS: hdmi5: Register HDMI audio with omap_hdmi_audio_register()
>    ASoC: omap: Remove obsolete HDMI audio code and Kconfig options
>    OMAPDSS: hdmi4: Remove callbacks for an external ASoC DAI driver
>    OMAPDSS: hdmi5: Remove callbacks for an external ASoC DAI driver
>    OMAPDSS: Remove all references to obsolete HDMI audio callbacks
>
>   .../fbdev/omap2/displays-new/connector-hdmi.c      |   99 ------
>   .../fbdev/omap2/displays-new/encoder-tpd12s015.c   |   56 ---
>   drivers/video/fbdev/omap2/dss/Kconfig              |   28 +-
>   drivers/video/fbdev/omap2/dss/hdmi.h               |   35 +-
>   drivers/video/fbdev/omap2/dss/hdmi4.c              |  233 ++++++-------
>   drivers/video/fbdev/omap2/dss/hdmi4_core.c         |   14 -
>   drivers/video/fbdev/omap2/dss/hdmi4_core.h         |    4 -
>   drivers/video/fbdev/omap2/dss/hdmi5.c              |  216 +++++-------
>   drivers/video/fbdev/omap2/dss/hdmi5_core.c         |    6 -
>   drivers/video/fbdev/omap2/dss/hdmi5_core.h         |    2 -
>   drivers/video/fbdev/omap2/dss/hdmi_common.c        |   18 +-
>   drivers/video/fbdev/omap2/dss/hdmi_wp.c            |    8 +-
>   include/sound/omap-hdmi-audio.h                    |   50 +++
>   include/video/omapdss.h                            |   34 +-
>   sound/soc/omap/Kconfig                             |   15 +-
>   sound/soc/omap/Makefile                            |    6 +-
>   sound/soc/omap/omap-hdmi-audio.c                   |  357 +++++++++++++++++++
>   sound/soc/omap/omap-hdmi-card.c                    |   87 -----
>   sound/soc/omap/omap-hdmi.c                         |  364 --------------------
>   sound/soc/omap/omap-hdmi.h                         |   38 --
>   20 files changed, 676 insertions(+), 994 deletions(-)
>   create mode 100644 include/sound/omap-hdmi-audio.h
>   create mode 100644 sound/soc/omap/omap-hdmi-audio.c
>   delete mode 100644 sound/soc/omap/omap-hdmi-card.c
>   delete mode 100644 sound/soc/omap/omap-hdmi.c
>   delete mode 100644 sound/soc/omap/omap-hdmi.h
>

