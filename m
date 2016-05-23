From: "R, Vignesh" <vigneshr@ti.com>
Subject: Re: [RFC PATCH 1/2] Input: rotary-encoder- Add support for absolute
 encoder
Date: Mon, 23 May 2016 16:48:40 +0530
Message-ID: <5742E710.9@ti.com>
References: <1463648641-6931-1-git-send-email-vigneshr@ti.com>
 <1463648641-6931-2-git-send-email-vigneshr@ti.com>
 <20160522102606.GB23704@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
In-Reply-To: <20160522102606.GB23704@pengutronix.de>
Sender: linux-input-owner@vger.kernel.org
To: =?UTF-8?Q?Uwe_Kleine-K=c3=b6nig?= <u.kleine-koenig@pengutronix.de>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Rob Herring <robh+dt@kernel.org>, Tony Lindgren <tony@atomide.com>, Jonathan Corbet <corbet@lwn.net>, Johan Hovold <johan@kernel.org>, Sylvain Rochet <sylvain.rochet@finsecur.com>, Masanari Iida <standby24x7@gmail.com>, Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>, S Twiss <stwiss.opensource@diasemi.com>, Krzysztof Kozlowski <k.kozlowski@samsung.com>, Moritz Fischer <moritz.fischer@ettus.com>, Arnd Bergmann <arnd@arndb.de>, Geert Uytterhoeven <geert@linux-m68k.org>, Timo Teras <timo.teras@iki.fi>, Clifton Barnes <clifton.a.barnes@gmail.com>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>, "linux-omap@vger.kernel.org" <linux-omap@>
List-Id: linux-omap@vger.kernel.org



On 5/22/2016 3:56 PM, Uwe Kleine-K=F6nig wrote:
> Hello,
>=20
> On Thu, May 19, 2016 at 02:34:00PM +0530, Vignesh R wrote:
>> There are rotary-encoders where GPIO lines reflect the actual positi=
on
>> of the rotary encoder dial. For example, if dial points to 9, then f=
our
>> GPIO lines connected to the rotary encoder will read HLLH(1001b =3D =
9).
>> Add support for such rotary-encoder.
>> The driver relies on rotary-encoder,absolute-encoder DT property to
>> detect such encoders.
>> Since, GPIO IRQs are not necessary to work with
>> such encoders, optional polling mode support is added using
>=20
> I don't understand this. It's necessary in the same way as with the
> already supported devices. I.e. you want to trigger an irq when the
> encoder is moved and then check for it's position in the handler.
>=20

Unlike already supported device, there is no need to count steps or
determine the direction of rotation. Hence, IRQ is not a requirement,
periodically polling the gpio lines is more than sufficient. With
absolute encoder, you are able to determine the current position at any
time just by looking at the gpio inputs.
Suppose we poll device at t=3D0ms and see gpio values are LLLH(1), if w=
e
again poll device at t=3D500ms(which is what input_poll_dev helps to do=
)
and see that gpio values is LLHH(3), then we know that rotary encoder
has changed to 3. This can be done w/o IRQ for absolute encoders.

>> diff --git a/Documentation/devicetree/bindings/input/rotary-encoder.=
txt b/Documentation/devicetree/bindings/input/rotary-encoder.txt
>> index 6c9f0c8a846c..9c928dbd1500 100644
>> --- a/Documentation/devicetree/bindings/input/rotary-encoder.txt
>> +++ b/Documentation/devicetree/bindings/input/rotary-encoder.txt
>> @@ -12,6 +12,10 @@ Optional properties:
>>  - rotary-encoder,relative-axis: register a relative axis rather tha=
n an
>>    absolute one. Relative axis will only generate +1/-1 events on th=
e input
>>    device, hence no steps need to be passed.
>> +- rotary-encoder,absolute-encoder: support encoders where GPIO line=
s
>> +  reflect the actual position of the rotary encoder dial. For examp=
le,
>> +  if dial points to 9, then four GPIO lines read HLLH(1001b =3D 9).
>> +  In this case, rotary-encoder,steps-per-period needed not be defin=
ed.
>=20
> IMHO this is wrong, I'd formalize this device as:
>=20
> 	{
> 		compatible =3D "rotary-encoder";
> 		gpios =3D <&gpio 19 1>, <&gpio 20 0>, <...>, <...>;
> 		rotary-encoder,encoding =3D "binary";
> 		rotary-encoder,steps =3D <16>;
> 		rotary-encoder,steps-per-period =3D <16>;

The above bindings essential means quarter_period device. I would not
like to bother with all the logic in rotary_encoder_quarter_period_irq(=
)
when we can know encoder->pos by directly reading state of gpio lines.

> 		rotary-encoder,rollover;
> 	}
>=20
> and support this with a v4 of
>=20
> 	http://thread.gmane.org/gmane.linux.kernel.input/48892
>=20
>

IMHO, there needs to be separate IRQ handler for absolute encoders so
that the driver logic is greatly simplified.

--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
