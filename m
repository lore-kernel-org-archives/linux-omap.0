From: Jarkko Nikula <jhnikula@gmail.com>
Subject: Re: [PATCH 0/2] McBSP: OMAP3: Add sidetone feature
Date: Thu, 28 Jan 2010 18:57:02 +0200
Message-ID: <20100128185702.6c1c0f04.jhnikula@gmail.com>
References: <1264693587-4764-1-git-send-email-ilkka.koskinen@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
In-Reply-To: <1264693587-4764-1-git-send-email-ilkka.koskinen@nokia.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Ilkka Koskinen <ilkka.koskinen@nokia.com>
Cc: alsa-devel@alsa-project.org, tony@atomide.com, peter.ujfalusi@nokia.com, broonie@opensource.wolfsonmicro.com, eduardo.valentin@nokia.com, ext-eero.nurkkala@nokia.com, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

On Thu, 28 Jan 2010 17:46:25 +0200
Ilkka Koskinen <ilkka.koskinen@nokia.com> wrote:

> The first patch implements McBSP sidetone feature on OMAP3 while the second one
> provides ALSA interface for using it.
> 
> The patch set is based on the patch Eduardo Valentin sent to alsa-devel
> mailing list in October 2009. Channel gain control and enabling the sidetone
> have been moved to ALSA interface as suggested in comments. 
> 
> Eero Nurkkala (1):
>   McBSP: OMAP3: Add sidetone feature
> 
> Ilkka Koskinen (1):
>   ASoC: OMAP-McBSP: ASoC interface for McBSP sidetone
> 
>  arch/arm/mach-omap2/mcbsp.c             |    2 +
>  arch/arm/plat-omap/include/plat/mcbsp.h |   63 +++++
>  arch/arm/plat-omap/mcbsp.c              |  402 ++++++++++++++++++++++++++++++-
>  sound/soc/omap/omap-mcbsp.c             |  187 ++++++++++++++
>  sound/soc/omap/omap-mcbsp.h             |    2 +
>  5 files changed, 655 insertions(+), 1 deletions(-)
> 
For me the separation between arch/arm/plat-omap/mcbsp.c and
sound/soc/omap/omap-mcbsp.c and board specific control registration
function omap_mcbsp_st_add_controls looks ok.

Set applies well on top of vanilla but the patch 1 doesn't apply on
linux-omap due commit bcbb73c6fe8544bb50cddb8b5df0e2fcbb08b4b0.

I was thinking that it makes sense to base the patch 1 on top of McBSP
register cache patches from Janusz Krzysztofik after Tony applies
them (+ having cache for ST regs). That avoid conflicts in mainline
and makes the sidetone also ready for McBSP context save/restore
functionality.


-- 
Jarkko
