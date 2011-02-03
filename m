From: "Poddar, Sourav" <sourav.poddar@ti.com>
Subject: Re: [PATCHv2 1/2] ads7846: OMAP3: Removal of warnings backtrace in bootup
Date: Thu, 3 Feb 2011 16:30:29 +0530
Message-ID: <AANLkTi=U1qo=udB=tMyuA2HcnCS4EmreaVDbw2vQ9dY8@mail.gmail.com>
References: <1296726514-32146-1-git-send-email-sourav.poddar@ti.com>
	<4D4A7F13.8080502@compulab.co.il>
	<4D4A80D3.2060407@compulab.co.il>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
In-Reply-To: <4D4A80D3.2060407@compulab.co.il>
Sender: linux-input-owner@vger.kernel.org
To: Igor Grinberg <grinberg@compulab.co.il>
Cc: dmitry.torokhov@gmail.com, balbi@ti.com, Kishon Vijay Abraham I <kishon@ti.com>, charu@ti.com, linux-input@vger.kernel.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, gadiyar@ti.com
List-Id: linux-omap@vger.kernel.org

On Thu, Feb 3, 2011 at 3:47 PM, Igor Grinberg <grinberg@compulab.co.il>=
 wrote:
> Hi again,
>
> On 02/03/11 12:10, Igor Grinberg wrote:
>
>> Hi,
>>
>> On 02/03/11 11:48, Sourav Poddar wrote:
>>
>>> gpio_pendown in ads7846_probe is not getting initalized (defaulted =
to 0)
>>> resulting in gpio_free to be called without a gpio_request. This
>>> results in the following backtrace in bootup.
>>>
>>> ------------[ cut here ]------------
>>> WARNING: at drivers/gpio/gpiolib.c:1258 gpio_free+0x100/0x12c()
>>> Modules linked in:
>>> [<c0061208>] (unwind_backtrace+0x0/0xe4) from [<c0091f58>]
>>> =A0 =A0 =A0(warn_slowpath_common+0x4c/0x64)
>>> [<c0091f58>] (warn_slowpath_common+0x4c/0x64) from [<c0091f88>]
>>> =A0 =A0 =A0(warn_slowpath_null+0x18/0x1c)
>>> [<c0091f88>] (warn_slowpath_null+0x18/0x1c) from [<c024e610>]
>>> =A0 =A0 =A0(gpio_free+0x100/0x12c)
>>> [<c024e610>] (gpio_free+0x100/0x12c) from [<c03e9fbc>]
>>> =A0 =A0 =A0(ads7846_probe+0xa38/0xc5c)
>>> [<c03e9fbc>] (ads7846_probe+0xa38/0xc5c) from [<c02cff14>]
>>> =A0 =A0 =A0(spi_drv_probe+0x18/0x1c)
>>> [<c02cff14>] (spi_drv_probe+0x18/0x1c) from [<c028bca4>]
>>> =A0 =A0 =A0(driver_probe_device+0xc8/0x184)
>>> [<c028bca4>] (driver_probe_device+0xc8/0x184) from [<c028bdc8>]
>>> =A0 =A0 =A0(__driver_attach+0x68/0x8c)
>>> [<c028bdc8>] (__driver_attach+0x68/0x8c) from [<c028b4c8>]
>>> =A0 =A0 =A0(bus_for_each_dev+0x48/0x74)
>>> [<c028b4c8>] (bus_for_each_dev+0x48/0x74) from [<c028ae08>]
>>> =A0 =A0 =A0(bus_add_driver+0xa0/0x220)
>>> [<c028ae08>] (bus_add_driver+0xa0/0x220) from [<c028c0c0>]
>>> =A0 =A0 =A0(driver_register+0xa8/0x134)
>>> [<c028c0c0>] (driver_register+0xa8/0x134) from [<c0050550>]
>>> =A0 =A0 =A0(do_one_initcall+0xcc/0x1a4)
>>> [<c0050550>] (do_one_initcall+0xcc/0x1a4) from [<c00084e4>]
>>> =A0 =A0 =A0(kernel_init+0x14c/0x214)
>>> [<c00084e4>] (kernel_init+0x14c/0x214) from [<c005b494>]
>>> =A0 =A0 =A0(kernel_thread_exit+0x0/0x8)
>>> ---[ end trace 4053287f8a5ec18f ]---
>>>
>>> Initializing gpio_pendown in ads7846_probe to -1 before
>>> ads7846_setup_pendown function removes the above backtrace
>>> warning.
>>>
>>> Signed-off-by: Sourav Poddar <sourav.poddar@ti.com>
>>> Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
>>> ---
>>> =A0drivers/input/touchscreen/ads7846.c | =A0 =A01 +
>>> =A01 files changed, 1 insertions(+), 0 deletions(-)
>>>
>>> diff --git a/drivers/input/touchscreen/ads7846.c b/drivers/input/to=
uchscreen/ads7846.c
>>> index 14ea54b..036f245 100644
>>> --- a/drivers/input/touchscreen/ads7846.c
>>> +++ b/drivers/input/touchscreen/ads7846.c
>>> @@ -1221,6 +1221,7 @@ static int __devinit ads7846_probe(struct spi=
_device *spi)
>>> =A0 =A0 =A0ts->input =3D input_dev;
>>> =A0 =A0 =A0ts->vref_mv =3D pdata->vref_mv;
>>> =A0 =A0 =A0ts->swap_xy =3D pdata->swap_xy;
>>> + =A0 =A0ts->gpio_pendown =3D -1;
>> Wouldn't it be better putting this into ads7846_setup_pendown() func=
tion?
>> This will keep the whole gpio_pendown initialization code close toge=
ther.
>> Something like:
>>
>> if (pdata->get_pendown_state) {
>> <http://git.kernel.org/?p=3Dlinux/kernel/git/torvalds/linux-2.6.git;=
a=3Dblob;f=3Ddrivers/input/touchscreen/ads7846.c;h=3D14ea54b78e4648b0ac=
8a3403440f6f5d120dfdd9;hb=3DHEAD#l954> =A0 =A0 =A0 =A0ts->get_pendown_s=
tate =3D pdata->get_pendown_state;
>> =A0 =A0 =A0 =A0 ts->gpio_pendown =3D -1;
>> <http://git.kernel.org/?p=3Dlinux/kernel/git/torvalds/linux-2.6.git;=
a=3Dblob;f=3Ddrivers/input/touchscreen/ads7846.c;h=3D14ea54b78e4648b0ac=
8a3403440f6f5d120dfdd9;hb=3DHEAD#l955> =A0 =A0 =A0 =A0return 0;
>> <http://git.kernel.org/?p=3Dlinux/kernel/git/torvalds/linux-2.6.git;=
a=3Dblob;f=3Ddrivers/input/touchscreen/ads7846.c;h=3D14ea54b78e4648b0ac=
8a3403440f6f5d120dfdd9;hb=3DHEAD#l956>}
>
> Sorry for the above links (this is embarrassing, but I've got played =
by my email client),
> I meant of course:
>
> if (pdata->get_pendown_state) {
> =A0 =A0 =A0 =A0ts->get_pendown_state =3D pdata->get_pendown_state;
> =A0 =A0 =A0 =A0ts->gpio_pendown =3D -1;
> =A0 =A0 =A0 =A0return 0;
> }
>

Yes we can do so .I initialise it at a place where other variables
 where initialised.


>>
>> Also, why don't we use -EINVAL for the invalid gpio number instead o=
f -1 constant?
>>

 I used -1 because conditional check done in probe ads7846_probe functi=
on
 used this value.

  err_free_gpio:
        if (ts->gpio_pendown !=3D -1)
                gpio_free(ts->gpio_pendown);
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
