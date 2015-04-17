From: Michael Welling <mwelling@ieee.org>
Subject: Re: AM335x OMAP2 common clock external fixed-clock registration
Date: Fri, 17 Apr 2015 11:59:08 -0500
Message-ID: <20150417165908.GA23647@deathray>
References: <20150415194707.GA11007@deathray>
 <CAPtuhTggHctp5ArGPEuKn2GuPzb-WnKv2_CzPrHzq8hwOR5Aqw@mail.gmail.com>
 <20150415205136.GA3399@deathray>
 <552F3B60.8050703@ti.com>
 <20150416161756.GA27590@deathray>
 <55301D7F.30708@gmail.com>
 <20150416220918.GA6057@deathray>
 <55304486.5020404@gmail.com>
 <20150417020048.GA27174@deathray>
 <5530CE63.9070508@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <5530CE63.9070508@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
Cc: Tero Kristo <t-kristo@ti.com>, Mike Turquette <mturquette@linaro.org>, Stephen Boyd <sboyd@codeaurora.org>, Linux OMAP Mailing List <linux-omap@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, Russell King <linux@arm.linux.org.uk>, devicetree <devicetree@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Tony Lindgren <tony@atomide.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Daniel Mack <daniel@zonque.org>
List-Id: linux-omap@vger.kernel.org

On Fri, Apr 17, 2015 at 11:12:03AM +0200, Sebastian Hesselbarth wrote:
> On 17.04.2015 04:00, Michael Welling wrote:
> >On Fri, Apr 17, 2015 at 01:23:50AM +0200, Sebastian Hesselbarth wrote:
> >>On 17.04.2015 00:09, Michael Welling wrote:
> >>>On Thu, Apr 16, 2015 at 10:37:19PM +0200, Sebastian Hesselbarth wrote:
> >>>>On 16.04.2015 18:17, Michael Welling wrote:
> [...]
> >>>What would be the proper error path?
> >>>What cleanup is required?
> >>
> >>A proper error path would be to release any claimed resource
> >>on any error. If you look at the code, the only resources that
> >>need to be released are the two clocks in question.
> >
> >So for every error return in the probe function and in the of si5351_dt_parse
> >it needs to clk_put first right?
> 
> Not quite. The driver should clk_put() every clock that it called a
> [of_]clk_get() for. The thing is that clocks can be passed by
> platform_data and we never claim them.
>

Should the ones from the platform data be claimed?
 
> >See attached patch to see if we are on the same page.
> 
> Adding a .remove() function needs more care because of the pdata passed
> clocks. I admit that back when the driver was introduced clk_put()
> wasn't really necessary at all.
> 

Is it necessary now?

> [...]
> >>>Here is what the kernel reports with debugging off:
> >>
> >>Do you have any measurement equipment to check what is actually set?
> >
> >Yes, I have an oscilloscope here at my desk.
> >The reported numbers do not always correspond to the actual output in some
> >cases.
> 
> is "not always correspond" close or way off the requested frequency?
> 

Both.

> Stability is an issue that I am aware of. Neither the datasheet nor the
> appnote were clear about any order the clocks should be set or how long
> we should wait between changing pll/ms/clkout parameters.
>
> SiLabs suggests to configure all clocks at once and never change them
> later, at least that is what you can read from the public documents.
> The drivers you mention below can however reveal some steps that have
> to be taken care of before and after changing parameters.
> 

The drivers were not provided we wrote them and they do nothing but write
the registers with the raw values provided from the SiLab clock generator
software.

> >The ms2 output has appeared to stop working all together sometime whilest
> >testing. I may have to solder a new chip on there.
> >
> >Could misconfiguration damage the chip?
> 
> You should know that a lot of things can damage a chip and
> misconfiguration is among them, yes. I cannot tell if that
> is the cause though.
>

Well I did something to the chip.
 
> [...]
> >>Is there any way to try out a less recent kernel, let's say two or
> >>three releases before 4.0?
> >
> >Could you provide a specific version that you think has the best chances of
> >working?
> 
> My guess with 2-3 releases before 4.0 was because somewhere in between
> clk API must have switched from passing struct clk pointers to clk
> cookies.
> 
> [...]
> 
> From your patch (that you should inline next time please):
> 
> @@ -1129,11 +1130,21 @@ static int si5351_dt_parse(struct i2c_client
> *client,
>  		return -ENOMEM;
> 
>  	pdata->clk_xtal = of_clk_get(np, 0);
> -	if (!IS_ERR(pdata->clk_xtal))
> -		clk_put(pdata->clk_xtal);
> -	pdata->clk_clkin = of_clk_get(np, 1);
> -	if (!IS_ERR(pdata->clk_clkin))
> -		clk_put(pdata->clk_clkin);
> +	if (IS_ERR(pdata->clk_xtal)) {
> +		dev_err(&client->dev,
> +			"xtal clock not speficied\n");
> +		return -ENODEV;
> +	}
> +
> +	if (variant == SI5351_VARIANT_C) {
> +		pdata->clk_clkin = of_clk_get(np, 1);
> +		if (IS_ERR(pdata->clk_clkin)) {
> +			dev_err(&client->dev,
> +				"clkin clock not speficied\n");
> +			ret = -ENODEV;
> +			goto err_put_clk_of;
> +		}
> +	}
> 
> Basically, yes. But as I said, if you move that to the end of
> si5351_dt_parse() you won't have to add
> 
> @ -1143,14 +1154,16 @@ static int si5351_dt_parse(struct i2c_client *client,
>  		if (num >= 2) {
>  			dev_err(&client->dev,
>  				"invalid pll %d on pll-source prop\n", num);
> -			return -EINVAL;
> +			ret = -EINVAL;
> +			goto err_put_clk_of;
>  		}
> 
> this to each of the sanity checks. Claiming the clock resources at
> the end saves you from tearing down the resources on each error above.
> 

Sure I can move it down put it seems counterintuitive to parse parameters that
rely on the clocks before they are determined to be specified.

> Another thing is that you now require VARIANT_C devices to always
> pass both, xtal and clkin. I can live with it until we find somebody
> who actually uses C-type devices with only one clock input connected.
> 

Okay I did not realize that the C variant could run with one or the other.

> Adding a .remove() function to si5351 definitely needs more care with
> respect to claimed and pdata passed clocks. I am not sure we should
> go for it before we haven't ruled out the other issues.
>

Okay. Either way we should probably open a new thread because this is not
an issue with the processor support. Let me know how you want to proceed.

It looks like this chip is used on the dove-cubox:
http://lxr.free-electrons.com/source/arch/arm/boot/dts/dove-cubox.dts#L77

I wonder if this issue effects that board as well.

Any one out there want with one of these board want to test it?

It looks like the clock is used for a audio master clock so it may sound
pretty funny when playing audio. :)

> Sebastian
