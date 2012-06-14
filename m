From: "Cousson, Benoit" <b-cousson@ti.com>
Subject: Re: [PATCHv2 08/12] ARM: OMAP4: hwmod data: add SL2IF hardreset line
Date: Thu, 14 Jun 2012 23:07:09 +0200
Message-ID: <4FDA527D.9080401@ti.com>
References: <20120611004502.20034.8840.stgit@dusk> <20120611004614.20034.50895.stgit@dusk> <4FD9DF2A.3010000@ti.com> <alpine.DEB.2.00.1206141052240.30212@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:48332 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754220Ab2FNVHR (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 14 Jun 2012 17:07:17 -0400
In-Reply-To: <alpine.DEB.2.00.1206141052240.30212@utopia.booyaka.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Tero Kristo <t-kristo@ti.com>

On 6/14/2012 7:09 PM, Paul Walmsley wrote:
> Hi
>
> On Thu, 14 Jun 2012, Cousson, Benoit wrote:
>
>> I don't think we should allow that at hwmod level. This line is already
>> handled by the IVAHD hwmod. We will then have some potential issue since
>> nothing will prevent the concurrent access.
>> Moreover that IP is only used by the IVAHD and thus should be handled by the
>> same driver. The SL2 being inside the IVA subsystem, it should be reset when
>> the IVA will be reset and thus does not require an individual control.
>
> If a hardreset line will affect an IP block, then the line should be
> listed as one of the IP block's hardreset lines.

No, not necessarily. That signal is already added in the IVA hwmod that 
is the subsystem that does contain the SL2. The fact that the HW signal 
is propagated inside the SS is an implementation detail. In fact the 
hardreset of every SS is always propagated inside the SS IPs.

What is adding some confusion here is just because the SL2 does have a 
modulemode for some weird legacy reason and thus a hwmod.

>  Otherwise, the hwmod
> data will not accurately reflect the hardware -- the ultimate goal.

Not really, describing the relevant HW for the SW usage is the goal. 
Otherwise we will end up with the full RTL inside the kernel.

So, here the point is just that SL2 is inside the IVAHD and thus will be 
reset when the IVAHD will be reset.

That does not mean the reset line should be controlled by the SL2 hwmod 
as well. This is in that case a duplication of a already existing line 
that is already controlled by the parent subsystem.

It seems obvious to me that in that case, only the parent should have 
the control. Otherwise, you will end up in a situation where a 
(potential) SL2 driver will reset the whole subsystem and all its 
siblings if it does try to reset the SL2.

>> I guess, we should just mark the dependency with some external power resource
>> to avoid the fmwk to try to enable that automatically.
>
> Right now, the presence of a hardreset line will effectively cause the
> hwmod code to ignore the IP block from a reset and enable point of view.
> So the IP block won't be enabled automatically right now anyway, since we
> still don't have a clear sense of how to handle those.

Yep, but for that I'd rather add a flag than a information that is a 
duplication of the parent data.

>> It is similar to DSS sub IPs and to some extend McPDM for my point of view.
>
> These seem like different cases to me.
>
> The DSS has no hardreset and the sub-IPs have their own softreset bits.
> As far as I know, the main reason why we can't have individual reset
> functions for the DSS sub-IPs is because we don't have hierarchical IP
> block enable/disable implemented in the hwmod code, not any real hardware
> constraint.

The point with DSS is that you cannot enable the DISPC hwmod if the DSS 
(parent) is not enable.
-> Clock/Power dependency

> McPDM has a functional clock dependency on an external (non-SoC) device
> that's only controllable via I2C.  And, the McPDM can block the ABE
> clockdomain from going idle.  That's just wacky.

The point with McPDM is that you cannot enable the McPDM if the external 
clock is not enabled.
-> Clock dependency

> So those cases seem quite different to me.  One is a software issue.  And
> the other is an off-chip (non-OMAP) dependency, unlike the SL2IF/IVAHD
> issue in which all the needed resources are still on-chip.

The IVAHD reset must be de-asserted to enable the SL2.
-> Parent reset dependency


The point I'm trying to make is that some IPs do have dependency with 
other IPs / devices in the system. It can be clock/reset or power.

Some of them could be indeed handled by hwmod fmwk, but since some other 
will require a management at Linux device level, and because LDM does 
already have a proper way to handle parent/child relationship, there is 
no point adding extra complexity in hwmod fmwk.

By using a single flag we can just prevent the hwmod fmwk to try to 
enable these IPs at boot time, because we already know it will fail due 
to missing dependencies.

>> Maybe we should rename HWMOD_EXT_OPT_MAIN_CLK with something more
>> generic like HWMOD_EXT_POWER_DEP to highlight the dependency with an
>> external resource. It can be a external clock or another module.
>
> Yes, I agree that it would be convenient to have some flag, either on the
> hwmod or the hardreset line, to indicate that some of the reset lines are
> shared.

I guess such flag will be mostly irrelevant. What will we do with that?

We just want to avoid enabling an IP that cannot be enabled without 
enabling some other IPs before.
We do not want the hwmod fmwk to do that, we want to defer that do the 
Linux device level.

Regards,
Benoit

