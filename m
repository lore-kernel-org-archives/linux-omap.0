From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: Re: [PATCH 5/9] ARM: OMAP2+: Remove hardcoded twl4030 gpio_base,
 irq_base and irq_end
Date: Wed, 05 Sep 2012 16:12:32 +0300
Message-ID: <50474FC0.6010805@ti.com>
References: <20120831004828.28732.902.stgit@muffinssi.local> <20120831005230.28732.1131.stgit@muffinssi.local> <20120831235212.GS1303@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog113.obsmtp.com ([74.125.149.209]:56578 "EHLO
	na3sys009aog113.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750895Ab2IENML (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 5 Sep 2012 09:12:11 -0400
Received: by obbuo13 with SMTP id uo13so93308obb.19
        for <linux-omap@vger.kernel.org>; Wed, 05 Sep 2012 06:12:10 -0700 (PDT)
In-Reply-To: <20120831235212.GS1303@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: linux-arm-kernel@lists.infradead.org, Grant Likely <grant.likely@secretlab.ca>, Linus Walleij <linus.walleij@linaro.org>, linux-omap@vger.kernel.org, Samuel Ortiz <sameo@linux.intel.com>

Hi Tony,

On 09/01/2012 02:52 AM, Tony Lindgren wrote:
> * Tony Lindgren <tony@atomide.com> [120830 17:53]:
>> We can't use hardcoded interrupts for SPARSE_IRQ, and can replace
>> the hardcoded gpio_base with twl_gpiochip.base after it's been
>> allocated.
> ...
>=20
>> --- a/include/linux/mfd/twl6040.h
>> +++ b/include/linux/mfd/twl6040.h
>> @@ -194,7 +194,6 @@ struct twl6040_vibra_data {
>> =20
>>  struct twl6040_platform_data {
>>  	int audpwron_gpio;	/* audio power-on gpio */
>> -	unsigned int irq_base;
>> =20
>>  	struct twl6040_codec_data *codec;
>>  	struct twl6040_vibra_data *vibra;
>=20
> The platform_data irq_base is not being used it seems..

Yes, this is not in use.

>=20
>> @@ -222,7 +221,6 @@ struct twl6040 {
>>  	unsigned int mclk;
>> =20
>>  	unsigned int irq;
>> -	unsigned int irq_base;
>>  	u8 irq_masks_cur;
>>  	u8 irq_masks_cache;
>>  };
>=20
> ..but irq_base here is still in use as that's where the value from
> irq_alloc_descs() is being stored to. So I'll drop the changes to
> struct twl6040 from this patch as otherwise twl6040 code won't compil=
e.
>=20
> Turns out I did not have twl6040 selected in any of the testconfigs
> that I ran.

I store the irq_base in a private data for the MFD driver so child driv=
ers can
request the correct IRQ.

You can safely remove the irq_base from twl6040_platform_data struct

--=20
P=E9ter
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
