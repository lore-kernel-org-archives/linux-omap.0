From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] pwm-omap: handle timers not ready in probe
Date: Mon, 16 Jul 2018 00:57:40 -0700
Message-ID: <20180716075740.GT99251@atomide.com>
References: <20180709081534.GA6799@amd>
 <20180709214910.tes6u4ivxomd3aja@earth.universe>
 <20180709220211.GA7760@amd>
 <20180710101147.lyu65ro4czvrs2da@earth.universe>
 <20180710133040.GA4391@amd>
 <20180710161123.azym6sbboriuj4yc@earth.universe>
 <20180711080218.GA21225@amd>
 <20180711132739.GL99251@atomide.com>
 <20180711142526.dto6iost57zx5t5l@earth.universe>
 <20180716071323.GB23110@amd>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20180716071323.GB23110@amd>
Sender: linux-kernel-owner@vger.kernel.org
To: Pavel Machek <pavel@ucw.cz>
Cc: Sebastian Reichel <sre@kernel.org>, kernel list <linux-kernel@vger.kernel.org>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, linux-omap@vger.kernel.org, nekit1000@gmail.com, mpartap@gmx.net, merlijn@wizzup.org
List-Id: linux-omap@vger.kernel.org

* Pavel Machek <pavel@ucw.cz> [180716 07:16]:
> 
> When all the drivers are built-in, timers are not ready and probing
> fails. Fix that with -EPROBE_DEFFER.
> 
> Signed-off-by: Pavel Machek <pavel@ucw.cz>
> 
> diff --git a/drivers/pwm/pwm-omap-dmtimer.c b/drivers/pwm/pwm-omap-dmtimer.c
> index 665da3c..debeb70 100644
> --- a/drivers/pwm/pwm-omap-dmtimer.c
> +++ b/drivers/pwm/pwm-omap-dmtimer.c
> @@ -265,7 +271,7 @@ static int pwm_omap_dmtimer_probe(struct platform_device *pdev)
>  	timer_pdata = dev_get_platdata(&timer_pdev->dev);
>  	if (!timer_pdata) {
>  		dev_err(&pdev->dev, "dmtimer pdata structure NULL\n");
> -		ret = -EINVAL;
> +		ret = -EPROBE_DEFER;
>  		goto put;
>  	}

There seems to be an earlier similar patch, care to take a look
at "[PATCH] pwm: pwm-omap-dmtimer: return -EPROBE_DEFER if no
dmtimer platform data"?

Regards,

Tony
