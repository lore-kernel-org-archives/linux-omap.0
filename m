From: =?UTF-8?Q?Andreas_M=C3=BCller?= <schnitzeltony@googlemail.com>
Subject: Re: [PATCH] board-overo.c: enable TWL4030 power off
Date: Tue, 5 Mar 2013 09:15:25 +0100
Message-ID: <CALbNGRQbAq4NdS4JFmJABG_kwOWsHeY9xOuk=x7AzCk3zb9eBA@mail.gmail.com>
References: <1362055461-27154-1-git-send-email-schnitzeltony@googlemail.com>
	<20130304190035.GT11806@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-ve0-f171.google.com ([209.85.128.171]:52099 "EHLO
	mail-ve0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754503Ab3CEIPZ convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 5 Mar 2013 03:15:25 -0500
Received: by mail-ve0-f171.google.com with SMTP id b10so5560014vea.30
        for <linux-omap@vger.kernel.org>; Tue, 05 Mar 2013 00:15:25 -0800 (PST)
In-Reply-To: <20130304190035.GT11806@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: linux-omap@vger.kernel.org

On Mon, Mar 4, 2013 at 8:00 PM, Tony Lindgren <tony@atomide.com> wrote:
> * Andreas M=C3=BCller <schnitzeltony@googlemail.com> [130228 04:50]:
>
> Can you please add a description here? Preferrably something
> like "With commit XYZ overo poweroff stopped working. Fix this
> by blah blah blah" so this can be queued as a fix.
>
> Regards,
>
> Tony
>
>> Signed-off-by: Andreas M=C3=BCller <schnitzeltony@googlemail.com>
>> ---
>>  arch/arm/mach-omap2/board-overo.c |    5 +++++
>>  1 files changed, 5 insertions(+), 0 deletions(-)
>>
>> diff --git a/arch/arm/mach-omap2/board-overo.c b/arch/arm/mach-omap2=
/board-overo.c
>> index 86bab51..b975c72 100644
>> --- a/arch/arm/mach-omap2/board-overo.c
>> +++ b/arch/arm/mach-omap2/board-overo.c
>> @@ -418,9 +418,14 @@ static struct regulator_init_data overo_vmmc1 =3D=
 {
>>       .consumer_supplies      =3D overo_vmmc1_supply,
>>  };
>>
>> +static struct twl4030_power_data overo_power_data =3D {
>> +     .use_poweroff   =3D true,
>> +};
>> +
>>  static struct twl4030_platform_data overo_twldata =3D {
>>       .gpio           =3D &overo_gpio_data,
>>       .vmmc1          =3D &overo_vmmc1,
>> +     .power          =3D &overo_power_data,
>>  };
>>
>>  static int __init overo_i2c_init(void)
>> --
Sorry for the noise but I am newbie here and have one question:
Against which branch should patches send here be based on. Up to now I
used Linus' mainline branch - is that OK?

Andreas
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
