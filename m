From: Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com>
Subject: Re: [PATCH] regulator: twl: Enable regulators over the powerbus as
 well
Date: Fri, 25 Mar 2016 18:50:18 +0200
Message-ID: <56F56C4A.7070502@gmail.com>
References: <1458760956-29892-1-git-send-email-ivo.g.dimitrov.75@gmail.com>
 <20160325111757.GC2566@sirena.org.uk> <20160325150259.GA9372@earth>
 <20160325155419.GI2566@sirena.org.uk> <56F562B7.10107@gmail.com>
 <20160325161954.GA5028@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20160325161954.GA5028@sirena.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
To: Mark Brown <broonie@kernel.org>
Cc: Sebastian Reichel <sre@kernel.org>, tony@atomide.com, lgirdwood@gmail.com, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org



On 25.03.2016 18:19, Mark Brown wrote:
> On Fri, Mar 25, 2016 at 06:09:27PM +0200, Ivaylo Dimitrov wrote:
>
>> Ok, so you say that regulator framework should call twl4030reg_set_mode(),
>> but it doesn't. If that is the case, then the bug is in the regulator
>> framework, a similar one to what you've fixed in "regulator: core: Always
>> flag voltage constraints as appliable".
>
> What makes you claim that this is a bug in the framework?  Does anything
> in the machine configuration say that changing the modes is allowed?
>

My understanding is that regulator core have to make sure an enabled 
regulator to be in REGULATOR_STATUS_NORMAL. Now it enables the 
regulator, but does not make it in REGULATOR_STATUS_NORMAL. There are 3 
places set_mode() is called in regulator/core.c - in drms_uA_update(), 
in regulator_set_mode() and in set_machine_constraints(). 
set_machine_constraints() calls set_mode() only if there is initial mode 
for that regulator. I can't find a call to regulator_set_mode() anywhere 
in the tree.

 From the documentation:

"regulator-initial-mode: initial operating mode...."

Does the above imply that every regulator present in the system must 
have "initial-mode" defined even if it is "always-on" regulator?

Also, who puts a regulator out of REGULATOR_STATUS_NORMAL if there are 
no more consumers?

It might be that I am not getting the logic behind.

Ivo
