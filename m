From: John Syne <john3909@gmail.com>
Subject: Re: [PATCH] drivers: mfd: ti_am335x_tscadc: increase ADC ref clock to
 24MHz
Date: Wed, 9 Nov 2016 15:53:37 -0800
Message-ID: <D0AA78D0-9562-4E4D-A949-A771289D7570@gmail.com>
References: <20161024060226.4170-1-mugunthanvnm@ti.com>
 <038C6B01-8443-4321-9C65-BAC4095237D3@gmail.com>
 <086ab2fa-63ee-c5ab-2715-b2efd78270d7@ti.com>
 <12725C92-9BB8-4F77-A7B4-F3C3DA9F8B0B@gmail.com>
 <DB09B26E-C5AB-427A-82D5-6FE857E7C218@gmail.com> <20161025063847.GD8574@dell>
 <CC15CFB4-60D0-4A63-A3D3-2079CFA31274@gmail.com> <20161026084811.GI8574@dell>
 <A5F6974F-5793-4E85-BF82-2D9309980991@gmail.com>
 <d7fadbf6-8026-d821-1ef8-981f536a8fdf@ti.com>
Mime-Version: 1.0 (Mac OS X Mail 10.1 \(3251\))
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <d7fadbf6-8026-d821-1ef8-981f536a8fdf@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Vignesh R <vigneshr@ti.com>
Cc: Lee Jones <lee.jones@linaro.org>, Mugunthan V N <mugunthanvnm@ti.com>, linux-iio@vger.kernel.org, Tony Lindgren <tony@atomide.com>, Jonathan Cameron <jic23@kernel.org>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, Sekhar Nori <nsekhar@ti.com>, Peter Ujfalusi <peter.ujfalusi@ti.com>
List-Id: linux-omap@vger.kernel.org


> On Oct 31, 2016, at 4:39 AM, Vignesh R <vigneshr@ti.com> wrote:
>=20
>=20
>=20
> On Friday 28 October 2016 02:47 AM, John Syne wrote:
>=20
>>>>>>>>>>>=20
>>>>>>>>>>> ---
>>>>>>>>>>> include/linux/mfd/ti_am335x_tscadc.h | 4 ++--
>>>>>>>>>>> 1 file changed, 2 insertions(+), 2 deletions(-)
>>>>>>>>>>>=20
>>>>>>>>>>> diff --git a/include/linux/mfd/ti_am335x_tscadc.h =
b/include/linux/mfd/ti_am335x_tscadc.h
>>>>>>>>>>> index b9a53e0..96c4207 100644
>>>>>>>>>>> --- a/include/linux/mfd/ti_am335x_tscadc.h
>>>>>>>>>>> +++ b/include/linux/mfd/ti_am335x_tscadc.h
>>>>>>>>>>> @@ -90,7 +90,7 @@
>>>>>>>>>>> /* Delay register */
>>>>>>>>>>> #define STEPDELAY_OPEN_MASK	(0x3FFFF << 0)
>>>>>>>>>>> #define STEPDELAY_OPEN(val)	((val) << 0)
>>>>>>>>>>> -#define STEPCONFIG_OPENDLY	STEPDELAY_OPEN(0x098)
>>>>>>>>> Wouldn=E2=80=99t this be better to add this to the devicetree?
>>>>>>>>>=20
>>>>>>>>> 	ti,chan-step-avg =3D <0x16 0x16 0x16 0x16 0x16 0x16 =
0x16>;
>>>>>>>>> 	ti,chan-step-opendelay =3D <0x500 0x500 0x500 0x500 =
0x500 0x500 0x500>;
>>>>>>>>> 	ti,chan-step-sampledelay =3D <0x0 0x0 0x0 0x0 0x0 0x0 =
0x0>;
>>>>>>>>=20
>>>>>>>> For a touch screen, there is not need to change in these =
parameter
>>>>>>>> settings, so my opinion is to keep it as is. Or am I missing =
something?
>>>>>>> I was thinking that if you are using this driver as an ADC, you =
may want the flexibility to make these changes in the DT. I=E2=80=99m =
doing this by connecting sensors to the ADC inputs. I=E2=80=99m not =
using this driver for a touchscreen.=20
>>>>>>=20
>>>>>> Here is a DT overlay were this gets using on the BeagleBoneBlack. =
=20
>>>>>>=20
>>>>>> =
https://github.com/RobertCNelson/bb.org-overlays/blob/master/src/arm/BB-AD=
C-00A0.dts
>>>>>>=20
>>>>>> Besides, these DT features are already implemented in the driver =
so it is just a matter of adding these entries to the am33xx.dtsi & =
am4372.dtsi, which you modified in this patch series.
>>>>>=20
>>>>> This looks like configuration, no?
>>>>>=20
>>>>> DT should be used to describe the hardware.
>>>> You may be right, but how is this different to setting the baud =
rate on a serial channel or sampling rate on a audio channel? Looking =
through the DT, there are many configuration settings, so I=E2=80=99m =
not sure what is the correct way to handle this. Surely it is better to =
handle this in DT vs hard coding these settings?
>>>=20
>>> I think setting the UART baud rate is also an invalid DT entry.
>>>=20
>>> It's okay to list all of the options in DT, but to actually select
>>> one, that should be done either in userspace or as a kernel option.
>>> Perhaps as a Kconfig selection.
>> Yeah, this has been inconsistent for a long time. My only point was =
that these DT parameters had already been implemented in the =
ti_am335x_adc KM and I thought that this was better than hard coding =
these settings. Implementing this in Kconfig means rebuilding the KM, =
which isn=E2=80=99t desirable.=20
>=20
>> Perhaps this should be done via sysfs attributes so as you say, a =
userspace app can configure this driver.=20
>=20
> This was discussed when DT properties were added.  Patches are welcome
> to add sysfs entries. There is nothing wrong with specifying an =
initial
> value in the DT.
>=20
>> I guess the DT code in ti_am335x_adc.c should be removed.=20
>>=20
>=20
> Removing DT properties is not an option as it will break DT backward
> compatibility.
Hi Vignesh,

OK, then back to my original question. Given that these DT properties =
are supported in the driver, shouldn=E2=80=99t the following be added to =
am33xx.dtsi and am4372.dtsi?

ti,chan-step-avg =3D <0x16 0x16 0x16 0x16 0x16 0x16 0x16>;
ti,chan-step-opendelay =3D <0x500 0x500 0x500 0x500 0x500 0x500 0x500>;
ti,chan-step-sampledelay =3D <0x0 0x0 0x0 0x0 0x0 0x0 0x0>;

Regards,
John
>=20
> --=20
> Regards
> Vignesh
