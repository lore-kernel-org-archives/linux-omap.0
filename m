From: Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com>
Subject: Re: Nokia N900 - audio TPA6130A2 problems
Date: Mon, 21 Mar 2016 21:34:31 +0200
Message-ID: <56F04CC7.1040403@gmail.com>
References: <56EBD96A.8090505@ti.com> <1458306829.11841.2.camel@Nokia-N900>
 <20160318133641.GB16747@earth> <56EC0676.3000509@gmail.com>
 <20160318150404.GA30829@earth> <56ED12B5.9000103@gmail.com>
 <20160320051704.GA12934@earth> <20160321114521.GO2566@sirena.org.uk>
 <56EFF983.2050303@gmail.com> <20160321134515.GT2566@sirena.org.uk>
 <20160321145347.GA19391@earth>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20160321145347.GA19391@earth>
Sender: linux-kernel-owner@vger.kernel.org
To: Sebastian Reichel <sre@kernel.org>, Mark Brown <broonie@kernel.org>
Cc: Liam Girdwood <lgirdwood@gmail.com>, Peter Ujfalusi <peter.ujfalusi@ti.com>, Grygorii Strashko <grygorii.strashko@ti.com>, =?UTF-8?Q?Pali_Roh=c3=a1r?= <pali.rohar@gmail.com>, Jarkko Nikula <jarkko.nikula@bitmer.com>, Tony Lindgren <tony@atomide.com>, Lars-Peter Clausen <lars@metafoo.de>, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, Pavel Machek <pavel@ucw.cz>, Aaro Koskinen <aaro.koskinen@iki.fi>, Nishanth Menon <nm@ti.com>, merlijn@wizzup.org
List-Id: linux-omap@vger.kernel.org



On 21.03.2016 16:53, Sebastian Reichel wrote:
> Hi Mark,
>
> On Mon, Mar 21, 2016 at 01:45:15PM +0000, Mark Brown wrote:
>> On Mon, Mar 21, 2016 at 03:39:15PM +0200, Ivaylo Dimitrov wrote:
>>> On 21.03.2016 13:45, Mark Brown wrote:
>>
>>>> No, if the voltage is variable we can't tell what the current
>>>> constraints are without something telling us so we just don't vary the
>>>> voltage until we're told to do this.  If we immediately lower the
>>>> voltage to the minimum supported voltage that's going to break things.
>>
>>> There are constraints set by the board DTS. Isn't it reasonable the
>>> framework to set the voltage to minimum voltage from the dts if the current
>>> set one is bellow it?
>>
>> Yes, if it's out of bounds for the constraints we should bring it
>> up/down to the minimum/maximum (when copying people into a thread it's a
>> good idea to explain what the problem you are trying to solve is,
>> especially if you're throwing around bodges).
>
> We have this regulator definition in omap3-n900.dts:
>
> &vmmc2 {
> 	regulator-name = "V28_A";
> 	regulator-min-microvolt = <2800000>;
> 	regulator-max-microvolt = <3000000>;
> 	regulator-always-on; /* due VIO leak to AIC34 VDDs */
> };
>
> The regulator is enabled during probe, but the voltage is not
> configured. The default reset voltage of the regulator is 2.6V.
> So basically when the regulator is enabled, it uses a voltage,
> which is out of the DT specified range.
>
> We also have a second problem: If the system has been rebooted from
> Nokia's stock kernel the regulator is left in STANDBY mode. Since
> the mode is not configured during probe, it results in different
> problems. According to my understanding it can be fixed trivially
> by adding
>
> &vmmc2 {
>      regulator-initial-mode = <2>;
> };
>

doesn't work:

"regulator-vmmc2: mapping for mode 2 not defined"

twl-regulator is missing .of_map_mode function.

Also, if we go that route, we should set the initial modes for all the 
regulators, not only vmmc2 (and not only for N900), as we don't really 
know what is the status of regulators at startup. I think a better 
approach is if regulator framework sets all always-on regulators to 
enabled, unless stated otherwise (which it already does iiuc).

I think there is a bug in twl-regulator twl4030reg_enable() and/or 
twl4030reg_is_enabled() - the latter only checks if DEV_GRP is P1, but 
not for the actual state of the regulator (bits 3:0). Also, what looks 
suspicious to me is that all the regulators are put in P1 device group. 
Legacy board code spreads the regulators all over the groups, so maybe 
this is simply a regression compared to legacy boot.

Regards,
Ivo
