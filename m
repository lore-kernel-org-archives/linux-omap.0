From: Enric Balletbo Serra <eballetbo-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH 3/3] mfd: Add battery charger as subdevice to the tps65217.
Date: Tue, 22 Sep 2015 09:43:50 +0200
Message-ID: <CAFqH_51hUMH=1MMWQ3uSz1yJ=i6upNAHJrhD78Ocp9EWRqXW5w@mail.gmail.com>
References: <1441699779-22189-1-git-send-email-enric.balletbo@collabora.com>
	<1441699779-22189-4-git-send-email-enric.balletbo@collabora.com>
	<20150920041953.GV3039@x1>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20150920041953.GV3039@x1>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Lee Jones <lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Cc: "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Ian Campbell <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>, Kumar Gala <galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, sre-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, Dmitry Eremin-Solenikov <dbaryshkov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, David Woodhouse <dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>, Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, sameo-VuQAYsv1563Yd54FQh9/CA@public.gmane.org, Sjoerd Simons <sjoerd.simons-ZGY8ohtN/8pPYcu2f3hruQ@public.gmane.org>, Javier Martinez Canillas <javier-0uQlZySMnqxg9hUCZPvPmw@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

2015-09-20 6:19 GMT+02:00 Lee Jones <lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>:
> On Tue, 08 Sep 2015, Enric Balletbo i Serra wrote:
>
>> Add tps65217 battery charger subdevice.
>>
>> Signed-off-by: Enric Balletbo i Serra <enric.balletbo-ZGY8ohtN/8qB+jHODAdFcQ@public.gmane.org>
>> ---
>>  drivers/mfd/tps65217.c | 4 ++++
>>  1 file changed, 4 insertions(+)
>
> Applied, thanks.
>

Many thanks, any feedback about ?

[PATCH 1/3] devicetree: Add TPS65217 charger binding
[PATCH 2/3] power_supply: Add support for tps65217-charger.

Or should go through another tree ?



>> diff --git a/drivers/mfd/tps65217.c b/drivers/mfd/tps65217.c
>> index 55add04..d32b5442 100644
>> --- a/drivers/mfd/tps65217.c
>> +++ b/drivers/mfd/tps65217.c
>> @@ -39,6 +39,10 @@ static const struct mfd_cell tps65217s[] =3D {
>>               .name =3D "tps65217-bl",
>>               .of_compatible =3D "ti,tps65217-bl",
>>       },
>> +     {
>> +             .name =3D "tps65217-charger",
>> +             .of_compatible =3D "ti,tps65217-charger",
>> +     },
>>  };
>>
>>  /**
>
> --
> Lee Jones
> Linaro STMicroelectronics Landing Team Lead
> Linaro.org =E2=94=82 Open source software for ARM SoCs
> Follow Linaro: Facebook | Twitter | Blog
--
To unsubscribe from this list: send the line "unsubscribe devicetree" i=
n
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
