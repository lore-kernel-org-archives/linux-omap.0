From: Javier Martinez Canillas <javier-0uQlZySMnqxg9hUCZPvPmw@public.gmane.org>
Subject: Re: [RESEND PATCH v6 2/8] mfd: retu: Drop -mfd suffix from I2C device
 ID name
Date: Wed, 28 Jun 2017 09:30:58 +0200
Message-ID: <CABxcv=nmP=JYmwCnRDzMS1BnFwfSNyRtyf8BdZLgGJUqqJCH3A@mail.gmail.com>
References: <20170615184928.12007-1-javier@dowhile0.org> <20170615184928.12007-3-javier@dowhile0.org>
 <20170619145423.w7zaeboy7iq2usmt@dell>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20170619145423.w7zaeboy7iq2usmt@dell>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Lee Jones <lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Cc: Linux Kernel <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, Aaro Koskinen <aaro.koskinen-X3B1VOXEql0@public.gmane.org>, =?UTF-8?Q?Beno=C3=AEt_Cousson?= <bcousson-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, "linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Russell King <linux-I+IVW8TIWO2tmTQ+vhA3Yw@public.gmane.org>, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

Hello Lee,

On Mon, Jun 19, 2017 at 4:54 PM, Lee Jones <lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org> wrote:
> On Thu, 15 Jun 2017, Javier Martinez Canillas wrote:
>
>> It's not correct to encode the subsystem in the I2C device name, so
>> drop the -mfd suffix. To maintain bisect-ability, change driver and
>> platform code / DTS users in the same patch.
>>
>> Suggested-by: Lee Jones <lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
>> Signed-off-by: Javier Martinez Canillas <javier-0uQlZySMnqxg9hUCZPvPmw@public.gmane.org>
>> Acked-by: Rob Herring <robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
>> Acked-by: Aaro Koskinen <aaro.koskinen-X3B1VOXEql0@public.gmane.org>
>> Acked-by: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
>> Reviewed-by: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
>>
>> ---
>>
>> Changes in v6:
>> - Add Wolfram Sang's Reviewed-by tag.
>>
>> Changes in v5:
>> - Add Rob Herring's Acked-by tag.
>> - Add Aaro Koskinen's Acked-by tag.
>> - Add Tony Lindgren's Acked-by tag.
>>
>> Changes in v4: None
>> Changes in v3: None
>> Changes in v2: None
>>
>>  arch/arm/boot/dts/omap2420-n8x0-common.dtsi | 4 ++--
>>  arch/arm/mach-omap1/board-nokia770.c        | 4 ++--
>>  drivers/mfd/retu-mfd.c                      | 4 ++--
>>  3 files changed, 6 insertions(+), 6 deletions(-)
>
> Acked-by: Lee Jones <lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>

Thanks for the ack, but the idea is you to take the whole series since
the platform maintainers have already acked the patches :)

Best regards,
Javier
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
