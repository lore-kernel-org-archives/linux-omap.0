From: Nishanth Menon <nm@ti.com>
Subject: Re: [PATCH V2] drivers/rtc/rtc-ds1307.c: Enable the mcp794xx alarm
 after programming time
Date: Thu, 23 Apr 2015 08:11:41 -0500
Message-ID: <5538EF8D.5050209@ti.com>
References: <1429577494-15087-1-git-send-email-nm@ti.com> <5537A169.206@linaro.org> <55383625.3070108@ti.com> <5538C6C2.5010508@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <5538C6C2.5010508@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: "Grygorii.Strashko@linaro.org" <grygorii.strashko@linaro.org>, Alexandre Belloni <alexandre.belloni@free-electrons.com>, Alessandro Zummo <a.zummo@towertech.it>
Cc: linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, rtc-linux@googlegroups.com
List-Id: linux-omap@vger.kernel.org

On 04/23/2015 05:17 AM, Grygorii.Strashko@linaro.org wrote:
> On 04/23/2015 03:00 AM, Nishanth Menon wrote:
>> On 04/22/2015 08:26 AM, Grygorii.Strashko@linaro.org wrote:
>>> Hi,
>>>
>>> On 04/21/2015 03:51 AM, Nishanth Menon wrote:
>>>> Alarm interrupt enable register is at offset 0x7, while the time
>>>> registers for the alarm follow that. When we program Alarm interru=
pt
>>>> enable prior to programming the time, it is possible that previous
>>>> time value could be close or match at the time of alarm enable
>>>> resulting in interrupt trigger which is unexpected (and does not m=
atch
>>>> the time we expect it to trigger).
>>>>
>>>> To prevent this scenario from occuring, program the ALM0_EN bit on=
ly
>>>> after the alarm time is appropriately programmed.
>>>>
>>>> Ofcourse, I2C programming is non-atomic, so there are loopholes wh=
ere
>>>> the interrupt wont trigger if the time requested is in the past at
>>>> the time of programming the ALM0_EN bit. However, we will not have
>>>> unexpected interrupts while the time is programmed after the inter=
rupt
>>>> are enabled.
>>>
>>> I think it will be nice if you will mention that you going to follo=
w
>>> vendor recommendations - AN1491 Configuring the MCP794XX RTCC Famil=
y
>>> http://ww1.microchip.com/downloads/en/AppNotes/01491A.pdf
>>> ;)
>>> "Also, it is recommended that the alarm registers be loaded
>>> before the alarm is enabled."
>>>
>>
>> Hmm... i did not know that existed, thanks for digging it up.. that
>> teaches me to look for docs before putting a scope/LA on the board
>> (not that I regret doing that)... That said, reading the app note, I
>> kind of realized:
>> a) that playing with ST bit for programming time is not done, but
>> then, that implies that oscillator will have to be restarted (upto a
>> few seconds for certain crystals).. but that said, it does not seem
>> mandatory or seem to (yet seen) functional issues...
>>
>> b) We dont have flexibility yet to describe if we do indeed have a
>> backup battery or not - VBATEN should be set only if we have a backu=
p
>> battery on the platform :( - on some it might even be optional thank=
s
>> to certain compliance requirements of shipping boards internationall=
y
>> and general "unlike" of lithium ion in cargo hold..
>>
>> c) we dont have capability to control the alarm polarity in the driv=
er
>> which, by the way, we probably should also control OUT polarity (whe=
n
>> ALARM is not asserted)..
>>
>> d) we dont have support for external 32k oscillator(X1 only) instead
>> of assuming we always have a 32k crystal(X1 and X2)...
>>
>> Ugghhh... more cleaning up to do for the future..
>>
>> that said, the sequence it does recommend (in page 4):
>> The following steps show how the Alarm 0 is config-
>> ured. Alarm 1 can be configured in the same manner.
>> 1.    Write 0x23 to the Alarm0 Seconds register
>> [0x0A].
>> 2.    Write 0x47 to the Alarm0 Minutes register
>> [0x0B].
>> 3.    Write 0x71 to the Alarm0 Hours register [0x0C]
>> =96 11 hours in 12-hour format.
>> 4.    Write 0x72 to the Alarm0 Day register [0x0D] =96
>> Tuesday + Alarm Polarity Low + Match on all.
>> The Alarm0 Interrupt Flag is also cleared.
>> 5.    Write 0x14 to the Alarm0 Date register [0x0E].
>> 6.    Write 0x08 to the Alarm0 Month register [0x0F].
>> With all the Alarm0 registers set we can now activate
>> the Alarm0 on the Control register.
>> 7.    Write 0x10 to the Control register [0x07] =96
>> Alarm0 enabled no CLKOUT, Alarm1 disabled
>>
>> before this patch we do ( http://pastebin.ubuntu.com/10863880/)
>> 	CONTROL r[7] =3D 0x90 (OUT=3D1, ALM0EN=3D1)
>> 	OSCTRIM r[8] =3D 0x00
>> 	EEUNLOCK r[9] =3D 0x00
>> 	ALM0SEC r[A] =3D 0x01
>> 	ALM0MIN r[B] =3D 0x45
>> 	ALM0HOUR r[C] =3D 0x23
>> 	ALM0WKDAY r[D] =3D 0x75 <-ALMOIF is cleared
>> 	ALM0DATE r[E] =3D 0x09
>> 	ALM0MTH r[F] =3D 0x04
>> 	RSRVED r[10] =3D 0x01
>>
>> with this patch, we do:
>> burst(	CONTROL r[7] =3D 0x80 (OUT=3D1)
>> 	OSCTRIM r[8] =3D 0x00
>> 	EEUNLOCK r[9] =3D 0x00
>> 	ALM0SEC r[A] =3D 0x01
>> 	ALM0MIN r[B] =3D 0x45
>> 	ALM0HOUR r[C] =3D 0x23
>> 	ALM0WKDAY r[D] =3D 0x75 <-ALMOIF is cleared
>> 	ALM0DATE r[E] =3D 0x09
>> 	ALM0MTH r[F] =3D 0x04
>> 	RSRVED r[10] =3D 0x01
>> )
>> 	CONTROL r[7] =3D 0x90 (OUT=3D1, ALM0EN=3D1)
>>
>> Which is slightly unoptimal way of what the app note recommends. - a=
s
>> I mentioned earlier in this thread, I will try and do optimizations =
in
>> a later patch.
>>
>> Given that Andrew had picked up this patch, I dont see a reason to
>> respin this yet. but will include the app note for future patches -
>> thanks for pointing it out to me.
>=20
> ^^ Up to you. Np, Always yours!

Considering the narrow focus of the current patch (which does fix an
issue that it attempts to), can I get an Ack?


--=20
Regards,
Nishanth Menon
