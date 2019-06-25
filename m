From: keerthy <j-keerthy@ti.com>
Subject: Re: [PATCH V2] net: ethernet: ti: cpsw: Fix suspend/resume break
Date: Tue, 25 Jun 2019 15:34:41 +0530
Message-ID: <e8e07695-d3dc-6a67-aede-a84d6cd3dbcc@ti.com>
References: <20190624051619.20146-1-j-keerthy@ti.com>
 <20190624.072333.2300932810459542260.davem@davemloft.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190624.072333.2300932810459542260.davem@davemloft.net>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: David Miller <davem@davemloft.net>
Cc: ivan.khoronzhuk@linaro.org, andrew@lunn.ch, ilias.apalodimas@linaro.org, linux-kernel@vger.kernel.org, netdev@vger.kernel.org, linux-omap@vger.kernel.org, t-kristo@ti.com, grygorii.strashko@ti.com, nsekhar@ti.com
List-Id: linux-omap@vger.kernel.org



On 6/24/2019 7:53 PM, David Miller wrote:
> From: Keerthy <j-keerthy@ti.com>
> Date: Mon, 24 Jun 2019 10:46:19 +0530
> 
>> Commit bfe59032bd6127ee190edb30be9381a01765b958 ("net: ethernet:
>> ti: cpsw: use cpsw as drv data")changes
>> the driver data to struct cpsw_common *cpsw. This is done
>> only in probe/remove but the suspend/resume functions are
>> still left with struct net_device *ndev. Hence fix both
>> suspend & resume also to fetch the updated driver data.
>>
>> Fixes: bfe59032bd6127ee1 ("net: ethernet: ti: cpsw: use cpsw as drv data")
>> Signed-off-by: Keerthy <j-keerthy@ti.com>
> 
> Applied but please make it clear that changes are targetting net-next in the
> future by saying "[PATCH net-next v2] ...." in your Subject line.

Sure will do that. Thanks.

> 
> Thank you.
> 
