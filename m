From: Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com>
Subject: Re: [PATCH] regulator: twl: Enable regulators over the powerbus as
 well
Date: Fri, 25 Mar 2016 18:09:27 +0200
Message-ID: <56F562B7.10107@gmail.com>
References: <1458760956-29892-1-git-send-email-ivo.g.dimitrov.75@gmail.com>
 <20160325111757.GC2566@sirena.org.uk> <20160325150259.GA9372@earth>
 <20160325155419.GI2566@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20160325155419.GI2566@sirena.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
To: Mark Brown <broonie@kernel.org>, Sebastian Reichel <sre@kernel.org>
Cc: tony@atomide.com, lgirdwood@gmail.com, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org



On 25.03.2016 17:54, Mark Brown wrote:
> On Fri, Mar 25, 2016 at 04:02:59PM +0100, Sebastian Reichel wrote:
>> On Fri, Mar 25, 2016 at 11:17:57AM +0000, Mark Brown wrote:
>>> On Wed, Mar 23, 2016 at 09:22:36PM +0200, Ivaylo Dimitrov wrote:
>
>>>> Assigning a device group to a regulator does not change its state. To
>>>> change the state of a regulator a message over the powerbus is required.
>>>> Also, the check for the current state of a regulator should not count on
>>>> a device group being assigned, but on the current resource state.
>
>>> How did this driver ever work then?  It sounds like there must be
>>> something else going on here.

In short - it does not work, the voltages and regulator states are left 
on the mercy of the reset defaults and the bootloader.

>
>>  From my understanding of the twl4030 TRM assigning a device group
>> means "<device group> wants this regulator enabled". It does not
>> change the regulator mode (sleep vs normal or in regulator-framework
>> terms: REGULATOR_STATUS_NORMAL vs REGULATOR_STATUS_STANDBY).
>
>> It usually works, since the default state is normal. If the system
>> is rebooted from a non-mainline kernel, which left the regulator in
>> sleep/standby, nothing in the kernel switches it to normal.
>

This is exactly what happens

> I really can't tell how anyone could get from the changelog to what
> you're saying about modes.  The explanation needs to be *much* clearer.
>
> Part of the confusion is that if you're trying to do something to do
> with the mode support that really needs to use the mode APIs, enabling
> or disabling the regulator should not silently change the mode.
>

Ok, so you say that regulator framework should call 
twl4030reg_set_mode(), but it doesn't. If that is the case, then the bug 
is in the regulator framework, a similar one to what you've fixed in 
"regulator: core: Always flag voltage constraints as appliable".
