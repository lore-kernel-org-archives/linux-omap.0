From: Santosh Shilimkar <santosh.shilimkar@ti.com>
Subject: Re: [PATCH v3 5/5] drivers: bus: omap_l3: Change pr_crit() to dev_err()
 when IRQ request fails
Date: Thu, 13 Mar 2014 05:05:03 +0800
Message-ID: <5320CBFF.3000909@ti.com>
References: <1393937293-6036-1-git-send-email-peter.ujfalusi@ti.com> <1393937293-6036-6-git-send-email-peter.ujfalusi@ti.com> <5315E522.9090606@ti.com> <5316CE17.6010201@ti.com> <20140312172854.GD30897@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20140312172854.GD30897@atomide.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>, Peter Ujfalusi <peter.ujfalusi@ti.com>
Cc: Olof Johansson <olof@lixom.net>, Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

On Thursday 13 March 2014 01:28 AM, Tony Lindgren wrote:
> * Peter Ujfalusi <peter.ujfalusi@ti.com> [140304 23:14]:
>> On 03/04/2014 04:37 PM, Santosh Shilimkar wrote:
>>> On Tuesday 04 March 2014 08:48 PM, Peter Ujfalusi wrote:
>>>> Use dev_err() which will going to print the driver's name as well and the
>>>> KERN_ERR level is sufficient in this case (we also print via dev_err when
>>>> there is an error with the mem resources)
>>>>
>>>> Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
>>>> Reviewed-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
>>>> ---
>>>>  drivers/bus/omap_l3_noc.c | 7 +++----
>>>>  1 file changed, 3 insertions(+), 4 deletions(-)
>>>>
>>>> diff --git a/drivers/bus/omap_l3_noc.c b/drivers/bus/omap_l3_noc.c
>>>> index 0eff48585ae3..972691a668a3 100644
>>>> --- a/drivers/bus/omap_l3_noc.c
>>>> +++ b/drivers/bus/omap_l3_noc.c
>>>> @@ -158,8 +158,8 @@ static int omap4_l3_probe(struct platform_device *pdev)
>>>>  	ret = devm_request_irq(&pdev->dev, l3->debug_irq, l3_interrupt_handler,
>>>>  			       IRQF_DISABLED, "l3-dbg-irq", l3);
>>>>  	if (ret) {
>>>> -		pr_crit("L3: request_irq failed to register for 0x%x\n",
>>>> -						l3->debug_irq);
>>>> +		dev_err(&pdev->dev, "request_irq failed for %d\n",
>>>> +			l3->debug_irq);
>>>>  		return ret;
>>>>  	}
>>>>  
>>>> @@ -167,8 +167,7 @@ static int omap4_l3_probe(struct platform_device *pdev)
>>>>  	ret = devm_request_irq(&pdev->dev, l3->app_irq, l3_interrupt_handler,
>>>>  			       IRQF_DISABLED, "l3-app-irq", l3);
>>>>  	if (ret)
>>>> -		pr_crit("L3: request_irq failed to register for 0x%x\n",
>>>> -						l3->app_irq);
>>>> +		dev_err(&pdev->dev, "request_irq failed for %d\n", l3->app_irq);
>>>>  
>>>>  	return ret;
>>>>  }
>>>>
>>> So this one change in the log level. If I look at now, may be dev_err
>>> is fine but the change is not same.
>>
>> Not sure what you mean by 'the change is not same'?
>> I just picked the old series and rebased it on linux-next, the patch is the
>> same as it was back in May 2013:
>> https://lkml.org/lkml/2013/5/2/205
>>
>> And yes, I have shortened the texts in the print, but the meaning of the
>> prints have not changed.
> 
> Santosh, got any more comments on this series?
> 
Nope. looks good
