From: Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com>
Subject: Re: [PATCH] regulator: twl: Enable regulators over the powerbus as
 well
Date: Fri, 25 Mar 2016 19:22:45 +0200
Message-ID: <56F573E5.6030408@gmail.com>
References: <1458760956-29892-1-git-send-email-ivo.g.dimitrov.75@gmail.com>
 <20160325111757.GC2566@sirena.org.uk> <20160325150259.GA9372@earth>
 <20160325155419.GI2566@sirena.org.uk> <56F562B7.10107@gmail.com>
 <20160325161954.GA5028@sirena.org.uk> <56F56C4A.7070502@gmail.com>
 <20160325170558.GB5028@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20160325170558.GB5028@sirena.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
To: Mark Brown <broonie@kernel.org>
Cc: Sebastian Reichel <sre@kernel.org>, tony@atomide.com, lgirdwood@gmail.com, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org



On 25.03.2016 19:05, Mark Brown wrote:
> On Fri, Mar 25, 2016 at 06:50:18PM +0200, Ivaylo Dimitrov wrote:
>> On 25.03.2016 18:19, Mark Brown wrote:
>
>>> What makes you claim that this is a bug in the framework?  Does anything
>>> in the machine configuration say that changing the modes is allowed?
>
>> My understanding is that regulator core have to make sure an enabled
>> regulator to be in REGULATOR_STATUS_NORMAL. Now it enables the regulator,
>
> No, absolutely not.  Modes are completely orthogonal to enabling and
> disabling the regulator - modes reflect an efficiency/accuracy tradeoff
> in the regulation, they are nothing to do with the regulator being
> enabled.  Setting a mode should not affect the regulator enable state
> and enabling the regulator should not affect the mode.
>
>> It might be that I am not getting the logic behind.
>
> Yes, that seems to be the case.
>

Fair enough.

Now, what am I supposed to do to the fix the problem. Will try to 
explain it in more details:

On Nokia N900 regulators are left in the mode last set by the bootloader 
or by the stock kernel, depends on whether it is power-on or reboot from 
stock kernel to mainline. That leads to problem with devices connected 
to vmmc2 regulator - when the device is rebooted from stock kernel vmmc2 
is left in "sleep" mode (REGULATOR_STATUS_STANDBY in terms of regulator 
framework) and as noone in mainline kernel switches vmmc2 regulator to 
normal (REGULATOR_STATUS_NORMAL) mode, devices supplied by it does not 
get enough power to operate normally.
