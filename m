From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: Re: [PATCH v3 5/5] drivers: bus: omap_l3: Change pr_crit() to dev_err()
 when IRQ request fails
Date: Wed, 5 Mar 2014 09:11:19 +0200
Message-ID: <5316CE17.6010201@ti.com>
References: <1393937293-6036-1-git-send-email-peter.ujfalusi@ti.com> <1393937293-6036-6-git-send-email-peter.ujfalusi@ti.com> <5315E522.9090606@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <5315E522.9090606@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Santosh Shilimkar <santosh.shilimkar@ti.com>, Tony Lindgren <tony@atomide.com>
Cc: Olof Johansson <olof@lixom.net>, Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

On 03/04/2014 04:37 PM, Santosh Shilimkar wrote:
> On Tuesday 04 March 2014 08:48 PM, Peter Ujfalusi wrote:
>> Use dev_err() which will going to print the driver's name as well an=
d the
>> KERN_ERR level is sufficient in this case (we also print via dev_err=
 when
>> there is an error with the mem resources)
>>
>> Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
>> Reviewed-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
>> ---
>>  drivers/bus/omap_l3_noc.c | 7 +++----
>>  1 file changed, 3 insertions(+), 4 deletions(-)
>>
>> diff --git a/drivers/bus/omap_l3_noc.c b/drivers/bus/omap_l3_noc.c
>> index 0eff48585ae3..972691a668a3 100644
>> --- a/drivers/bus/omap_l3_noc.c
>> +++ b/drivers/bus/omap_l3_noc.c
>> @@ -158,8 +158,8 @@ static int omap4_l3_probe(struct platform_device=
 *pdev)
>>  	ret =3D devm_request_irq(&pdev->dev, l3->debug_irq, l3_interrupt_h=
andler,
>>  			       IRQF_DISABLED, "l3-dbg-irq", l3);
>>  	if (ret) {
>> -		pr_crit("L3: request_irq failed to register for 0x%x\n",
>> -						l3->debug_irq);
>> +		dev_err(&pdev->dev, "request_irq failed for %d\n",
>> +			l3->debug_irq);
>>  		return ret;
>>  	}
>> =20
>> @@ -167,8 +167,7 @@ static int omap4_l3_probe(struct platform_device=
 *pdev)
>>  	ret =3D devm_request_irq(&pdev->dev, l3->app_irq, l3_interrupt_han=
dler,
>>  			       IRQF_DISABLED, "l3-app-irq", l3);
>>  	if (ret)
>> -		pr_crit("L3: request_irq failed to register for 0x%x\n",
>> -						l3->app_irq);
>> +		dev_err(&pdev->dev, "request_irq failed for %d\n", l3->app_irq);
>> =20
>>  	return ret;
>>  }
>>
> So this one change in the log level. If I look at now, may be dev_err
> is fine but the change is not same.

Not sure what you mean by 'the change is not same'?
I just picked the old series and rebased it on linux-next, the patch is=
 the
same as it was back in May 2013:
https://lkml.org/lkml/2013/5/2/205

And yes, I have shortened the texts in the print, but the meaning of th=
e
prints have not changed.

> Apart from above comment, rest of the series looks fine to me.
> Feel free to add my ack...

Thanks.

--=20
P=E9ter
