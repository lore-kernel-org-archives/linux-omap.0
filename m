From: Liam Girdwood <lrg@slimlogic.co.uk>
Subject: Re: [PATCHv3 3/4] Add ASoC support for DevKit8000
Date: Thu, 11 Feb 2010 09:55:12 +0000
Message-ID: <1265882112.3179.1.camel@odin>
References: <1265829784-19224-1-git-send-email-swirl@gmx.li>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
In-Reply-To: <1265829784-19224-1-git-send-email-swirl@gmx.li>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Thomas Weber <swirl@gmx.li>
Cc: alsa-devel@alsa-project.org, weber@corscience.de, Tomi.Valkeinen@nokia.com, tony@atomride.com, felipe.balbi@nokia.com, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

On Wed, 2010-02-10 at 20:23 +0100, Thomas Weber wrote:
> This patch expands the omap3beagle sound soc for the
> beagle board clone Devkit8000.
> 
> Change log
> V2
> 	Expand omap3beagle sound soc for DevKit8000 support.
> V3 
> 	Separate Kconfig for Devkit8000.
> 
> Signed-off-by: Thomas Weber <swirl@gmx.li>
> ---
>  sound/soc/omap/Kconfig       |    8 ++++++++
>  sound/soc/omap/Makefile      |    1 +
>  sound/soc/omap/omap3beagle.c |    6 +++---
>  3 files changed, 12 insertions(+), 3 deletions(-)
> 
> diff --git a/sound/soc/omap/Kconfig b/sound/soc/omap/Kconfig
> index 61952aa..8520b75 100644
> --- a/sound/soc/omap/Kconfig
> +++ b/sound/soc/omap/Kconfig
> @@ -101,6 +101,14 @@ config SND_OMAP_SOC_OMAP3_BEAGLE
>  	help
>  	  Say Y if you want to add support for SoC audio on the Beagleboard.
>  
> +config SND_OMAP_SOC_DEVKIT8000
> +	tristate "SoC Audio support for DevKit8000"
> +	depends on TWL4030_CORE && SND_OMAP_SOC && MACH_DEVKIT8000
> +	select SND_OMAP_SOC_MCBSP
> +	select SND_SOC_TWL4030
> +	help
> +	  Say Y if you want to add support for SoC audio on the DevKit8000
> +

Since this shares the same mach driver as beagle you should share the
Kconfig option too (like the Overo).

Thanks

Liam

-- 
Freelance Developer, SlimLogic Ltd
ASoC and Voltage Regulator Maintainer.
http://www.slimlogic.co.uk
