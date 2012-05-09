From: Russ Dill <Russ.Dill@ti.com>
Subject: Re: [PATCH] OMAPDSS: TFP410: use gpio_set_value_cansleep
Date: Wed, 9 May 2012 15:50:07 -0700
Message-ID: <CA+Bv8Xa+1RJ5QTn=vO4GSw1VtUZc3xX0J5qBVshvV5Dj+9uZVA@mail.gmail.com>
References: <1336601288-27848-1-git-send-email-Russ.Dill@ti.com>
	<20120509221447.GY5088@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-lpp01m010-f46.google.com ([209.85.215.46]:55572 "EHLO
	mail-lpp01m010-f46.google.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754972Ab2EIWuJ convert rfc822-to-8bit
	(ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 9 May 2012 18:50:09 -0400
In-Reply-To: <20120509221447.GY5088@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org

On Wed, May 9, 2012 at 3:14 PM, Tony Lindgren <tony@atomide.com> wrote:
> * Russ Dill <Russ.Dill@ti.com> [120509 15:12]:
>> The Beagleboard xM gpio used for TFP410 powerdown is connected throu=
gh
>> an I2C attached chip which means setting the GPIO can sleep. Code th=
at
>> calls tfp410_power_on/off holds a mutex, so sleeping should be fine.
>
> What's the error without this patch? Or just no display?
>
> Just wondering if it's safe to merge Tomi's clean up series to
> arm-soc tree..

The only platform that has a problem is Beagleboard xM, and that is
only after 'ARM: OMAP: Cleanup Beagleboard DVI reset gpio' is applied.
Since the context actually can sleep, the only consequence is a
WARN_ON statement.

So yes, it should be safe.

>> Signed-off-by: Russ Dill <Russ.Dill@ti.com>
>> ---
>> =C2=A0drivers/video/omap2/displays/panel-tfp410.c | =C2=A0 =C2=A04 +=
+--
>> =C2=A01 file changed, 2 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/video/omap2/displays/panel-tfp410.c b/drivers/v=
ideo/omap2/displays/panel-tfp410.c
>> index 52637fa..1266520 100644
>> --- a/drivers/video/omap2/displays/panel-tfp410.c
>> +++ b/drivers/video/omap2/displays/panel-tfp410.c
>> @@ -68,7 +68,7 @@ static int tfp410_power_on(struct omap_dss_device =
*dssdev)
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 goto err0;
>>
>> =C2=A0 =C2=A0 =C2=A0 if (gpio_is_valid(ddata->pd_gpio))
>> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 gpio_set_value(ddata->pd=
_gpio, 1);
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 gpio_set_value_cansleep(=
ddata->pd_gpio, 1);
>>
>> =C2=A0 =C2=A0 =C2=A0 return 0;
>> =C2=A0err0:
>> @@ -83,7 +83,7 @@ static void tfp410_power_off(struct omap_dss_devic=
e *dssdev)
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return;
>>
>> =C2=A0 =C2=A0 =C2=A0 if (gpio_is_valid(ddata->pd_gpio))
>> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 gpio_set_value(ddata->pd=
_gpio, 0);
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 gpio_set_value_cansleep(=
ddata->pd_gpio, 0);
>>
>> =C2=A0 =C2=A0 =C2=A0 omapdss_dpi_display_disable(dssdev);
>> =C2=A0}
>> --
>> 1.7.10
>>
>> --
>> To unsubscribe from this list: send the line "unsubscribe linux-omap=
" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at =C2=A0http://vger.kernel.org/majordomo-info.h=
tml
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap"=
 in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =C2=A0http://vger.kernel.org/majordomo-info.ht=
ml
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
