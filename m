From: Jarkko Nikula <jarkko.nikula@bitmer.com>
Subject: Re: Nokia N900 - audio TPA6130A2 problems
Date: Mon, 03 Aug 2015 21:48:28 +0300
Message-ID: <55BFB77C.6000208@bitmer.com>
References: <201507251228.27128@pali> <201508011218.45076@pali> <55BFACE4.1010100@bitmer.com> <201508032017.45654@pali>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <201508032017.45654@pali>
Sender: linux-kernel-owner@vger.kernel.org
To: =?UTF-8?B?UGFsaSBSb2jDoXI=?= <pali.rohar@gmail.com>
Cc: Lars-Peter Clausen <lars@metafoo.de>, Peter Ujfalusi <peter.ujfalusi@ti.com>, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, Pavel Machek <pavel@ucw.cz>, Sebastian Reichel <sre@kernel.org>, Aaro Koskinen <aaro.koskinen@iki.fi>, Tony Lindgren <tony@atomide.com>, Nishanth Menon <nm@ti.com>, Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com>
List-Id: linux-omap@vger.kernel.org

On 08/03/2015 09:17 PM, Pali Roh=C3=A1r wrote:
> On Monday 03 August 2015 20:03:16 Jarkko Nikula wrote:
>> Hi
>>
>> On 08/01/2015 01:18 PM, Pali Roh=C3=A1r wrote:
>>> On Saturday 25 July 2015 15:17:13 Lars-Peter Clausen wrote:
>>> Hello, your patch did not helped. Problem is still there...
>>
>> For me v4.2-rc5 works, i.e. TPA6130A2 can still play loudly to
>> headphones. Don't know were there any i2c etc regression before it o=
r
>> how easy it would be to reproduce.
>>
>=20
> Did you tested it on Nokia N900? Or other device?
>=20
N900. Seems to be only user of TPA6130A2 in mainline :-)

>> Logs below made me thinking can it be a HW issue? Although if it is
>> an HW issue it shouldn't work sometimes I guess. Do you have any
>> earlier well known configuration you could try is it an SW
>> regression or something else?
>>
>=20
> Stock Nokia's 2.6.28 kernel works always. With that kernel I have nev=
er=20
> seen this problem. So I do not think this is HW problem.
>=20
> This problem is there in more kernel versions, maybe in some older (l=
ike=20
> v3.5) is was there not so often. But do not remember correctly...
>
It is well possible that some regression got introduced to TPA6130A2 I2=
C
communication over the years without nobody than you now notices. We
used to do QA back in Meego N900 days but that was pre 3.x kernels.

> Maybe some power management problem? Something is not always initiali=
zed=20
> correctly?
>=20
> I remember that there is some problem (maybe in NoLo - Nokia bootload=
er)=20
> that sometimes chainloaded U-Boot (booted via NoLo) is not able to=20
> initialize mmc chip (all read operation fails). In U-Boot I added som=
e=20
> code to enable some parts in twl4030 regulator and after that mmc is=20
> working always...
>=20
> So maybe something similar? Kernel expects that some PM or regulator=20
> parts are initialized, but they are only sometimes? Just speculation.=
=2E.
>
I'm thinking the same. I could figure SCL could be stuck low if TPA or
some other chip connected to the same I2C bus is without power and is
pulling I2C signals down.

--=20
Jarkko
