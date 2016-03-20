From: Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com>
Subject: Re: Nokia N900 - audio TPA6130A2 problems
Date: Sun, 20 Mar 2016 21:43:11 +0200
Message-ID: <56EEFD4F.4030705@gmail.com>
References: <56E9A6D9.7000003@ti.com> <56E9B910.7000904@gmail.com>
 <56EA6282.5050501@ti.com> <56EAE8C3.1080301@gmail.com>
 <56EBD96A.8090505@ti.com> <1458306829.11841.2.camel@Nokia-N900>
 <20160318133641.GB16747@earth> <56EC0676.3000509@gmail.com>
 <20160318150404.GA30829@earth> <56ED12B5.9000103@gmail.com>
 <20160320051704.GA12934@earth>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20160320051704.GA12934@earth>
Sender: linux-kernel-owner@vger.kernel.org
To: Sebastian Reichel <sre@kernel.org>, Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>
Cc: Peter Ujfalusi <peter.ujfalusi@ti.com>, Grygorii Strashko <grygorii.strashko@ti.com>, =?UTF-8?Q?Pali_Roh=c3=a1r?= <pali.rohar@gmail.com>, Jarkko Nikula <jarkko.nikula@bitmer.com>, Tony Lindgren <tony@atomide.com>, Lars-Peter Clausen <lars@metafoo.de>, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, Pavel Machek <pavel@ucw.cz>, Aaro Koskinen <aaro.koskinen@iki.fi>, Nishanth Menon <nm@ti.com>, merlijn@wizzup.org
List-Id: linux-omap@vger.kernel.org

Hi

On 20.03.2016 07:17, Sebastian Reichel wrote:
> Hi,
>
> On Sat, Mar 19, 2016 at 10:49:57AM +0200, Ivaylo Dimitrov wrote:
>> On 18.03.2016 17:04, Sebastian Reichel wrote:
>>> On Fri, Mar 18, 2016 at 03:45:26PM +0200, Ivaylo Dimitrov wrote:
>>>> On 18.03.2016 15:36, Sebastian Reichel wrote:
>>>> Regulator is V28_A, which is always-on, so it is enabled no matter what
>>>> probe does. Anyway, I added a various delays after regulator_enable(), to no
>>>> success.
>>
>> I guess we're getting closer - I put some printks in various functions in
>> the twl-regulator.c, here is the result:
>>
>> on power-up:
>>
>> [    2.378601] twl4030ldo_get_voltage_sel VMMC2 vsel 0x00000008
>> [    2.384948] twl4030reg_enable VMMC2 grp 0x00000020
>> [    2.408416] twl4030ldo_get_voltage_sel VMMC2 vsel 0x00000008
>> [    7.196685] twl4030reg_is_enabled VMMC2 state 0x0000002e
>> [    7.202819] twl4030reg_is_enabled VMMC2 state 0x0000002e
>> [    7.209777] twl4030reg_is_enabled VMMC2 state 0x0000002e
>> [    7.215728] twl4030reg_is_enabled VMMC2 state 0x0000002e
>> [    7.223205] twl4030reg_is_enabled VMMC2 state 0x0000002e
>
> Ok, so normal power up results in running VMMC2 (always-on works),
> but voltage is not configured correctly. 2.6V is default according
> to the TRM. I think this is a "bug" in the regulator framework. It
> should setup the minimum allowed voltage before enabling the
> always-on regulator.
>

/sys/kernel/debug/regulator/regulator_summary shows 2850mV for V28_A, so 
I would remove the quotes. Also, always-on is because if V28_A regulator 
is turned off, there is a leakage through tlv320aic34 VIO. BTW one of 
the things I did while trying to find the problem, was to remove that 
always-on property from the DTS - it didn't help.

> In case of the tpa6130a2/tpa6140a2 driver it may also be nice to add
> something like this to the driver (Vdd may be between 2.5V and 5.5V
> according to both datasheets):
>
> if (regulator_can_change_voltage(data->supply))
>      regulator_set_voltage(data->supply, 2500000, 5500000);
>

and add DT property for that voltage range, as max output power and 
harmonics depend on the supply voltage.

>> after restart from stock kernel:
>>
>> [    2.388610] twl4030ldo_get_voltage_sel VMMC2 vsel 0x0000000a
>> [    2.394958] twl4030reg_enable VMMC2 grp 0x00000028
>
> I had a quick glance at this. I think stock kernel put VMMC2
> into sleep mode. Mainline kernel does not expect sleep mode
> being set and does not disable it.
>

Well, one would think that kernel should not have expectations on what 
would be the state of the hardware by the time it takes control over it, 
but setup everything needed instead.

>> [    2.418426] twl4030ldo_get_voltage_sel VMMC2 vsel 0x0000000a
>> [    7.186645] twl4030reg_is_enabled VMMC2 state 0x00000020
>> [    7.192718] twl4030reg_is_enabled VMMC2 state 0x00000020
>> [    7.199615] twl4030reg_is_enabled VMMC2 state 0x00000020
>> [    7.205535] twl4030reg_is_enabled VMMC2 state 0x00000020
>> [    7.212951] twl4030reg_is_enabled VMMC2 state 0x00000020
>>
>> I don't see twl4030ldo_set_voltage_sel() for VMMC2(V28_A) regulator, though
>> there are calls for VMMC1 and VAUX3.
>
> I guess that's because the voltage is only configured if at least
> one regulator consumer requests anything specific.
>

But then the board DTS is simply ignored. Doesn't look good :)

>> So, it seems to me that V28_A is not enabled or correctly set-up
>> and all devices connected to it does not function. And it looks
>> like even after power-on VMMC2 is not correctly set-up - it is
>> supposed to have voltage of 2.85V (10) but kernel leaves it to
>> 2.60V (8). However my twl-fu ends here so any help is appreciated.
>
> So in case of reboot from stock kernel voltage is already configured
> to 2.8V, but it does not work, because of the sleep mode.
>

Yeah, that sleep is pretty clear, I was rather asking - "any idea how to 
fix that?". Or it is someone else expected to fix it?

Thanks,
Ivo
