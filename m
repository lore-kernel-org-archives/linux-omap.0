From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 0/4] Hacks to allow booting ARM SMP kernel on UP ARMv7
Date: Thu, 19 Aug 2010 12:57:06 +0300
Message-ID: <20100819095705.GU12184@atomide.com>
References: <20100817104414.19061.38999.stgit@baageli.muru.com>
 <20100817135205.GC20325@n2100.arm.linux.org.uk>
 <20100817141210.GJ12184@atomide.com>
 <20100817154035.GD20325@n2100.arm.linux.org.uk>
 <20100819073810.GR12184@atomide.com>
 <4C6CFBAF.6020407@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:51927 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752041Ab0HSJ5O (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 19 Aug 2010 05:57:14 -0400
Content-Disposition: inline
In-Reply-To: <4C6CFBAF.6020407@canonical.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Bryan Wu <bryan.wu@canonical.com>
Cc: Russell King - ARM Linux <linux@arm.linux.org.uk>, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org

* Bryan Wu <bryan.wu@canonical.com> [100819 12:31]:
> On 08/19/2010 03:38 PM, Tony Lindgren wrote:
> > * Russell King - ARM Linux <linux@arm.linux.org.uk> [100817 18:33]:
> >> On Tue, Aug 17, 2010 at 05:12:11PM +0300, Tony Lindgren wrote:
> >>> Great, will give it a try hopefully tomorrow. Sounds like that's the way
> >>> to deal with fixing up things when booting up older UP ARMv6 without the
> >>> 32v6 support :)
> >>
> >> What I've also been debating about is adding another word to the
> >> smpalt structure, that being a set of flags which denote the situation
> >> where the alternative should be used.
> >>
> >> That means we can use it to do individual word replacements for SMP vs
> >> UP, ARMv6 vs ARMv6k etc.
> > 
> > Sounds good to me. Maybe it should then be called cpualt instead of smpalt?
> > 
> > Tried booting your patch and needed the following fix for Cortex-A8 UP.
> > 
> > Now it boots to the following error:
> > 
> > Machine configuration botched (nr -1073741824), unable to continue.
> > 
> > Does some struct size need to be changed or something?
> > 
> 
> I also tested these 2 patches on my beagle board based on -for-next branch for
> linux-omap tree. I don't have debug hardware to find the kernel boot failure. It
> looks like it stops at very early stage.
> 
> Do you know where is the message (nr -1073741824) coming from?

Looks like something is not quite right with smp_on_up part of __fixup_smp,
returning early before smp_on_up does not produce that.

Regards,

Tony
