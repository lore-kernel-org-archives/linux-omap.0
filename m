From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 0/4] Hacks to allow booting ARM SMP kernel on UP ARMv7
Date: Tue, 17 Aug 2010 17:12:11 +0300
Message-ID: <20100817141210.GJ12184@atomide.com>
References: <20100817104414.19061.38999.stgit@baageli.muru.com>
 <20100817135205.GC20325@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:64632 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753635Ab0HQOMU (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 17 Aug 2010 10:12:20 -0400
Content-Disposition: inline
In-Reply-To: <20100817135205.GC20325@n2100.arm.linux.org.uk>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, bryan.wu@canonical.com

* Russell King - ARM Linux <linux@arm.linux.org.uk> [100817 16:44]:
> On Tue, Aug 17, 2010 at 01:53:12PM +0300, Tony Lindgren wrote:
> > Here are some experimental patches to allow booting ARMv7 SMP
> > kernel on UP to some extent. Posting these early in case it is
> > of any help as I know at least Bryan Wu is working on similar
> > issues.
> 
> I think these are compeltely the wrong direction.  First thing to realise
> is that XIP in the "SMP and UP in one kernel" is not really practical -
> I'm not sure that many people who want that kind of flexibility also want
> XIP too.
> 
> So let's forget about the kernel text being read-only.

OK, at least for me.
 
> The second thing to realise is that most of the SMP dependencies are in
> assembly - and we can make lists of instructions and their modified
> versions that would be necessary to boot a SMP kernel on UP.

OK cool.
 
> So something like this will do (though note that not everywhere has been
> fixed up - such as the page table flags - or this patch tested yet.)

Great, will give it a try hopefully tomorrow. Sounds like that's the way
to deal with fixing up things when booting up older UP ARMv6 without the
32v6 support :)
 
> If we don't want the SMP-on-UP support for SMP kernels (it's not actually
> all that big - around 512 bytes) then we can discard the .smpalt.init
> section and the __fixup_smp code.

OK

Regards,

Tony
