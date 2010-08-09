From: Bryan Wu <bryan.wu@canonical.com>
Subject: Re: [PATCH] omap: Fix sev instruction usage for multi-omap
Date: Mon, 09 Aug 2010 14:42:06 +0800
Message-ID: <4C5FA33E.6020308@canonical.com>
References: <8739uu9em0.fsf@deeprootsystems.com> <5A47E75E594F054BAF48C5E4FC4B92AB0323E6947D@dbde02.ent.ti.com> <87tyn8ptkl.fsf@deeprootsystems.com> <20100806070301.GA23778@atomide.com> <20100806070519.GB23778@atomide.com>
Reply-To: bryan.wu@canonical.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from adelie.canonical.com ([91.189.90.139]:51673 "EHLO
	adelie.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753857Ab0HIGmW (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 9 Aug 2010 02:42:22 -0400
In-Reply-To: <20100806070519.GB23778@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Kevin Hilman <khilman@deeprootsystems.com>, "Nayak, Rajendra" <rnayak@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

On 08/06/2010 03:05 PM, Tony Lindgren wrote:
> * Tony Lindgren <tony@atomide.com> [100806 09:55]:
>> * Kevin Hilman <khilman@deeprootsystems.com> [100806 01:48]:
>>>
>>>> Also with omap_4430sdp_defconfig, I see these compile errors
>>>> arch/arm/kernel/entry-armv.S: Assembler messages:
>>>> arch/arm/kernel/entry-armv.S:48: Error: bad instruction `test_for_ipi r0,r6,r5,lr'
>>>> arch/arm/kernel/entry-armv.S:48: Error: bad instruction `test_for_ipi r0,r6,r5,lr'
>>>> make[1]: *** [arch/arm/kernel/entry-armv.o] Error 1
>>>> make: *** [arch/arm/kernel] Error 2
>>>>
>>>> Doing a git log on entry-armv.S shows me a top commit which might
>>>> be an issue if conflicts are'nt resolved well.
>>>>
>>>> commit 7b70c4275f28702b76b273c8534c38f8313812e9
>>>> Merge: ceb0885... a20df56...
>>>> Author: Russell King <rmk+kernel@arm.linux.org.uk>
>>>> Date:   Sat Jul 31 14:20:16 2010 +0100
>>>>
>>>>     Merge branch 'devel-stable' into devel
>>>>
>>>>     Conflicts:
>>>>         arch/arm/kernel/entry-armv.S
>>>>         arch/arm/kernel/setup.c
>>>>         arch/arm/mm/init.c
>>>>
>>>> Maybe this is an issue in Tony's for-next as well. Haven't tested
>>>> it though.
>>>
>>> Yeah, I'm guessing this an issue in for-next, and probably l-o master
>>> too.
>>
>> Noticed that with omap3_defconfig with CONFIG_SMP enabled. Does the
>> following work for you?
> 
> Here's a related patch that allows CONFIG_SMP to compile with
> omap3_defconfig. Booting still won't work before some arm generic
> code is changed.
> 
> Regards,
> 
> Tony


Tony,

I also did similar thing these days. And yes, with these 2 CONFIG_SMP related
patches in omap3_defconfig, I can built a single for omap2/3/4 with CONFIG_SMP=y.

But the kernel still doesn't boot on both omap3 beagle board and omap4 panda
board on my side.

I'm very glad to help this out.

Thanks,
-- 
Bryan Wu <bryan.wu@canonical.com>
Kernel Developer    +86.138-1617-6545 Mobile
Ubuntu Kernel Team | Hardware Enablement Team
Canonical Ltd.      www.canonical.com
Ubuntu - Linux for human beings | www.ubuntu.com
