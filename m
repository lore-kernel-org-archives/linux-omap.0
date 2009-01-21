From: Peter Ujfalusi <peter.ujfalusi@nokia.com>
Subject: Re: [PATCH] ASoC: Complete Beagleboard support
Date: Wed, 21 Jan 2009 09:53:36 +0200
Message-ID: <200901210953.36630.peter.ujfalusi@nokia.com>
References: <5e088bd90901202305m26900888jcaa2b0ec57d3fab1@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
In-Reply-To: <5e088bd90901202305m26900888jcaa2b0ec57d3fab1@mail.gmail.com>
Content-Disposition: inline
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: ext Steve Sakoman <sakoman@gmail.com>
Cc: alsa-devel@alsa-project.org, linux-omap <linux-omap@vger.kernel.org>
List-Id: linux-omap@vger.kernel.org

Hello,

for ure now you can build it, but does it actually works?
I mean there has been quite a bit of change in the twl4030
codec driver... The DAPM routing implementation might require
some change in the board file also (SND_SOC_DAPM_HP,
SND_SOC_DAPM_LINE, etc).

-- =

P=E9ter

On Wednesday 21 January 2009 09:05:27 ext Steve Sakoman wrote:
> Commit dc06102a0c8b5aa0dd7f9a40ce241e793c252a87 in the asoc tree
> did not include the necessary Kconfig and Makefile changes.  This patch
> completes the support for Beagleboard
>
> Signed-off-by: Steve Sakoman <steve@sakoman.com>
>
> ---
>  sound/soc/omap/Kconfig  |   10 ++++++++++
>  sound/soc/omap/Makefile |    2 ++
>  2 files changed, 12 insertions(+), 0 deletions(-)
>
> diff --git a/sound/soc/omap/Kconfig b/sound/soc/omap/Kconfig
> index 4f7f040..ccd8973 100644
> --- a/sound/soc/omap/Kconfig
> +++ b/sound/soc/omap/Kconfig
> @@ -55,3 +55,13 @@ config SND_OMAP_SOC_OMAP3_PANDORA
>  	select SND_SOC_TWL4030
>  	help
>  	  Say Y if you want to add support for SoC audio on the OMAP3 Pandora.
> +
> +config SND_OMAP_SOC_OMAP3_BEAGLE
> +	tristate "SoC Audio support for OMAP3 Beagle"
> +	depends on TWL4030_CORE && SND_OMAP_SOC && MACH_OMAP3_BEAGLE
> +	select SND_OMAP_SOC_MCBSP
> +	select SND_SOC_TWL4030
> +	help
> +	  Say Y if you want to add support for SoC audio on the Beagleboard.
> +
> +
> diff --git a/sound/soc/omap/Makefile b/sound/soc/omap/Makefile
> index 76fedd9..0c9e4ac 100644
> --- a/sound/soc/omap/Makefile
> +++ b/sound/soc/omap/Makefile
> @@ -12,6 +12,7 @@ snd-soc-overo-objs :=3D overo.o
>  snd-soc-omap2evm-objs :=3D omap2evm.o
>  snd-soc-sdp3430-objs :=3D sdp3430.o
>  snd-soc-omap3pandora-objs :=3D omap3pandora.o
> +snd-soc-omap3beagle-objs :=3D omap3beagle.o
>
>  obj-$(CONFIG_SND_OMAP_SOC_N810) +=3D snd-soc-n810.o
>  obj-$(CONFIG_SND_OMAP_SOC_OSK5912) +=3D snd-soc-osk5912.o
> @@ -19,3 +20,4 @@ obj-$(CONFIG_SND_OMAP_SOC_OVERO) +=3D snd-soc-overo.o
>  obj-$(CONFIG_MACH_OMAP2EVM) +=3D snd-soc-omap2evm.o
>  obj-$(CONFIG_SND_OMAP_SOC_SDP3430) +=3D snd-soc-sdp3430.o
>  obj-$(CONFIG_SND_OMAP_SOC_OMAP3_PANDORA) +=3D snd-soc-omap3pandora.o
> +obj-$(CONFIG_SND_OMAP_SOC_OMAP3_BEAGLE) +=3D snd-soc-omap3beagle.o
