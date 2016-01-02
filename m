From: Nishanth Menon <menon.nishanth@gmail.com>
Subject: Re: Nokia N900: Adjust MPU OPP values
Date: Sat, 2 Jan 2016 14:38:36 -0600
Message-ID: <5688354C.4070505@gmail.com>
References: <201601021531.10424@pali> <20160102171641.GD12622@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20160102171641.GD12622@atomide.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>, =?UTF-8?Q?Pali_Roh=c3=a1r?= <pali.rohar@gmail.com>
Cc: Aaro Koskinen <aaro.koskinen@iki.fi>, Nishanth Menon <nm@ti.com>, Pavel Machel <pavel@ucw.cz>, Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com>, Sebastian Reichel <sre@kernel.org>, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

On 01/02/2016 11:16 AM, Tony Lindgren wrote:
> * Pali Roh=C3=A1r <pali.rohar@gmail.com> [160102 06:31]:
>> Hello,
>>
>> MPU OPP table table (omap36xx_vddcore_volt_data) defined in
>> opp3xxx_data.c does not match Nokia N900 phone. For a long time we h=
ave
>> dirty patch in linux-n900 tree for it, see:
>>
>> https://github.com/pali/linux-n900/commit/4644c5801d7469e2be01d847c6=
1df3d934dadd8c
>>
>> Now when doing transition to device tree, is there any way how corre=
ct
>> MPU OOP table for Nokia N900 could be defined in DT file?
>=20
> Hmm I'd assume we can just define this in the dts.. Nishanth, got
> any comments on this one?
>=20

We already have definitions in dtb for omap3 OPPs. I think we should
start using device tree as default. the oppxx_data.c is sticking around
waiting for legacy boot to go away, then those files should be deleted.


--=20
Regards,
Nishanth Menon
