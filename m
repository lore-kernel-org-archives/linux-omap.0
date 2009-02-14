From: Felipe Balbi <me@felipebalbi.com>
Subject: Re: [PATCH 5/6] leds: lp5521: move to drivers/leds
Date: Fri, 13 Feb 2009 18:07:35 -0600
Message-ID: <6e3a378b4ae5036dbd50420a6a869012@felipebalbi.com>
References: <bdea5f5962eebe1bd420f184ebc7b32c@felipebalbi.com> <200902131249.00592.david-b@pacbell.net> <20090213223636.GP10711@frodo> <200902131554.20869.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from ns1.siteground211.com ([209.62.36.12]:58419 "EHLO
	serv01.siteground211.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751992AbZBNAHs (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 13 Feb 2009 19:07:48 -0500
In-Reply-To: <200902131554.20869.david-b@pacbell.net>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: David Brownell <david-b@pacbell.net>
Cc: Felipe Balbi <felipe.balbi@nokia.com>, linux-omap@vger.kernel.org



On Fri, 13 Feb 2009 15:54:20 -0800, David Brownell <david-b@pacbell.net=
>
wrote:
> On Friday 13 February 2009, Felipe Balbi wrote:
>> From: Felipe Balbi <felipe.balbi@nokia.com>
>> Date: Sat, 14 Feb 2009 00:34:56 +0200
>> Subject: [PATCH] leds: lp5521: use sysfs_streq()
>>
>> instead of using strcmp() for comparing strings,
>> use sysfs_streq().
>>
>> Signed-off-by: Felipe Balbi <felipe.balbi@nokia.com>
>=20
> Yes, just like that.

Good, so we can apply these to l-o and I'll send the
driver upstream after these patches are applied.

Same for lm8323

>=20
>=20
>> ---
>> =C2=A0drivers/leds/leds-lp5521.c | =C2=A0 =C2=A08 +++++---
>> =C2=A01 files changed, 5 insertions(+), 3 deletions(-)
>>
>> diff --git a/drivers/leds/leds-lp5521.c b/drivers/leds/leds-lp5521.c
>> index b3ba52a..3e1ca31 100644
>> --- a/drivers/leds/leds-lp5521.c
>> +++ b/drivers/leds/leds-lp5521.c
>> @@ -352,12 +352,14 @@ static ssize_t store_mode(struct device *dev,
>> =C2=A0
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0mutex_lock(&chip->lo=
ck);
>> =C2=A0
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0if (!strncmp(buf, "run", =
3))
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0if (sysfs_streq(buf, "run=
"))
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0lp5521_set_mode(chip, LP5521_MODE_RUN);
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0else if (!strncmp(buf, "l=
oad", 4))
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0else if (sysfs_streq(buf,=
 "load"))
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0lp5521_set_mode(chip, LP5521_MODE_LOAD);
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0else if (!strncmp(buf, "d=
irect", 6))
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0else if (sysfs_streq(buf,=
 "direct"))
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0lp5521_set_mode(chip,
> LP5521_MODE_DIRECT_CONTROL);
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0else
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0len =3D -EINVAL;
>> =C2=A0
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0mutex_unlock(&chip->=
lock);
>> =C2=A0
>> --
--=20
Best Regards,

=46elipe Balbi
http://blog.felipebalbi.com
me@felipebalbi.com

--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
