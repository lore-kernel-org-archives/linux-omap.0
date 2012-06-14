From: Zumeng Chen <zumeng.chen@windriver.com>
Subject: Re: [PATCH V2 5/5] Input: ads7846: set proper debounce time in driver
 level
Date: Thu, 14 Jun 2012 16:18:29 +0800
Message-ID: <4FD99E55.80603@windriver.com>
References: <zumeng.chen@gmail.com> <1339551850-20827-1-git-send-email-zumeng.chen@gmail.com> <1339551850-20827-6-git-send-email-zumeng.chen@gmail.com> <79CD15C6BA57404B839C016229A409A83EA4F07F@DBDE01.ent.ti.com> <4FD96CBF.5040106@windriver.com> <4FD98856.8070601@compulab.co.il> <4FD98DDA.9050806@windriver.com> <4FD99B91.9030705@compulab.co.il>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
In-Reply-To: <4FD99B91.9030705@compulab.co.il>
Sender: linux-input-owner@vger.kernel.org
To: Igor Grinberg <grinberg@compulab.co.il>
Cc: "Hiremath, Vaibhav" <hvaibhav@ti.com>, mike@compulab.co.il, Zumeng Chen <zumeng.chen@gmail.com>, "tony@atomide.com" <tony@atomide.com>, "Hunter, Jon" <jon-hunter@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "Hilman, Kevin" <khilman@ti.com>, "Syed Mohammed, Khasim" <khasim@ti.com>, "Gupta, Ajay Kumar" <ajay.gupta@ti.com>, "dmitry.torokhov@gmail.com" <dmitry.torokhov@gmail.com>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>
List-Id: linux-omap@vger.kernel.org

=E4=BA=8E 2012=E5=B9=B406=E6=9C=8814=E6=97=A5 16:06, Igor Grinberg =E5=86=
=99=E9=81=93:
> On 06/14/12 10:08, Zumeng Chen wrote:
>> =E4=BA=8E 2012=E5=B9=B406=E6=9C=8814=E6=97=A5 14:44, Igor Grinberg =E5=
=86=99=E9=81=93:
>>> On 06/14/12 07:46, Zumeng Chen wrote:
>>>>> =E4=BA=8E 2012=E5=B9=B406=E6=9C=8813=E6=97=A5 20:18, Hiremath, Va=
ibhav =E5=86=99=E9=81=93:
>>>>>>> On Wed, Jun 13, 2012 at 07:14:10, Zumeng Chen wrote:
>>>>>>>>> From: Zumeng Chen<zumeng.chen@windriver.com>
>>>>>>>>>
>>>>>>>>> If we don't set proper debouce time for ads7846, then there a=
re
>>>>>>>>> flooded interrupt counters of ads7846 responding to one time
>>>>>>>>> touch on screen, so the driver couldn't work well.
>>>>>>>>>
>>>>>>>>> And since most OMAP3 series boards pass NULL pointer of board=
_pdata
>>>>>>>>> to omap_ads7846_init, so it's more proper to set it in driver=
 level
