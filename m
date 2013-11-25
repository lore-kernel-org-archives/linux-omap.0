From: Michael Trimarchi <michael@amarulasolutions.com>
Subject: Re: [PATCH v2 2/3] bq2415x_charger: Use power_supply notifier for automode
Date: Mon, 25 Nov 2013 20:16:34 +0100
Message-ID: <CAOf5uw=-cy2QoDxjecxYTYsrQRD=LtN0N7DcYJHZ6HSbexzPRw@mail.gmail.com>
References: <1378630239-10006-1-git-send-email-pali.rohar@gmail.com>
	<1384856285-19593-3-git-send-email-pali.rohar@gmail.com>
	<CAOf5uwkrep0PhOn67+9PHmP2A2Jxrp9DNK3BRp9D_sYu_PYvvw@mail.gmail.com>
	<201311242001.23126@pali>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-wi0-f171.google.com ([209.85.212.171]:48916 "EHLO
	mail-wi0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754130Ab3KYTQk convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 25 Nov 2013 14:16:40 -0500
Received: by mail-wi0-f171.google.com with SMTP id ca18so4081592wib.4
        for <linux-omap@vger.kernel.org>; Mon, 25 Nov 2013 11:16:34 -0800 (PST)
In-Reply-To: <201311242001.23126@pali>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: =?ISO-8859-1?Q?Pali_Roh=E1r?= <pali.rohar@gmail.com>
Cc: Anton Vorontsov <anton@enomsg.org>, David Woodhouse <dwmw2@infradead.org>, Tony Lindgren <tony@atomide.com>, Russell King <linux@arm.linux.org.uk>, linux-kernel@vger.kernel.org, Linux OMAP Mailing List <linux-omap@vger.kernel.org>, freemangordon@abv.bg, aaro.koskinen@iki.fi, pavel@ucw.cz

Hi

On Sun, Nov 24, 2013 at 8:01 PM, Pali Roh=E1r <pali.rohar@gmail.com> wr=
ote:
> On Sunday 24 November 2013 18:18:03 Michael Trimarchi wrote:
>> Hi
>>
>> On Tue, Nov 19, 2013 at 11:18 AM, Pali Roh=E1r
> <pali.rohar@gmail.com> wrote:
>> > This patch removing set_mode_hook function from board data
>> > and replacing it with new string variable of notifier power
>> > supply device. After this change it is possible to add DT
>> > support because driver does not need specific board
>> > function anymore. Only static data and name of power supply
>> > device is required.
>> >
>> > Signed-off-by: Pali Roh=E1r <pali.rohar@gmail.com>
>> > ---
>> >
>> >  drivers/power/bq2415x_charger.c       |   77
>> >  +++++++++++++++++++++++++--------
>> >  include/linux/power/bq2415x_charger.h |   48
>> >  +++----------------- 2 files changed, 65 insertions(+), 60
>> >  deletions(-)
>> >
> ...
>> >
>> > -       struct bq2415x_device *bq =3D data;
>> > +       struct bq2415x_device *bq =3D
>> > +               container_of(nb, struct bq2415x_device, nb);
>> > +       struct power_supply *psy =3D v;
>> > +       enum bq2415x_mode mode;
>> > +       union power_supply_propval prop;
>> > +       int ret;
>> > +       int mA;
>> >
>> > -       if (!bq)
>> > -               return;
>> > +       if (val !=3D PSY_EVENT_PROP_CHANGED)
>> > +               return NOTIFY_OK;
>> > +
>> > +       if (strcmp(psy->name, bq->init_data.notify_device)
>> > !=3D 0) +               return NOTIFY_OK;
>> > +
>> > +       dev_dbg(bq->dev, "notifier call was called\n");
>> > +
>> > +       ret =3D psy->get_property(psy,
>> > POWER_SUPPLY_PROP_CURRENT_MAX, &prop); +       if (ret !=3D
>> > 0)
>> > +               return NOTIFY_OK;
>>
>> So you can read this value without any type of synchronization
>> with the power_supply_core
>> and sysfs implementation?
>>
>>
>> Michael
>>
>
> I do not see reason why I cannot use it. When isp1704 driver send
> PSY_EVENT_PROP_CHANGED then property
> POWER_SUPPLY_PROP_CURRENT_MAX is already updated and can be read
> by get_property function.
>

https://lists.ubuntu.com/archives/kernel-team/2013-January/025206.html

I found and equivalent scenario that I was trying to said

Michael


> --
> Pali Roh=E1r
> pali.rohar@gmail.com
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
