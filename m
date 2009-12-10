From: Liam Girdwood <lrg@slimlogic.co.uk>
Subject: Re: [PATCH] Fix build of OMAP sound drivers
Date: Thu, 10 Dec 2009 17:25:50 +0000
Message-ID: <1260465950.3625.213.camel@odin>
References: <20091210171555.GB19668@lixom.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
In-Reply-To: <20091210171555.GB19668@lixom.net>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Olof Johansson <olof@lixom.net>
Cc: alsa-devel@alsa-project.org, broonie@opensource.wolfsonmicro.com, Arun KS <arunks@mistralsolutions.com>, Anuj Aggarwal <anuj.aggarwal@ti.com>, linux-omap@vger.kernel.org, Anand Gadiyar <gadiyar@ti.com>
List-Id: linux-omap@vger.kernel.org

On Thu, 2009-12-10 at 11:15 -0600, Olof Johansson wrote:
> There are build errors when building for some of the omap2/3 boards without
> enabling sound:
> 
> sound/built-in.o:(.data+0x43bc): undefined reference to `soc_codec_dev_tlv320aic23'
> sound/built-in.o:(.data+0x43cc): undefined reference to `tlv320aic23_dai'
> 
> Confused me quite a bit since the drivers that had references to the
> codec weren't enabled. Turns out the Makefile was using the wrong
> config option to enable them. Patch below.
> 
> 
> 
> Reported-by: Anand Gadiyar <gadiyar@ti.com>
> Signed-off-by: Olof Johansson <olof@lixom.net>

Acked-by: Liam Girdwood <lrg@slimlogic.co.uk>

> 
> diff --git a/sound/soc/omap/Makefile b/sound/soc/omap/Makefile
> index d49458a..3db8a6c 100644
> --- a/sound/soc/omap/Makefile
> +++ b/sound/soc/omap/Makefile
> @@ -23,9 +23,9 @@ obj-$(CONFIG_SND_OMAP_SOC_N810) += snd-soc-n810.o
>  obj-$(CONFIG_SND_OMAP_SOC_AMS_DELTA) += snd-soc-ams-delta.o
>  obj-$(CONFIG_SND_OMAP_SOC_OSK5912) += snd-soc-osk5912.o
>  obj-$(CONFIG_SND_OMAP_SOC_OVERO) += snd-soc-overo.o
> -obj-$(CONFIG_MACH_OMAP2EVM) += snd-soc-omap2evm.o
> -obj-$(CONFIG_MACH_OMAP3EVM) += snd-soc-omap3evm.o
> -obj-$(CONFIG_MACH_OMAP3517EVM) += snd-soc-am3517evm.o
> +obj-$(CONFIG_SND_OMAP_SOC_OMAP2EVM) += snd-soc-omap2evm.o
> +obj-$(CONFIG_SND_OMAP_SOC_OMAP3EVM) += snd-soc-omap3evm.o
> +obj-$(CONFIG_SND_OMAP_SOC_OMAP3517EVM) += snd-soc-am3517evm.o
>  obj-$(CONFIG_SND_OMAP_SOC_SDP3430) += snd-soc-sdp3430.o
>  obj-$(CONFIG_SND_OMAP_SOC_OMAP3_PANDORA) += snd-soc-omap3pandora.o
>  obj-$(CONFIG_SND_OMAP_SOC_OMAP3_BEAGLE) += snd-soc-omap3beagle.o
> _______________________________________________
> Alsa-devel mailing list
> Alsa-devel@alsa-project.org
> http://mailman.alsa-project.org/mailman/listinfo/alsa-devel
