From: Michael Trimarchi <michael@amarulasolutions.com>
Subject: Re: [PATCH v2 2/3] bq2415x_charger: Use power_supply notifier for automode
Date: Sun, 24 Nov 2013 18:18:03 +0100
Message-ID: <CAOf5uwkrep0PhOn67+9PHmP2A2Jxrp9DNK3BRp9D_sYu_PYvvw@mail.gmail.com>
References: <1378630239-10006-1-git-send-email-pali.rohar@gmail.com>
	<1384856285-19593-1-git-send-email-pali.rohar@gmail.com>
	<1384856285-19593-3-git-send-email-pali.rohar@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-wi0-f169.google.com ([209.85.212.169]:59594 "EHLO
	mail-wi0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753246Ab3KXRSF convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sun, 24 Nov 2013 12:18:05 -0500
Received: by mail-wi0-f169.google.com with SMTP id hm6so3410967wib.0
        for <linux-omap@vger.kernel.org>; Sun, 24 Nov 2013 09:18:04 -0800 (PST)
In-Reply-To: <1384856285-19593-3-git-send-email-pali.rohar@gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: =?ISO-8859-1?Q?Pali_Roh=E1r?= <pali.rohar@gmail.com>
Cc: Anton Vorontsov <anton@enomsg.org>, David Woodhouse <dwmw2@infradead.org>, Tony Lindgren <tony@atomide.com>, Russell King <linux@arm.linux.org.uk>, linux-kernel@vger.kernel.org, Linux OMAP Mailing List <linux-omap@vger.kernel.org>, freemangordon@abv.bg, aaro.koskinen@iki.fi, pavel@ucw.cz

Hi

On Tue, Nov 19, 2013 at 11:18 AM, Pali Roh=E1r <pali.rohar@gmail.com> w=
rote:
> This patch removing set_mode_hook function from board data and replac=
ing it with
> new string variable of notifier power supply device. After this chang=
e it is
> possible to add DT support because driver does not need specific boar=
d function
> anymore. Only static data and name of power supply device is required=
=2E
>
> Signed-off-by: Pali Roh=E1r <pali.rohar@gmail.com>
> ---
>  drivers/power/bq2415x_charger.c       |   77 +++++++++++++++++++++++=
++--------
>  include/linux/power/bq2415x_charger.h |   48 +++-----------------
>  2 files changed, 65 insertions(+), 60 deletions(-)
>
> diff --git a/drivers/power/bq2415x_charger.c b/drivers/power/bq2415x_=
charger.c
> index 0727f92..d89583d 100644
> --- a/drivers/power/bq2415x_charger.c
> +++ b/drivers/power/bq2415x_charger.c
> @@ -1,7 +1,7 @@
>  /*
>   * bq2415x charger driver
>   *
> - * Copyright (C) 2011-2012  Pali Roh=E1r <pali.rohar@gmail.com>
> + * Copyright (C) 2011-2013  Pali Roh=E1r <pali.rohar@gmail.com>
>   *
>   * This program is free software; you can redistribute it and/or mod=
ify
>   * it under the terms of the GNU General Public License as published=
 by
> @@ -170,6 +170,7 @@ struct bq2415x_device {
>         struct bq2415x_platform_data init_data;
>         struct power_supply charger;
>         struct delayed_work work;
> +       struct notifier_block nb;
>         enum bq2415x_mode reported_mode;/* mode reported by hook func=
tion */
>         enum bq2415x_mode mode;         /* current configured mode */
>         enum bq2415x_chip chip;
> @@ -791,24 +792,53 @@ static int bq2415x_set_mode(struct bq2415x_devi=
ce *bq, enum bq2415x_mode mode)
>
>  }
>
> -/* hook function called by other driver which set reported mode */
> -static void bq2415x_hook_function(enum bq2415x_mode mode, void *data=
)
> +static int bq2415x_notifier_call(struct notifier_block *nb,
> +               unsigned long val, void *v)
>  {
> -       struct bq2415x_device *bq =3D data;
> +       struct bq2415x_device *bq =3D
> +               container_of(nb, struct bq2415x_device, nb);
> +       struct power_supply *psy =3D v;
> +       enum bq2415x_mode mode;
> +       union power_supply_propval prop;
> +       int ret;
> +       int mA;
>
> -       if (!bq)
> -               return;
> +       if (val !=3D PSY_EVENT_PROP_CHANGED)
> +               return NOTIFY_OK;
> +
> +       if (strcmp(psy->name, bq->init_data.notify_device) !=3D 0)
> +               return NOTIFY_OK;
> +
> +       dev_dbg(bq->dev, "notifier call was called\n");
> +
> +       ret =3D psy->get_property(psy, POWER_SUPPLY_PROP_CURRENT_MAX,=
 &prop);
> +       if (ret !=3D 0)
> +               return NOTIFY_OK;

So you can read this value without any type of synchronization with
the power_supply_core
and sysfs implementation?


Michael

> +
> +       mA =3D prop.intval;
> +
> +       if (mA =3D=3D 0)
> +               mode =3D BQ2415X_MODE_OFF;
> +       else if (mA < 500)
> +               mode =3D BQ2415X_MODE_NONE;
> +       else if (mA < 1800)
> +               mode =3D BQ2415X_MODE_HOST_CHARGER;
> +       else
> +               mode =3D BQ2415X_MODE_DEDICATED_CHARGER;
> +
> +       if (bq->reported_mode =3D=3D mode)
> +               return NOTIFY_OK;
>
> -       dev_dbg(bq->dev, "hook function was called\n");
>         bq->reported_mode =3D mode;
>
>         /* if automode is not enabled do not tell about reported_mode=
 */
>         if (bq->automode < 1)
> -               return;
> +               return NOTIFY_OK;
>
>         sysfs_notify(&bq->charger.dev->kobj, NULL, "reported_mode");
>         bq2415x_set_mode(bq, bq->reported_mode);
>
> +       return NOTIFY_OK;
>  }
>
>  /**** timer functions ****/
> @@ -1508,6 +1538,7 @@ static int bq2415x_probe(struct i2c_client *cli=
ent,
>         int num;
>         char *name;
>         struct bq2415x_device *bq;
> +       struct power_supply *psy;
>
>         if (!client->dev.platform_data) {
>                 dev_err(&client->dev, "platform data not set\n");
> @@ -1569,16 +1600,27 @@ static int bq2415x_probe(struct i2c_client *c=
lient,
>                 goto error_4;
>         }
>
> -       if (bq->init_data.set_mode_hook) {
> -               if (bq->init_data.set_mode_hook(
> -                               bq2415x_hook_function, bq)) {
> -                       bq->automode =3D 1;
> +       if (bq->init_data.notify_device) {
> +               bq->nb.notifier_call =3D bq2415x_notifier_call;
> +               ret =3D power_supply_reg_notifier(&bq->nb);
> +               if (ret) {
> +                       dev_err(bq->dev, "failed to reg notifier: %d\=
n", ret);
> +                       goto error_5;
> +               }
> +               psy =3D power_supply_get_by_name(bq->init_data.notify=
_device);
> +               if (psy) {
> +                       /* Query for initial reported_mode and set it=
 */
> +                       bq2415x_notifier_call(&bq->nb,
> +                                       PSY_EVENT_PROP_CHANGED, psy);
>                         bq2415x_set_mode(bq, bq->reported_mode);
> -                       dev_info(bq->dev, "automode enabled\n");
>                 } else {
> -                       bq->automode =3D -1;
> -                       dev_info(bq->dev, "automode failed\n");
> +                       dev_info(bq->dev, "notifier power supply devi=
ce (%s) "
> +                               "for automode is not registred yet...=
 "
> +                               "automode will not work without that =
device\n",
> +                               bq->init_data.notify_device);
>                 }
> +               bq->automode =3D 1;
> +               dev_info(bq->dev, "automode enabled\n");
>         } else {
>                 bq->automode =3D -1;
>                 dev_info(bq->dev, "automode not supported\n");
> @@ -1590,6 +1632,7 @@ static int bq2415x_probe(struct i2c_client *cli=
ent,
>         dev_info(bq->dev, "driver registered\n");
>         return 0;
>
> +error_5:
>  error_4:
>         bq2415x_sysfs_exit(bq);
>  error_3:
> @@ -1610,8 +1653,8 @@ static int bq2415x_remove(struct i2c_client *cl=
ient)
>  {
>         struct bq2415x_device *bq =3D i2c_get_clientdata(client);
>
> -       if (bq->init_data.set_mode_hook)
> -               bq->init_data.set_mode_hook(NULL, NULL);
> +       if (bq->init_data.notify_device)
> +               power_supply_unreg_notifier(&bq->nb);
>
>         bq2415x_sysfs_exit(bq);
>         bq2415x_power_supply_exit(bq);
> diff --git a/include/linux/power/bq2415x_charger.h b/include/linux/po=
wer/bq2415x_charger.h
> index 8dcc0f4..50762af 100644
> --- a/include/linux/power/bq2415x_charger.h
> +++ b/include/linux/power/bq2415x_charger.h
> @@ -1,7 +1,7 @@
>  /*
>   * bq2415x charger driver
>   *
> - * Copyright (C) 2011-2012  Pali Roh=E1r <pali.rohar@gmail.com>
> + * Copyright (C) 2011-2013  Pali Roh=E1r <pali.rohar@gmail.com>
>   *
>   * This program is free software; you can redistribute it and/or mod=
ify
>   * it under the terms of the GNU General Public License as published=
 by
> @@ -31,46 +31,9 @@
>   * termination current. It it is less or equal to zero, configuring =
charge
>   * and termination current will not be possible.
>   *
> - * Function set_mode_hook is needed for automode (setting correct cu=
rrent
> - * limit when charger is connected/disconnected or setting boost mod=
e).
> - * When is NULL, automode function is disabled. When is not NULL, it=
 must
> - * have this prototype:
> - *
> - *    int (*set_mode_hook)(
> - *      void (*hook)(enum bq2415x_mode mode, void *data),
> - *      void *data)
> - *
> - * hook is hook function (see below) and data is pointer to driver p=
rivate
> - * data
> - *
> - * bq2415x driver will call it as:
> - *
> - *    platform_data->set_mode_hook(bq2415x_hook_function, bq2415x_de=
vice);
> - *
> - * Board/platform function set_mode_hook return non zero value when =
hook
> - * function was successful registered. Platform code should call tha=
t hook
> - * function (which get from pointer, with data) every time when char=
ger
> - * was connected/disconnected or require to enable boost mode. bq241=
5x
> - * driver then will set correct current limit, enable/disable charge=
r or
> - * boost mode.
> - *
> - * Hook function has this prototype:
> - *
> - *    void hook(enum bq2415x_mode mode, void *data);
> - *
> - * mode is bq2415x mode (charger or boost)
> - * data is pointer to driver private data (which get from
> - * set_charger_type_hook)
> - *
> - * When bq driver is being unloaded, it call function:
> - *
> - *    platform_data->set_mode_hook(NULL, NULL);
> - *
> - * (hook function and driver private data are NULL)
> - *
> - * After that board/platform code must not call driver hook function=
! It
> - * is possible that pointer to hook function will not be valid and c=
alling
> - * will cause undefined result.
> + * For automode support is needed to provide name of power supply de=
vice
> + * in value notify_device. Device driver must immediately report pro=
perty
> + * POWER_SUPPLY_PROP_CURRENT_MAX when current changed.
>   */
>
>  /* Supported modes with maximal current limit */
> @@ -89,8 +52,7 @@ struct bq2415x_platform_data {
>         int charge_current;             /* mA */
>         int termination_current;        /* mA */
>         int resistor_sense;             /* m ohm */
> -       int (*set_mode_hook)(void (*hook)(enum bq2415x_mode mode, voi=
d *data),
> -                            void *data);
> +       const char *notify_device;      /* name */
>  };
>
>  #endif
> --
> 1.7.9.5
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap"=
 in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
