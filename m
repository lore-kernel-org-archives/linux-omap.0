From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: Re: [PATCH v4] ASoC: omap-mcbsp: Add PM QoS support
 for McBSP to prevent glitches
Date: Mon, 2 Jan 2017 16:18:16 +0200
Message-ID: <706677a0-c140-b777-a44f-678ca087cac3@ti.com>
References: <1482551370-31493-1-git-send-email-matt@ranostay.consulting>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
In-Reply-To: <1482551370-31493-1-git-send-email-matt@ranostay.consulting>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Matt Ranostay <matt@ranostay.consulting>, linux-omap@vger.kernel.org, alsa-devel@alsa-project.org
Cc: Tony Lindgren <tony@atomide.com>
List-Id: linux-omap@vger.kernel.org

Matt,

On 12/24/2016 05:49 AM, Matt Ranostay wrote:
> We can get audio errors if hitting deeper idle states on omaps:
> =

> [alsa.c:230] error: Fatal problem with alsa output, error -5.
> [audio.c:614] error: Error in writing audio (Input/output error?)!
> =

> This seems to happen with off mode idle enabled as power for the
> whole SoC may get cut off between filling the McBSP fifo using DMA.
> While active DMA blocks deeper idle states in hardware, McBSP
> activity does not seem to do so.
> =

> Basing the QoS latency calculation on the FIFO size, threshold,
> sample rate, and channels.
> =

> Based on the original patch by Tony Lindgren
> Link: https://patchwork.kernel.org/patch/9305867/

I think it would be much better if...
 =

> Cc: Tony Lindgren <tony@atomide.com>
> Cc: Peter Ujfalusi <peter.ujfalusi@ti.com>
> Signed-off-by: Matt Ranostay <matt@ranostay.consulting>
> ---
> =

> Changes from v1:
> * add calculations for latency per number of FIFO locations
> =

> Changes from v2:
> * add missing mcbsp.h header change
> =

> Changes from v3:
> * base the latency calculations on threshold, buffer size, sample
>   rate, and channels
> =

>  sound/soc/omap/mcbsp.c      | 19 +++++++++++++++++++
>  sound/soc/omap/mcbsp.h      |  3 +++
>  sound/soc/omap/omap-mcbsp.c | 21 ++++++++++++++++++++-
>  3 files changed, 42 insertions(+), 1 deletion(-)
> =

> diff --git a/sound/soc/omap/mcbsp.c b/sound/soc/omap/mcbsp.c
> index 06fec5699cc8..8f792e714894 100644
> --- a/sound/soc/omap/mcbsp.c
> +++ b/sound/soc/omap/mcbsp.c
> @@ -25,6 +25,7 @@
>  #include <linux/io.h>
>  #include <linux/slab.h>
>  #include <linux/pm_runtime.h>
> +#include <linux/pm_qos.h>
>  =

>  #include <linux/platform_data/asoc-ti-mcbsp.h>
> @@ -640,9 +641,19 @@ void omap_mcbsp_free(struct omap_mcbsp *mcbsp)
>   */
>  void omap_mcbsp_start(struct omap_mcbsp *mcbsp, int tx, int rx)
>  {
> +	struct pm_qos_request *pm_qos_req =3D &mcbsp->pm_qos_req;
>  	int enable_srg =3D 0;
>  	u16 w;
>  =

> +	/* Prevent omap hardware from hitting off between fifo fills */
> +	if (mcbsp->latency) {
> +		if (pm_qos_request_active(pm_qos_req))
> +			pm_qos_update_request(pm_qos_req, mcbsp->latency);
> +		else
> +			pm_qos_add_request(pm_qos_req, PM_QOS_CPU_DMA_LATENCY,
> +					mcbsp->latency);
> +	}

int stream1 =3D tx ? SNDRV_PCM_STREAM_PLAYBACK : SNDRV_PCM_STREAM_CAPTURE;
int stream2 =3D tx ? SNDRV_PCM_STREAM_CAPTURE : SNDRV_PCM_STREAM_PLAYBACK;
unsigned int latency;

if (!mcbsp->latency[stream2] ||
    mcbsp->latency[stream1] < mcbsp->latency[stream2])
	latency =3D mcbsp->latency[stream1];
else
	latency =3D mcbsp->latency[stream2];

if (latency) {
	if (pm_qos_request_active(pm_qos_req))
		pm_qos_update_request(pm_qos_req, latency);
	else
		pm_qos_add_request(pm_qos_req, PM_QOS_CPU_DMA_LATENCY,
				   latency);
}

> +
>  	if (mcbsp->st_data)
>  		omap_st_start(mcbsp);
>  =

> @@ -731,6 +742,11 @@ void omap_mcbsp_stop(struct omap_mcbsp *mcbsp, int t=
x, int rx)
>  =

>  	if (mcbsp->st_data)
>  		omap_st_stop(mcbsp);
> +
> +	if (mcbsp->active =3D=3D 1 && pm_qos_request_active(&mcbsp->pm_qos_req)=
) {
> +		pm_qos_remove_request(&mcbsp->pm_qos_req);
> +		mcbsp->latency =3D 0;
> +	}

if (pm_qos_request_active(&mcbsp->pm_qos_req)) {
	int stream1 =3D tx ? SNDRV_PCM_STREAM_PLAYBACK :
			   SNDRV_PCM_STREAM_CAPTURE;
	int stream2 =3D tx ? SNDRV_PCM_STREAM_CAPTURE :
			   SNDRV_PCM_STREAM_PLAYBACK;

	mcbsp->latency[stream1] =3D 0;
	if (mcbsp->latency[stream2])
		pm_qos_update_request(pm_qos_req,
				      mcbsp->latency[stream2]);
	else
		pm_qos_remove_request(&mcbsp->pm_qos_req);
}

So we fall back to the qos needed for the remaining stream.

>  }
>  =

