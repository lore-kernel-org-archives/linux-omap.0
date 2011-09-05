From: Raju Sana <venkat.rajuece-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH] beagledaq: Hack in cs_gpios
Date: Mon, 5 Sep 2011 18:12:26 +0530
Message-ID: <CA+dZkamSp1O_e+uEEhudCGFedUC0mzHg0Ur4bJQ76mMekHkZGw@mail.gmail.com>
References: <1314712254-27199-1-git-send-email-bgamari.foss@gmail.com>
	<1314712343-27367-1-git-send-email-bgamari.foss@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <1314712343-27367-1-git-send-email-bgamari.foss-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=spi-devel-general>
List-Post: <mailto:spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Errors-To: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
To: Ben Gamari <bgamari.foss-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, beagleboard-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-omap@vger.kernel.org

Hi Ben,

The McSPI1 has got  "num_cs"  as 4.
I would like to use McSPI1 to select my 3 chips based on the two GPIO pins.

Could you please give me some pointers on this.

Thanks,
Venkat Raju.





On Tue, Aug 30, 2011 at 7:22 PM, Ben Gamari <bgamari.foss-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> wrote:

> ---
>  arch/arm/mach-omap2/board-omap3beagle.c |    4 ++--
>  arch/arm/mach-omap2/devices.c           |   15 +++++++++++++++
>  2 files changed, 17 insertions(+), 2 deletions(-)
>
> diff --git a/arch/arm/mach-omap2/board-omap3beagle.c
> b/arch/arm/mach-omap2/board-omap3beagle.c
> index 67999da..481c1a9 100644
> --- a/arch/arm/mach-omap2/board-omap3beagle.c
> +++ b/arch/arm/mach-omap2/board-omap3beagle.c
> @@ -661,8 +661,8 @@ static struct spi_board_info
> beagledaq_mcspi_board_info[] = {
>        },
>  };
>
> -static int mcspi3_cs_gpios[4];
> -static int mcspi4_cs_gpios[4];
> +int mcspi3_cs_gpios[4];
> +int mcspi4_cs_gpios[4];
>
>  static void __init beagledaq_init(void)
>  {
> diff --git a/arch/arm/mach-omap2/devices.c b/arch/arm/mach-omap2/devices.c
> index 5b8ca68..6808251 100644
> --- a/arch/arm/mach-omap2/devices.c
> +++ b/arch/arm/mach-omap2/devices.c
> @@ -341,6 +341,9 @@ struct omap_device_pm_latency omap_mcspi_latency[] = {
>        },
>  };
>
> +extern int mcspi3_cs_gpios[4];
> +extern int mcspi4_cs_gpios[4];
> +
>  static int omap_mcspi_init(struct omap_hwmod *oh, void *unused)
>  {
>        struct omap_device *od;
> @@ -369,6 +372,18 @@ static int omap_mcspi_init(struct omap_hwmod *oh, void
> *unused)
>                        return -EINVAL;
>        }
>
> +       /* HACK: Not enough time to figure out how to export cs_gpios from
> +        * board file to driver correctly */
> +       if (spi_num == 2) {
> +               // Setup McSPI3 cs_gpios
> +               pdata->num_cs = 4;
> +               pdata->cs_gpios = mcspi3_cs_gpios;
> +       } else if (spi_num == 3) {
> +               // Setup McSPI4 cs_gpios
> +               pdata->num_cs = 4;
> +               pdata->cs_gpios = mcspi4_cs_gpios;
> +       }
> +
>        spi_num++;
>        od = omap_device_build(name, spi_num, oh, pdata,
>                                sizeof(*pdata), omap_mcspi_latency,
> --
> 1.7.4.1
>
>
------------------------------------------------------------------------------
Special Offer -- Download ArcSight Logger for FREE!
Finally, a world-class log management solution at an even better 
price-free! And you'll get a free "Love Thy Logs" t-shirt when you
download Logger. Secure your free ArcSight Logger TODAY!
http://p.sf.net/sfu/arcsisghtdev2dev
