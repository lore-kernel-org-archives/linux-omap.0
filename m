From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: Re: [PATCH] dmaengine: edma: fix build without CONFIG_OF
Date: Wed, 4 Nov 2015 09:42:35 +0200
Message-ID: <5639B6EB.8030101@ti.com>
References: <17811472.bY8CqmdEVy@wuerfel>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <17811472.bY8CqmdEVy@wuerfel>
Sender: linux-kernel-owner@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>, Vinod Koul <vinod.koul@intel.com>, dmaengine@vger.kernel.org
Cc: Dan Williams <dan.j.williams@intel.com>, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Sekhar Nori <nsekhar@ti.com>, Kevin Hilman <khilman@deeprootsystems.com>, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

On 11/03/2015 04:00 PM, Arnd Bergmann wrote:
> During the edma rework, a build error was introduced for the
> case that CONFIG_OF is disabled:
>=20
> drivers/built-in.o: In function `edma_tc_set_pm_state':
> :(.text+0x43bf0): undefined reference to `of_find_device_by_node'
>=20
> As the edma_tc_set_pm_state() function does nothing in case
> we are running without OF, this adds an IS_ENABLED() check
> that turns the function into an empty stub then and avoids the
> link error.
>=20
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> Fixes: ca304fa9bb76 ("ARM/dmaengine: edma: Public API to use private =
struct pointer")

The actual commit this patch is fixing is:
1be5336bc7ba dmaengine: edma: New device tree binding

> ---
> Found on ARM randconfig builds with today's linux-next

I have sanity built the kernel with omap2plus_defconfig and
davinci_all_defconfig since eDMA is used by these platforms and did not=
 faced
with this issue, as obviously these defconfigs will result OF to be ena=
bled.

> diff --git a/drivers/dma/edma.c b/drivers/dma/edma.c
> index 31722d436a42..16713a93da10 100644
> --- a/drivers/dma/edma.c
> +++ b/drivers/dma/edma.c
> @@ -1560,7 +1560,7 @@ static void edma_tc_set_pm_state(struct edma_tc=
 *tc, bool enable)
>  	struct platform_device *tc_pdev;
>  	int ret;
> =20
> -	if (!tc)
> +	if (!IS_ENABLED(CONFIG_OF) || !tc)
>  		return;

Should we instead put the function inside of:
#if IS_ENABLED(CONFIG_OF)
static void edma_tc_set_pm_state(struct edma_tc *tc, bool enable)
{
=2E..
}
#else
static inline void edma_tc_set_pm_state(struct edma_tc *tc, bool enable=
)
{
}
#endif /* IS_ENABLED(CONFIG_OF) */


> =20
>  	tc_pdev =3D of_find_device_by_node(tc->node);
>=20

--=20
P=E9ter
