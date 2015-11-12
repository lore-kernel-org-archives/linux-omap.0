From: Felipe Balbi <balbi@ti.com>
Subject: Re: [PATCH] gpio: omap: fix debounce time calculation
Date: Thu, 12 Nov 2015 13:33:26 -0600
Message-ID: <877flnqagp.fsf@saruman.tx.rr.com>
References: <1447350640-20347-1-git-send-email-balbi@ti.com> <5644D4F5.8070006@ti.com> <87egfvqecr.fsf@saruman.tx.rr.com> <5644E85C.8010807@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-="; micalg=pgp-sha1;
	protocol="application/pgp-signature"
Return-path: <linux-gpio-owner@vger.kernel.org>
In-Reply-To: <5644E85C.8010807@ti.com>
Sender: linux-gpio-owner@vger.kernel.org
To: Grygorii Strashko <grygorii.strashko@ti.com>, Javier Martinez Canillas <javier@dowhile0.org>, Santosh Shilimkar <ssantosh@kernel.org>, Kevin Hilman <khilman@deeprootsystems.com>, Linus Walleij <linus.walleij@linaro.org>, Alexandre Courbot <gnurou@gmail.com>
Cc: Linux OMAP Mailing List <linux-omap@vger.kernel.org>, Linux ARM Kernel Mailing List <linux-arm-kernel@lists.infradead.org>, Tony Lindgren <tony@atomide.com>, linux-gpio@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

--=-=-=
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable


Hi,

Grygorii Strashko <grygorii.strashko@ti.com> writes:
> On 11/12/2015 08:09 PM, Felipe Balbi wrote:
>>
>> Hi,
>>
>> Grygorii Strashko <grygorii.strashko@ti.com> writes:
>>> On 11/12/2015 07:50 PM, Felipe Balbi wrote:
>>>> According to TRM, debounce is measured in periods of
>>>> the functional clock of the GPIO IP. This means that
>>>
>>>
>>> What TRM? link pls.
>>>
>>> http://www.ti.com/lit/ug/spruhl7d/spruhl7d.pdf
>>>
>>> 28.4.1.24 GPIO_DEBOUNCINGTIME Register (offset =3D 154h) [reset =3D 0h]
>>>
>>> The GPIO_DEBOUNCINGTIME register controls debouncing time (the value is
>>> global for all ports). The debouncing cell is running with the
>>> debouncing clock (32 kHz), this register represents the number of the
>>> clock cycle(s) (31 s long) to be used.
>>>
>>> Debouncing Value in 31 microsecond steps.
>>> Debouncing Value =3D (DEBOUNCETIME + 1) * 31 microseconds.
>>
>> DRA7xx:
>>
>> "
>> 8-bit values specifying the debouncing time. It is n-
>> periods of the muxed clock, which can come from either
>> a true 32k oscillator/pad of from the system clock. It
>> depends on which boot mode is selected. For more
>> information see Chapter 32, Initialization.
>> "
>>
>
> See
> http://www.ti.com/lit/ug/spruhz6d/spruhz6d.pdf
> 27.4.3 General-Purpose Interface Clock Configuration
> 27.4.3.1 Clocking
>
> This completely unclear. Sry, I think this patch can't be used as is,
> first of all because of backward compatibility issues.

yeah, might be. No issues, I'll just go dig older TRMs and trying to
figure this one out. Meanwhile, let's let's keep it as is.

=2D-=20
balbi

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJWROmHAAoJEIaOsuA1yqREQjoP+gIJuFxGeT4nnRF+ta5wKmFl
qAL70yQNskTTynuPbNzP+p2STetwlpAKAx495cuaabgowvGO5RcO0nUblpXx0S4u
WOCT9qUkj9XRioCeRfA9FsA1hpRg22BWrzeKi38GWW3AOwfd2b5bkbYKvMIxTTXy
fyuRCg3fFNzbaRT1prTX7GCwZkxvPU8BjFu/+9yEtHTksXdYdf9rX9Cw9AMgYVzR
CwWk5SdO9KEAqYDtmxujX6VPrwal1UMwCSIvOoQGx9/zSdgqoiGSpRfN/585d3ZR
aMD/0NQLIXZyz413yzHTl9UTqmJYQUUQZFc8RdXdMz8Gn7A94F5S1F4INugccJ5U
sB497cxlFasTeQUZMXud70rHNgqXjiD0HK04wQohhkhzXx8JUK9IYxfBxMGML5JE
ipvp227S/Oahz/6f6PpIY2wvysRPbSzPp2QhNObLDkpiBqiEp2O8CVQolzYYjdlq
do0IDofqW4qKuMKBjs1do2ODaJLTacOQb32PYllYTh76VREutMr/eGDximCp+8g6
Ss0cxv6ZzZqS76Q1sPQrSkrkXAfGH+3tatc3xwYCEL9XAPfFIYncXDxvZsjnYkyU
lfGYxYtUWHFFtrKZmWYUxnHEvzpY19RgT6+PJW4V0FJIqppyrIr3VhY87HDzl3lP
m13Lm/gdHimQjOijBeVC
=EtsG
-----END PGP SIGNATURE-----
--=-=-=--