>  int omap2_mcbsp_set_clks_src(struct omap_mcbsp *mcbsp, u8 fck_src_id)
> @@ -1098,6 +1114,9 @@ int omap_mcbsp_init(struct platform_device *pdev)
>  =

>  void omap_mcbsp_cleanup(struct omap_mcbsp *mcbsp)
>  {
> +	if (pm_qos_request_active(&mcbsp->pm_qos_req))
> +		pm_qos_remove_request(&mcbsp->pm_qos_req);
> +
>  	if (mcbsp->pdata->buffer_size)
>  		sysfs_remove_group(&mcbsp->dev->kobj, &additional_attr_group);
>  =

> diff --git a/sound/soc/omap/mcbsp.h b/sound/soc/omap/mcbsp.h
> index 61e93b1c185d..d312e72f7979 100644
> --- a/sound/soc/omap/mcbsp.h
> +++ b/sound/soc/omap/mcbsp.h
> @@ -323,8 +323,11 @@ struct omap_mcbsp {
>  =

>  	unsigned int fmt;
>  	unsigned int in_freq;
> +	unsigned int latency;

unsigned int latency[2];

>  	int clk_div;
>  	int wlen;
> +
> +	struct pm_qos_request pm_qos_req;
>  };
>  =

>  void omap_mcbsp_config(struct omap_mcbsp *mcbsp,
> diff --git a/sound/soc/omap/omap-mcbsp.c b/sound/soc/omap/omap-mcbsp.c
> index d018e966e533..ddaec37fb4c3 100644
> --- a/sound/soc/omap/omap-mcbsp.c
> +++ b/sound/soc/omap/omap-mcbsp.c
> @@ -226,6 +226,7 @@ static int omap_mcbsp_dai_hw_params(struct snd_pcm_su=
bstream *substream,
>  	int wlen, channels, wpf;
>  	int pkt_size =3D 0;
>  	unsigned int format, div, framesize, master;
> +	unsigned int buffer_size =3D mcbsp->pdata->buffer_size;
>  =

>  	dma_data =3D snd_soc_dai_get_dma_data(cpu_dai, substream);
>  	channels =3D params_channels(params);
> @@ -240,7 +241,9 @@ static int omap_mcbsp_dai_hw_params(struct snd_pcm_su=
bstream *substream,
>  	default:
>  		return -EINVAL;
>  	}
> -	if (mcbsp->pdata->buffer_size) {
> +	if (buffer_size) {
> +		int latency;
> +
>  		if (mcbsp->dma_op_mode =3D=3D MCBSP_DMA_MODE_THRESHOLD) {
>  			int period_words, max_thrsh;
>  			int divider =3D 0;
> @@ -271,6 +274,22 @@ static int omap_mcbsp_dai_hw_params(struct snd_pcm_s=
ubstream *substream,
>  			/* Use packet mode for non mono streams */
>  			pkt_size =3D channels;
>  		}
> +
> +		latency =3D ((((buffer_size - pkt_size) / channels) * 1000)
> +				 / (params->rate_num / params->rate_den));
> +
> +		/*
> +		 * Use the lowest QoS latency value for active streams, but
> +		 * this has the disadvantage of using lower than needed latency
> +		 * if an stream with lower QoS ends before one with a higher
> +		 * one. Latency setting only gets reset when all streams
> +		 * complete.
> +		 */
> +		if (latency <=3D mcbsp->latency)
> +			mcbsp->latency =3D latency;
> +		else
> +			mcbsp->latency =3D 0;

mcbsp->latency[substream->stream] =3D latency;

> +
>  		omap_mcbsp_set_threshold(substream, pkt_size);
>  	}
>  =

> =


What do you think?

-- =

P=E9ter
