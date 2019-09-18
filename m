From: Grygorii Strashko <grygorii.strashko@ti.com>
Subject: Re: [PATCH net-next] net: ethernet: ti: use
 devm_platform_ioremap_resource() to simplify code
Date: Wed, 18 Sep 2019 12:29:15 +0300
Message-ID: <12c00786-980f-5761-3117-3e741e63d7b3@ti.com>
References: <20190821124850.9592-1-yuehaibing@huawei.com>
 <CAMuHMdXdd4oiHqTpFTYBTSeCB6A78_gSGmwPy5EgPRZXibOqZw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAMuHMdXdd4oiHqTpFTYBTSeCB6A78_gSGmwPy5EgPRZXibOqZw@mail.gmail.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Geert Uytterhoeven <geert@linux-m68k.org>, YueHaibing <yuehaibing@huawei.com>
Cc: "David S. Miller" <davem@davemloft.net>, ivan.khoronzhuk@linaro.org, Andrew Lunn <andrew@lunn.ch>, =?UTF-8?Q?Petr_=c5=a0tetiar?= <ynezz@true.cz>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, netdev <netdev@vger.kernel.org>, "open list:TI ETHERNET SWITCH DRIVER (CPSW)" <linux-omap@vger.kernel.org>
List-Id: linux-omap@vger.kernel.org



On 17/09/2019 21:35, Geert Uytterhoeven wrote:
> Hi YueHaibing,
> 
> On Wed, Aug 21, 2019 at 2:51 PM YueHaibing <yuehaibing@huawei.com> wrote:
>> Use devm_platform_ioremap_resource() to simplify the code a bit.
>> This is detected by coccinelle.
>>
>> Reported-by: Hulk Robot <hulkci@huawei.com>
>> Signed-off-by: YueHaibing <yuehaibing@huawei.com>
>> ---
>>   drivers/net/ethernet/ti/cpsw.c | 5 ++---
>>   1 file changed, 2 insertions(+), 3 deletions(-)
>>
>> diff --git a/drivers/net/ethernet/ti/cpsw.c b/drivers/net/ethernet/ti/cpsw.c
>> index 32a8974..5401095 100644
>> --- a/drivers/net/ethernet/ti/cpsw.c
>> +++ b/drivers/net/ethernet/ti/cpsw.c
>> @@ -2764,7 +2764,7 @@ static int cpsw_probe(struct platform_device *pdev)
>>          struct net_device               *ndev;
>>          struct cpsw_priv                *priv;
>>          void __iomem                    *ss_regs;
>> -       struct resource                 *res, *ss_res;
>> +       struct resource                 *ss_res;
>>          struct gpio_descs               *mode;
>>          const struct soc_device_attribute *soc;
>>          struct cpsw_common              *cpsw;
>> @@ -2798,8 +2798,7 @@ static int cpsw_probe(struct platform_device *pdev)
> 
> And just out-of-context, we also have:
> 
>          ss_res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
>          ss_regs = devm_ioremap_resource(dev, ss_res);
>          if (IS_ERR(ss_regs))
> 
> which was not detected as being the same pattern?
> 
> Interesting...

ss_res is used below to determine phys address of CPPI RAM.

> 
>>                  return PTR_ERR(ss_regs);
>>          cpsw->regs = ss_regs;
>>
>> -       res = platform_get_resource(pdev, IORESOURCE_MEM, 1);
>> -       cpsw->wr_regs = devm_ioremap_resource(dev, res);
>> +       cpsw->wr_regs = devm_platform_ioremap_resource(pdev, 1);
>>          if (IS_ERR(cpsw->wr_regs))
>>                  return PTR_ERR(cpsw->wr_regs);

-- 
Best regards,
grygorii
