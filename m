From: Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com>
Subject: Re: Nokia N900 - audio TPA6130A2 problems
Date: Thu, 17 Mar 2016 15:11:16 +0200
Message-ID: <56EAACF4.2040005@gmail.com>
References: <20160306152339.GA428@earth> <201603121342.33099@pali>
 <56E68B71.2030202@ti.com> <20160316133319.GR8413@pali>
 <20160316144709.GA3389@earth> <56E9A42B.3010209@gmail.com>
 <56E9A6D9.7000003@ti.com> <56E9B910.7000904@gmail.com>
 <20160317004917.GA6750@earth> <56EA6326.4000702@gmail.com>
 <20160317130115.GU8413@pali>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20160317130115.GU8413@pali>
Sender: linux-kernel-owner@vger.kernel.org
To: =?UTF-8?Q?Pali_Roh=c3=a1r?= <pali.rohar@gmail.com>
Cc: Sebastian Reichel <sre@kernel.org>, Grygorii Strashko <grygorii.strashko@ti.com>, Peter Ujfalusi <peter.ujfalusi@ti.com>, Jarkko Nikula <jarkko.nikula@bitmer.com>, Tony Lindgren <tony@atomide.com>, Lars-Peter Clausen <lars@metafoo.de>, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, Pavel Machek <pavel@ucw.cz>, Aaro Koskinen <aaro.koskinen@iki.fi>, Nishanth Menon <nm@ti.com>, merlijn@wizzup.org
List-Id: linux-omap@vger.kernel.org

Hi,

On 17.03.2016 15:01, Pali Roh=C3=A1r wrote:
> On Thursday 17 March 2016 09:56:22 Ivaylo Dimitrov wrote:
>> Hi,
>>
>
> Is camera on same bus as tpa? Maybe this is reason why camera is
> non-functional too?
>

It doesn't matter, all the i2c busses are missing the pullups.

>> Will fix the board DTS file later on an will report
>
> Thanks for investigation! Is that problem in both DTS and also legacy
> board code?
>

I guess legacy board code does not set i2c pull-ups either, as we
have that problem since the beginning of time. Anyway, let me first
check if enabling pullups really solves the issue, I hope to test that=20
in a couple of hours when I am back home.

Or you can do it yourself, it is just a matter of replacing PIN_INPUT=20
with PIN_INPUT_PULLUP in=20
https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git/tree/ar=
ch/arm/boot/dts/omap3-n900.dts?id=3Drefs/tags/v4.5#n199=20
for all the 3 ic2 busses

Regards,
Ivo
