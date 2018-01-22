From: Ladislav Michl <ladis@linux-mips.org>
Subject: Re: [PATCH 2/3] pwm: pwm-omap-dmtimer: Fix frequency when using
 prescaler
Date: Mon, 22 Jan 2018 11:53:31 +0100
Message-ID: <20180122105331.GA21159@lenoch>
References: <20180117214629.GA11952@lenoch>
 <20180117214737.GC11952@lenoch>
 <3e00e721-984c-e8db-49f7-046d7b335404@microchip.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pwm-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <3e00e721-984c-e8db-49f7-046d7b335404@microchip.com>
Sender: linux-pwm-owner@vger.kernel.org
To: Claudiu Beznea <Claudiu.Beznea@microchip.com>
Cc: linux-omap@vger.kernel.org, linux-pwm@vger.kernel.org, Keerthy <j-keerthy@ti.com>, daniel.lezcano@linaro.org, thierry.reding@gmail.com, tony@atomide.com, aaro.koskinen@iki.fi, narmstrong@baylibre.com, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, sebastian.reichel@collabora.co.uk, robh+dt@kernel.org, t-kristo@ti.com, grygorii.strashko@ti.com
List-Id: linux-omap@vger.kernel.org

Dear Claudiu,

On Mon, Jan 22, 2018 at 11:17:08AM +0200, Claudiu Beznea wrote:
> On 17.01.2018 23:47, Ladislav Michl wrote:
> > @@ -334,18 +348,18 @@ static int pwm_omap_dmtimer_probe(struct platform_device *pdev)
> >  
> >  	mutex_init(&omap->mutex);
> >  
> > -	status = pwmchip_add(&omap->chip);
> > -	if (status < 0) {
> > +	ret = pwmchip_add(&omap->chip);
> > +	if (ret < 0) {
> >  		dev_err(&pdev->dev, "failed to register PWM\n");
> > -		omap->pdata->free(omap->dm_timer);
> > -		ret = status;
> > -		goto put;
> > +		goto free;
> >  	}
> >  
> >  	platform_set_drvdata(pdev, omap);
> >From documentation: "of_parse_phandle(): Returns the device_node pointer with refcount
> incremented. Use of_node_put() on it when done."
> In case of success the of_node_put() should also be called as I see.

Based on you previous suggestions found here:
https://patchwork.kernel.org/patch/10140209/
I'd say this fix belongs to patch which introduces of_node_put() in the error
path. I'll then rebase this patches on top of the fix.

Thank you,
	ladis
