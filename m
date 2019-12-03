From: "H. Nikolaus Schaller" <hns@goldelico.com>
Subject: Re: [PATCH] ARM: OMAP2+: Fix warnings with broken
 omap2_set_init_voltage()
Date: Tue, 3 Dec 2019 13:58:09 +0100
Message-ID: <33A772D8-5A90-4FB0-A5A2-CAE0AB33E518@goldelico.com>
References: <20190924233222.52757-1-tony@atomide.com>
 <8FFD44DB-73F8-4807-91E1-C97DA8F781BA@goldelico.com>
 <20191202213929.GB35479@atomide.com>
 <EE749881-C3DB-4BBE-85FE-E5AF3D34884F@goldelico.com>
 <BAF5B057-1017-4174-8C3F-4B49B31E2E0D@goldelico.com>
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <BAF5B057-1017-4174-8C3F-4B49B31E2E0D@goldelico.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Tony Lindgren <tony@atomide.com>
Cc: Nishanth Menon <nm@ti.com>, Discussions about the Letux Kernel <letux-kernel@openphoenux.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Tero Kristo <t-kristo@ti.com>, =?utf-8?Q?Andr=C3=A9_Roth?= <neolynx@gmail.com>, Linux-OMAP <linux-omap@vger.kernel.org>, Adam Ford <aford173@gmail.com>, arm-soc <linux-arm-kernel@lists.infradead.org>
List-Id: linux-omap@vger.kernel.org


