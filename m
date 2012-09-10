From: Benoit Cousson <b-cousson@ti.com>
Subject: Re: [PATCH 1/2] gpio/twl4030: get platform data from device tree
Date: Mon, 10 Sep 2012 10:29:55 +0200
Message-ID: <504DA503.5050901@ti.com>
References: <1346831186-29947-1-git-send-email-florian.vaussard@epfl.ch> <1346831186-29947-2-git-send-email-florian.vaussard@epfl.ch> <504A2FF2.7070607@ti.com> <504DA20D.7020903@epfl.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:53125 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751594Ab2IJIaP (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 10 Sep 2012 04:30:15 -0400
In-Reply-To: <504DA20D.7020903@epfl.ch>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: florian.vaussard@epfl.ch
Cc: Linus Walleij <linus.walleij@linaro.org>, Tony Lindgren <tony@atomide.com>, linux-omap@vger.kernel.org, devicetree-discuss@lists.ozlabs.org, Grant Likely <grant.likely@secretlab.ca>, Vaibhav Hiremath <hvaibhav@ti.com>, Rob Herring <rob.herring@calxeda.com>, linux-arm-kernel@lists.infradead.org

Hi Florian,

On 09/10/2012 10:17 AM, Florian Vaussard wrote:
> Hello Benoit,
>=20
> Le 07/09/2012 19:33, Benoit Cousson a =E9crit :
>> Hi Florian,
>>
>> I've just noticed that this patch is reporting some CHECK issues.
>>
>> d1f5052 - gpio/twl4030: get platform data from device tree
>> CHECK: Alignment should match open parenthesis
>> #66: FILE: drivers/gpio/gpio-twl4030.c:412:
>> +    of_property_read_u32(dev->of_node, "ti,debounce",
>> +                &omap_twl_info->debounce);
>>
>> CHECK: Alignment should match open parenthesis
>> #68: FILE: drivers/gpio/gpio-twl4030.c:414:
>> +    of_property_read_u32(dev->of_node, "ti,mmc-cd",
>> +                (u32 *)&omap_twl_info->mmc_cd);
>>
>> CHECK: Alignment should match open parenthesis
>> #70: FILE: drivers/gpio/gpio-twl4030.c:416:
>> +    of_property_read_u32(dev->of_node, "ti,pullups",
>> +                &omap_twl_info->pullups);
>>
>> CHECK: Alignment should match open parenthesis
>> #72: FILE: drivers/gpio/gpio-twl4030.c:418:
>> +    of_property_read_u32(dev->of_node, "ti,pulldowns",
>> +                &omap_twl_info->pulldowns);
>>
>> CHECK: Alignment should match open parenthesis
>> +                pdata->pullups, pdata->pulldowns,
>>
>> CHECK: Alignment should match open parenthesis
>> #139: FILE: drivers/gpio/gpio-twl4030.c:479:
>> +        dev_dbg(&pdev->dev, "debounce %.03x %.01x --> %d\n",
>> +                pdata->debounce, pdata->mmc_cd,
>>
>> total: 0 errors, 0 warnings, 6 checks, 118 lines checked
>>
>>
>> I fixed them since it was trivial, but next time you should ensure
>> that the patch pass checkpatch before posting.
>=20
> Sorry for these errors. I however checked my patches before submittin=
g,
> and had no such warnings. I redone, and remarked that these warnings
> appear only with the "--strict" option, which is not enabled by defau=
lt.
> Is this the recommended  guideline? Thus why not enabling it by defau=
lt?

That's a pretty good question :-)

Maybe the --strict is more a nice to have than a strong requirement?
Anyway, we'd better run checkpatch with --strict and thus fix any
cosmetic details that might be in the patch.

>> Just let me know if you have any issue with the following update.
>=20
> I will test, but should not have any issue with your fix.
>=20
> Thank you very much for fixing my patch, I send you a virtual chocola=
te
> from Switzerland!

Cool, I love chocolate. That being said, I'm not sure how tasteful will
be the *virtual* chocolate.

Regards,
Benoit

--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
