From: Jarkko Nikula <jarkko.nikula@nokia.com>
Subject: Re: [PATCH 4/5] SOUND: SOC: OMAP: Add support for
	Gumstix Overo
Date: Thu, 4 Sep 2008 13:40:13 +0300
Message-ID: <20080904134013.0331f17c.jarkko.nikula@nokia.com>
References: <1220504520-6067-1-git-send-email-sakoman@gmail.com>
	<1220504520-6067-2-git-send-email-sakoman@gmail.com>
	<1220504520-6067-3-git-send-email-sakoman@gmail.com>
	<1220504520-6067-4-git-send-email-sakoman@gmail.com>
	<1220504520-6067-5-git-send-email-sakoman@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
In-Reply-To: <1220504520-6067-5-git-send-email-sakoman@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: "ext sakoman@gmail.com" <sakoman@gmail.com>
Cc: alsa-devel@alsa-project.org, linux-omap@vger.kernel.org, Steve Sakoman <steve@sakoman.com>
List-Id: linux-omap@vger.kernel.org

On Wed,  3 Sep 2008 22:01:59 -0700
"ext sakoman@gmail.com" <sakoman@gmail.com> wrote:

> From: Steve Sakoman <steve@sakoman.com>
> 
> ---
>  sound/soc/omap/Kconfig  |    9 +++
>  sound/soc/omap/Makefile |    3 +
>  sound/soc/omap/overo.c  |  149 ++++++++++++++++++++++++++++++++++++++
> +++++++++ 3 files changed, 161 insertions(+), 0 deletions(-)
>  create mode 100644 sound/soc/omap/overo.c
> 
> diff --git a/sound/soc/omap/Kconfig b/sound/soc/omap/Kconfig
> index aea27e7..d7b8939 100644
> --- a/sound/soc/omap/Kconfig
> +++ b/sound/soc/omap/Kconfig
> @@ -13,3 +13,12 @@ config SND_OMAP_SOC_N810
>  	select SND_SOC_TLV320AIC3X
>  	help
>  	  Say Y if you want to add support for SoC audio on Nokia
> N810. +
> +config SND_OMAP_SOC_OVERO
> +	tristate "SoC Audio support for Gumstix Overo"
> +	depends on SND_OMAP_SOC && MACH_OVERO
> +	select SND_OMAP_SOC_MCBSP
> +	select SND_SOC_TWL4030
> +	help
> +	  Say Y if you want to add support for SoC audio on the
> Gumstix Overo. +

Just advertisement that Overo (+ Beagle and SDP) needs two patches
from me in order to work. One for McBSP low-level driver and one for
McBSP DAI driver.

http://marc.info/?l=linux-omap&m=121931987919296&w=2

http://marc.info/?l=linux-omap&m=121931988119303&w=2
http://marc.info/?l=linux-omap&m=121931988019300&w=2

Assuming TWL4030 core and codec driver will find their way into
upstream, it looks like sound/soc/omap/overo.c is still "make
randconfig" safe even if my patches are missing.

I'll post my second patch to alsa-devel as soon it's possible after
joint effort to clean low-level McBSP driver in linux-omap is done :-)


Jarkko
