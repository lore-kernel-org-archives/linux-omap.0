From: Ilkka Koskinen <ilkka.koskinen@nokia.com>
Subject: [PATCH 0/2] McBSP: OMAP3: Add sidetone feature
Date: Thu, 28 Jan 2010 17:46:25 +0200
Message-ID: <1264693587-4764-1-git-send-email-ilkka.koskinen@nokia.com>
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
To: alsa-devel@alsa-project.org, linux-omap@vger.kernel.org, peter.ujfalusi@nokia.com, jhnikula@gmail.com, broonie@opensource.wolfsonmicro.com, tony@atomide.com
Cc: eduardo.valentin@nokia.com, ext-eero.nurkkala@nokia.com
List-Id: linux-omap@vger.kernel.org

The first patch implements McBSP sidetone feature on OMAP3 while the second one
provides ALSA interface for using it.

The patch set is based on the patch Eduardo Valentin sent to alsa-devel
mailing list in October 2009. Channel gain control and enabling the sidetone
have been moved to ALSA interface as suggested in comments. 

Eero Nurkkala (1):
  McBSP: OMAP3: Add sidetone feature

Ilkka Koskinen (1):
  ASoC: OMAP-McBSP: ASoC interface for McBSP sidetone

 arch/arm/mach-omap2/mcbsp.c             |    2 +
 arch/arm/plat-omap/include/plat/mcbsp.h |   63 +++++
 arch/arm/plat-omap/mcbsp.c              |  402 ++++++++++++++++++++++++++++++-
 sound/soc/omap/omap-mcbsp.c             |  187 ++++++++++++++
 sound/soc/omap/omap-mcbsp.h             |    2 +
 5 files changed, 655 insertions(+), 1 deletions(-)
