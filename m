From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: Re: [PATCH] ARM: OMAP: fix return value check in beagle_opp_init()
Date: Mon, 01 Oct 2012 16:00:40 -0700
Message-ID: <87d311er1j.fsf@deeprootsystems.com>
References: <CAPgLHd9aJUYX_a7_iXLi5r6VEVuB0W15G9Ryw2bVzNzko2NpBA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <CAPgLHd9aJUYX_a7_iXLi5r6VEVuB0W15G9Ryw2bVzNzko2NpBA@mail.gmail.com>
 (Wei Yongjun's message of "Fri, 21 Sep 2012 14:26:37 +0800")
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.infradead.org
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Wei Yongjun <weiyj.lk@gmail.com>
Cc: tony@atomide.com, yongjun_wei@trendmicro.com.cn, linux-omap@vger.kernel.org, linux@arm.linux.org.uk, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

Wei Yongjun <weiyj.lk@gmail.com> writes:

> From: Wei Yongjun <yongjun_wei@trendmicro.com.cn>
>
> In case of error, the function omap_device_get_by_hwmod_name()
> returns ERR_PTR() not NULL pointer. The NULL test in the return
> value check should be replaced with IS_ERR().
>
> dpatch engine is used to auto generated this patch.
> (https://github.com/weiyj/dpatch)
>
> Signed-off-by: Wei Yongjun <yongjun_wei@trendmicro.com.cn>

Acked-by: Kevin Hilman <khilman@ti.com>

> ---
>  arch/arm/mach-omap2/board-omap3beagle.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/arch/arm/mach-omap2/board-omap3beagle.c b/arch/arm/mach-omap2/board-omap3beagle.c
> index 6202fc7..a548d70 100644
> --- a/arch/arm/mach-omap2/board-omap3beagle.c
> +++ b/arch/arm/mach-omap2/board-omap3beagle.c
> @@ -466,7 +466,7 @@ static void __init beagle_opp_init(void)
>  		mpu_dev = omap_device_get_by_hwmod_name("mpu");
>  		iva_dev = omap_device_get_by_hwmod_name("iva");
>  
> -		if (!mpu_dev || !iva_dev) {
> +		if (IS_ERR(mpu_dev) || IS_ERR(iva_dev)) {
>  			pr_err("%s: Aiee.. no mpu/dsp devices? %p %p\n",
>  				__func__, mpu_dev, iva_dev);
>  			return;
>
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
