From: Zhang Rui <rui.zhang@intel.com>
Subject: Re: [PATCH] thermal: ti-soc-thermal: clk_round_rate() can return a
 zero upon error
Date: Thu, 02 Jan 2014 10:51:08 +0800
Message-ID: <1388631068.3739.73.camel@rzhang1-mobl4>
References: <alpine.DEB.2.02.1312091803260.4127@tamien>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
In-Reply-To: <alpine.DEB.2.02.1312091803260.4127@tamien>
Sender: linux-pm-owner@vger.kernel.org
To: Paul Walmsley <pwalmsley@nvidia.com>
Cc: Eduardo Valentin <eduardo.valentin@ti.com>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

On Mon, 2013-12-09 at 18:09 -0800, Paul Walmsley wrote:
> Treat both negative and zero return values from clk_round_rate() as
> errors.  This is needed since subsequent patches will convert
> clk_round_rate()'s return value to be an unsigned type, rather than a
> signed type, since some clock sources can generate rates higher than
> (2^31)-1 Hz.
> 
> Eventually, when calling clk_round_rate(), only a return value of zero
> will be considered a error.  All other values will be considered valid
> rates.  The comparison against values less than 0 is kept to preserve
> the correct behavior in the meantime.
> 
> This patch also gets rid of a comparison between unsigned and signed 
> values; a side-benefit.
> 
> Signed-off-by: Paul Walmsley <pwalmsley@nvidia.com>
> Cc: Eduardo Valentin <eduardo.valentin@ti.com>
> Cc: Zhang Rui <rui.zhang@intel.com>

Eduardo,

will you take this patch?

thanks,
rui
> ---
> Applies on v3.13-rc3.  See also:
> 
> http://marc.info/?l=linux-arm-kernel&m=138542591313620&w=2
> 
>   drivers/thermal/ti-soc-thermal/ti-bandgap.c |    2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/thermal/ti-soc-thermal/ti-bandgap.c b/drivers/thermal/ti-soc-thermal/ti-bandgap.c
> index 74c0e3474d6e..8fe46dbc0c6f 100644
> --- a/drivers/thermal/ti-soc-thermal/ti-bandgap.c
> +++ b/drivers/thermal/ti-soc-thermal/ti-bandgap.c
> @@ -1248,7 +1248,7 @@ int ti_bandgap_probe(struct platform_device *pdev)
>   	clk_rate = clk_round_rate(bgp->div_clk,
>   				  bgp->conf->sensors[0].ts_data->max_freq);
>   	if (clk_rate < bgp->conf->sensors[0].ts_data->min_freq ||
> -	    clk_rate == 0xffffffff) {
> +	    clk_rate <= 0) {
>   		ret = -ENODEV;
>   		dev_err(&pdev->dev, "wrong clock rate (%d)\n", clk_rate);
>   		goto put_clks;


