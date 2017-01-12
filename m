From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: Re: [PATCH v6] ASoC: omap-mcbsp: Add PM QoS support
 for McBSP to prevent glitches
Date: Thu, 12 Jan 2017 09:55:23 +0200
Message-ID: <12e553d8-705f-8308-3f34-e461813068fc@ti.com>
References: <20170112073541.30765-1-matt@ranostay.consulting>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
In-Reply-To: <20170112073541.30765-1-matt@ranostay.consulting>
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

On 01/12/2017 09:35 AM, Matt Ranostay wrote:
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

> Changes from v4:
> * using Peter Ujfalusi's suggestions for restoring a higher latency on
> audio stream completion, or if not applicable remove the QoS request
> =

> Changes from v5:
> * clean up latency checking logic
> * move logic to .prepare and .shutdown to avoid functions that can sleep
> =

> Changes from v6:
> * move QoS removal to asoc_mcbsp_remove from omap_mcbsp_cleanup

Looks good.

You can add my
Acked-by: Peter Ujfalusi <peter.ujfalusi@ti.com>

to v7...

> =

>  sound/soc/omap/mcbsp.c      |  1 +
>  sound/soc/omap/mcbsp.h      |  3 +++
>  sound/soc/omap/omap-mcbsp.c | 47 +++++++++++++++++++++++++++++++++++++++=
+++++-
>  3 files changed, 50 insertions(+), 1 deletion(-)
> =

> diff --git a/sound/soc/omap/mcbsp.c b/sound/soc/omap/mcbsp.c
> index 06fec5699cc8..8fdb949a266e 100644
> --- a/sound/soc/omap/mcbsp.c
> +++ b/sound/soc/omap/mcbsp.c
> @@ -25,6 +25,7 @@
>  #include <linux/io.h>
>  #include <linux/slab.h>
>  #include <linux/pm_runtime.h>
> +#include <linux/pm_qos.h>

Which would not add this include line ;)

>  =

>  #include <linux/platform_data/asoc-ti-mcbsp.h>
>  =


-- =

P=E9ter
