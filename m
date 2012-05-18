From: Ricardo Neri <ricardo.neri@ti.com>
Subject: [PATCH 00/11] ASoC: OMAP: HDMI: Use DSS audio
	interface and prepare for OMAP5
Date: Fri, 18 May 2012 01:42:32 -0500
Message-ID: <1337323363-11449-1-git-send-email-ricardo.neri@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: broonie@opensource.wolfsonmicro.com, lrg@ti.com
Cc: x0055901@ti.com, alsa-devel@alsa-project.org, Ricardo Neri <ricardo.neri@ti.com>, peter.ujfalusi@ti.com, s-guiriec@ti.com, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

Hello,

The ASoC HDMI codec used to be embedded in the DSS HDMI driver. In order
to give the OMAP HDMI code a more logical arrangement and to remove
some dependency breaks[1][2], such ASoC HDMI codec was removed[3]. Instead, the
DSS HDMI audio functionality[4] is now provided through the new DSS device driver
audio interface [5]. Hence, the ASoC HDMI support for OMAP needs to be changed
to use this new DSS device driver audio interface. Under this new approach:

 * The HDMI audio functionality provided by the OMAP is now regarded as a
   CPU DAI rather than a codec. Hence, the CPU DAI will perform the operations
   that were performed previously by the codec (using the DSS dev driver audio
   interface).
 * A new ASoC HDMI OMAP codec is introduced as a dummy component. In the
   future, this component will examine the features supported by the sink
   and limit the number of channels, sample rates and formats that are exposed
   to the user.

Also, this set of patches paves the way to the introduction of the HDMI audio
functionality for OMAP5. The goal is to use the same set of ASoC drivers
for OMAP4 and OMAP5 (DSS will be in charge of selecting the correct set
of functions at run time). For this, several patches are submitted for:

 * Generalizing the build files to encompass not only OMAP4.
 * In the HDMI sound card driver, renaming the the functions and structures
   from omap4_ to omap_.

This set includes the suggestions and improvements that Mark Brown kindly provided
some time ago [6][7].

Please note that this set of patches will not build unless the patches from [4],
[5] and [8] are present. All these patches have been accepted and should be
upstream for K3.5.

This implementation was validated on top of:
git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux-2.6.git v3.4-rc7

and Liam Girdwood's:
git://gitorious.org/omap-audio/linux-audio.git lrg/topic/3.5-dev

Thanks,

Ricardo

[1] http://www.mail-archive.com/linux-omap@vger.kernel.org/msg67295.html
[2] http://www.spinics.net/lists/linux-omap/msg66178.html
[3] http://www.mail-archive.com/linux-omap@vger.kernel.org/msg67809.html
[4] http://www.spinics.net/lists/linux-omap/msg69466.html
[5] http://www.spinics.net/lists/linux-omap/msg69451.html
[6] http://mailman.alsa-project.org/pipermail/alsa-devel/2012-February/049064.html
[7] http://mailman.alsa-project.org/pipermail/alsa-devel/2012-February/049065.html
[8] http://www.mail-archive.com/linux-omap@vger.kernel.org/msg66600.html

Ricardo Neri (11):
  ASoC: OMAP: HDMI: Introduce codec
  ASoC: OMAP: HDMI: Update the platform device names
  ASoC: OMAP: HDMI: Change error values in HDMI CPU DAI
  ASoC: OMAP: HDMI: Create a structure for private data of the CPU DAI
  ASoC: OMAP: HDMI: Use the DSS audio interface
  ASoC: OMAP: HDMI: Expand configuration of hw_params
  ASoC: OMAP: HDMI: Improve how the display state is verified
  ASoC: OMAP: HDMI: Expand capabilities of the HDMI DAI
  ASoC: OMAP: HDMI: Make build config options more generic
  ASoC: OMAP: HDMI: Make sound card naming more generic
  ASoC: OMAP: HDMI: Rename sound card driver

 sound/soc/codecs/Kconfig         |    4 +
 sound/soc/codecs/Makefile        |    2 +
 sound/soc/codecs/omap-hdmi.c     |   69 +++++++++++
 sound/soc/omap/Kconfig           |    8 +-
 sound/soc/omap/Makefile          |    4 +-
 sound/soc/omap/omap-hdmi-card.c  |   87 ++++++++++++++
 sound/soc/omap/omap-hdmi.c       |  238 +++++++++++++++++++++++++++++++++++---
 sound/soc/omap/omap-hdmi.h       |    4 +-
 sound/soc/omap/omap4-hdmi-card.c |  121 -------------------
 9 files changed, 395 insertions(+), 142 deletions(-)
 create mode 100644 sound/soc/codecs/omap-hdmi.c
 create mode 100644 sound/soc/omap/omap-hdmi-card.c
 delete mode 100644 sound/soc/omap/omap4-hdmi-card.c

-- 
1.7.5.4
