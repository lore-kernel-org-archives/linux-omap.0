From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: [PATCH 0/6] ARM: OMAP3: Audio support update for
	omap-twl4030
Date: Mon, 31 Dec 2012 12:02:54 +0100
Message-ID: <1356951780-5412-1-git-send-email-peter.ujfalusi@ti.com>
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
To: Tony Lindgren <tony@atomide.com>
Cc: NeilBrown <neilb@suse.de>, alsa-devel@alsa-project.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

Hello,

omap-twl4030 ASoC machine driver can support more boards with the following
series:
http://mailman.alsa-project.org/pipermail/alsa-devel/2012-December/058119.html

Rework the omap-twl4030 audio support code in arch/arm/mach-omap2/ to take
advantages of this. The same machine driver can support the zoom2 and sdp3430
boards as well.

Regards,
Peter
---
Peter Ujfalusi (6):
  ARM: OMAP: 3430sdp: Enable extmute functionality for audio
  ARM: OMAP: zoom: Zoom2 does not have extmute functionality
  ARM: OMAP2+: twl-common: Add default twl4030 audio configuration
  ARM: OMAP2+: twl-common: Allow boards to customize the twl4030 audio
    setup
  ARM: OMAP: zoom: Audio support via the common omap-twl4030 machine
    driver
  ARM: OMAP: sdp3430: Audio support via the common omap-twl4030 machine
    driver

 arch/arm/mach-omap2/board-3430sdp.c          | 20 +++++++++++++++++++
 arch/arm/mach-omap2/board-cm-t35.c           |  2 +-
 arch/arm/mach-omap2/board-devkit8000.c       |  2 +-
 arch/arm/mach-omap2/board-igep0020.c         |  2 +-
 arch/arm/mach-omap2/board-omap3beagle.c      |  2 +-
 arch/arm/mach-omap2/board-omap3evm.c         |  2 +-
 arch/arm/mach-omap2/board-overo.c            |  2 +-
 arch/arm/mach-omap2/board-zoom-peripherals.c | 29 ++++++++++++++++++++--------
 arch/arm/mach-omap2/twl-common.c             | 17 ++++++++++------
 arch/arm/mach-omap2/twl-common.h             |  3 ++-
 10 files changed, 60 insertions(+), 21 deletions(-)

-- 
1.8.0.2
