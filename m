From: Keerthy <j-keerthy@ti.com>
Subject: Re: [PATCH 2/3] pwm: pwm-omap-dmtimer: Fix frequency when using
 prescaler
Date: Wed, 24 Jan 2018 11:19:46 +0530
Message-ID: <618f9f28-f655-6d50-5a51-f25ebbb87a54@ti.com>
References: <20180117214629.GA11952@lenoch> <20180117214737.GC11952@lenoch>
 <3e00e721-984c-e8db-49f7-046d7b335404@microchip.com>
 <20180122105331.GA21159@lenoch> <cc075969-872e-1ec1-a854-2e19f2c952fe@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <cc075969-872e-1ec1-a854-2e19f2c952fe@ti.com>
Content-Language: en-US
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Ladislav Michl <ladis@linux-mips.org>, Claudiu Beznea <Claudiu.Beznea@microchip.com>
Cc: linux-pwm@vger.kernel.org, grygorii.strashko@ti.com, aaro.koskinen@iki.fi, tony@atomide.com, t-kristo@ti.com, daniel.lezcano@linaro.org, linux-kernel@vger.kernel.org, robh+dt@kernel.org, narmstrong@baylibre.com, thierry.reding@gmail.com, sebastian.reichel@collabora.co.uk, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org



On Wednesday 24 January 2018 10:56 AM, Keerthy wrote:
> 
> 
> On Monday 22 January 2018 04:23 PM, Ladislav Michl wrote:
>> Dear Claudiu,
>>
>> On Mon, Jan 22, 2018 at 11:17:08AM +0200, Claudiu Beznea wrote:
>>> On 17.01.2018 23:47, Ladislav Michl wrote:
>>>> @@ -334,18 +348,18 @@ static int pwm_omap_dmtimer_probe(struct platform_device *pdev)
>>>>  
>>>>  	mutex_init(&omap->mutex);
>>>>  
>>>> -	status = pwmchip_add(&omap->chip);
>>>> -	if (status < 0) {
>>>> +	ret = pwmchip_add(&omap->chip);
>>>> +	if (ret < 0) {
>>>>  		dev_err(&pdev->dev, "failed to register PWM\n");
>>>> -		omap->pdata->free(omap->dm_timer);
>>>> -		ret = status;
>>>> -		goto put;
>>>> +		goto free;
>>>>  	}
>>>>  
>>>>  	platform_set_drvdata(pdev, omap);
>>> >From documentation: "of_parse_phandle(): Returns the device_node pointer with refcount
>>> incremented. Use of_node_put() on it when done."
>>> In case of success the of_node_put() should also be called as I see.
>>
>> Based on you previous suggestions found here:
>> https://patchwork.kernel.org/patch/10140209/
>> I'd say this fix belongs to patch which introduces of_node_put() in the error
>> path. I'll then rebase this patches on top of the fix.
> 
> Agreed. I missed the success path as i assumed only error paths needed
> te of_node_put(). I will post v8 of this patch alone as other patches
> can be left untouched. Hope that is okay.

Ladis,

I posted v8 of the above mentioned patch alone.

https://marc.info/?l=linux-omap&m=151677273619960&w=2

Thanks,
Keerthy
> 
> Regards,
> Keerthy
>>
>> Thank you,
>> 	ladis
>>
