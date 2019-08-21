From: Grygorii Strashko <grygorii.strashko@ti.com>
Subject: Re: [PATCH net] net: cpsw: fix NULL pointer exception in the probe
 error path
Date: Wed, 21 Aug 2019 18:02:07 +0300
Message-ID: <139cd66e-e8f8-0d18-a876-59e791bb8624@ti.com>
References: <20190821144123.22248-1-antoine.tenart@bootlin.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190821144123.22248-1-antoine.tenart@bootlin.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Antoine Tenart <antoine.tenart@bootlin.com>, davem@davemloft.net
Cc: netdev@vger.kernel.org, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, maxime.chevallier@bootlin.com
List-Id: linux-omap@vger.kernel.org



On 21/08/2019 17:41, Antoine Tenart wrote:
> In certain cases when the probe function fails the error path calls
> cpsw_remove_dt() before calling platform_set_drvdata(). This is an
> issue as cpsw_remove_dt() uses platform_get_drvdata() to retrieve the
> cpsw_common data and leds to a NULL pointer exception. This patches
> fixes it by calling platform_set_drvdata() earlier in the probe.
> 
> Fixes: 83a8471ba255 ("net: ethernet: ti: cpsw: refactor probe to group common hw initialization")
> Reported-by: Maxime Chevallier <maxime.chevallier@bootlin.com>
> Signed-off-by: Antoine Tenart <antoine.tenart@bootlin.com>
> ---
>   drivers/net/ethernet/ti/cpsw.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 

Thank you.
Reviewed-by: Grygorii Strashko <grygorii.strashko@ti.com>

-- 
Best regards,
grygorii
