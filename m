From: =?iso-8859-1?Q?M=E5ns_Rullg=E5rd?= <mans@mansr.com>
Subject: Re: RGB LED control (was Re: "advanced" LED controllers)
Date: Mon, 09 Mar 2015 11:50:56 +0000
Message-ID: <yw1xd24i1ja7.fsf@unicorn.mansr.com>
References: <20150219211424.GN13603@saruman.tx.rr.com>
	<CAMuHMdUUNzFYHzSR3yLCJuz11vuO3Z4yVWVxRQfutGY1KxZLPQ@mail.gmail.com>
	<CAAVeFuJ7DCs_=iESJRcXwyQ09eD57dZCxGG5CD3LD9_ZGZHP2A@mail.gmail.com>
	<20150302092111.GA19233@amd>
	<CAAVeFuK9eGO2TN+tgDyN8EFzEhgHOy5YCch+LaqS9PNaQXQ4Qg@mail.gmail.com>
	<20150308205732.GA385@amd>
	<CAMuHMdUVgZ1i5zymxmi3-i98n9UPTV=Sq-Oa=ieyfOzETW-DzA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-gpio-owner@vger.kernel.org>
In-Reply-To: <CAMuHMdUVgZ1i5zymxmi3-i98n9UPTV=Sq-Oa=ieyfOzETW-DzA@mail.gmail.com>
	(Geert Uytterhoeven's message of "Mon, 9 Mar 2015 09:08:37 +0100")
Sender: linux-gpio-owner@vger.kernel.org
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Pavel Machek <pavel@ucw.cz>, Alexandre Courbot <gnurou@gmail.com>, Felipe Balbi <balbi@ti.com>, Bryan Wu <cooloney@gmail.com>, Richard Purdie <rpurdie@rpsys.net>, "linux-leds@vger.kernel.org" <linux-leds@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux OMAP Mailing List <linux-omap@vger.kernel.org>, "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>
List-Id: linux-omap@vger.kernel.org

Geert Uytterhoeven <geert@linux-m68k.org> writes:

> Hi Pavel,
>
> On Sun, Mar 8, 2015 at 9:57 PM, Pavel Machek <pavel@ucw.cz> wrote:
>> Ok, so I played with RGB LED a bit, and we have quite a gap in
>> documentation: what 50% brightness means is non-trivial and very
>> important in case we want to do smooth blinking and color transition=
s.
>>
>> Signed-off-by: Pavel Machek <pavel@ucw.cz>
>>
>> diff --git a/Documentation/ABI/testing/sysfs-class-led b/Documentati=
on/ABI/testing/sysfs-class-led
>> index 3646ec8..649d7a6 100644
>> --- a/Documentation/ABI/testing/sysfs-class-led
>> +++ b/Documentation/ABI/testing/sysfs-class-led
>> @@ -8,6 +8,11 @@ Description:
>>                 non-zero brightness settings. The value is between 0=
 and
>>                 /sys/class/leds/<led>/max_brightness.
>>
>> +               If LED supports continuous brightness settings, 50% =
brightness
>> +               should correspond to 50% brightness perceived by hum=
an, in a similar
>> +               manner pixel brightness on monitor does (not 50% PWM=
).
>
> How many drivers do it right? How many don't?
>
> For those that don't, perhaps we handle the conversion between percei=
ved and
> pwm in the core, e.g. by adding a new flag to led_classdev.flags to i=
ndicate
> the need for conversion?

Some LED controllers do the right thing in hardware, so any adjustment
done in the core needs to be optional.

--=20
M=E5ns Rullg=E5rd
mans@mansr.com
--
To unsubscribe from this list: send the line "unsubscribe linux-gpio" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
