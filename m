From: YueHaibing <yuehaibing@huawei.com>
Subject: Re: [PATCH net-next] net: ethernet: ti: cpsw: Fix inconsistent IS_ERR
 and PTR_ERR in cpsw_probe()
Date: Mon, 29 Apr 2019 22:17:48 +0800
Message-ID: <f3b8d542-9ba6-d867-4979-530b53a395d5@huawei.com>
References: <20190429135650.72794-1-yuehaibing@huawei.com>
 <20190429135603.GI10772@lunn.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Return-path: <netdev-owner@vger.kernel.org>
In-Reply-To: <20190429135603.GI10772@lunn.ch>
Sender: netdev-owner@vger.kernel.org
To: Andrew Lunn <andrew@lunn.ch>
Cc: Grygorii Strashko <grygorii.strashko@ti.com>, Ivan Khoronzhuk <ivan.khoronzhuk@linaro.org>, Ilias Apalodimas <ilias.apalodimas@linaro.org>, linux-omap@vger.kernel.org, netdev@vger.kernel.org, kernel-janitors@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

On 2019/4/29 21:56, Andrew Lunn wrote:
> On Mon, Apr 29, 2019 at 01:56:50PM +0000, YueHaibing wrote:
>> Change the call to PTR_ERR to access the value just tested by IS_ERR.
>>
>> Signed-off-by: YueHaibing <yuehaibing@huawei.com>
> 
> Please could you add a Fixes: tag.
> 

Ok, will sendv2, thanks!

> Reviewed-by: Andrew Lunn <andrew@lunn.ch>
> 
>     Andrew
> 
> .
> 
