From: Grygorii Strashko <grygorii.strashko@ti.com>
Subject: Re: [PATCH 1/3] ARM: dts: omap5-board-common: enable rtc and charging
 of backup battery
Date: Wed, 13 Jan 2016 21:22:05 +0200
Message-ID: <5696A3DD.5000106@ti.com>
References: <CCB763BE-5D1F-4A53-BF9A-C12C08A6EFC4@goldelico.com>
 <20160111202421.GA12777@atomide.com> <20160112000917.GC12777@atomide.com>
 <417BBA32-A7DC-40CD-8A6B-EA910B1C9C13@goldelico.com>
 <E4C8F6CA-37C1-406F-9804-46055253BED9@goldelico.com>
 <001346CD-CF31-4FEF-B406-B89EEBDFA063@goldelico.com>
 <56966558.1070608@ti.com> <569669C5.2070200@ti.com>
 <20160113164856.GF12777@atomide.com> <5696896F.4090309@ti.com>
 <20160113180006.GJ12777@atomide.com>
 <2B99611A-5D2E-4D17-A17D-0150516109FD@goldelico.com>
 <56969800.5010206@ti.com>
 <D6479E92-4226-4B07-95F3-C0DF092B827C@goldelico.com>
 <5696A002.6050402@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <5696A002.6050402@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Nishanth Menon <nm@ti.com>, "H. Nikolaus Schaller" <hns@goldelico.com>
Cc: Tony Lindgren <tony@atomide.com>, Laxman Dewangan <ldewangan@nvidia.com>, =?UTF-8?Q?Beno=c3=aet_Cousson?= <bcousson@baylibre.com>, Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, Russell King <linux@arm.linux.org.uk>, linux-omap <linux-omap@vger.kernel.org>, devicetree@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>, Marek Belisko <marek@goldelico.com>, =?UTF-8?Q?Gra=c5=bevydas_Ignotas?= <notasas@gmail.com>, Keerthy <j-keerthy@ti.com>
List-Id: linux-omap@vger.kernel.org

On 01/13/2016 09:05 PM, Nishanth Menon wrote:
> On 01/13/2016 12:44 PM, H. Nikolaus Schaller wrote:
>>
>> Am 13.01.2016 um 19:31 schrieb Nishanth Menon <nm@ti.com>:
>>
>>> On 01/13/2016 12:08 PM, H. Nikolaus Schaller wrote:
>>> [...]
>>>
>>>>> OK. So are we sure the TWL driver will never have to toggle this =
pin?
>>>>
>>>> After studying the Palmas TRM it appears that this pin just should=
 be "high"
>>>> to be able to write to RTC and some scratchpad register. If the Pa=
lmas OTP
>>>> is programmed to use gpio7 as msecure input.
>>>
>>> Thanks for digging it up. we dont use the scratchpad, but in some c=
ases
>>> where SoC cold reset is involved, those registers may store additio=
nal
>>> information.
>>
>> I remember a similar thing from omap3-twl4030 where the boot source =
is stored
>> so that a warm reboot searches there. But I don#t know if the OMPAP5=
 Boot ROM
>> is using that.
>>
>=20
> I believe that nonsense of OMAP ROM accessing PMIC stopped with OMAP3=
=2E I
> dont believe OMAP4 or any later generation processors does any PMIC
> access anymore - they instead make assumptions about specific voltage
> levels they will work on (So called OPP_BOOT) instead of assuming
> specific PMIC they will work with..
>=20
>>>> Since the scratchpad is not used we can permanently enable msecure=
=2E Which
>>>> means that we must somehow get the driving output to be "1".
>>>>
>>>> This can be either done by
>>>> * a gpio with pull-up - switched to input mode as I proposed, or
>>>
>>> I think you intended to suggest to do a mux to gpio with just pinmu=
x
>>> pull?
>>
>> Yes.
>>
>>> The internal pull on padconf is very weak
>>> - for typical needs like
>>> these, it is rather suggested to stick with real GPIO drive to prev=
ent
>>> conditions like noise interference(for example).
>>
>>
>> well, on OMAP5 pull up/down are astonishingly strong :)
>> 100-250=B5A. Which translated roughly to 7 .. 18 kOhm @ 1.8V logic.
>> So a noise source must be coupled by an impedance in the 1 kOhm rang=
e.
>> This is quite rare. So I would not worry about that.
>>
>=20
> Interesting. I did not know that, and have'nt dug at people to confir=
m
> that either :).
>=20
> An internal feedback I got some time back on AM57 (not OMAP5) - conte=
xt
> was that we were discussing if an external pull up resistor was neede=
d
> for a GPIO button:
> "Internal pull-ups are relatively weak (ranging to 100kOhm or higher)
> and are good for avoiding higher leakage due to floating input level,
> and may not be sufficient for valid logic 1/0 depending on what else =
is
> connected on the board.  If a signal must absolutely be pulled to a
> valid logic 1 or 0 for system functionality, then an external pull
> should be used."

MUX_MODE1(secure modes) is not working well as i mentioned.=20

Here I agree with Nishanth -  "gpio hog" mechanism looks like
the best solution now, because of:
- it exist now :P. At the moment when omap4/5 were fixed the pinmux
solution was the simplest and fastest one, with not too many alternativ=
es.
- explicit gpio hog definition in DT will help other developer (and
what is more important HW designers) to better understand that this gpi=
o
can be used as generic GPIO (at minimum without HW modification). =20

--=20
regards,
-grygorii
