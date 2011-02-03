From: "Poddar, Sourav" <sourav.poddar@ti.com>
Subject: Re: [PATCHv2 1/2] ads7846: OMAP3: Removal of warnings backtrace in bootup
Date: Thu, 3 Feb 2011 17:10:31 +0530
Message-ID: <AANLkTimro-sb91Ow1v2fmCp-SF4GWBEeRrEe_ikjSuHr@mail.gmail.com>
References: <1296726514-32146-1-git-send-email-sourav.poddar@ti.com>
	<4D4A7F13.8080502@compulab.co.il>
	<4D4A80D3.2060407@compulab.co.il>
	<AANLkTi=U1qo=udB=tMyuA2HcnCS4EmreaVDbw2vQ9dY8@mail.gmail.com>
	<4D4A8DA0.1010806@compulab.co.il>
	<19786.37462.662253.3644@ipc1.ka-ro>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
In-Reply-To: <19786.37462.662253.3644@ipc1.ka-ro>
Sender: linux-input-owner@vger.kernel.org
To: =?ISO-8859-1?Q?Lothar_Wa=DFmann?= <LW@karo-electronics.de>
Cc: Igor Grinberg <grinberg@compulab.co.il>, gadiyar@ti.com, dmitry.torokhov@gmail.com, balbi@ti.com, Kishon Vijay Abraham I <kishon@ti.com>, linux-input@vger.kernel.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, charu@ti.com
List-Id: linux-omap@vger.kernel.org

On Thu, Feb 3, 2011 at 5:02 PM, Lothar Wa=DFmann <LW@karo-electronics.d=
e> wrote:
> Hi,
>
> Igor Grinberg writes:
>>
>>
>> On 02/03/11 13:00, Poddar, Sourav wrote:
>>
>> > On Thu, Feb 3, 2011 at 3:47 PM, Igor Grinberg <grinberg@compulab.c=
o.il> wrote:
>> >> if (pdata->get_pendown_state) {
>> >> =A0 =A0 =A0 =A0ts->get_pendown_state =3D pdata->get_pendown_state=
;
>> >> =A0 =A0 =A0 =A0ts->gpio_pendown =3D -1;
>> >> =A0 =A0 =A0 =A0return 0;
>> >> }
>> > Yes we can do so .I initialise it at a place where other variables
>> > =A0where initialised.
>> >
>> >>> Also, why don't we use -EINVAL for the invalid gpio number inste=
ad of -1 constant?
>> >>>
>> > =A0I used -1 because conditional check done in probe ads7846_probe=
 function
>> > =A0used this value.
>> >
>> > =A0 err_free_gpio:
>> > =A0 =A0 =A0 =A0 if (ts->gpio_pendown !=3D -1)
>> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 gpio_free(ts->gpio_pendown);
>> >
>>
>> Well I understand that and that's why in my proposal I used -1 also,=
 but
>> I thought we can make it even better if we switch to -EINVAL
>> (though wanted to check if there are any reasonable objections)
>> and while you are at this, may be you are willing also to submit a p=
atch for this?
>>
> Since ts->gpio_pendown is used as a GPIO number, the check with
> gpio_is_valid(), as suggested by Felipe Balbi, would be the most
> sensible thing to do here.
>

Yes,it seems gpio_is_valid() would be more sensible to use.
 Will post a patch using gpio_is_valid() asap.
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
