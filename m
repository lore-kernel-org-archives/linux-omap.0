From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: Re: [PATCH 1/3] mfd: twl6040: Select i2c fast mode as default with
 regmap patch
Date: Mon, 3 Mar 2014 13:30:27 +0200
Message-ID: <531467D3.2030307@ti.com>
References: <1393509410-1640-1-git-send-email-peter.ujfalusi@ti.com> <1393509410-1640-2-git-send-email-peter.ujfalusi@ti.com> <530F4A84.9070906@ti.com> <530F4CA5.6030502@ti.com> <530F5323.1020305@ti.com> <53103D34.8050101@ti.com> <53108F90.7070608@ti.com> <53109C92.10104@ti.com> <5310A61C.5000105@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <5310A61C.5000105@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Nishanth Menon <nm@ti.com>, Lee Jones <lee.jones@linaro.org>
Cc: florian.vaussard@epfl.ch, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, Samuel Ortiz <sameo@linux.intel.com>
List-Id: linux-omap@vger.kernel.org

On 02/28/2014 05:07 PM, Nishanth Menon wrote:
> On 02/28/2014 08:26 AM, Peter Ujfalusi wrote:
>> On 02/28/2014 03:30 PM, Nishanth Menon wrote:
>>> TWL6030 can do 3.3MHz by default and there are no speed registers t=
o
>>> configure.
>>
>> According to the datasheet the speed of twl6030 is limited to 2.4MHz=
=2E I have
>> not seen registers or pins to select the speed. As the documentation=
 puts
>> this: High-speed mode (limited to 2.4Mbit/s maximum)
>=20
> Aye, you are correct, the latest data sheet does show this - i made
> the mistake of opening an older spec doc :(..

As a note: I tried first with 3.4MHz bus speed (who reads documentation=
?)
twl6030 was working fine as far as I can tell. But the TRM is really
expressing that 2.4MHz is the limit for twl6030.

> I do however suggest that you put one of those i2c analyser on the
> rail to see what is happening. else, we'd be doing a lot of guessing =
here.

If I would have access to one...


>> If I have fast mode configured to the controller, I can still commun=
icate with
>> twl6040 even if it is set to normal mode.
>=20
>>
>> I still think that this patch is safe for now. We could try to figur=
e out how
>> to increase the i2c speed on the bus for twl6030 and twl6040. This h=
as to be
>> done in the same series.
>=20
> ?? you mean set i2c bus speed to full speed on PandaBoard? it is
> already full speed[1]!

No, I was thinking of Fast+ or HighSpeed but I have doubts that it can =
be done.

>> Now after several boots:
>> It seams if I set the i2c to 2.4MHz and I can not communicate with t=
wl6040
>> right after cold power on.
>> So if the i2c bus is already set to 2.4GHz I can not set the twl6040=
 ACCCTL
>> register. But the content of ACCCTL register seams to be preserved b=
etween
>> reboots and this is why I saw that the 2.4MHz bus speed might be eve=
n possible.
>=20
> This observation is the key.
>=20
> Are you power cycling the regulators for TWL6040 as part of your
> shutdown handler?

When the mfd driver is removed, yes powers are asked to be turned off b=
ut in
reality at least vio is always on in all of the boards I have seen.

> Did you read the ACCTL register after a reboot to
> see if the register contents are still the same as before?

Yes I did. after reboot the ACCCTL register is the same in u-boot as I =
set
previously, before the reboot.
Disconnect power + Power the board the ACCCTL is as it has been specifi=
ed in
the datasheet.

> Based on this observation, I suggest switching [1] to 100KHz.

After several power cycle, reboot, cold boot etc. I think we can leave =
the i2c
speed at 400KHz and configure the twl6040 to Fast mode as the first thi=
ng when
the driver probes or the chip is powering on (regmap patch functionalit=
y).
I have not seen a single case when this failed on me and the the 4x ban=
dwidth
does matter for twl6030 IMHO.

>=20
> [1]
> http://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git/tree/a=
rch/arm/boot/dts/omap4-panda-common.dtsi#n291
>=20


--=20
P=E9ter
