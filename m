From: "Nayak, Rajendra" <rnayak@ti.com>
Subject: RE: [PATCH] omap: Fix sev instruction usage for multi-omap
Date: Fri, 6 Aug 2010 16:59:09 +0530
Message-ID: <5A47E75E594F054BAF48C5E4FC4B92AB032401CFA6@dbde02.ent.ti.com>
References: <8739uu9em0.fsf@deeprootsystems.com>
 <5A47E75E594F054BAF48C5E4FC4B92AB0323E6947D@dbde02.ent.ti.com>
 <87tyn8ptkl.fsf@deeprootsystems.com> <20100806070301.GA23778@atomide.com>
 <20100806070519.GB23778@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:45556 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1761248Ab0HFL3T convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 6 Aug 2010 07:29:19 -0400
In-Reply-To: <20100806070519.GB23778@atomide.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>, Kevin Hilman <khilman@deeprootsystems.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

 

> -----Original Message-----
> From: Tony Lindgren [mailto:tony@atomide.com] 
> Sent: Friday, August 06, 2010 12:35 PM
> To: Kevin Hilman
> Cc: Nayak, Rajendra; linux-omap@vger.kernel.org
> Subject: [PATCH] omap: Fix sev instruction usage for multi-omap
> 
> * Tony Lindgren <tony@atomide.com> [100806 09:55]:
> > * Kevin Hilman <khilman@deeprootsystems.com> [100806 01:48]:
> > > 
> > > > Also with omap_4430sdp_defconfig, I see these compile errors
> > > > arch/arm/kernel/entry-armv.S: Assembler messages:
> > > > arch/arm/kernel/entry-armv.S:48: Error: bad instruction 
> `test_for_ipi r0,r6,r5,lr'
> > > > arch/arm/kernel/entry-armv.S:48: Error: bad instruction 
> `test_for_ipi r0,r6,r5,lr'
> > > > make[1]: *** [arch/arm/kernel/entry-armv.o] Error 1
> > > > make: *** [arch/arm/kernel] Error 2
> > > >
> > > > Doing a git log on entry-armv.S shows me a top commit 
> which might
> > > > be an issue if conflicts are'nt resolved well.
> > > >
> > > > commit 7b70c4275f28702b76b273c8534c38f8313812e9
> > > > Merge: ceb0885... a20df56...
> > > > Author: Russell King <rmk+kernel@arm.linux.org.uk>
> > > > Date:   Sat Jul 31 14:20:16 2010 +0100
> > > >
> > > >     Merge branch 'devel-stable' into devel
> > > >
> > > >     Conflicts:
> > > >         arch/arm/kernel/entry-armv.S
> > > >         arch/arm/kernel/setup.c
> > > >         arch/arm/mm/init.c
> > > >
> > > > Maybe this is an issue in Tony's for-next as well. 
> Haven't tested
> > > > it though.
> > > 
> > > Yeah, I'm guessing this an issue in for-next, and 
> probably l-o master
> > > too.
> > 
> > Noticed that with omap3_defconfig with CONFIG_SMP enabled. Does the
> > following work for you?

With this patch, I went past the previous break but hit this

/tmp/ccUTrImV.s: Assembler messages:
/tmp/ccUTrImV.s:140: Error: selected processor does not support `sev'
make[1]: *** [arch/arm/mach-omap2/omap-smp.o] Error 1
make: *** [arch/arm/mach-omap2] Error 2

> 
> Here's a related patch that allows CONFIG_SMP to compile with
> omap3_defconfig. Booting still won't work before some arm generic
> code is changed.

Now with this, omap4 build using omap_4430sdp_defconfig seems to
go through, but like you said, boot is still an issue.

regards,
Rajendra

> 
> Regards,
> 
> Tony
> 