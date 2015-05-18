From: Pantelis Antoniou <pantelis.antoniou@konsulko.com>
Subject: Re: [PATCH] ARM: dts: am335x-bone* enable pmic-shutdown-controller
Date: Mon, 18 May 2015 21:01:26 +0300
Message-ID: <7ECB47C4-812D-4465-82EE-56796B987011@konsulko.com>
References: <1431525001-5747-1-git-send-email-robertcnelson@gmail.com> <20150513141658.GB6605@localhost> <20150513144846.GC6605@localhost> <CAALWOA-hkgrMi+OeNrmwaVpdEfNadFn0R-QbpXi9LU-4sbakJQ@mail.gmail.com> <20150518152108.GE10274@atomide.com> <CAOCHtYgwyQy+hQE2PeUd+7U9wNygVOUuAb-VSh_9K5y7zFHEWA@mail.gmail.com> <20150518162936.GF10274@atomide.com> <CAOCHtYjtziBwfSMGPRrQ7rfDEf_dC=7rPytQUxVXy8bSp-8NNw@mail.gmail.com> <20150518170354.GG10274@atomide.com>
Mime-Version: 1.0 (Mac OS X Mail 8.2 \(2098\))
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-wi0-f182.google.com ([209.85.212.182]:35392 "EHLO
	mail-wi0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752295AbbERSBb convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 18 May 2015 14:01:31 -0400
Received: by wicmx19 with SMTP id mx19so88795603wic.0
        for <linux-omap@vger.kernel.org>; Mon, 18 May 2015 11:01:30 -0700 (PDT)
In-Reply-To: <20150518170354.GG10274@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Robert Nelson <robertcnelson@gmail.com>, Matthijs van Duin <matthijsvanduin@gmail.com>, Johan Hovold <johan@kernel.org>, devicetree <devicetree@vger.kernel.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Felipe Balbi <balbi@ti.com>

Hi Tony,

> On May 18, 2015, at 20:03 , Tony Lindgren <tony@atomide.com> wrote:
>=20
> * Robert Nelson <robertcnelson@gmail.com> [150518 09:51]:
>> On Mon, May 18, 2015 at 11:29 AM, Tony Lindgren <tony@atomide.com> w=
rote:
>>> * Robert Nelson <robertcnelson@gmail.com> [150518 09:15]:
>>>> On Mon, May 18, 2015 at 10:21 AM, Tony Lindgren <tony@atomide.com>=
 wrote:
>>>>=20
>>>> All the rev information is in the board's eeprom:
>>>>=20
>>>> hexdump -e '8/1 "%c"' /sys/bus/i2c/devices/0-0050/eeprom -s 12 -n =
4
>>>>=20
>>>> Rev A5B
>>>> 0A5B
>>>>=20
>>>> Rev C
>>>> 000C
>>>>=20
>>>> Just another default qwerk to add to Pantelis' bone_capemgr. ;)
>>>=20
>>> It seems we should not even instantiate some devices on BBB
>>> until the EEPROM is parsed.. So maybe something like this:
>>>=20
>>> 1. The problem devices are initially set with status =3D "disabled"
>>>   in the dts
>>>=20
>>> 2. We set up drivers/*/bbb-eeprom.c that parses the board
>>>   revision at module_init time, and then flips the selected
>>>   devices to have status =3D "enabled" and populates the revision
>>>   info based on the eeprom and SoC revision passed in pdata.
>>>   Then those devices get their struct device created and
>>>   probed, but at a much later time.
>>>=20
>>> So rather than trying to init all that early, let's just
>>> init them much later when we have the proper I2C driver
>>> running?
>>=20
>> I see that working just fine.  We (beagleboard.org) enforce the eepr=
om
>> data, as all the official images require a proper baseboard eeprom.
>=20
> OK
>=20
>> We just have to be very careful to limit the scope, otherwise we wil=
l
>> end up with Pantelis' rejected capebus from the v3.2.x days...
>=20
> Naturally I was thinking #2 above would use Pantelis' code for
> CONFIG_OF_OVERLAY in mainline. But instead of the earlier patches,
> we can make things happen much later on to avoid the detect of
> EEPROM early on.
>=20


Already been taken care of:

https://lkml.org/lkml/2015/2/18/258

The patchset works, but it still needs some review eyeballs.
There might be a rename to variants or something.

You were part of that thread too :)

I think it=E2=80=99s best if we go this path instead of twiddling with =
the
status properties manually. Conceptually the idea is similar to
the detection of the white/black, with the added joy of revision
detection.

Ain=E2=80=99t hardware designers a fun bunch or what?

> Regards,
>=20
> Tony

Regards

=E2=80=94 Pantelis

--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
