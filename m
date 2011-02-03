From: "Varadarajan, Charulatha" <charu@ti.com>
Subject: Re: [PATCH 1/2] ads7846: fix gpio free without requesting
Date: Thu, 3 Feb 2011 14:31:06 +0530
Message-ID: <AANLkTikDso+pvJb8zJ0X5a-jY4EQ-J4KS3o9L6zbS88S@mail.gmail.com>
References: <1296660624-28120-1-git-send-email-sourav.poddar@ti.com>
 <AANLkTimQaQNTNaLWMxCqJ2Y+peU1+tt8u3CitDZA6gba@mail.gmail.com> <2b2cb2992afd1bc5c9119425e9b1da0f@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog104.obsmtp.com ([74.125.149.73]:49518 "EHLO
	na3sys009aog104.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755149Ab1BCJBr convert rfc822-to-8bit
	(ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 3 Feb 2011 04:01:47 -0500
In-Reply-To: <2b2cb2992afd1bc5c9119425e9b1da0f@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Anand Gadiyar <gadiyar@ti.com>
Cc: Sourav Poddar <sourav.poddar@ti.com>, linux-omap@vger.kernel.org, linux-arm-kernel@vger.kernel.org, KISHON VIJAY ABRAHAM <kishon@ti.com>

<<snip>>

>> > diff --git a/drivers/input/touchscreen/ads7846.c
> b/drivers/input/touchscreen/ads7846.c
>> > index 14ea54b..036f245 100644
>> > --- a/drivers/input/touchscreen/ads7846.c
>> > +++ b/drivers/input/touchscreen/ads7846.c
>> > @@ -1221,6 +1221,7 @@ static int __devinit ads7846_probe(struct
> spi_device *spi)
>> > =A0 =A0 =A0 =A0ts->input =3D input_dev;
>> > =A0 =A0 =A0 =A0ts->vref_mv =3D pdata->vref_mv;
>> > =A0 =A0 =A0 =A0ts->swap_xy =3D pdata->swap_xy;
>> > + =A0 =A0 =A0 ts->gpio_pendown =3D -1;
>>
>> Going through the code, I see that ts->gpio_pendown is being filled
>> in ads7846_setup_pendown() which in turn is called by the
>> ads7846_probe().
>>
>> Actually in ads7846_dev_init() [board-3430sdp.c], the gpio_pendown
>> pin has been requested already. The problem is with the following
>> line in ads7846_probe():
>> =A0 =A0 =A0 =A0 =A0if (pdata->get_pendown_state) {
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0ts->get_pendown_state =3D pdata->=
get_pendown_state;
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0return 0;
>> =A0 =A0 =A0 =A0 =A0}
>>
>> Instead it should have been
>> =A0 =A0 =A0 =A0 =A0if (pdata->get_pendown_state( )) {
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0ts->get_pendown_state =3D pdata->=
get_pendown_state;
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0return 0;
>> =A0 =A0 =A0 =A0 =A0}
>>
>
> This is not correct. This section of the code is simply assigning
> the function pointer that platform data passed down to the
> local structure. So all you need to check is if the platform data
> pointer is valid or not.
>
> So that section of the code is correct - you should not call
> pdata->get_pendown_state(). It is unnecessary during probe.

Okay.

>
>
>> Also, filling ts->gpio_pendown =3D -1 should not be done in the
>> driver file.
>> Instead pdata should either send a valid GPIO pin number or an -1
>> if it is not applicable to the board and this has to be done
>> in the board file.
>
> I'm not very familiar with this driver, but it looks to me like
> there is no hard and fast rule that a gpio be passed down from
> platform files.
>
> The platform file could just as well pass down a way to get
> the pendown state directly (which is what board-3430sdp.c does).
>
>> Also in board-3430sdp.c file, I observed that pdata->gpio_pendown
>> is not filled at all. But the ads7846_setup_pendown() in the
>> driver relies on pdata->gpio_pendown. This also needs to be fixed.
>
> ads7846_setup_pendown calls the get_pendown_state function pointer
> if the platform provided one, or requests the gpio to use if
> the platform provided one. The platform could provide either one,
> and doesn't necessarily have to provide both (I'm not sure).
>
> ads7846_setup_pendown doesn't populate the ts->gpio_pendown at all,
> if there was a get_pendown_state pointer passed. So fixing the
> platform files will not be enough. This is the bug that Sourav's
> patch appears to fix.

Okay.
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