> Am 03.12.2019 um 13:30 schrieb H. Nikolaus Schaller <hns@goldelico.com>:
> 
>> 
>> Am 03.12.2019 um 10:53 schrieb H. Nikolaus Schaller <hns@goldelico.com>:
>> 
>> HiTony,
>> 
>>> Am 02.12.2019 um 22:39 schrieb Tony Lindgren <tony@atomide.com>:
>>> 
>>> Hi,
>>> 
>>> * H. Nikolaus Schaller <hns@goldelico.com> [191202 21:10]:
>>>>> Am 25.09.2019 um 01:32 schrieb Tony Lindgren <tony@atomide.com>:
>>>>> Guys, please check and ack if we can really do this to get rid of some
>>>>> pointless dmesg -l3 errors without affecting the ongoing cpufreq and
>>>>> voltage work.
>>>> 
>>>> unfortunately we did not yet test in combination with the 1GHz OPP
>>>> patches for omap3630 (queued for v5.5-rc1) and it appears that this
>>>> patch breaks the 1GHz OPP.
>>>> 
>>>> The symptom is that it works fine on a dm3730 with 800MHz rating
>>>> but results in spurious kernel panics, stack corruption, virtual memory
>>>> failures, OneNAND DMA timeouts etc. on a dm3730 with 1GHz speed grade.
>>> 
>>> Hmm yeah OK, I was a bit worried about this breaking something.
>>> 
>>>> We can also re-add the "turbo-mode" tags in the omap36xx.dtsi (or
>>>> remove the 1GHz OPP) and can then boot with 800MHz max. clock. But
>>>> enabling boost (echo 1 >/sys/devices/system/cpu/cpufreq/boost) makes
>>>> the problem and its symptoms appear almost immediately.
>>>> 
>>>> After some scratching our heads we found that v5.3.7 is still good and
>>>> v5.3.8 is bad. A bisect of our tree (which includes the 1GHz OPP) did
>>>> point to this patch whichwas apparently already backported to v5.3.8 and
>>>> v5.4.
>>>> 
>>>> So I assume that the code removed here enabled or initialized something
>>>> we need for safe 1GHz transitions. Maybe the ABB-LDO. Or it looks up the
>>>> vdd regulator and initializes it earlier than without this code. Maybe
>>>> it also (pre-)initializes some clk which could now be left uninitialized
>>>> too long?
>>> 
>>> It was just doing voltdm_lookup() and clk_get_rate() and then failed
>>> dev_pm_opp_find_freq_ceil(), but I don't see what these might affect..
>>> 
>>>> Note that seeing the log message indicates that voltdm_scale() and
>>>> dev_pm_opp_get_voltage() are not called, but all functions before could
>>>> be with side-effects.
>>> 
>>> Yes that is strange. There's no clk_prepare() before we proceed to
>>> call clk_get_rate() either, not sure if that matter here though.
>>> 
>>>> v5.5-rc1 will likely fail right from the beginning (only on 1GHz rated
>>>> omap36xx) because it makes the combination of this patch and 1GHz OPP
>>>> public (linux-next should already fail but it appears that nobody has
>>>> tested).
>>> 
>>> OK
>> 
>> Well, it is not that urgent as I thought since I have not yet submitted
>> my patch to remove the turbo-mode tags for 1GHz OPP. Therefore even if this
>> code is deployed, no dm3730 will try to boot or run at 1GHz unless
>> manually enabled by echo 1 >/sys/devices/system/cpu/cpufreq/boost.
>> 
>>> 
>>>> Any ideas how to fix? Before I try to do a revert and then add goto exit;
>>>> after each function call and see which ones are essential for 1GHz.
>>> 
>>> If you have things reproducable, care to try to narrow the issue down
>>> a bit by trying see which parts of the old omap2_set_init_voltage()
>>> fix the issue?
>>> 
>>> The issue should be there somewhere in the few lines of code before
>>> dev_pm_opp_find_freq_ceil(), right?
>>> 
>>> It would be good to understand what's going on before reverting or
>>> fixing things condering that a revert would add back code that has
>>> it's own errors and fails to init :)
>> 
>> Indeed!
>> 
>>> 
>>> Another thing to check is if the dev instance is actually the right
>>> one we had in omap2_set_init_voltage() vs the dts dev instance as
>>> we use that with dev_pm_opp_find_freq_ceil().
>> 
>> As a first step I tried to comment out some steps but immediately
>> got failures.
>> 
>> What I then noticed is that there is only a message for
>> 
>> [    2.508392] omap2_set_init_voltage: unable to find boot up OPP for vdd_core
>> [    2.517639] omap2_set_init_voltage: unable to set vdd_core
>> 
>> There is none for vdd_mpu_iva. This OPP initialization is successful
>> and does call voltdm_scale() once.
>> 
>> So it appears as if omap3_init_voltages() is not a complete no-op.
>> 
>> IMHO the reason for the message is that u-boot defines a frequency
>> and voltage that can not be found in the OPP table at all.
>> 
>> Maybe a better solution to get rid of the message would be to modify 
>> dev_pm_opp_find_freq_ceil() to interpolate between OPPs?
>> 
>> Hm. After looking into the code I start to wonder why it fails at
>> all. _find_freq_ceil() should return the highest available frequency
>> above the one passed in and u-boot should not pass more than 800 MHz...
>> 
>> That is IMHO a good next step to go into details.
> 
> Ok, dev_pm_opp_find_freq_ceil() is doing what it should do and it
> returns the first OPP higher or equal than the frequency passed in.
> 
> The real reason for the warning is that the same OPP table is used
> for vdd_mpu_iva and vdd_core and it appears as if "core" (l3_ick)
> runs at 200 MHz which does not correspond to a valid OPP.
> 
> So to silcence the warning it suffices to remove
> 
> 	omap2_set_init_voltage("core", "l3_ick", "l3_main");
> 
> The question is now what l3_ick has to do with the OPPs at all
> and how it should interwork with OPPs and cpufreq.
> 
> Or does all this mean we may need a second OPP fable for vdd_core
> and 200 MHz? But what would it be good for? I have not seen any
> reference for "core-OPPs" in the TRM.

One more, maybe important, finding:

cpufreq_init() is called ca. 0.4 seconds before omap2_set_init_voltage()
and dpll1_ck may already be 1 GHz at that point.
