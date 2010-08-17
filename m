From: Robert Nelson <robertcnelson@gmail.com>
Subject: Re: [PATCH v4 1/3] ARM: OMAP: Beagle: revision detection
Date: Tue, 17 Aug 2010 15:10:35 -0500
Message-ID: <AANLkTinrJTCvorB0+LrFXmiChhZbbJZXeovmU3uWXYFw@mail.gmail.com>
References: <1281969403-28312-1-git-send-email-robertcnelson@gmail.com>
	<20100817084824.8f869e8e.jhnikula@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-ew0-f46.google.com ([209.85.215.46]:50671 "EHLO
	mail-ew0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750713Ab0HQUKg convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 17 Aug 2010 16:10:36 -0400
Received: by ewy23 with SMTP id 23so3323018ewy.19
        for <linux-omap@vger.kernel.org>; Tue, 17 Aug 2010 13:10:35 -0700 (PDT)
In-Reply-To: <20100817084824.8f869e8e.jhnikula@gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Jarkko Nikula <jhnikula@gmail.com>
Cc: tony@atomide.com, linux-omap@vger.kernel.org

On Tue, Aug 17, 2010 at 12:48 AM, Jarkko Nikula <jhnikula@gmail.com> wr=
ote:
> Hi
>
> On Mon, 16 Aug 2010 09:36:41 -0500
> Robert Nelson <robertcnelson@gmail.com> wrote:
>
>> +u8 get_omap3_beagle_rev(void)
>> +{
>> + =A0 =A0 return omap3_beagle_version;
>> +}
>> +
>> +static void __init omap3_beagle_get_revision(void)
>> +{
>> + =A0 =A0 int ret;
>> + =A0 =A0 u16 beagle_rev =3D 0;
>> +
>> + =A0 =A0 omap_mux_init_gpio(171, OMAP_PIN_INPUT_PULLUP);
>> + =A0 =A0 omap_mux_init_gpio(172, OMAP_PIN_INPUT_PULLUP);
>> + =A0 =A0 omap_mux_init_gpio(173, OMAP_PIN_INPUT_PULLUP);
>> +
>> + =A0 =A0 ret =3D gpio_request(171, "rev_id_0");
>> + =A0 =A0 if (ret < 0)
>> + =A0 =A0 =A0 =A0 =A0 =A0 goto fail;
>> +
>> + =A0 =A0 ret =3D gpio_request(172, "rev_id_1");
>> + =A0 =A0 if (ret < 0)
>> + =A0 =A0 =A0 =A0 =A0 =A0 goto fail;
>> +
>> + =A0 =A0 ret =3D gpio_request(173, "rev_id_2");
>> + =A0 =A0 if (ret < 0)
>> + =A0 =A0 =A0 =A0 =A0 =A0 goto fail;
>> +
>

Thanks Jarkko

> Sorry, I didn't notice this earlier: you should free already allocate=
d
> gpios if the next one fails.

Sure, i'll add something like:

fail3:
=A0 =A0 =A0 =A0 gpio_free(173);
fail2:
=A0 =A0 =A0 =A0 gpio_free(172);
fail1:
=A0 =A0 =A0 =A0 gpio_free(171);

Do you have any preference if the gpio allocation fails?  Right now
it'll just halts, we could just return as Cx based board.. Which would
be the route the current kernel would take without this patch...

> <minor>
> I was thinking would it make a sense to rename funtions below. I.e. t=
o
> indicate that only one of them is for runtime revision detection and
> another is for revision initialization only. What do you think?
>
> get_omap3_beagle_rev -> omap3_beagle_get_rev
> omap3_beagle_get_revision -> omap3_beagle_init_rev

That does help clear up the two functions a little.

I didn't give much thought to the names, they just came from the evm
board revision example:  s/evm/beagle/g

Regards,

--=20
Robert Nelson
http://www.rcn-ee.com/
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
