From: Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com>
Subject: Re: Nokia N900 - audio TPA6130A2 problems
Date: Sat, 19 Mar 2016 10:49:57 +0200
Message-ID: <56ED12B5.9000103@gmail.com>
References: <20160316144709.GA3389@earth> <56E9A42B.3010209@gmail.com>
 <56E9A6D9.7000003@ti.com> <56E9B910.7000904@gmail.com>
 <56EA6282.5050501@ti.com> <56EAE8C3.1080301@gmail.com>
 <56EBD96A.8090505@ti.com> <1458306829.11841.2.camel@Nokia-N900>
 <20160318133641.GB16747@earth> <56EC0676.3000509@gmail.com>
 <20160318150404.GA30829@earth>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20160318150404.GA30829@earth>
Sender: linux-kernel-owner@vger.kernel.org
To: Sebastian Reichel <sre@kernel.org>
Cc: Peter Ujfalusi <peter.ujfalusi@ti.com>, Grygorii Strashko <grygorii.strashko@ti.com>, =?UTF-8?Q?Pali_Roh=c3=a1r?= <pali.rohar@gmail.com>, Jarkko Nikula <jarkko.nikula@bitmer.com>, Tony Lindgren <tony@atomide.com>, Lars-Peter Clausen <lars@metafoo.de>, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, Pavel Machek <pavel@ucw.cz>, Aaro Koskinen <aaro.koskinen@iki.fi>, Nishanth Menon <nm@ti.com>, merlijn@wizzup.org
List-Id: linux-omap@vger.kernel.org

Hi,

On 18.03.2016 17:04, Sebastian Reichel wrote:
> Hi,
>
> On Fri, Mar 18, 2016 at 03:45:26PM +0200, Ivaylo Dimitrov wrote:
>> On 18.03.2016 15:36, Sebastian Reichel wrote:
>>
>>
>> Regulator is V28_A, which is always-on, so it is enabled no matter what
>> probe does. Anyway, I added a various delays after regulator_enable(), to no
>> success.
>

I guess we're getting closer - I put some printks in various functions 
in the twl-regulator.c, here is the result:

on power-up:

[    2.378601] twl4030ldo_get_voltage_sel VMMC2 vsel 0x00000008
[    2.384948] twl4030reg_enable VMMC2 grp 0x00000020
[    2.408416] twl4030ldo_get_voltage_sel VMMC2 vsel 0x00000008
[    7.196685] twl4030reg_is_enabled VMMC2 state 0x0000002e
[    7.202819] twl4030reg_is_enabled VMMC2 state 0x0000002e
[    7.209777] twl4030reg_is_enabled VMMC2 state 0x0000002e
[    7.215728] twl4030reg_is_enabled VMMC2 state 0x0000002e
[    7.223205] twl4030reg_is_enabled VMMC2 state 0x0000002e

after restart from stock kernel:

[    2.388610] twl4030ldo_get_voltage_sel VMMC2 vsel 0x0000000a
[    2.394958] twl4030reg_enable VMMC2 grp 0x00000028
[    2.418426] twl4030ldo_get_voltage_sel VMMC2 vsel 0x0000000a
[    7.186645] twl4030reg_is_enabled VMMC2 state 0x00000020
[    7.192718] twl4030reg_is_enabled VMMC2 state 0x00000020
[    7.199615] twl4030reg_is_enabled VMMC2 state 0x00000020
[    7.205535] twl4030reg_is_enabled VMMC2 state 0x00000020
[    7.212951] twl4030reg_is_enabled VMMC2 state 0x00000020

I don't see twl4030ldo_set_voltage_sel() for VMMC2(V28_A) regulator, 
though there are calls for VMMC1 and VAUX3.

So, it seems to me that V28_A is not enabled or correctly set-up and all 
devices connected to it does not function. And it looks like even after 
power-on VMMC2 is not correctly set-up - it is supposed to have voltage 
of 2.85V (10) but kernel leaves it to 2.60V (8). However my twl-fu ends 
here so any help is appreciated.

Ivo
