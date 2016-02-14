From: "Kim, Milo" <milo.kim@ti.com>
Subject: Re: [PATCH v2 2/4] regulator: lp872x: Add enable GPIO pin support
Date: Mon, 15 Feb 2016 08:31:02 +0900
Message-ID: <56C10E36.1030808@ti.com>
References: <1454697741-8687-1-git-send-email-contact@paulk.fr>
 <1454697741-8687-3-git-send-email-contact@paulk.fr> <56BD23ED.8010207@ti.com>
 <1455301532.2760.1.camel@collins>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1455301532.2760.1.camel@collins>
Sender: linux-kernel-owner@vger.kernel.org
To: Paul Kocialkowski <contact@paulk.fr>
Cc: linux-kernel@vger.kernel.org, Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, Russell King <linux@arm.linux.org.uk>, =?UTF-8?Q?Beno=c3=aet_Cousson?= <bcousson@baylibre.com>, Tony Lindgren <tony@atomide.com>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Javier Martinez Canillas <javier@dowhile0.org>, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

On 2/13/2016 3:25 AM, Paul Kocialkowski wrote:
>>> > >+
>>> > >+	/* Always set enable GPIO high. */
>>> > >+	ret = devm_gpio_request_one(lp->dev, gpio, GPIOF_OUT_INIT_HIGH, "LP872X EN");
>>> > >+	if (ret) {
>>> > >+		dev_err(lp->dev, "gpio request err: %d\n", ret);
>>> > >+		return ret;
>>> > >+	}
>>> > >+
>>> > >+	/* Each chip has a different enable delay. */
>>> > >+	if (lp->chipid == LP8720)
>>> > >+		usleep_range(LP8720_ENABLE_DELAY, 1.5 * LP8720_ENABLE_DELAY);
>>> > >+	else
>>> > >+		usleep_range(LP8725_ENABLE_DELAY, 1.5 * LP8725_ENABLE_DELAY);
>>> > >+
>>> > >+	return 0;
>>> > >+}
>>> > >+
>>> > >   static int lp872x_config(struct lp872x *lp)
>>> > >   {
>>> > >   	struct lp872x_platform_data *pdata = lp->pdata;
>>> > >@@ -875,6 +903,8 @@ static struct lp872x_platform_data
>>> > >   	of_property_read_u8(np, "ti,dvs-state", &dvs_state);
>>> > >   	pdata->dvs->init_state = dvs_state ? DVS_HIGH : DVS_LOW;
>>> > >
>>> > >+	pdata->enable_gpio = of_get_named_gpio(np, "enable-gpios", 0);
>> >
>> >Please move this code to lp872x_populate_pdata_from_dt().
> This already adds it in lp872x_populate_pdata_from_dt (see the context
> around the insertion).

Ah, sorry. Your patch is correct.

> I don't know why the diff makes it seem like it's added in
> lp872x_config. It's really not.

I think it was from a line break of lp872x_populate_pdata_from_dt().
Let me add my ACK to this patch. Thank you.

Best regards,
Milo
