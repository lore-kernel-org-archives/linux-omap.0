From: "Cousson, Benoit" <b-cousson-l0cyMroinI0@public.gmane.org>
Subject: Re: [PATCH RFC] spi/omap: Trivial cleanup
Date: Tue, 6 Mar 2012 11:16:50 +0100
Message-ID: <4F55E412.5050409@ti.com>
References: <1330524246-8864-1-git-send-email-shubhrajyoti@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <1330524246-8864-1-git-send-email-shubhrajyoti-l0cyMroinI0@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=spi-devel-general>
List-Post: <mailto:spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Errors-To: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
To: Shubhrajyoti D <shubhrajyoti-l0cyMroinI0@public.gmane.org>
Cc: spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-omap@vger.kernel.org

Hi Shubhro,

On 2/29/2012 3:04 PM, Shubhrajyoti D wrote:
> The context is stored directly inside drvdata structure post
> [f887876 spi/omap: Remove bus_num usage for instance index].
> Remove the OMAP2_MCSPI_MAX_CTRL macro as it is not needed anymore.
>
> Cc: Benoit Cousson<b-cousson-l0cyMroinI0@public.gmane.org>
> Signed-off-by: Shubhrajyoti D<shubhrajyoti-l0cyMroinI0@public.gmane.org>

Thanks for that extra cleanup, I missed it.

Acked-by: Benoit Cousson <b-cousson-l0cyMroinI0@public.gmane.org>

> ---
> Applies on Benoit's for_3.4/dt_spi_eth
>
>   drivers/spi/spi-omap2-mcspi.c |    3 ---
>   1 files changed, 0 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/spi/spi-omap2-mcspi.c b/drivers/spi/spi-omap2-mcspi.c
> index d1eb26c..3526281 100644
> --- a/drivers/spi/spi-omap2-mcspi.c
> +++ b/drivers/spi/spi-omap2-mcspi.c
> @@ -45,9 +45,6 @@
>
>   #define OMAP2_MCSPI_MAX_FREQ		48000000
>
> -/* OMAP2 has 3 SPI controllers, while OMAP3 has 4 */
> -#define OMAP2_MCSPI_MAX_CTRL 		4
> -

I guess it can be included in the "spi/omap: Remove bus_num usage for 
instance index"?
Is that OK for you?


Thanks,
Benoit


------------------------------------------------------------------------------
Keep Your Developer Skills Current with LearnDevNow!
The most comprehensive online learning library for Microsoft developers
is just $99.99! Visual Studio, SharePoint, SQL - plus HTML5, CSS3, MVC3,
Metro Style Apps, more. Free future releases when you subscribe now!
http://p.sf.net/sfu/learndevnow-d2d
