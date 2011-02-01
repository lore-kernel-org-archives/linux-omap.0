From: Peter Ujfalusi <peter.ujfalusi@nokia.com>
Subject: Re: [PATCH v2 04/13] OMAP2430: hwmod data: Add McBSP
Date: Tue, 01 Feb 2011 14:39:49 +0200
Message-ID: <4D47FF15.5000603@nokia.com>
References: <1296485437-12806-1-git-send-email-kishon@ti.com>
	<1296485437-12806-5-git-send-email-kishon@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
In-Reply-To: <1296485437-12806-5-git-send-email-kishon@ti.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: ext Kishon Vijay Abraham I <kishon@ti.com>
Cc: alsa-devel@alsa-project.org, b-cousson@ti.com, khilman@deeprootsystems.com, broonie@opensource.wolfsonmicro.com, paul@pwsan.com, p-basak2@ti.com, lrg@slimlogic.co.uk, linux-omap@vger.kernel.org, shubhrajyoti@ti.com, charu@ti.com
List-Id: linux-omap@vger.kernel.org

Looks, but:

On 01/31/2011 04:50 PM, ext Kishon Vijay Abraham I wrote:
> From: Charulatha V <charu@ti.com>
> =

> Add McBSP hwmod data for OMAP2430.
> =

> Added a revision member inorder to facilitate the driver to
> differentiate between mcbsp in different omap.
> =

> Signed-off-by: Charulatha V <charu@ti.com>
> Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
> Signed-off-by: Shubhrajyoti D <shubhrajyoti@ti.com>
> ---
>  arch/arm/mach-omap2/omap_hwmod_2430_data.c |  417 ++++++++++++++++++++++=
++++++
>  arch/arm/plat-omap/include/plat/mcbsp.h    |    2 +
>  2 files changed, 419 insertions(+), 0 deletions(-)
> =

> diff --git a/arch/arm/mach-omap2/omap_hwmod_2430_data.c b/arch/arm/mach-o=
map2/omap_hwmod_2430_data.c

...

>  	/* dma_system class*/
>  	&omap2430_dma_system_hwmod,
> +
> +	/*mcbsp class*/

Missing spaces around the comment text

> +	&omap2430_mcbsp1_hwmod,
> +	&omap2430_mcbsp2_hwmod,
> +	&omap2430_mcbsp3_hwmod,
> +	&omap2430_mcbsp4_hwmod,
> +	&omap2430_mcbsp5_hwmod,
>  	NULL,
>  };
>  =


-- =

P=E9ter
