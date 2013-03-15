From: Jon Hunter <jon-hunter@ti.com>
Subject: Re: [PATCH 0/8] ARM: OMAP3+: Switch to use DT based cpu0-cpufreq
 driver
Date: Fri, 15 Mar 2013 09:56:19 -0500
Message-ID: <51433693.2@ti.com>
References: <1363294695-658-1-git-send-email-nm@ti.com> <5142AF41.7070003@ti.com> <20130315142157.GC2939@kahuna>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <cpufreq-owner@vger.kernel.org>
In-Reply-To: <20130315142157.GC2939@kahuna>
Sender: cpufreq-owner@vger.kernel.org
To: Nishanth Menon <nm@ti.com>
Cc: Santosh Shilimkar <santosh.shilimkar@ti.com>, linux-omap@vger.kernel.org, Kevin Hilman <khilman@deeprootsystems.com>, =?ISO-8859-1?Q?Beno=EEt_Cousson?= <b-cousson@ti.com>, Shawn Guo <shawn.guo@linaro.org>, Keerthy <j-keerthy@ti.com>, devicetree-discuss@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org, cpufreq@vger.kernel.org, linux-pm@vger.kernel.org
List-Id: linux-omap@vger.kernel.org


On 03/15/2013 09:21 AM, Nishanth Menon wrote:
> On 10:48-20130315, Santosh Shilimkar wrote:
>> On Friday 15 March 2013 02:28 AM, Nishanth Menon wrote:
>>> The following series arose from trying to use BeagleBoard-XM (OMAP3 variant)
>>> for doing CPU DVFS using cpufreq-cpu0. This series will eventually result in
>>> migrating the cpufreq support only through device tree (part of the effort
>>> to migrate away from non-DT configurations for OMAP). Unfortunately, as already
>>> known, we have a bunch of legacy code and mutually dependent device tree
>>> conversion that is pending.
>>> Key features pending:
>>> A) clock framework transition to DT - this should happen soon, so this series hacks
>>> the clock node for the time being as suggested in review of original series
>>> B) on processors that use voltage controller, voltage processor (VC/VP hardware
>>> loop using I2C_SR path) - we have started work on transitioning them to regulator
>>> framework driven by DT.
>>> C) Adaptive Body Bias and SmartReflex AVS conversion to DT.
>>>
>>> As a result of these pending features:
>>> - OMAP4 TWL6030 and TPS62361 which set voltage ONLY over I2C_SR have no regulators
>>> associated at the moment - fortunately, we boot at highest voltage, so things still
>>> work.
>>> - Missing ABB and AVS implies that for few of the SoCs (3630, OMAP4), I have not added
>>> those OPPs in DT yet - this also needs alignment with iMX, AM series like pending work,
>>> where certain OPPs need enabling based on efuse programmed bit sequences - since it
>>> is an add-on work, it is not addressed here.
>>>
>> Thanks for looking into it.
> Yes, this should be the next stage to solve.
>>
>>> Note: Somewhere in the future, when we have regulators driven off CCF and OMAP
>>> converted to CCF, we could remove the DT regulator requirements there as well.
>>>
>>> Key benefit of the series is to allow all relevant TI platforms now to use a single
>>> cpufreq driver and equivalent frameworks in addition be part of the transition to
>>> DT. As a result of this series, CPUFreq feature will not be available for non-DT
>>> boot systems.
>>>
>> As commented by Jon on internal thread, I am also against the idea of dropping
>> non-DT support now. Till we migrate to 100 % DT, it is best to keep support
>> alive. Especial OMAP3 based devices.
>>
>> Why don't you take phased approach and have both supported for time being.
>> Then once we move to DT only, we just drop the non-DT support as we plan
>> to do for many more stuff.
>>
>> BTW, we are using only CPUFreq driver before this series as well. I guess you
>> mean the common CPUFReq drivers used by other ARM SOCs.
> I had removed the entries for OPPs and clock nodes used by
> omap-cpufreq.c and deleted the omap-cpufreq.c as well - so the statement
> "CPUFreq wont work in non-DT" configuration was accurate.
> 
> My intent was as follows:
> - This series is driven mainly from maintenance angle - having to maintain
> two different drivers (legacy omap-cpufreq.c and cpufreq-cpu0.c),
> ensuring the data is proper in both OPP tables in kernel and DT entries
> is sure to cause mayhem sometime. This is not just an pain for OMAP
> community, but for cpufreq community as well (since there is absolutely
> no reason other than OMAP legacy burden for making cpu0-cpufreq work in non-DT
> world).
> - as long as non-DT supported boot provides all features, there is no
> real feature incentive to move to DT.

You are missing the point. Before you can migrate people over to DT, you
need to be ready. IMO OMAP is still not quite ready unfortunately.

> But, that said, there is one path I see possible:
> - keep omap-cpufreq alive (BUT I will add a patch that will not let it init
>   when in DT entries are present)
> - add DT entries for all relevant OMAPs - in DT mode, we will *only*
> support cpufreq-cpu0
> - All future SoCs will continue to use cpufreq-cpu0 using DT, as was the
> alignment I believe.

Yes that is what we are doing for other drivers and should be done here.

Jon

