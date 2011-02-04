From: Kishore Kadiyala <kishorek.kadiyala@gmail.com>
Subject: Re: [PATCH v3 2/2] Input: ads7846: use gpio_request_one to configure pendown_gpio
Date: Fri, 4 Feb 2011 19:07:37 +0530
Message-ID: <AANLkTimynBC=0EiC1VOboqgYRC_swXnOB+EAm5aQwSmv@mail.gmail.com>
References: <1296746506-12221-1-git-send-email-sourav.poddar@ti.com>
 <20110203165405.GB12802@core.coreip.homeip.net> <20110203171953.GA13997@core.coreip.homeip.net>
 <20110204133250.GB2070@m-desktop>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
In-Reply-To: <20110204133250.GB2070@m-desktop>
Sender: linux-input-owner@vger.kernel.org
To: "G, Manjunath Kondaiah" <manjugk@ti.com>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Sourav Poddar <sourav.poddar@ti.com>, LW@karo-electronics.de, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-input@vger.kernel.org, gadiyar@ti.com, charu@ti.com, grinberg@compulab.co.il, balbi@ti.com
List-Id: linux-omap@vger.kernel.org

Manju,

Line wrapped, looks like your .muttrc needs to be configured for 80
characters limit.

Regards,
Kishore

On Fri, Feb 4, 2011 at 7:02 PM, G, Manjunath Kondaiah <manjugk@ti.com> =
wrote:
> On Thu, Feb 03, 2011 at 09:19:53AM -0800, Dmitry Torokhov wrote:
>> On Thu, Feb 03, 2011 at 08:54:05AM -0800, Dmitry Torokhov wrote:
>> > On Thu, Feb 03, 2011 at 08:51:46PM +0530, Sourav Poddar wrote:
>> > > The ads7846 driver requests a gpio but does not currently
>> > > configure it explicitly as an input. Use gpio_request_one
>> > > to request and configure it at one shot.
>> > >
>> > > Signed-off-by: Sourav Poddar <sourav.poddar@ti.com>
>> > > Cc: Dmitry Torokhov <dtor@mail.ru>
>> >
>> > Will apply this one, the other one is a bit messy IMO, will have t=
o
>> > think about it.
>> >
>>
>> Something like below should do I think.
> Patch looks good but it applies only on top of previous patch:
> https://patchwork.kernel.org/patch/529941/
>
> Why to have two patches for this fix?
>
> Both the patches can be merged as:
>
> diff --git a/drivers/input/touchscreen/ads7846.c
> b/drivers/input/touchscreen/ads7846.c
> index 14ea54b..940967b 100644
> --- a/drivers/input/touchscreen/ads7846.c
> +++ b/drivers/input/touchscreen/ads7846.c
> @@ -941,29 +941,30 @@ static int __devinit ads7846_setup_pendown(stru=
ct
> spi_device *spi, struct ads784
> =A0 =A0 =A0 =A0struct ads7846_platform_data *pdata =3D spi->dev.platf=
orm_data;
> =A0 =A0 =A0 =A0int err;
>
> - =A0 =A0 =A0 /* REVISIT when the irq can be triggered active-low, or=
 if for
> =A0 =A0 =A0 =A0some
> + =A0 =A0 =A0 /*
> + =A0 =A0 =A0 =A0* REVISIT when the irq can be triggered active-low, =
or if for
> some
> =A0 =A0 =A0 =A0 * reason the touchscreen isn't hooked up, we don't ne=
ed to
> =A0 =A0 =A0 =A0 * access
> =A0 =A0 =A0 =A0 * the pendown state.
> =A0 =A0 =A0 =A0 */
> - =A0 =A0 =A0 if (!pdata->get_pendown_state &&
> =A0 =A0 =A0 =A0!gpio_is_valid(pdata->gpio_pendown)) {
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_err(&spi->dev, "no get_pendown_stat=
e nor
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0gpio_pendown?\n");
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -EINVAL;
> - =A0 =A0 =A0 }
>
> =A0 =A0 =A0 =A0if (pdata->get_pendown_state) {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0ts->get_pendown_state =3D pdata->get_p=
endown_state;
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 return 0;
> - =A0 =A0 =A0 }
> + =A0 =A0 =A0 } else if (gpio_is_valid(pdata->gpio_pendown)) {
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 err =3D gpio_request_one(pdata->gpio_pe=
ndown,
> GPIOF_DIR_IN,
> +
> "ads7846_pendown");
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (err) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_err(&spi->dev, "fai=
led to request pendown
> GPIO%d\n",
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 pdata->=
gpio_pendown);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 return err;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
>
> - =A0 =A0 =A0 err =3D gpio_request(pdata->gpio_pendown, "ads7846_pend=
own");
> - =A0 =A0 =A0 if (err) {
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_err(&spi->dev, "failed to request p=
endown GPIO%d\n",
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 pdata->gpio_pendown);
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 return err;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 ts->gpio_pendown =3D pdata->gpio_pendow=
n;
> + =A0 =A0 =A0 } else {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_err(&spi->dev, "no get_pendown_stat=
e nor
> gpio_pendown?\n");
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -EINVAL;
> =A0 =A0 =A0 =A0}
>
> - =A0 =A0 =A0 ts->gpio_pendown =3D pdata->gpio_pendown;
> -
> =A0 =A0 =A0 =A0return 0;
> =A0}
>
> @@ -1353,7 +1354,7 @@ static int __devinit ads7846_probe(struct
> spi_device *spi)
> =A0err_put_regulator:
> =A0 =A0 =A0 =A0regulator_put(ts->reg);
> =A0err_free_gpio:
> - =A0 =A0 =A0 if (ts->gpio_pendown !=3D -1)
> + =A0 =A0 =A0 if (!ts->get_pendown_state)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0gpio_free(ts->gpio_pendown);
> =A0err_cleanup_filter:
> =A0 =A0 =A0 =A0if (ts->filter_cleanup)
> @@ -1383,8 +1384,13 @@ static int __devexit ads7846_remove(struct
> spi_device *spi)
> =A0 =A0 =A0 =A0regulator_disable(ts->reg);
> =A0 =A0 =A0 =A0regulator_put(ts->reg);
>
> - =A0 =A0 =A0 if (ts->gpio_pendown !=3D -1)
> + =A0 =A0 =A0 if (!ts->get_pendown_state) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 /*
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0* If we are not using specialized pe=
ndown method we
> must
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0* have been relying on gpio we set u=
p ourselves.
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0*/
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0gpio_free(ts->gpio_pendown);
> + =A0 =A0 =A0 }
>
> =A0 =A0 =A0 =A0if (ts->filter_cleanup)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0ts->filter_cleanup(ts->filter_data);
>
>
>>
>> --
>> Dmitry
>>
>>
>> Input: ads7846 - check proper condition when freeing gpio
>>
>> From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
>>
>> When driver uses custom pendown detection method gpio_pendown is not
>> set up and so we should not try to free it, otherwise we are present=
ed
>> with:
>>
>> ------------[ cut here ]------------
>> WARNING: at drivers/gpio/gpiolib.c:1258 gpio_free+0x100/0x12c()
>> Modules linked in:
>> [<c0061208>] (unwind_backtrace+0x0/0xe4) from [<c0091f58>](warn_slow=
path_common+0x4c/0x64)
>> [<c0091f58>] (warn_slowpath_common+0x4c/0x64) from [<c0091f88>](warn=
_slowpath_null+0x18/0x1c)
>> [<c0091f88>] (warn_slowpath_null+0x18/0x1c) from [<c024e610>](gpio_f=
ree+0x100/0x12c)
>> [<c024e610>] (gpio_free+0x100/0x12c) from [<c03e9fbc>](ads7846_probe=
+0xa38/0xc5c)
>> [<c03e9fbc>] (ads7846_probe+0xa38/0xc5c) from [<c02cff14>](spi_drv_p=
robe+0x18/0x1c)
>> [<c02cff14>] (spi_drv_probe+0x18/0x1c) from [<c028bca4>](driver_prob=
e_device+0xc8/0x184)
>> [<c028bca4>] (driver_probe_device+0xc8/0x184) from [<c028bdc8>](__dr=
iver_attach+0x68/0x8c)
>> [<c028bdc8>] (__driver_attach+0x68/0x8c) from [<c028b4c8>](bus_for_e=
ach_dev+0x48/0x74)
>> [<c028b4c8>] (bus_for_each_dev+0x48/0x74) from [<c028ae08>](bus_add_=
driver+0xa0/0x220)
>> [<c028ae08>] (bus_add_driver+0xa0/0x220) from [<c028c0c0>](driver_re=
gister+0xa8/0x134)
>> [<c028c0c0>] (driver_register+0xa8/0x134) from [<c0050550>](do_one_i=
nitcall+0xcc/0x1a4)
>> [<c0050550>] (do_one_initcall+0xcc/0x1a4) from [<c00084e4>](kernel_i=
nit+0x14c/0x214)
>> [<c00084e4>] (kernel_init+0x14c/0x214) from [<c005b494>](kernel_thre=
ad_exit+0x0/0x8)
>> ---[ end trace 4053287f8a5ec18f ]---
>>
>> Also rearrange ads7846_setup_pendown() to have only one exit point
>> returning success.
>>
>> Reported-by: Sourav Poddar <sourav.poddar@ti.com>
>> Signed-off-by: Dmitry Torokhov <dtor@mail.ru>
>> ---
>>
>> =A0drivers/input/touchscreen/ads7846.c | =A0 39 ++++++++++++++++++++=
---------------
>> =A01 files changed, 22 insertions(+), 17 deletions(-)
>>
>>
>> diff --git a/drivers/input/touchscreen/ads7846.c b/drivers/input/tou=
chscreen/ads7846.c
>> index 0e9492d..b1217e1 100644
>> --- a/drivers/input/touchscreen/ads7846.c
>> +++ b/drivers/input/touchscreen/ads7846.c
>> @@ -946,30 +946,30 @@ static int __devinit ads7846_setup_pendown(str=
uct spi_device *spi, struct ads784
>> =A0 =A0 =A0 struct ads7846_platform_data *pdata =3D spi->dev.platfor=
m_data;
>> =A0 =A0 =A0 int err;
>>
>> - =A0 =A0 /* REVISIT when the irq can be triggered active-low, or if=
 for some
>> + =A0 =A0 /*
>> + =A0 =A0 =A0* REVISIT when the irq can be triggered active-low, or =
if for some
>> =A0 =A0 =A0 =A0* reason the touchscreen isn't hooked up, we don't ne=
ed to access
>> =A0 =A0 =A0 =A0* the pendown state.
>> =A0 =A0 =A0 =A0*/
>> - =A0 =A0 if (!pdata->get_pendown_state && !gpio_is_valid(pdata->gpi=
o_pendown)) {
>> - =A0 =A0 =A0 =A0 =A0 =A0 dev_err(&spi->dev, "no get_pendown_state n=
or gpio_pendown?\n");
>> - =A0 =A0 =A0 =A0 =A0 =A0 return -EINVAL;
>> - =A0 =A0 }
>>
>> =A0 =A0 =A0 if (pdata->get_pendown_state) {
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 ts->get_pendown_state =3D pdata->get_pen=
down_state;
>> - =A0 =A0 =A0 =A0 =A0 =A0 return 0;
>> - =A0 =A0 }
>> + =A0 =A0 } else if (gpio_is_valid(pdata->gpio_pendown)) {
>> +
>> + =A0 =A0 =A0 =A0 =A0 =A0 err =3D gpio_request_one(pdata->gpio_pendo=
wn, GPIOF_DIR_IN,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 "ads7846_pendown");
>> + =A0 =A0 =A0 =A0 =A0 =A0 if (err) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_err(&spi->dev, "failed=
 to request pendown GPIO%d\n",
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 pdata->gpi=
o_pendown);
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 return err;
>> + =A0 =A0 =A0 =A0 =A0 =A0 }
>>
>> - =A0 =A0 err =3D gpio_request_one(pdata->gpio_pendown, GPIOF_DIR_IN=
,
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 "ads7846_pendown");
>> - =A0 =A0 if (err) {
>> - =A0 =A0 =A0 =A0 =A0 =A0 dev_err(&spi->dev, "failed to request pend=
own GPIO%d\n",
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 pdata->gpio_pendown);
>> - =A0 =A0 =A0 =A0 =A0 =A0 return err;
>> + =A0 =A0 =A0 =A0 =A0 =A0 ts->gpio_pendown =3D pdata->gpio_pendown;
>> + =A0 =A0 } else {
>> + =A0 =A0 =A0 =A0 =A0 =A0 dev_err(&spi->dev, "no get_pendown_state n=
or gpio_pendown?\n");
>> + =A0 =A0 =A0 =A0 =A0 =A0 return -EINVAL;
>> =A0 =A0 =A0 }
>>
>> - =A0 =A0 ts->gpio_pendown =3D pdata->gpio_pendown;
>> -
>> =A0 =A0 =A0 return 0;
>> =A0}
>>
>> @@ -1359,7 +1359,7 @@ static int __devinit ads7846_probe(struct spi_=
device *spi)
>> =A0 err_put_regulator:
>> =A0 =A0 =A0 regulator_put(ts->reg);
>> =A0 err_free_gpio:
>> - =A0 =A0 if (ts->gpio_pendown !=3D -1)
>> + =A0 =A0 if (!ts->get_pendown_state)
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 gpio_free(ts->gpio_pendown);
>> =A0 err_cleanup_filter:
>> =A0 =A0 =A0 if (ts->filter_cleanup)
>> @@ -1389,8 +1389,13 @@ static int __devexit ads7846_remove(struct sp=
i_device *spi)
>> =A0 =A0 =A0 regulator_disable(ts->reg);
>> =A0 =A0 =A0 regulator_put(ts->reg);
>>
>> - =A0 =A0 if (ts->gpio_pendown !=3D -1)
>> + =A0 =A0 if (!ts->get_pendown_state) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 /*
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0* If we are not using specialized pendo=
wn method we must
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0* have been relying on gpio we set up o=
urselves.
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0*/
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 gpio_free(ts->gpio_pendown);
>> + =A0 =A0 }
>>
>> =A0 =A0 =A0 if (ts->filter_cleanup)
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 ts->filter_cleanup(ts->filter_data);
>> --
>> To unsubscribe from this list: send the line "unsubscribe linux-omap=
" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at =A0http://vger.kernel.org/majordomo-info.html
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap"=
 in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =A0http://vger.kernel.org/majordomo-info.html
>
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
