From: Keerthy <j-keerthy@ti.com>
Subject: Re: [PATCH v5 7/8] pwm: pwm-omap-dmtimer: Adapt driver to utilize
 dmtimer pdata ops
Date: Mon, 18 Dec 2017 18:25:25 +0530
Message-ID: <e215a5e3-f729-1de4-2837-24c4a0120114@ti.com>
References: <1513059137-21593-1-git-send-email-j-keerthy@ti.com>
 <1513059137-21593-8-git-send-email-j-keerthy@ti.com>
 <20171218093153.GA22729@lenoch>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20171218093153.GA22729@lenoch>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Ladislav Michl <ladis@linux-mips.org>
Cc: daniel.lezcano@linaro.org, tony@atomide.com, aaro.koskinen@iki.fi, thierry.reding@gmail.com, grygorii.strashko@ti.com, linux-omap@vger.kernel.org, robh+dt@kernel.org, linux-arm-kernel@lists.infradead.org, linux-pwm@vger.kernel.org, sebastian.reichel@collabora.co.uk, linux-kernel@vger.kernel.org, t-kristo@ti.com, linux@armlinux.org.uk
List-Id: linux-omap@vger.kernel.org



On Monday 18 December 2017 03:01 PM, Ladislav Michl wrote:
> Keerthy,
> 
> On Tue, Dec 12, 2017 at 11:42:16AM +0530, Keerthy wrote:
>> Adapt driver to utilize dmtimer pdata ops instead of pdata-quirks.
>>
>> Signed-off-by: Keerthy <j-keerthy@ti.com>
>> ---
>>
>> Changes in v4:
>>
>>   * Switched to dev_get_platdata.
> 
> Where do you expect dev.platform_data to be set? PWM driver is failing
> with:
> omap-dmtimer-pwm dmtimer-pwm: dmtimer pdata structure NULL
> omap-dmtimer-pwm: probe of dmtimer-pwm failed with error -22
> 
> Which I fixed with patch bellow, to be able to test your patchset.

Thanks! I will make the below patch part of my series.

> 
> Also I'm running a bit out of time, so I'll send few clean up
> patches and event capture code to get some feedback early.
> 
> Regards,
> 	ladis
> 
> diff --git a/drivers/clocksource/timer-dm.c b/drivers/clocksource/timer-dm.c
> index 39be39e6a8dd..d3d8a49cae0d 100644
> --- a/drivers/clocksource/timer-dm.c
> +++ b/drivers/clocksource/timer-dm.c
> @@ -773,6 +773,7 @@ static int omap_dm_timer_probe(struct platform_device *pdev)
>  		dev_err(dev, "%s: no platform data.\n", __func__);
>  		return -ENODEV;
>  	}
> +	dev->platform_data = pdata;
>  
>  	irq = platform_get_resource(pdev, IORESOURCE_IRQ, 0);
>  	if (unlikely(!irq)) {
> 
>>
>> Changes in v3:
>>
>>   * Used of_find_platdata_by_node function to fetch platform
>>     data for timer node.
>>
>>  drivers/pwm/pwm-omap-dmtimer.c | 39 ++++++++++++++++++++++-----------------
>>  1 file changed, 22 insertions(+), 17 deletions(-)
