From: Bryan Wu <bryan.wu@canonical.com>
Subject: Re: [PATCH 0/4] Hacks to allow booting ARM SMP kernel on UP ARMv7
Date: Thu, 19 Aug 2010 17:38:55 +0800
Message-ID: <4C6CFBAF.6020407@canonical.com>
References: <20100817104414.19061.38999.stgit@baageli.muru.com> <20100817135205.GC20325@n2100.arm.linux.org.uk> <20100817141210.GJ12184@atomide.com> <20100817154035.GD20325@n2100.arm.linux.org.uk> <20100819073810.GR12184@atomide.com>
Reply-To: bryan.wu@canonical.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from adelie.canonical.com ([91.189.90.139]:52723 "EHLO
	adelie.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750883Ab0HSJjU (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 19 Aug 2010 05:39:20 -0400
In-Reply-To: <20100819073810.GR12184@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Russell King - ARM Linux <linux@arm.linux.org.uk>, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org

On 08/19/2010 03:38 PM, Tony Lindgren wrote:
> * Russell King - ARM Linux <linux@arm.linux.org.uk> [100817 18:33]:
>> On Tue, Aug 17, 2010 at 05:12:11PM +0300, Tony Lindgren wrote:
>>> Great, will give it a try hopefully tomorrow. Sounds like that's the way
>>> to deal with fixing up things when booting up older UP ARMv6 without the
>>> 32v6 support :)
>>
>> What I've also been debating about is adding another word to the
>> smpalt structure, that being a set of flags which denote the situation
>> where the alternative should be used.
>>
>> That means we can use it to do individual word replacements for SMP vs
>> UP, ARMv6 vs ARMv6k etc.
> 
> Sounds good to me. Maybe it should then be called cpualt instead of smpalt?
> 
> Tried booting your patch and needed the following fix for Cortex-A8 UP.
> 
> Now it boots to the following error:
> 
> Machine configuration botched (nr -1073741824), unable to continue.
> 
> Does some struct size need to be changed or something?
> 

I also tested these 2 patches on my beagle board based on -for-next branch for
linux-omap tree. I don't have debug hardware to find the kernel boot failure. It
looks like it stops at very early stage.

Do you know where is the message (nr -1073741824) coming from?

Thanks,
-- 
Bryan Wu <bryan.wu@canonical.com>
Kernel Developer    +86.138-1617-6545 Mobile
Ubuntu Kernel Team | Hardware Enablement Team
Canonical Ltd.      www.canonical.com
Ubuntu - Linux for human beings | www.ubuntu.com
