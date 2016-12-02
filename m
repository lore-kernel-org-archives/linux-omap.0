From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: Re: [PATCH v3] ASoC: omap-mcbsp: Add PM QoS support
 for McBSP to prevent glitches
Date: Fri, 2 Dec 2016 10:23:46 +0200
Message-ID: <e8e9a552-14d9-15eb-bf9a-48fdc79965e2@ti.com>
References: <1480555145-8300-1-git-send-email-matt@ranostay.consulting>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
In-Reply-To: <1480555145-8300-1-git-send-email-matt@ranostay.consulting>
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

Hi,

On 12/01/2016 03:19 AM, Matt Ranostay wrote:
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

> Basing the QoS latency on the FIFO size with the approximate delay
> required being 2.3 milliseconds per buffer location.
> =

> Note that this is different from snd_pcm_hw_constraint_step() as
> that can configure things based on the buffer and period size.
> However, that does not help to block idle between the fifo fills.
> =

> Note that in theory some omaps are capable of playing audio while
> hitting deeper idle states. If somebody needs that and gets it
> working, we can set the latency requirements accordingly.
> =

> Based on the original patch by Tony Lindgren
> Link: https://patchwork.kernel.org/patch/9305867/
> =

> Cc: Tony Lindgren <tony@atomide.com>
> Cc: Peter Ujfalusi <peter.ujfalusi@ti.com>
> Signed-off-by: Matt Ranostay <matt@ranostay.consulting>
> ---
> Changes from v1:
> * add calculations for latency per number of FIFO locations
> =

> Changes from v2:
> * add missing mcbsp.h header change
> =

>  sound/soc/omap/mcbsp.c | 15 +++++++++++++++
>  sound/soc/omap/mcbsp.h |  2 ++
>  2 files changed, 17 insertions(+)
> =

> diff --git a/sound/soc/omap/mcbsp.c b/sound/soc/omap/mcbsp.c
> index 06fec5699cc8..b4a773ca2bac 100644
> --- a/sound/soc/omap/mcbsp.c
> +++ b/sound/soc/omap/mcbsp.c
> @@ -25,6 +25,7 @@
>  #include <linux/io.h>
>  #include <linux/slab.h>
>  #include <linux/pm_runtime.h>
> +#include <linux/pm_qos.h>
>  =

>  #include <linux/platform_data/asoc-ti-mcbsp.h>
>  =

> @@ -637,12 +638,21 @@ void omap_mcbsp_free(struct omap_mcbsp *mcbsp)
>   * Here we start the McBSP, by enabling transmitter, receiver or both.
>   * If no transmitter or receiver is active prior calling, then sample-ra=
te
>   * generator and frame sync are started.
> + *
> + * Also setting of the QoS latency for the FIFO which varies upon the bu=
ffer
> + * size. Approximately 2.3 milliseconds per FIFO location.
>   */
>  void omap_mcbsp_start(struct omap_mcbsp *mcbsp, int tx, int rx)
>  {
>  	int enable_srg =3D 0;
> +	int latency =3D mcbsp->pdata->buffer_size * 23;

I think this is not correct.
The McBSP FIFO time depends on the sample rate and on the number of
channels the audio is using. With 8KHz mono you have 12 times more time
per FIFO element compared to 48KHz stereo.

As it has been discussed with Tony we should calculate the QoS latency
in hw_params:

latency_ms =3D ((FIFOsize - FIFOthreshold) / channels) * 1000/sampling-rate

On OMAP3.McBSP2 for example (44.1KHz, stereo):
FIFO threshold 128
 - DMA request will be triggered when 128 slots are free in the FIFO
 - at that point we have still 1152 words in the FIFO.
 - if the C wakeup latency is longer then what it takes to play out the
samples from the FIFO (13.06ms), we will drain the FIFO and got underflow.
 - in this case the QOS should be set as 13.06ms

FIFO threshold 1024
 - DMA request will be triggered when 1024 slots are free in the FIFO
 - at that point we have still 256 words in the FIFO.
 - if the C wakeup latency is longer then what it takes to play out the
samples from the FIFO (2.9ms), we will drain the FIFO and got underflow.
 - in this case the QOS should be 2.9ms

On other McBSPs with 128 word FIFO the required latency is shorter to ensure
we don't drain the FIFO.


>  	u16 w;
>  =

> +	/* Prevent omap hardware from hitting off between fifo fills */
> +	if (latency)
> +		pm_qos_add_request(&mcbsp->pm_qos_req,
> +				   PM_QOS_CPU_DMA_LATENCY, latency);
> +
>  	if (mcbsp->st_data)
>  		omap_st_start(mcbsp);
>  =

> @@ -731,6 +741,8 @@ void omap_mcbsp_stop(struct omap_mcbsp *mcbsp, int tx=
, int rx)
>  =

>  	if (mcbsp->st_data)
>  		omap_st_stop(mcbsp);
> +
> +	pm_qos_remove_request(&mcbsp->pm_qos_req);
>  }
>  =

>  int omap2_mcbsp_set_clks_src(struct omap_mcbsp *mcbsp, u8 fck_src_id)
> @@ -1098,6 +1110,9 @@ int omap_mcbsp_init(struct platform_device *pdev)
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
> index 61e93b1c185d..e603f33f4082 100644
> --- a/sound/soc/omap/mcbsp.h
> +++ b/sound/soc/omap/mcbsp.h
> @@ -325,6 +325,8 @@ struct omap_mcbsp {
>  	unsigned int in_freq;
>  	int clk_div;
>  	int wlen;
> +
> +	struct pm_qos_request pm_qos_req;
>  };
>  =

>  void omap_mcbsp_config(struct omap_mcbsp *mcbsp,
> =


-- =

P=E9ter
