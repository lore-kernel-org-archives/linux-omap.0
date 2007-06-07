From: Dirk Behme <dirk.behme@googlemail.com>
Subject: Re: [PATCH] Update SX1 audio to current ALSA typenames
Date: Thu, 07 Jun 2007 17:19:16 +0200
Message-ID: <466821F4.3070801@googlemail.com>
References: <fb249edb0706061950t2a1a5596h55911911365608d3@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com>
In-Reply-To: <fb249edb0706061950t2a1a5596h55911911365608d3@mail.gmail.com>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com
Errors-To: linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com
To: andrzej zaborowski <balrogg@gmail.com>
Cc: OMAP <Linux-omap-open-source@linux.omap.com>
List-Id: linux-omap@vger.kernel.org

andrzej zaborowski wrote:
> Update to newer ALSA structs in order to fix building.
> 
> Signed-off-by: Andrzej Zaborowski <balrog@zabor.org>
> 
> 
> ------------------------------------------------------------------------
> 
> From 307d4ea30f8731a275494a97e5d7b7555a6e209c Mon Sep 17 00:00:00 2001
> From: Andrzej Zaborowski <balrog@zabor.org>
> Date: Thu, 7 Jun 2007 05:28:24 +0200
> Subject: [PATCH] ARM: OMAP: Update SX1 audio to current ALSA typenames.
> 
> ---
>  sound/arm/omap/omap-alsa-sx1.c |    6 +++---
>  1 files changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/sound/arm/omap/omap-alsa-sx1.c b/sound/arm/omap/omap-alsa-sx1.c
> index eadae68..c4691cd 100644
> --- a/sound/arm/omap/omap-alsa-sx1.c
> +++ b/sound/arm/omap/omap-alsa-sx1.c
> @@ -82,13 +82,13 @@ static unsigned int rates[] = {
>  	 32000, 44100, 48000,
>  };
>  
> -static snd_pcm_hw_constraint_list_t egold_hw_constraints_rates = {
> +static struct snd_pcm_hw_constraint_list egold_hw_constraints_rates = {
>  	.count	= ARRAY_SIZE(rates),
>  	.list	= rates,
>  	.mask	= 0,
>  };
>  
> -static snd_pcm_hardware_t egold_snd_omap_alsa_playback = {
> +static struct snd_pcm_hardware egold_snd_omap_alsa_playback = {
>  	.info = (SNDRV_PCM_INFO_INTERLEAVED | SNDRV_PCM_INFO_BLOCK_TRANSFER |
>  		 SNDRV_PCM_INFO_MMAP | SNDRV_PCM_INFO_MMAP_VALID),
>  	.formats = (SNDRV_PCM_FMTBIT_S16_LE),
> @@ -109,7 +109,7 @@ static snd_pcm_hardware_t egold_snd_omap_alsa_playback = {
>  	.fifo_size		= 0,
>  };
>  
> -static snd_pcm_hardware_t egold_snd_omap_alsa_capture = {
> +static struct snd_pcm_hardware egold_snd_omap_alsa_capture = {
>  	.info = (SNDRV_PCM_INFO_INTERLEAVED | SNDRV_PCM_INFO_BLOCK_TRANSFER |
>  		 SNDRV_PCM_INFO_MMAP | SNDRV_PCM_INFO_MMAP_VALID),
>  	.formats = (SNDRV_PCM_FMTBIT_S16_LE),

What's wrong with

http://source.mvista.com/git/gitweb.cgi?p=linux-omap-2.6.git;a=commitdiff;h=2ce53a2061d29405b35e30fafcc70c63fdbf98b7

?

Do you work on recent git tree?

Dirk
