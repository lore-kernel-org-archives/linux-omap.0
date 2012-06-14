From: Zumeng Chen <zumeng.chen@windriver.com>
Subject: Re: [PATCH V2 5/5] Input: ads7846: set proper debounce time in driver
 level
Date: Thu, 14 Jun 2012 12:46:55 +0800
Message-ID: <4FD96CBF.5040106@windriver.com>
References: <zumeng.chen@gmail.com> <1339551850-20827-1-git-send-email-zumeng.chen@gmail.com> <1339551850-20827-6-git-send-email-zumeng.chen@gmail.com> <79CD15C6BA57404B839C016229A409A83EA4F07F@DBDE01.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
In-Reply-To: <79CD15C6BA57404B839C016229A409A83EA4F07F@DBDE01.ent.ti.com>
Sender: linux-input-owner@vger.kernel.org
To: "Hiremath, Vaibhav" <hvaibhav@ti.com>, mike@compulab.co.il
Cc: Zumeng Chen <zumeng.chen@gmail.com>, "tony@atomide.com" <tony@atomide.com>, "Hunter, Jon" <jon-hunter@ti.com>, "grinberg@compulab.co.il" <grinberg@compulab.co.il>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "Hilman, Kevin" <khilman@ti.com>, "Syed Mohammed, Khasim" <khasim@ti.com>, "Gupta, Ajay Kumar" <ajay.gupta@ti.com>, "dmitry.torokhov@gmail.com" <dmitry.torokhov@gmail.com>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>
List-Id: linux-omap@vger.kernel.org

=E4=BA=8E 2012=E5=B9=B406=E6=9C=8813=E6=97=A5 20:18, Hiremath, Vaibhav =
=E5=86=99=E9=81=93:
> On Wed, Jun 13, 2012 at 07:14:10, Zumeng Chen wrote:
>> From: Zumeng Chen<zumeng.chen@windriver.com>
>>
>> If we don't set proper debouce time for ads7846, then there are
>> flooded interrupt counters of ads7846 responding to one time
>> touch on screen, so the driver couldn't work well.
>>
>> And since most OMAP3 series boards pass NULL pointer of board_pdata
>> to omap_ads7846_init, so it's more proper to set it in driver level
>> after having gpio_request done.
>>
>> This patch has been validated on 3530evm.
>>
>> Signed-off-by: Zumeng Chen<zumeng.chen@windriver.com>
>> Signed-off-by: Syed Mohammed Khasim<khasim@ti.com>
>> ---
>>   drivers/input/touchscreen/ads7846.c |    4 ++++
>>   1 files changed, 4 insertions(+), 0 deletions(-)
>>
>> diff --git a/drivers/input/touchscreen/ads7846.c b/drivers/input/tou=
chscreen/ads7846.c
>> index f02028e..459ff29 100644
>> --- a/drivers/input/touchscreen/ads7846.c
>> +++ b/drivers/input/touchscreen/ads7846.c
>> @@ -980,6 +980,10 @@ static int __devinit ads7846_setup_pendown(stru=
ct spi_device *spi, struct ads784
>>   		}
>>
>>   		ts->gpio_pendown =3D pdata->gpio_pendown;
>> +#ifdef CONFIG_ARCH_OMAP3
>> +		/* 310 means about 10 microsecond for omap3 */
>> +		gpio_set_debounce(pdata->gpio_pendown, 310);
>> +#endif
>>
> Zumeng,
>
> With my sign-off you are changing the original code, that too
> without my sign-off and ack.
> I wouldn't mind you to submit patches from my tree, but the expectati=
on is
> if you are changing the original code, it should be under your sign-o=
ff.
Thanks, good to learn. I'll remove in next time.
> Coming to the patch, #ifdef in driver is not recommended, and this 10=
msec
> delay is specific to OMAP GPIO and driver should not be aware of this=
,
> that's where you will find the original patch handling it in board fi=
le.
According to the git blame of the board-omap3evm.c I think
96974a24 did a good thing to all the related codes for omap3
boards. So I think we can call board and driver as BSP level :-)

If #ifdef in driver can save many codes, I guess it's deserved.

Regards,
Zumeng
> Thanks,
> Vaibhav
>>   	} else {
>>   		dev_err(&spi->dev, "no get_pendown_state nor gpio_pendown?\n");
>> --=20
>> 1.7.5.4
>>
>>

--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
