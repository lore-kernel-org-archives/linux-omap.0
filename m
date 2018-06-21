From: Grygorii Strashko <grygorii.strashko@ti.com>
Subject: Re: [PATCH] net: ethernet: ti: davinci_cpdma: make function
 cpdma_desc_pool_create static
Date: Thu, 21 Jun 2018 12:22:32 -0500
Message-ID: <187d0436-0b04-dd9e-98bd-3cb812fa8bd6@ti.com>
References: <20180621171645.29734-1-colin.king@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180621171645.29734-1-colin.king@canonical.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Colin King <colin.king@canonical.com>, "David S . Miller" <davem@davemloft.net>, Florian Fainelli <f.fainelli@gmail.com>, Ivan Khoronzhuk <ivan.khoronzhuk@linaro.org>, linux-omap@vger.kernel.org, netdev@vger.kernel.orgnetdev@vger.kernel.org
Cc: kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

Please, add netdev@vger.kernel.org for the future

On 06/21/2018 12:16 PM, Colin King wrote:
> From: Colin Ian King <colin.king@canonical.com>
> 
> The function cpdma_desc_pool_create is local to the source and does not
> need to be in global scope, so make it static.
> 
> Cleans up sparse warning:
> warning: symbol 'cpdma_desc_pool_create' was not declared. Should it
> be static?
> 
> Signed-off-by: Colin Ian King <colin.king@canonical.com>
> ---
>   drivers/net/ethernet/ti/davinci_cpdma.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/net/ethernet/ti/davinci_cpdma.c b/drivers/net/ethernet/ti/davinci_cpdma.c
> index cdbddf16dd29..4f1267477aa4 100644
> --- a/drivers/net/ethernet/ti/davinci_cpdma.c
> +++ b/drivers/net/ethernet/ti/davinci_cpdma.c
> @@ -205,7 +205,7 @@ static void cpdma_desc_pool_destroy(struct cpdma_ctlr *ctlr)
>    * devices (e.g. cpsw switches) use plain old memory.  Descriptor pools
>    * abstract out these details
>    */
> -int cpdma_desc_pool_create(struct cpdma_ctlr *ctlr)
> +static int cpdma_desc_pool_create(struct cpdma_ctlr *ctlr)
>   {
>   	struct cpdma_params *cpdma_params = &ctlr->params;
>   	struct cpdma_desc_pool *pool;
> 

Reviewed-by: Grygorii Strashko <grygorii.strashko@ti.com>

-- 
regards,
-grygorii
