From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: Re: Nokia N900 - audio TPA6130A2 problems
Date: Tue, 4 Aug 2015 10:02:39 +0300
Message-ID: <55C0638F.30000@ti.com>
References: <201507251228.27128@pali> <201508011218.45076@pali>
 <55BFACE4.1010100@bitmer.com> <201508032017.45654@pali>
 <55BFB77C.6000208@bitmer.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <55BFB77C.6000208@bitmer.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Jarkko Nikula <jarkko.nikula@bitmer.com>, =?UTF-8?Q?Pali_Roh=c3=a1r?= <pali.rohar@gmail.com>
Cc: Lars-Peter Clausen <lars@metafoo.de>, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, Pavel Machek <pavel@ucw.cz>, Sebastian Reichel <sre@kernel.org>, Aaro Koskinen <aaro.koskinen@iki.fi>, Tony Lindgren <tony@atomide.com>, Nishanth Menon <nm@ti.com>, Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com>
List-Id: linux-omap@vger.kernel.org

On 08/03/2015 09:48 PM, Jarkko Nikula wrote:
> It is well possible that some regression got introduced to TPA6130A2 =
I2C
> communication over the years without nobody than you now notices. We
> used to do QA back in Meego N900 days but that was pre 3.x kernels.

No major changes has been done to the tpa driver during the past years.=
=2E. I
wanted to do some updates, like moving it to regmap, but as you said, n=
900 is
the only user (and n9) and I do not feel comfortable to hack on a devic=
e where
I do not have serial console... And I'm using the n900 time to time als=
o.

>> So maybe something similar? Kernel expects that some PM or regulator=
=20
>> parts are initialized, but they are only sometimes? Just speculation=
=2E..
>>
> I'm thinking the same. I could figure SCL could be stuck low if TPA o=
r
> some other chip connected to the same I2C bus is without power and is
> pulling I2C signals down.

What would happen with the SCL stuck on i2c.2 bus if you remove the tpa=
 driver
from the kernel? If you remove the other drivers for the devices on i2c=
=2E2?

--=20
P=C3=A9ter
