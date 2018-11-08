From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: [RFC 0/9] ASoC/ARM: Merge the davinci and omap audio
	directories
Date: Thu, 8 Nov 2018 10:37:45 +0200
Message-ID: <20181108083754.1746-1-peter.ujfalusi@ti.com>
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
To: Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, jarkko.nikula@bitmer.com, tony@atomide.com, nsekhar@ti.com
Cc: alsa-devel@alsa-project.org, linux-omap@vger.kernel.org, jsarha@ti.com, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

Hi,

This RFC series is on top of the omap-mcbsp cleanup series:
http://mailman.alsa-project.org/pipermail/alsa-devel/2018-November/141604.html

For Texas Instruments audio support we have two directories at the moment:
davinci
omap

In reality TI have the following SoC lines supported by Linux:
daVinci
OMAP
Sitara
Keystone

We already needed to have cross directory 'links' for DRA7x/AM5 since they use
McASP (davinci directory) and sDMA (omap directory).
Keystone II line of SoCs are using drivers from davinci directory (McASP and
EDMA). Which is kind of fine as they are in the same place.

With the new AM654 (http://www.ti.com/lit/pdf/spruid7) we will have completely
new DMA and there is no place to put that as it does not belong under davinci
or omap, but it makes no sense to create yet another TI related directory just
for the small udma-pcm.

Another issue with the current support is how the Kconfigs are written.
The DAI drivers are depending on the ASoC platform drivers and it is a bit of a
mess at the moment.
For simple-sound-card one need to know what DMA is used and then select the DAI
driver (if the Kconfig is right).
I have also cleaned up the Kconfig prompts and comments a bit to be more
precise.

As can be seen in the diffstat I tried to do the merger with minimal code
change, resisting the urge to rename the davinci-i2c driver to davinci-asp.

With the merger I have created a new Kconfig structure:
- Submenu for TI related settings for clarity
- Only the DAI drivers are selectable and the platform drivers are selected
  based on the available (enabled) DMA engines
- The remaining ASoC machine drivers are selecting the DAIs they need
- The davinci-evm is now a single entry, combining all the various daVinci EVMS
  it supports and selects the needed DAIs based on the enabled boards

The series also includes patches to updated the arch/arm/ files (defconfigs,
source files using audio Kconfig symbols).

I believe with v1 all of this can be merged via ASoC tree as the chances of
conflicts are low for the touched arch/arm files. But Sekhar and Tony can
correct me if I'm wrong.

I think I have catched all (I hope) issues regarding to Kconfig thanks to the
various autobuild machines out there kindly testing my linux-next-wip branch.

I would appreciate any testing comments before I send the v1!

Regards,
Peter
---
Peter Ujfalusi (9):
  ASoC: ti: Merge davinci and omap directories
  MAINTAINERS: Add entry for sound/soc/ti and update the OMAP audio
    support
  ARM: OMAP1: Makefile: Update for new MCBSP Kconfig option
  ARM: OMAP2: Update for new MCBSP Kconfig option
  ARM: davinci: dm365-evm: Update for the new ASoC Kcofnig options
  ARM: omap2plus_defconfig: Update the audio options
  ARM: omap1_defconfig: Do not select ASoC by default
  ARM: davinci_all_defconfig: Update the audio options
  ASoC: ti: Kconfig: Remove the deprecated options

 MAINTAINERS                                   |  11 +-
 arch/arm/configs/davinci_all_defconfig        |   5 +-
 arch/arm/configs/omap1_defconfig              |   2 -
 arch/arm/configs/omap2plus_defconfig          |  14 +-
 arch/arm/mach-davinci/board-dm365-evm.c       |   4 +-
 arch/arm/mach-omap1/Makefile                  |   2 +-
 arch/arm/mach-omap2/Makefile                  |   2 +-
 arch/arm/mach-omap2/pdata-quirks.c            |   4 +-
 sound/soc/Kconfig                             |   3 +-
 sound/soc/Makefile                            |   3 +-
 sound/soc/davinci/Kconfig                     | 106 ---------
 sound/soc/davinci/Makefile                    |  16 --
 sound/soc/omap/Kconfig                        | 120 ----------
 sound/soc/omap/Makefile                       |  30 ---
 sound/soc/ti/Kconfig                          | 209 ++++++++++++++++++
 sound/soc/ti/Makefile                         |  44 ++++
 sound/soc/{omap => ti}/ams-delta.c            |   0
 sound/soc/{davinci => ti}/davinci-evm.c       |   4 +-
 sound/soc/{davinci => ti}/davinci-i2s.c       |   0
 sound/soc/{davinci => ti}/davinci-i2s.h       |   0
 sound/soc/{davinci => ti}/davinci-mcasp.c     |  14 +-
 sound/soc/{davinci => ti}/davinci-mcasp.h     |   0
 sound/soc/{davinci => ti}/davinci-vcif.c      |   0
 sound/soc/{davinci => ti}/edma-pcm.c          |   0
 sound/soc/{davinci => ti}/edma-pcm.h          |   4 +-
 sound/soc/{omap => ti}/n810.c                 |   0
 sound/soc/{omap => ti}/omap-abe-twl6040.c     |   0
 sound/soc/{omap => ti}/omap-dmic.c            |   0
 sound/soc/{omap => ti}/omap-dmic.h            |   0
 .../omap-hdmi-audio.c => ti/omap-hdmi.c}      |   0
 sound/soc/{omap => ti}/omap-mcbsp-priv.h      |   0
 sound/soc/{omap => ti}/omap-mcbsp-st.c        |   0
 sound/soc/{omap => ti}/omap-mcbsp.c           |   0
 sound/soc/{omap => ti}/omap-mcbsp.h           |   0
 sound/soc/{omap => ti}/omap-mcpdm.c           |   0
 sound/soc/{omap => ti}/omap-mcpdm.h           |   0
 sound/soc/{omap => ti}/omap-twl4030.c         |   0
 sound/soc/{omap => ti}/omap3pandora.c         |   0
 sound/soc/{omap => ti}/osk5912.c              |   0
 sound/soc/{omap => ti}/rx51.c                 |   0
 sound/soc/{omap => ti}/sdma-pcm.c             |   0
 sound/soc/{omap => ti}/sdma-pcm.h             |   4 +-
 42 files changed, 294 insertions(+), 307 deletions(-)
 delete mode 100644 sound/soc/davinci/Kconfig
 delete mode 100644 sound/soc/davinci/Makefile
 delete mode 100644 sound/soc/omap/Kconfig
 delete mode 100644 sound/soc/omap/Makefile
 create mode 100644 sound/soc/ti/Kconfig
 create mode 100644 sound/soc/ti/Makefile
 rename sound/soc/{omap => ti}/ams-delta.c (100%)
 rename sound/soc/{davinci => ti}/davinci-evm.c (99%)
 rename sound/soc/{davinci => ti}/davinci-i2s.c (100%)
 rename sound/soc/{davinci => ti}/davinci-i2s.h (100%)
 rename sound/soc/{davinci => ti}/davinci-mcasp.c (99%)
 rename sound/soc/{davinci => ti}/davinci-mcasp.h (100%)
 rename sound/soc/{davinci => ti}/davinci-vcif.c (100%)
 rename sound/soc/{davinci => ti}/edma-pcm.c (100%)
 rename sound/soc/{davinci => ti}/edma-pcm.h (91%)
 rename sound/soc/{omap => ti}/n810.c (100%)
 rename sound/soc/{omap => ti}/omap-abe-twl6040.c (100%)
 rename sound/soc/{omap => ti}/omap-dmic.c (100%)
 rename sound/soc/{omap => ti}/omap-dmic.h (100%)
 rename sound/soc/{omap/omap-hdmi-audio.c => ti/omap-hdmi.c} (100%)
 rename sound/soc/{omap => ti}/omap-mcbsp-priv.h (100%)
 rename sound/soc/{omap => ti}/omap-mcbsp-st.c (100%)
 rename sound/soc/{omap => ti}/omap-mcbsp.c (100%)
 rename sound/soc/{omap => ti}/omap-mcbsp.h (100%)
 rename sound/soc/{omap => ti}/omap-mcpdm.c (100%)
 rename sound/soc/{omap => ti}/omap-mcpdm.h (100%)
 rename sound/soc/{omap => ti}/omap-twl4030.c (100%)
 rename sound/soc/{omap => ti}/omap3pandora.c (100%)
 rename sound/soc/{omap => ti}/osk5912.c (100%)
 rename sound/soc/{omap => ti}/rx51.c (100%)
 rename sound/soc/{omap => ti}/sdma-pcm.c (100%)
 rename sound/soc/{omap => ti}/sdma-pcm.h (85%)

-- 
Peter

Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki
