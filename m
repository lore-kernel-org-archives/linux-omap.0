From: YueHaibing <yuehaibing@huawei.com>
Subject: Re: [PATCH v2 net-next] net: ethernet: ti: cpsw: Fix inconsistent
 IS_ERR and PTR_ERR in cpsw_probe()
Date: Tue, 30 Apr 2019 09:33:16 +0800
Message-ID: <a2766de6-d0cd-d840-2546-33ce0b388585@huawei.com>
References: <20190429135650.72794-1-yuehaibing@huawei.com>
 <20190429143157.79035-1-yuehaibing@huawei.com>
 <alpine.DEB.2.21.1904291228000.2444@hadrien>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Return-path: <netdev-owner@vger.kernel.org>
In-Reply-To: <alpine.DEB.2.21.1904291228000.2444@hadrien>
Sender: netdev-owner@vger.kernel.org
To: Julia Lawall <julia.lawall@lip6.fr>
Cc: Grygorii Strashko <grygorii.strashko@ti.com>, Ivan Khoronzhuk <ivan.khoronzhuk@linaro.org>, Andrew Lunn <andrew@lunn.ch>, Ilias Apalodimas <ilias.apalodimas@linaro.org>, linux-omap@vger.kernel.org, netdev@vger.kernel.org, kernel-janitors@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

On 2019/4/30 0:30, Julia Lawall wrote:
> 
> 
> On Mon, 29 Apr 2019, YueHaibing wrote:
> 
>> Change the call to PTR_ERR to access the value just tested by IS_ERR.
> 
> I assume you didn't find the problem just looking through the code by
> hand.  If you used a tool, it would be really good to acknowledge the tool
> that was used.  The tools don't come for free, and you don't pay for them.
> The only payment that you can offer is to acknowledge that the tool was
> used, which helps justify that the tool is useful and what it is useful
> for.

Sorry, I forgot edit the commit log and add this info.

It was detected by Coccinelle, I will add this and resend.

> 
> julia
> 
>>
>> Fixes: 83a8471ba255 ("net: ethernet: ti: cpsw: refactor probe to group common hw initialization")
>> Signed-off-by: YueHaibing <yuehaibing@huawei.com>
>> Reviewed-by: Andrew Lunn <andrew@lunn.ch>
>> ---
>> v2: add Fixes tag
>> ---
>>  drivers/net/ethernet/ti/cpsw.c | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/net/ethernet/ti/cpsw.c b/drivers/net/ethernet/ti/cpsw.c
>> index c3cba46fac9d..e37680654a13 100644
>> --- a/drivers/net/ethernet/ti/cpsw.c
>> +++ b/drivers/net/ethernet/ti/cpsw.c
>> @@ -2381,7 +2381,7 @@ static int cpsw_probe(struct platform_device *pdev)
>>
>>  	clk = devm_clk_get(dev, "fck");
>>  	if (IS_ERR(clk)) {
>> -		ret = PTR_ERR(mode);
>> +		ret = PTR_ERR(clk);
>>  		dev_err(dev, "fck is not found %d\n", ret);
>>  		return ret;
>>  	}
>>
>>
>>
>>
> 
> .
> 
