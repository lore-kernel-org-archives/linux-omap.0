From: Sebastian Hesselbarth <sebastian.hesselbarth-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: AM335x OMAP2 common clock external fixed-clock registration
Date: Fri, 17 Apr 2015 11:12:03 +0200
Message-ID: <5530CE63.9070508@gmail.com>
References: <20150415140945.GA30787@deathray> <552EB152.7050306@ti.com> <20150415194707.GA11007@deathray> <CAPtuhTggHctp5ArGPEuKn2GuPzb-WnKv2_CzPrHzq8hwOR5Aqw@mail.gmail.com> <20150415205136.GA3399@deathray> <552F3B60.8050703@ti.com> <20150416161756.GA27590@deathray> <55301D7F.30708@gmail.com> <20150416220918.GA6057@deathray> <55304486.5020404@gmail.com> <20150417020048.GA27174@deathray>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20150417020048.GA27174@deathray>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Michael Welling <mwelling-EkmVulN54Sk@public.gmane.org>
Cc: Tero Kristo <t-kristo-l0cyMroinI0@public.gmane.org>, Mike Turquette <mturquette-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Stephen Boyd <sboyd-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, Linux OMAP Mailing List <linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Ian Campbell <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>, Kumar Gala <galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, Russell King <linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>, devicetree <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, Daniel Mack <daniel-cYrQPVfZoowdnm+yROfE0A@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

On 17.04.2015 04:00, Michael Welling wrote:
> On Fri, Apr 17, 2015 at 01:23:50AM +0200, Sebastian Hesselbarth wrote:
>> On 17.04.2015 00:09, Michael Welling wrote:
>>> On Thu, Apr 16, 2015 at 10:37:19PM +0200, Sebastian Hesselbarth wrote:
>>>> On 16.04.2015 18:17, Michael Welling wrote:
[...]
>>> What would be the proper error path?
>>> What cleanup is required?
>>
>> A proper error path would be to release any claimed resource
>> on any error. If you look at the code, the only resources that
>> need to be released are the two clocks in question.
>
> So for every error return in the probe function and in the of si5351_dt_parse
> it needs to clk_put first right?

Not quite. The driver should clk_put() every clock that it called a
[of_]clk_get() for. The thing is that clocks can be passed by
platform_data and we never claim them.

> See attached patch to see if we are on the same page.

Adding a .remove() function needs more care because of the pdata passed
clocks. I admit that back when the driver was introduced clk_put()
wasn't really necessary at all.

[...]
>>> Here is what the kernel reports with debugging off:
>>
>> Do you have any measurement equipment to check what is actually set?
>
> Yes, I have an oscilloscope here at my desk.
> The reported numbers do not always correspond to the actual output in some
> cases.

is "not always correspond" close or way off the requested frequency?

Stability is an issue that I am aware of. Neither the datasheet nor the
appnote were clear about any order the clocks should be set or how long
we should wait between changing pll/ms/clkout parameters.

SiLabs suggests to configure all clocks at once and never change them
later, at least that is what you can read from the public documents.
The drivers you mention below can however reveal some steps that have
to be taken care of before and after changing parameters.

> The ms2 output has appeared to stop working all together sometime whilest
> testing. I may have to solder a new chip on there.
>
> Could misconfiguration damage the chip?

You should know that a lot of things can damage a chip and
misconfiguration is among them, yes. I cannot tell if that
is the cause though.

[...]
>> Is there any way to try out a less recent kernel, let's say two or
>> three releases before 4.0?
>
> Could you provide a specific version that you think has the best chances of
> working?

My guess with 2-3 releases before 4.0 was because somewhere in between
clk API must have switched from passing struct clk pointers to clk
cookies.

[...]

 From your patch (that you should inline next time please):

@@ -1129,11 +1130,21 @@ static int si5351_dt_parse(struct i2c_client 
*client,
  		return -ENOMEM;

  	pdata->clk_xtal = of_clk_get(np, 0);
-	if (!IS_ERR(pdata->clk_xtal))
-		clk_put(pdata->clk_xtal);
-	pdata->clk_clkin = of_clk_get(np, 1);
-	if (!IS_ERR(pdata->clk_clkin))
-		clk_put(pdata->clk_clkin);
+	if (IS_ERR(pdata->clk_xtal)) {
+		dev_err(&client->dev,
+			"xtal clock not speficied\n");
+		return -ENODEV;
+	}
+
+	if (variant == SI5351_VARIANT_C) {
+		pdata->clk_clkin = of_clk_get(np, 1);
+		if (IS_ERR(pdata->clk_clkin)) {
+			dev_err(&client->dev,
+				"clkin clock not speficied\n");
+			ret = -ENODEV;
+			goto err_put_clk_of;
+		}
+	}

Basically, yes. But as I said, if you move that to the end of
si5351_dt_parse() you won't have to add

@ -1143,14 +1154,16 @@ static int si5351_dt_parse(struct i2c_client *client,
  		if (num >= 2) {
  			dev_err(&client->dev,
  				"invalid pll %d on pll-source prop\n", num);
-			return -EINVAL;
+			ret = -EINVAL;
+			goto err_put_clk_of;
  		}

this to each of the sanity checks. Claiming the clock resources at
the end saves you from tearing down the resources on each error above.

Another thing is that you now require VARIANT_C devices to always
pass both, xtal and clkin. I can live with it until we find somebody
who actually uses C-type devices with only one clock input connected.

Adding a .remove() function to si5351 definitely needs more care with
respect to claimed and pdata passed clocks. I am not sure we should
go for it before we haven't ruled out the other issues.

Sebastian
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