>>>>>>>>> after having gpio_request done.
>>>>>>>>>
>>>>>>>>> This patch has been validated on 3530evm.
>>>>>>>>>
>>>>>>>>> Signed-off-by: Zumeng Chen<zumeng.chen@windriver.com>
>>>>>>>>> Signed-off-by: Syed Mohammed Khasim<khasim@ti.com>
>>>>>>>>> ---
>>>>>>>>>    drivers/input/touchscreen/ads7846.c |    4 ++++
>>>>>>>>>    1 files changed, 4 insertions(+), 0 deletions(-)
>>>>>>>>>
>>>>>>>>> diff --git a/drivers/input/touchscreen/ads7846.c b/drivers/in=
put/touchscreen/ads7846.c
>>>>>>>>> index f02028e..459ff29 100644
>>>>>>>>> --- a/drivers/input/touchscreen/ads7846.c
>>>>>>>>> +++ b/drivers/input/touchscreen/ads7846.c
>>>>>>>>> @@ -980,6 +980,10 @@ static int __devinit ads7846_setup_pendo=
wn(struct spi_device *spi, struct ads784
>>>>>>>>>            }
>>>>>>>>>
>>>>>>>>>            ts->gpio_pendown =3D pdata->gpio_pendown;
>>>>>>>>> +#ifdef CONFIG_ARCH_OMAP3
>>>>>>>>> +        /* 310 means about 10 microsecond for omap3 */
>>>>>>>>> +        gpio_set_debounce(pdata->gpio_pendown, 310);
>>>>>>>>> +#endif
>>>>>>>>>
>>>>>>> Zumeng,
>>>>>>>
>>>>>>> With my sign-off you are changing the original code, that too
>>>>>>> without my sign-off and ack.
>>>>>>> I wouldn't mind you to submit patches from my tree, but the exp=
ectation is
>>>>>>> if you are changing the original code, it should be under your =
sign-off.
>>>>> Thanks, good to learn. I'll remove in next time.
>>>>>>> Coming to the patch, #ifdef in driver is not recommended, and t=
his 10msec
>>>>>>> delay is specific to OMAP GPIO and driver should not be aware o=
f this,
>>>>>>> that's where you will find the original patch handling it in bo=
ard file.
>>>>> According to the git blame of the board-omap3evm.c I think
>>>>> 96974a24 did a good thing to all the related codes for omap3
>>>>> boards. So I think we can call board and driver as BSP level :-)
>>>>>
>>>>> If #ifdef in driver can save many codes, I guess it's deserved.
>>> No, platform/board specific ifdefs in the generic driver code are n=
ever
>>> deserved.
>>> How about the attached patch, does it fix the problem for you?
>> Sorry Igor, I just read your patch, yes, most are there, and we
>> just have to set get_pendown_state as you early said. Really
>> *thanks* for your drive :)
> No, with my patch, you don't need the get_pendown_state() and
> you don't need to change the board-omap3evm.c ADS7846 related code.
> So, I'm going to submit my patch properly.
=46eel free to do that

>> Regards,
>> Zumeng
>>> -- Regards, Igor.
>>> ads7846.patch
>>>
>>>
>>> diff --git a/arch/arm/mach-omap2/common-board-devices.c b/arch/arm/=
mach-omap2/common-board-devices.c
>>> index 1706ebc..c187586 100644
>>> --- a/arch/arm/mach-omap2/common-board-devices.c
>>> +++ b/arch/arm/mach-omap2/common-board-devices.c
>>> @@ -63,28 +63,30 @@ void __init omap_ads7846_init(int bus_num, int =
gpio_pendown, int gpio_debounce,
>>>   	struct spi_board_info *spi_bi =3D&ads7846_spi_board_info;
>>>   	int err;
>>>
>>> -	if (board_pdata&&  board_pdata->get_pendown_state) {
>>> -		err =3D gpio_request_one(gpio_pendown, GPIOF_IN, "TSPenDown");
>>> -		if (err) {
>>> -			pr_err("Couldn't obtain gpio for TSPenDown: %d\n", err);
>>> -			return;
>>> -		}
>>> -		gpio_export(gpio_pendown, 0);
>>> -
>>> -		if (gpio_debounce)
>>> -			gpio_set_debounce(gpio_pendown, gpio_debounce);
>>> +	err =3D gpio_request_one(gpio_pendown, GPIOF_IN, "TSPenDown");
>>> +	if (err) {
>>> +		pr_err("Couldn't obtain gpio for TSPenDown: %d\n", err);
>>> +		return;
>>>   	}
>>>   =09
>>> +	if (gpio_debounce)
>>> +		gpio_set_debounce(gpio_pendown, gpio_debounce);
>>> +
>>>   	spi_bi->bus_num	=3D bus_num;
>>>   	spi_bi->irq	=3D gpio_to_irq(gpio_pendown);
>>>
>>>   	if (board_pdata) {
>>>   		board_pdata->gpio_pendown =3D gpio_pendown;
>>>   		spi_bi->platform_data =3D board_pdata;
>>> +		if (board_pdata->get_pendown_state)
>>> +			gpio_export(gpio_pendown, 0);
>>>   	} else {
>>>   		ads7846_config.gpio_pendown =3D gpio_pendown;
>>>   	}
>>>
>>> +	if (!board_pdata || (board_pdata&&  !board_pdata->get_pendown_sta=
te))
>>> +		gpio_free(gpio_pendown);
>>> +
>>>   	spi_register_board_info(&ads7846_spi_board_info, 1);
>>>   }
>>>   #else

--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
