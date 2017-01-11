From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: Re: [PATCH v6] ASoC: omap-mcbsp: Add PM QoS support
 for McBSP to prevent glitches
Date: Wed, 11 Jan 2017 09:26:47 +0200
Message-ID: <340575c8-e515-28a9-64db-6d9a93b5158c@ti.com>
References: <20170111054600.12982-1-matt@ranostay.consulting>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
In-Reply-To: <20170111054600.12982-1-matt@ranostay.consulting>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Matt Ranostay <matt@ranostay.consulting>, alsa-devel@alsa-project.org, linux-omap@vger.kernel.org
Cc: Tony Lindgren <tony@atomide.com>
List-Id: linux-omap@vger.kernel.org

On 01/11/2017 07:46 AM, Matt Ranostay wrote:
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
> =

> Cc: Tony Lindgren <tony@atomide.com>
> Cc: Peter Ujfalusi <peter.ujfalusi@ti.com>
> Signed-off-by: Matt Ranostay <matt@ranostay.consulting>
> ---
> hanges from v1:
> * add calculations for latency per number of FIFO locations
> =

> Changes from v2:
> * add missing mcbsp.h header change
> =

> Changes from v3:
> * base the latency calculations on threshold, buffer size, sample
>   rate, and channels
> =

> Changes from v4:
> * using Peter Ujfalusi's suggestions for restoring a higher latency on
>   audio stream completion, or if not applicable remove the QoS request
> =

> Changes from v5:
> * clean up latency checking logic
> * move logic to .prepare and .shutdown to avoid functions that can sleep
> =

>  sound/soc/omap/mcbsp.c      |  4 ++++
>  sound/soc/omap/mcbsp.h      |  3 +++
>  sound/soc/omap/omap-mcbsp.c | 44 +++++++++++++++++++++++++++++++++++++++=
++++-
>  3 files changed, 50 insertions(+), 1 deletion(-)
> =

> diff --git a/sound/soc/omap/mcbsp.c b/sound/soc/omap/mcbsp.c
> index 06fec5699cc8..e1c3d21dc5ed 100644
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

> @@ -1098,6 +1099,9 @@ int omap_mcbsp_init(struct platform_device *pdev)
>  =

>  void omap_mcbsp_cleanup(struct omap_mcbsp *mcbsp)
>  {
> +	if (pm_qos_request_active(&mcbsp->pm_qos_req))
> +		pm_qos_remove_request(&mcbsp->pm_qos_req);
> +

It might be better to do this in asoc_mcbsp_remove() in omap-mcbsp.c so
the pm_qos stuff is handled within one file.

>  	if (mcbsp->pdata->buffer_size)
>  		sysfs_remove_group(&mcbsp->dev->kobj, &additional_attr_group);
>  =

> diff --git a/sound/soc/omap/mcbsp.h b/sound/soc/omap/mcbsp.h
> index 61e93b1c185d..46ae1269a698 100644
> --- a/sound/soc/omap/mcbsp.h
> +++ b/sound/soc/omap/mcbsp.h
> @@ -323,8 +323,11 @@ struct omap_mcbsp {
>  =

>  	unsigned int fmt;
>  	unsigned int in_freq;
> +	unsigned int latency[2];
>  	int clk_div;
>  	int wlen;
> +
> +	struct pm_qos_request pm_qos_req;
>  };
>  =

>  void omap_mcbsp_config(struct omap_mcbsp *mcbsp,
> diff --git a/sound/soc/omap/omap-mcbsp.c b/sound/soc/omap/omap-mcbsp.c
> index d018e966e533..3814a234ef61 100644
> --- a/sound/soc/omap/omap-mcbsp.c
> +++ b/sound/soc/omap/omap-mcbsp.c

#include <linux/pm_qos.h> ?


-- =

P=E9ter
