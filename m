From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: Re: [PATCH 15/15] ARM: OMAP2+: AM33XX: Basic suspend resume support
Date: Wed, 07 Nov 2012 09:15:20 -0800
Message-ID: <87pq3p72s7.fsf@deeprootsystems.com>
References: <1351859566-24818-1-git-send-email-vaibhav.bedia@ti.com>
	<1351859566-24818-16-git-send-email-vaibhav.bedia@ti.com>
	<87txt4aqyc.fsf@deeprootsystems.com>
	<B5906170F1614E41A8A28DE3B8D121433EC04AE5@DBDE01.ent.ti.com>
	<87r4o68bnl.fsf@deeprootsystems.com>
	<B5906170F1614E41A8A28DE3B8D121433EC085EE@DBDE01.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-pa0-f46.google.com ([209.85.220.46]:60270 "EHLO
	mail-pa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751346Ab2KGRPW (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 7 Nov 2012 12:15:22 -0500
Received: by mail-pa0-f46.google.com with SMTP id hz1so1292264pad.19
        for <linux-omap@vger.kernel.org>; Wed, 07 Nov 2012 09:15:21 -0800 (PST)
In-Reply-To: <B5906170F1614E41A8A28DE3B8D121433EC085EE@DBDE01.ent.ti.com>
	(Vaibhav Bedia's message of "Wed, 7 Nov 2012 13:25:56 +0000")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Bedia, Vaibhav" <vaibhav.bedia@ti.com>
Cc: "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "paul@pwsan.com" <paul@pwsan.com>, "Cousson, Benoit" <b-cousson@ti.com>, "tony@atomide.com" <tony@atomide.com>

"Bedia, Vaibhav" <vaibhav.bedia@ti.com> writes:

> Hi Kevin,
>
> On Wed, Nov 07, 2012 at 06:36:06, Kevin Hilman wrote:
>> "Bedia, Vaibhav" <vaibhav.bedia@ti.com> writes:
>> 
>> > On Mon, Nov 05, 2012 at 23:10:27, Kevin Hilman wrote:
>> 
>> [...]
>> 
>> >> 
>> >> Also, if there are drivers for these devices, won't this interfere?
>> >> 
>> >
>> > Hmm, I can think of the following scenarios
>> >
>> > 1. Runtime PM adapted drivers are compiled in - We'll have to ensure that
>> > in their suspend callbacks they end up doing omap_hwmod_idle() via the
>> > runtime PM APIs. 
>> 
>> That already happens for all omap_devices.
>> 
>> > In this case the omap_hwmod_enable() followed by omap_hwmod_idle() is
>> > not necessary in the PM code.
>> 
>> Correct.
>> 
>> > 2. The drivers are not compiled in - In this case, the hwmod code puts
>> > the IPs in standby during bootup so the first suspend-resume iteration
>> > will pass. During resuming, the SYSC configuration for forced standby will
>> > be lost, 
>> 
>> Please clarify how the SYSC is lost in this case.
>
> The register configuration of IPs in the PER domain is lost when we enter
> the suspend state. So the forced standby configuration from SYSC is lost
> and we need to do this for every successful suspend-resume cycle.
>
>> 
>> > so in the subsequent iterations these IPs won't go standby and the
>> > hwmod code does not touch them since they never got enabled. In this case
>> > we do need the sequence that is there currently.
>> >
>> > 3. For some reason the respective drivers don't idle the IPs during suspend -
>> > (no_idle_on_suspend flag for the hwmod in DT?). In this scenario I think
>> > we should abort the suspend process since we know that the suspend is not
>> > going to work. 
>> 
>> Agreed.
>> 
>> > Is there some other scenario that needs to be covered?
>> 
>> You covered the ones I was thinking of.
>> 
>> > How about adding some flag in hwmod code for handling this? Something
>> > similar to what was done for MMC [1]. I think the problem that we have
>> > is in some ways similar to the one addressed in [1].
>> 
>> Except that in the absence of drivers, no hwmod code is executed on the
>> suspend/resume path.
>> 
>
> We could perhaps add a couple of APIs to check the SYSC values when coming
> out of suspend and take appropriate action if the sysc cache does not match?

Yes, for IPs with only SW support and no drivers, we may need something
like this.  But again, it needs to be suspend and idle aware, not just
suspend.

Kevin


