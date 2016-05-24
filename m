From: Vignesh R <vigneshr@ti.com>
Subject: Re: [RFC PATCH 1/2] Input: rotary-encoder- Add support for absolute
 encoder
Date: Tue, 24 May 2016 10:39:26 +0530
Message-ID: <5743E206.2050602@ti.com>
References: <1463648641-6931-1-git-send-email-vigneshr@ti.com>
 <1463648641-6931-2-git-send-email-vigneshr@ti.com>
 <20160522102606.GB23704@pengutronix.de> <5742E710.9@ti.com>
 <20160523131808.GN23704@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
In-Reply-To: <20160523131808.GN23704@pengutronix.de>
Sender: linux-input-owner@vger.kernel.org
To: =?UTF-8?Q?Uwe_Kleine-K=c3=b6nig?= <u.kleine-koenig@pengutronix.de>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Rob Herring <robh+dt@kernel.org>, Tony Lindgren <tony@atomide.com>, Jonathan Corbet <corbet@lwn.net>, Johan Hovold <johan@kernel.org>, Sylvain Rochet <sylvain.rochet@finsecur.com>, Masanari Iida <standby24x7@gmail.com>, Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>, S Twiss <stwiss.opensource@diasemi.com>, Krzysztof Kozlowski <k.kozlowski@samsung.com>, Moritz Fischer <moritz.fischer@ettus.com>, Arnd Bergmann <arnd@arndb.de>, Geert Uytterhoeven <geert@linux-m68k.org>, Timo Teras <timo.teras@iki.fi>, Clifton Barnes <clifton.a.barnes@gmail.com>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>, "linux-omap@vger.kernel.org" <linux-omap@>
List-Id: linux-omap@vger.kernel.org

Hi,

On 05/23/2016 06:48 PM, Uwe Kleine-K=F6nig wrote:
> Hello,
>=20
> On Mon, May 23, 2016 at 04:48:40PM +0530, R, Vignesh wrote:
>> On 5/22/2016 3:56 PM, Uwe Kleine-K=F6nig wrote:
>>> Hello,
>>>
>>> On Thu, May 19, 2016 at 02:34:00PM +0530, Vignesh R wrote:
>>>> There are rotary-encoders where GPIO lines reflect the actual posi=
tion
>>>> of the rotary encoder dial. For example, if dial points to 9, then=
 four
>>>> GPIO lines connected to the rotary encoder will read HLLH(1001b =3D=
 9).
>>>> Add support for such rotary-encoder.
>>>> The driver relies on rotary-encoder,absolute-encoder DT property t=
o
>>>> detect such encoders.
>>>> Since, GPIO IRQs are not necessary to work with
>>>> such encoders, optional polling mode support is added using
>>>
>>> I don't understand this. It's necessary in the same way as with the
>>> already supported devices. I.e. you want to trigger an irq when the
>>> encoder is moved and then check for it's position in the handler.
>>>
>>
>> Unlike already supported device, there is no need to count steps or
>> determine the direction of rotation. Hence, IRQ is not a requirement=
,
>> periodically polling the gpio lines is more than sufficient. With
>> absolute encoder, you are able to determine the current position at =
any
>> time just by looking at the gpio inputs.
>=20
> The timing might not be that critical, but there is no reason to oper=
ate
> this device without irqs, is there?

No, I am not against the use of IRQs. In fact, my patches add support
for both IRQ based(default) and polling based operation(optional). If
rotary-encoder does not have interrupt capable gpio lines connected to
it (like am335x-ice) then one can make use of the polling mode support.

>=20
>> Suppose we poll device at t=3D0ms and see gpio values are LLLH(1), i=
f we
>> again poll device at t=3D500ms(which is what input_poll_dev helps to=
 do)
>> and see that gpio values is LLHH(3), then we know that rotary encode=
r
>> has changed to 3. This can be done w/o IRQ for absolute encoders.
>>
>>>> diff --git a/Documentation/devicetree/bindings/input/rotary-encode=
r.txt b/Documentation/devicetree/bindings/input/rotary-encoder.txt
>>>> index 6c9f0c8a846c..9c928dbd1500 100644
>>>> --- a/Documentation/devicetree/bindings/input/rotary-encoder.txt
>>>> +++ b/Documentation/devicetree/bindings/input/rotary-encoder.txt
>>>> @@ -12,6 +12,10 @@ Optional properties:
>>>>  - rotary-encoder,relative-axis: register a relative axis rather t=
han an
>>>>    absolute one. Relative axis will only generate +1/-1 events on =
the input
>>>>    device, hence no steps need to be passed.
>>>> +- rotary-encoder,absolute-encoder: support encoders where GPIO li=
nes
>>>> +  reflect the actual position of the rotary encoder dial. For exa=
mple,
>>>> +  if dial points to 9, then four GPIO lines read HLLH(1001b =3D 9=
).
>>>> +  In this case, rotary-encoder,steps-per-period needed not be def=
ined.
>>>
>>> IMHO this is wrong, I'd formalize this device as:
>>>
>>> 	{
>>> 		compatible =3D "rotary-encoder";
>>> 		gpios =3D <&gpio 19 1>, <&gpio 20 0>, <...>, <...>;
>>> 		rotary-encoder,encoding =3D "binary";
>>> 		rotary-encoder,steps =3D <16>;
>>> 		rotary-encoder,steps-per-period =3D <16>;
>>
>> The above bindings essential means quarter_period device. I would no=
t
>> like to bother with all the logic in rotary_encoder_quarter_period_i=
rq()
>> when we can know encoder->pos by directly reading state of gpio line=
s.
>=20
> OK, we have code that is more complex than it needs to be for your
> device. But your device is a special case of the supported devices, s=
o
> I'd say don't bother that there is more logic in the driver than you
> need and be lucky.
>=20

More complexity is just a overhead. Since, encoder can be turned at a
rate faster than handling of IRQs (rotary_encoder_quarter_period_irq()
is threaded IRQ hence, priority is not close to real time), some states
can be missed. rotary_encoder_quarter_period_irq() is not robust in thi=
s
case, reading gpios directly is more suitable option. I see similar
views expressed in previously[1]

[1]http://lists.infradead.org/pipermail/linux-arm-kernel/2015-December/=
391196.html

--=20
Regards
Vignesh
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
