From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: [PATCH 00/11] ARM/ASoC: OMAP McBSP device tree support
Date: Wed,  8 Aug 2012 12:11:30 +0300
Message-ID: <1344417101-5015-1-git-send-email-peter.ujfalusi@ti.com>
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
To: Mark Brown <broonie@opensource.wolfsonmicro.com>, Liam Girdwood <lrg@ti.com>, Tony Lindgren <tony@atomide.com>
Cc: alsa-devel@alsa-project.org, Benoit Cousson <b-cousson@ti.com>, devicetree-discuss@lists.ozlabs.org, Jarkko Nikula <jarkko.nikula@bitmer.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

Hello,

in order to be able to add DT support for the McBSP driver which is used on all
OMAP platforms (OMAP1/2/3/4/5) I needed to make some cleanups to the stack:
- Removing callbacks used by the driver for
 - clock re-parenting (code moved to sound driver)
 - FSR/CLKR mux configuration (from now on it need to be done at board level)
   This mux is board specific and depends on the wiring.
- OMAP3 sidetone ICLK workaround has been reimplemented using the SYSCONFIG
  register's SIDLEMODE filed to prevent ICLK gating while ST is running.
- Replaced the cpu_is_omap* checks with future proof check.
- The FIFO was not enabled on OMAP2430 SoC

It has been tested on BeagleBoard (with legacy and DT boot).

The series changes McBSP related files mostly. It would be great if the whole
series could go via audio tree (if the patches are OK and it is fine by Tony).

Regards,
Peter
---
Peter Ujfalusi (11):
  ARM/ASoC: omap-mcbsp: Move OMAP2+ clock parenting code to ASoC driver
  ARM: OMAP2+: McBSP: Do not create legacy devices when booting with DT
    data
  ARM: OMAP: mcbsp: Enable FIFO use for OMAP2430
  ARM: OMAP: board-am3517evm: Configure McBSP1 CLKR/FSR signal source
  ASoC: am3517evm: Do not configure McBSP1 CLKR/FSR signal muxing
  ARM/ASoC: omap-mcbsp: Remove CLKR/FSR mux configuration code
  ASoC: omap-mcbsp: Sidetone: Use SIDLE bits in SYSCONFIG register to
    select noidle mode
  ARM: OMAP3: Remove callback for McBSP sidetone ICLK workaround
  ASoC: omap-mcbsp: Remove unused defines
  ASoC: omap-mcbsp: Remove cpu_is_omap* checks from the code
  ASoC: omap-mcbsp: Add device tree bindings

 .../devicetree/bindings/sound/omap-mcbsp.txt       |   45 ++++++
 arch/arm/mach-omap2/board-am3517evm.c              |   13 ++
 arch/arm/mach-omap2/mcbsp.c                        |  152 +-------------------
 arch/arm/plat-omap/include/plat/mcbsp.h            |    3 -
 sound/soc/omap/am3517evm.c                         |   20 +---
 sound/soc/omap/mcbsp.c                             |   72 +++++-----
 sound/soc/omap/mcbsp.h                             |    4 +-
 sound/soc/omap/omap-mcbsp.c                        |  106 ++++++++++-----
 sound/soc/omap/omap-mcbsp.h                        |   20 ---
 9 files changed, 177 insertions(+), 258 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/sound/omap-mcbsp.txt

-- 
1.7.8.6
