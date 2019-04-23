From: Andrew Lunn <andrew@lunn.ch>
Subject: Re: [PATCH net-next 05/19] net: ethernet: ti: cpsw: use local var
 dev in probe
Date: Tue, 23 Apr 2019 20:40:15 +0200
Message-ID: <20190423184015.GD28405@lunn.ch>
References: <1556024950-20752-1-git-send-email-grygorii.strashko@ti.com>
 <1556024950-20752-6-git-send-email-grygorii.strashko@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1556024950-20752-6-git-send-email-grygorii.strashko@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Grygorii Strashko <grygorii.strashko@ti.com>
Cc: netdev@vger.kernel.org, Ilias Apalodimas <ilias.apalodimas@linaro.org>, "David S . Miller" <davem@davemloft.net>, Ivan Khoronzhuk <ivan.khoronzhuk@linaro.org>, Florian Fainelli <f.fainelli@gmail.com>, Sekhar Nori <nsekhar@ti.com>, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, Murali Karicheri <m-karicheri2@ti.com>
List-Id: linux-omap@vger.kernel.org

>On Tue, Apr 23, 2019 at 04:08:56PM +0300, Grygorii Strashko wrote:
> Use local variable struct device *dev in probe to simplify code.
> 
> Signed-off-by: Grygorii Strashko <grygorii.strashko@ti.com>
> ---
>  drivers/net/ethernet/ti/cpsw.c | 65 +++++++++++++++++-----------------
>  1 file changed, 33 insertions(+), 32 deletions(-)
> 
> diff --git a/drivers/net/ethernet/ti/cpsw.c b/drivers/net/ethernet/ti/cpsw.c
> index 13a339c64892..0b8cc4e6d9cd 100644
> --- a/drivers/net/ethernet/ti/cpsw.c
> +++ b/drivers/net/ethernet/ti/cpsw.c
> @@ -3458,6 +3458,7 @@ static const struct soc_device_attribute cpsw_soc_devices[] = {
>  
>  static int cpsw_probe(struct platform_device *pdev)
>  {
> +	struct device *dev = &pdev->dev;
>  	struct clk			*clk;
>  	struct cpsw_platform_data	*data;
>  	struct net_device		*ndev;

It seems odd not to keep with the column layout?
Plus it would make it reverse Christmas tree.

     Andrew
